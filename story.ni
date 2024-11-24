"COLOSSAL CAVE ADVENTURE" by Will Crowther 1976 and Don Woods 1977 --- Ported by Nathaniel Lindell 2024

[Explaination of comments:
	I put numbers next to things found in the original FORTRAN database for the game with the following system:
		L - Location
		O - Object with
			D - Description based on property 0, 1, or 2
		M - Message (with additional M for "modified")
	I also commented if a description/scenery object came from Colossal Cave Revisited (ccr) or the Inform 6 version (I6)]

Part 1 - Setup

Chapter 1 - Contents

The story headline is "The Interactive Original".

The story creation year is 1977.

Use scoring.

Release along with the "Quixe" interpreter, the source text, and cover art.

Section - Tables

Table of Hints
hint	turns needed	points to deduct	question text		hint text
cave hint	4	2	"Are you trying to get into the cave?"		"The grate is very solid and has a hardened steel lock.  You cannot enter without a key and there are no keys nearby.  I would recommend looking elsewhere for the keys."
bird hint	5	2	"Are you trying to catch the bird?"		"The bird is frightened right now and you cannot catch it no matter what you try.  Perhaps you might try later."
snake hint	8	2	"Are you trying to somehow deal with the snake?"		"You can't kill the snake, or drive it away, or avoid it, or anything like that.  There is a way to get by, but you don't have the necessary resources right now."
maze hint	75	4	"Do you need help getting out of the maze?"		"You can make the passages look less alike by dropping things."
dark hint	25	5	"Are you trying to explore beyond the plover room?"	"There is a way to explore that region without having to worry about falling into a pit.  None of the objects available is immediately useful in descovering the secret."
witt hint	20	3	"Do you need help getting out of here?"		"Don't go west."
[M62	M63]
[M18	M19]
[M20	M21]
[M176	M177]
[M178	M179]
[M180	M181]

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"read some HISTORY about the game"	true	"history"	read about history rule	--

Chapter 2 - Kinds

Section - New Kinds and Properties

A liquid is a kind of thing with indefinite article "some". 

A hint is a kind of value. The hints are defined by the Table of Hints. A hint can be used. A hint has a number called turns.

Height is a kind of value. The heights are tiny, tall, and huge.

A room can be for dwarves. A room is usually for dwarves. A room can be forbidden. A room is usually dark. A room has a text called brief description. A room can be twopit.

An aboveground room is a kind of room.  An aboveground room is never for dwarves. An aboveground room is always lighted.

A maze room is a kind of room. The printed name of a maze room is usually "Maze". The description is usually "You are in a maze of twisty little passages, all alike."
Instead of going outside in a maze room, say [I6]"Easier said than done."

A diffmaze room is a kind of room. The printed name of a diffmaze room is usually "Maze".

A deadend room is a kind of room. The printed name is usually "Dead End". The description is usually [ccr]"You have reached a dead end.". The brief description is usually "Dead End".
Instead of going outside in a deadend room:
	move player to a random adjacent room as going;
	rule succeeds.

A person is either following you or wandering. A person is usually wandering.
A person has a room called the prior location.
Definition: a person is another if it is not the player.
The player has a number called deaths. The carrying capacity of the player is 7.

A thing can be seen or unseen. A thing can be climbable.

A backdrop can be referable.

Section - Directions

The forward is a direction. Understand "forward/forwards/continue/onward/onwards" as forward.
The right is a direction. Understand "right" as right.
The left is a direction. Understand "left" as left.

Understand "exit/leave" as outside.
Understand "inward/inwards" as inside.
Understand "upward/upwards/above/ascend" as up.
Understand "downward/downwards/descend" as down.

Section - Dwarves

A dwarf is a kind of man. The plural of dwarf is dwarves. [M4]"There is a threatening little dwarf in the room with you!" The description of a dwarf is [ccr]"It's probably not a good idea to get too close. Suffice it to say the little guy's pretty aggressive."
Understand "nasty/mean/threatening/little" as a dwarf. A dwarf is always undescribed.


Section - Treasures

A treasure is a kind of thing. A treasure has a number called deposit points. The deposit points of a treasure is usually 10. A treasure can be found, unfound, or elusive. A treasure is usually unfound.
After writing a paragraph about a treasure (called the item):
	if the item is unfound:
		now the item is found;
		unless the item is the rug or the item is the chain:
			increase the score by 2;
			say line break;
		if no treasures are unfound and at least one treasure is elusive and the power remaining of the lantern is greater than 35, now the power remaining of the lantern is 35.
Definition: A treasure (called specimen) is stealable unless (the specimen is the pyramid and (the location is In_Plover_Room or the location is In_Dark_Room)) or (the specimen is the rug and the dragon is on-stage) or (the specimen is the locked chain).

Chapter 3 - Actions

Understand the command "say" as something new.
Understand the command "light" as something new.
Understand the command "swing" as something new.
Understand the command "read" as something new.
Understand the command "break" as something new.
Understand the commands "exit", "leave", and "out" as something new.
Understand the command "touch" as something new.
Understand the commands "rotate", "twist", "unscrew" and "screw" as something new.
Understand the command "throw" as something new.

Section - Traveling

Traveling to is an action applying to one visible thing. Understand "go to/towards/-- [any visited room]" or "[any visited room]" as traveling to.
Check traveling to (this is the can't travel to current location rule):
	if the noun is the location, say "But you're already here!" (A) instead.
Check traveling to (this is the can't travel to every room rule):
	if location does not travel to the noun, say [M12]"I don't know how to apply that word here." (A) instead.
First carry out traveling to (this is the store prior location when traveling rule):
	now the prior location of the player is the location.
Carry out traveling to (this is the standard travel rule):
	move the player to the noun, without printing a room description.
Report traveling to (this is the standard report travel rule):
	produce a room description with going spacing conventions.
		
Travelability relates various room to various rooms. The verb to travel to (he travels to, they travel to, he traveled to, it is traveled to) implies the travelability relation.

Definition: A room is destination if the location travels to it.

Does the player mean going or traveling to a destination room: it is likely.

Section - Going

Understand "go to/towards [direction]" as going.
Understand "turn [direction]", "find [direction]", or "where is/are/-- [direction]" as going.
Understand the commands "travel", "proceed", "continue", "explore",  "goto", and "follow" as "go".

Check an actor going (this is the advent can't go rule):
	if the room gone to is nothing:
		if the actor is the player:
			if the noun is right or the noun is left or the noun is forward:
				say [M10]"I am unsure how you are facing.  Use compass points or nearby objects." (A);
			otherwise if (the noun is inside or the noun is outside) and the room inside from the location is nothing and the room outside from the location is nothing:
				say [M11]"I don't know in from out here.  Use compass points or name something in the general direction you want to go." (B);
			otherwise:
				say [M9]"There is no way to go that direction." (C);
		stop the action.

The advent can't go rule is listed instead of the can't go that way rule in the check going rulebook.
The can't go through closed doors rule is not listed in any rulebook.

The going action has a truth state called was dark. 
Setting action variables for going (this is the establish prior darkness rule):  
	if in darkness, now was dark is true;
	otherwise now was dark is false.
First carry out an actor going (this is the store prior location when going rule):
	now the prior location of the actor is the room gone from.
The last carry out going rule (this is the moving in the dark rule): 
	if in darkness and was dark is true and a random chance of 7 in 20 succeeds:
		say [M23]"You fell into a pit and broke every bone in your body!" (A);
		end the story.

The block vaguely going rule response (A) is [M43]"Where?"

Section - Entering

The basic accessibility rule does nothing when entering.
Understand "[door]" or "go [door]" as entering.
Rule for supplying a missing noun while entering (this is the advent find what to enter rule):
	if something enterable (called the box) is in the location, now the noun is the box;
	otherwise say [M43]"Where?"
The advent find what to enter rule is listed instead of the find what to enter rule in the for supplying a missing noun rulebook.

Section - Filling/Emptying

Filling is an action applying to one thing. Understand "fill [container]" or "fill [something]" as filling.
Check an actor filling (this is the block filling rule): say [M109]"You can't fill that." (A) instead.

Emptying is an action applying to one thing. Understand "empty [container]" or "empty [something]" as emptying.
Check an actor emptying (this is the block emptying rule): say "You can't empty that." (A) instead.

Section - Eating/Drinking

Understand the command "devour" as "eat".
Instead of eating someone, say [M71]"I think I just lost my appetite."
The can't eat unless edible rule response (A) is [M110]"Don't be ridiculous!".
The block drinking rule response (A) is [M110]"Don't be ridiculous!".

Section - Looking

Before looking when the player's command matches the regular expression "look|l" at most three times: if set to unabbreviated room descriptions, say [M15]"Sorry, but I am not allowed to give more detail.  I will repeat the long description of your location."

Carry out looking (this is the advent room description body text rule):
	if the visibility level count is 0:
		if set to abbreviated room descriptions, continue the action;
		begin the printing the description of a dark room activity;
		if handling the printing the description of a dark room activity:
			now the prior named object is nothing;
			say [M16]"It is now pitch dark. If you proceed you will likely fall into a pit." (A);
		end the printing the description of a dark room activity;
	otherwise if the visibility ceiling is the location:
		if set to abbreviated room descriptions:
			say line break;
		otherwise if set to sometimes abbreviated room descriptions and abbreviated form allowed is true and the location is visited and the brief description of the location is not "":
			say "[brief description of the location][line break]";
		otherwise:
			print the location's description.
	
The advent room description body text rule is listed instead of the room description body text rule in the carry out looking rulebook.

Section - Blasting

Blasting it with is an action applying to two visible things. Understand "blast [something] with [something]" or "blast [something]" or "blast" as blasting it with.
Understand the commands "detonate", "ignite", and "blowup" as "blast".
Report blasting it with (this is the block blasting rule): say [M67]"Blasting requires dynamite." (A).
Rule for supplying a missing noun while blasting:
	now the noun is the location;
	now clarified is true.
Rule for supplying a missing second noun while blasting:
	if the location encloses the mark rod, now the second noun is the mark rod;
	otherwise now the second noun is the location.
	
Section - Locking/Unlocking

Understand "open" or "unlock" as unlocking it with.
Rule for supplying a missing noun when unlocking:
	if a lockable thing (called the item) is enclosed by the location, now the noun is the item;
	otherwise say [M28]"There is nothing here with a lock!"
Rule for supplying a missing second noun when unlocking:
	if the keys are enclosed by the location:
		now the second noun is the keys;
		say "(with [the second noun])[command clarification break]";
	otherwise:
		say [M31]"You have no keys!"
		
Understand "close" or "lock" as locking it with.
Rule for supplying a missing noun when locking:
	if a lockable thing (called the item) is enclosed by the location, now the noun is the item;
	otherwise say [M28]"There is nothing here with a lock!"
Rule for supplying a missing second noun when locking:
	if the keys are enclosed by the location:
		now the second noun is the keys;
		say "(with [the second noun])[command clarification break]";
	otherwise:
		say [M31]"You have no keys!"

The can't lock what's open rule is not listed in any rulebook.
The can't lock without a lock rule response (A) is [M33]"I don't know how to lock or unlock such a thing."
The can't lock what's already locked rule response (A) is [M34]"It was already locked."
The can't unlock without a lock rule response (A) is [M33]"I don't know how to lock or unlock such a thing."
The can't unlock what's already unlocked rule response (A) is [M37]"It was already unlocked."

Section - Retreating

Retreating is an action applying to nothing. Understand "retreat" and "go back" as retreating.
Understand the commands "back" and "return" as "retreat".
Check retreating (this is the can't go back nowhere rule):
	if the prior location of the player is nothing or the prior location of the player is the location, say [M91]"Sorry, but I no longer seem to remember how it was you got here." (A) instead.
Check retreating (this is the can't go back if unconnected rule):
	unless the prior location of the player is adjacent to the location or the location travels to the prior location of the player, say [M140]"You can't get there from here." (A) instead.
Carry out retreating (this is the standard retreating rule):
	move the player to the prior location of the player as going.

Section - Climbing

The basic accessibility rule does nothing when climbing.
Understand "climb" as climbing. Understand "climb [direction]" as climbing.
Check climbing (this is the convert climbing to going rule): if the noun is a direction, try going the noun.
The convert climbing to going rule is listed before the block climbing rule in the check climbing rulebook.
Rule for supplying a missing noun while climbing:
	if something climbable (called the ladder) is enclosed by the location, now the noun is the ladder;
	otherwise say [M12]"I don't know how to apply that word here."
Does the player mean climbing a climbable thing: it is very likely.

Section - Examining

Understand the command "touch" as "examine".
Understand "[any referable backdrop]" as examining.
The examine devices rule does nothing.

Section - Taking/Dropping

Understand the commands "keep", "catch", "steal", "capture", and "tote" as "take".
The can't take what's already taken rule response (A) is [M24]"You are already carrying it!".
The can't take scenery rule response (A) is [M25]"You can't be serious!".
The can't take what's fixed in place rule response (A) is [M25]"You can't be serious!".
The can't take other people rule response (A) is [M25]"You can't be serious!".
The standard report taking rule response (A) is [M54]"OK."

Check an actor taking (this is the advent can't exeed carrying capacity rule):
	if the number of things enclosed by the actor is at least the carrying capacity of the actor:
		if the actor is the player, say [M92]"You can't carry anything more.  You'll have to drop something first." (A);
		stop the action.
The advent can't exeed carrying capacity rule is listed instead of the can't exceed carrying capacity rule in the check taking rulebook.

Understand the commands "release", "free", and "dump" as "drop". Understand "throw [something]" as dropping when the location does not enclose another person.
The can't drop what's not held rule response (A) is [M29]"You aren't carrying it!"
The standard report dropping rule response (A) is [M54]"OK."
The can't drop what's already dropped rule is not listed in any rulebook.

Section - Taking inventory

The print empty inventory rule response (A) is [M98]"You're not carrying anything."
The print standard inventory rule response (A) is [M99]"You are currently holding the following:[line break]".

Section - Saying

Saying is an action applying to one topic. Understand "say [text]" as saying.
Understand the commands "chant", "sing", "utter", and "mumble" as "say".
Report saying: say "Okay, '[topic understood]'."

Section - Calming

Calming is an action applying to one thing. Understand "calm [someone]" as calming.
Understand the commands "placate" and "tame" as "calm".
Check calming (this is the block calming rule): say [M14]"I'm game.  Would you care to explain how?" (A) instead.

Section - Attacking

Understand the command "strike" as "attack".
Understand "attack" as attacking.
Rule for supplying a missing noun while attacking:
	if another person (called enemy) is enclosed by the location, now the noun is the enemy;
	otherwise say [M44]"There is nothing here to attack."
The block attacking rule response (A) is [M110]"Don't be ridiculous!".
Does the player mean attacking another person: it is very likely.

Section - Throwing

Understand nothing as throwing it at. Understand "throw [something] at/to [something]" as throwing it at.
Understand the command "toss" as "throw".
Does the player mean throwing something at a dwarf: it is very likely.
Does the player mean throwing something at a person: it is likely.

Section - Pouring

Pouring it on is an action applying to two things. Understand "pour [something] on [something]" or "[any liquid] [something]" or "pour [something]" as pouring it on.
Check pouring it on (this is the block pouring rule): say [M78]"You can't pour that." (A) instead.
Rule for supplying a missing second noun while pouring (this is the pour on the ground by default rule):
	unless the location encloses the plant or the location encloses the rusty door, now the second noun is the location.

Section - Finding

Finding is an action applying to one object.
Understand "find [any visited room]" or "where is/are/-- [any visited room]" as finding. Understand "find [any seen thing]" or "where is/are/-- [any seen thing]" as finding.
Check finding (this is the can't find distant items rule):
	if the noun is a room and the noun is not a destination room:
		say [M59]"I can only tell you what you see as you move about and manipulate things.  I cannot tell you where remote things are." (A) instead;
	otherwise if the noun is an invisible thing:
		say [MT]"I see no [noun] here." (B) instead.
Carry out finding (this is the convert find to travel rule):
	if the noun is a destination room, try traveling to the noun.
Report finding (this is the standard report finding rule):
	if the noun is not a room:
		if the player encloses the noun, say [M24]"You are already carrying it!" (A);
		otherwise say [M94]"I believe what you want is right here with you." (B).
Does the player mean finding a destination room: it is very likely.

Section - Breaking

Breaking is an action applying to one thing. Understand "break [something]" as breaking.
Understand the command "shatter" as "break".
Check breaking (this is the block breaking rule): say [M146]"It is beyond your power to do that." (A) instead.

Section - Switching on/off

Understand "on" or "on [something]" or "[something] on" as switching on.
Understand the command "light" as "on".
Rule for supplying a missing noun while switching on:
	unless brass lantern is enclosed by the location, say [M38]"You have no source of light.";
	otherwise now the noun is the brass lantern.

Understand "off" or "off [something]" or "[something] off" as switching off.
Understand the command "extinguish" as "off".
Rule for supplying a missing noun while switching off:
	unless brass lantern is enclosed by the location, say [M38]"You have no source of light.";
	otherwise now the noun is the brass lantern.

Section - Stating

[I invented this action to allow for the player to type just a noun and then be asked for a verb which was a functionality of the original parser. It requires some hacks and may still have undesirable behavior.]
Stated item is an object that varies.
Parser guessed is a truth state that varies.
Stating is an action out of world applying to one visible thing. Understand "[any seen thing]" as stating.
Check stating:
	If the noun is enclosed by the location:
		now the stated item is the noun;
		say [MT]"What do you want to do with [the noun]?";
	otherwise:
		say [MT]"I see no [noun] here."
		
Before doing something when the stated item is not nothing and the noun is not the stated item and parser guessed is true:
	now the noun is the stated item;
	try the current action instead.
	
Rule for clarifying the parser's choice of something while the stated item is not nothing:
	say "([the stated item])[command clarification break]";
	now parser guessed is true.
	
Does the player mean doing something to the stated item: it is very likely.
Rule for supplying a missing noun when the stated item is not nothing (this is the use previously stated item as the noun rule):
	now the noun is the stated item.
Every turn (this is the reset stated item rule), now the stated item is nothing.
Every turn (this is the reset parser guessed rule), now parser guessed is false.

Section - Giving

Understand the command "feed" as something new.
Understand "feed [something]" or "feed [something] to [something]" as giving it to. Understand "feed [something] [something]" as giving it to (with nouns reversed).
Rule for supplying a missing second noun while giving:
	now the second noun is the noun;
	if the food is enclosed by the location:
		now the noun is the food;
		say "(with [the noun])[command clarification break]";
	otherwise:
		say [M174]"There is nothing here to eat."

The can't give to a non-person rule response (A) is [M14]"I'm game.  Would you care to explain how?".

Section - Reading

Reading is an action applying to one visible thing. Understand "read [something]" as reading.
Understand the command "peruse" as "read".
Check reading (this is the block reading rule): say [M195]"I'm afraid I don't understand." (A) instead.

Section - Feefing

Feefing is an action applying to one visible thing. Understand "[feefie] [something]" as feefing.
Check feefing (this is the wrong use of feefie rule): say [M147]"I don't know how." (A) instead.

Section - Briefing

Briefing is a action applying to one visible thing. Understand "brief [something]" as briefing.
Check briefing (This is the wrong use of brief rule): say [M155]"On what?" (A) instead.

The standard report preferring sometimes abbreviated room descriptions rule is not listed in any rulebook.
Report preferring sometimes abbreviated room descriptions (this is the advent report preferring sometimes abbreviated room descriptions rule): say [M156]"Okay, from now on I'll only describe a place in full the first time you come to it.  To get the full description, say 'LOOK'." (A).

Section - Saying Yes/No

Check saying yes (this is the pretend to not know the word yes rule):
	now the latest parser error is the noun did not make sense in that context error;
	carry out the printing a parser error activity;
	stop the action.
The pretend to not know the word yes rule is listed instead of the block saying yes rule in the check saying yes rulebook.

Check saying no (this is the pretend to not know the word no rule):
	now the latest parser error is the noun did not make sense in that context error;
	carry out the printing a parser error activity;
	stop the action.
The pretend to not know the word no rule is listed instead of the block saying no rule in the check saying no rulebook.

Section - Waking

Understand "wake [something]" as waking.
Understand the command "disturb" as "wake".
Understand nothing as waking up.
The block waking rule response (A) is [M110]"Don't be ridiculous!"

Section - Waving

Understand the commands "shake" and "swing" as "wave".
Understand nothing as waving hands.
The can't wave what's not held rule response (A) is [M29]"You aren't carrying it!"
The report waving things rule response (A) is [M42]"Nothing happens."

Section - Waiting

Understand "nothing" as waiting.
The standard report waiting rule response (A) is [M54]"OK."

Section - Magic words

Saying xyzzy is an action applying to nothing. Understand "xyzzy" and "say xyzzy" as saying xyzzy.
Report saying xyzzy (this is the standard report saying xyzzy rule): say [M42]"Nothing happens." (A).

Saying plugh is an action applying to nothing. Understand "plugh" and "say plugh" as saying plugh.
Report saying plugh (this is the standard report saying plugh rule): say [M42]"Nothing happens." (A).

Saying plover is an action applying to nothing. Understand "plover" and "say plover" as saying plover.
Report saying plover (this is the standard report saying plover rule): say [M42]"Nothing happens." (A).

Saying fee is an action applying to nothing. Understand "fee" and "say fee" as saying fee.
Carry out saying fee: run the feefie magic 0.

Saying fie is an action applying to nothing. Understand "fie" and "say fie" as saying fie.
Carry out saying fie: run the feefie magic 1.

Saying foe is an action applying to nothing. Understand "foe" and "say foe" as saying foe.
Carry out saying foe: run the feefie magic 2.

Saying foo is an action applying to nothing. Understand "foo" and "say foo" as saying foo.
Carry out saying foo: run the feefie magic 3.

Section - Cave

Understand "cave" as a mistake ([M57]"I don't know where the cave is, but hereabouts no stream can run on the surface for long.  I would try the stream.") when the location is an aboveground room and the location is not Outside_Grate.

Understand "cave" as a mistake ([M58]"I need more detailed instructions to do that.")

Section - Misc actions

Understand the commands "suspend" and "pause" as "save".

Understand "hours" as a mistake ("[bracket]In this implementation, collosal cave is always open.[close bracket]").

Understand "[old magic]" or "say [old magic]" as a mistake ([M50]"Good try, but that is an old worn-out magic word.").

Understand "help"[ or "?"] as a mistake ([M51]"I know of places, actions, and things.  Most of my vocabulary describes places and is used to move you there.  To move, try words like forest, building, downstream, enter, east, west, north, south, up, or down.  I know about a few special objects, like a black rod hidden in the cave.  These objects can be manipulated using some of the action words that I know.  Usually you will need to give both the object and action words (in either order), but sometimes I can infer the object from the verb alone.  Some objects also imply verbs; in particular, 'inventory' implies 'take inventory', which causes me to give you a list of what you're carrying.  The objects have side effects; for instance, the rod scares the bird.  Usually people having trouble moving just need to try a few more words.  Usually people trying unsuccessfully to manipulate an object are attempting something beyond their (or my!) capabilities and should try a completely different tack.  To speed the game you can sometimes move long distances with a single word.  For example, 'building' usually gets you to the building from anywhere above ground except when lost in the forest.  Also, note that cave passages turn a lot, and that leaving a room to the north does not guarantee entering the next from the south.  Good luck!").
After reading a command (this is the convert question mark rule):
	if the player's command matches the regular expression "^\?", change the text of the player's command to "help". 

Understand "dig" or "excavate" as a mistake ([M66]"Digging without a shovel is quite impractical. Even with a shovel progress is unlikely.")

Understand "lost" as a mistake ([M68]"I'm as confused as you are.")

Understand "stop" as a mistake ([M139]"I don't know the word 'stop'. Use 'quit' if you want to give up.")

Understand "info" or "information" as a mistake ([M142]"If you want to end your adventure early, say 'quit'.  To suspend your adventure such that you can continue later, say 'suspend' (or 'pause' or 'save').  To see what hours the cave is normally open, say 'hours'.  To see how well you're doing, say 'score'.  To get full credit for a treasure, you must have left it safely in the building, though you get partial credit just for locating it.  You lose points for getting killed, or for quitting, though the former costs you more.  There are also points based on how much (if any) of the cave you've managed to explore; in particular, there is a large bonus just for getting in (to distinguish the beginners from the rest of the pack), and there are other ways to determine whether you've been through some of the more harrowing sections.  If you think you've found all the treasures, just keep exploring for a while.  If nothing interesting happens, you haven't found them all yet.  If something interesting *DOES* happen, it means you're getting a bonus and have an opportunity to garner many more points in the master's section.  I may occasionally offer hints if you seem to be having trouble.  If I do, I'll warn you in advance how much it will effect your score to accept the hints.  Finally, to save paper, you may specify 'brief' which tells me never to repeat the full description of a place unless you explicitly ask me to.")

Understand "swim" as a mistake ([M147]"I don't know how.")

Understand "stupid" or "idiot" as a mistake ([M79]"Watch it!"). [This is a change from the original to avoid being flagged for adult language]

Section - Tokens

Understand "road/hill" as "[road]".
Understand "building/house" as "[building]".
Understand "sesame/opensesame/abra/abracadabra/shazam/hocus/pocus" as "[old magic]".
Understand "fee/fie/foe/foo/fum" as "[feefie]".

Chapter 4 - Phrases

To move the/-- player to (someplace - object) as going:
	now the prior location of the player is the location;
	move the player to someplace, without printing a room description;
	produce a room description with going spacing conventions.

To prevent undo:
	now undo allowed is false.
	
Feefie count is a number that varies.
To run the feefie magic (i - a number):
	if feefie count is not i:
		now feefie count is 0;
		say [M151]"What's the matter, can't you read?  Now you'd best start over.";
	otherwise if feefie count is 3:
		now feefie count is 0;
		if golden eggs are in In_Giant_Room:
			say [M42]"Nothing happens.";
			rule succeeds;
		if golden eggs are enclosed by the location, say [O56D1]"The nest of golden eggs has vanished!";
		otherwise say [O56D2]"Done!";
		if golden eggs are in Inside_Building, decrease the score by deposit points of the golden eggs;
		if golden eggs are off-stage, now the troll is not placated;
		move golden eggs to In_Giant_Room;
		if the location is In_Giant_Room, say [I6]"[paragraph break]A large nest full of golden eggs suddenly appears out of nowhere!";
	otherwise:
		increment the feefie count;
		say "OK."

Chapter 5 - Rules

Section - Seen

Every turn (this is the make things seen rule), now all visible things are seen.

Section - Undo

When play begins (this is the remove undo option rule):
	choose row 5 in the Table of Final Question Options;
	blank out the whole row.
	
Undo allowed is a truth state that varies. Undo allowed is true.

Include (-
[ Perform_Undo;
	if (KIT_CONFIGURATION_BITMAP & PREVENT_UNDO_TCBIT) {
		IMMEDIATELY_UNDO_RM('A'); new_line; return;
	}
	if (IterationsOfTurnSequence == 0) { IMMEDIATELY_UNDO_RM('B'); new_line; return; }
	if (undo_flag == 0) { IMMEDIATELY_UNDO_RM('C'); new_line; return; }
	if (undo_flag == 1) { IMMEDIATELY_UNDO_RM('D'); new_line; return; }
	if (~~(+ undo allowed +)) { print "Previous turn cannot be undone.^^"; return; }
	if (VM_Undo() == 0) { IMMEDIATELY_UNDO_RM('F'); new_line; }
]; -) replacing "Perform_Undo".

Every turn (this is the reset undo rule), now undo allowed is true.

Section Yes/No

The yes or no question internal rule response (A) is [MT]"Please answer the question.[line break]"

Section - All

Rule for deciding whether all includes something inside a container (this is the exclude things in a container from all rule): it does not.

Section - Initial appearances

Rule for writing a paragraph about a thing (called the specimen) (this is the always use initial appearance rule):
	If initial appearance of the specimen is not empty:
		say the initial appearance of the specimen;
		say line break.

Section - Supplying a missing noun

The supplying a missing noun activity has a truth state called clarified.
After supplying a missing noun (this is the clarify missing nouns in a command rule): if clarified is false and the noun is not nothing, say "([the noun])[command clarification break]".

Section - Notable locale objects

After choosing notable locale objects (this is the put objects in correct order rule):
	repeat through the Table of Locale Priorities:
		if the notable-object entry is a door, set the locale priority of the notable-object entry to 3;
		if the notable-object entry is a person, set the locale priority of the notable-object entry to 4.

Section - Moving

The moving rules is a object based rulebook.
Rule for moving a man (called current dwarf) (this is the main dwarf movement rule):
	if the location is forbidden, rule fails;
	let possible destinations be a list of rooms;
	add (list of rooms adjacent to location of current dwarf) to possible destinations;
	repeat with d running through possible destinations:
		if (the number of entries in possible destinations is greater than one and d is the prior location of the current dwarf) or (the current dwarf is the pirate and d is forbidden) or d is not for dwarves or d is a diffmaze room, remove d from possible destinations;
	now the prior location of the current dwarf is the location of the current dwarf;
	if the location of the current dwarf is the location:
		now the current dwarf is following you;
		make no decision;
	if the current dwarf is following you and the location is for dwarves:
		move the current dwarf to the location;
		make no decision;
	let r be a random number from 1 to number of entries in possible destinations;
	move current dwarf to entry r in possible destinations;
	if the location of the current dwarf is the location, now the current dwarf is following you;
	otherwise now the current dwarf is wandering.
Rule for moving a following you dwarf (called current dwarf) (this is the dwarves attack rule):
	if the prior location of the current dwarf is the location of the current dwarf:
		increment attackers of Dwarves Active;
		if a random chance of (95 times madness of Dwarves Active) in 1000 succeeds:
			increment killers of Dwarves Active.
The dwarves attack rule is listed last in the moving rulebook.
		
Section - Quitting

This is the advent confirm quit the game rule:
	unless the actor is the player, rule fails;
	say [M22]"Do you really want to quit now?[line break]>" (A);
	unless the player consents:
		say [M54]"OK.[line break]" (B);
		rule fails.

Last carry out quitting the game rule (this is the advent actually quit rule):
	decrease the score by 4;
	end the story;
	follow the notify score changes rule;
	follow the advent scoring rule;
	follow the immediately quit rule.

The advent confirm quit the game rule is listed instead of the quit the game rule in the carry out quitting the game rulebook.

Section - Scoring

The maximum score is 350.

This is the advent scoring rule:
	if the story has ended:
		let next level be a number;
		say [CT]"You scored [score] out of a possible [maximum score], using [turn count] turn[s].[paragraph break]";
		if the score is less than 35:
			say [C35]"You are obviously a rank amateur. Better luck next time.";
			now next level is 35 minus the score;
		otherwise if the score is less than 100:
			say [C100]"Your score qualifies you as a Novice Class Adventurer.";
			now next level is 100 minus the score;
		otherwise if the score is less than 130:
			say [C130]"You have achieved the rating: 'Experienced Adventurer'.";
			now next level is 130 minus the score;
		otherwise if the score is less than 200:
			say [C200]"You may now consider yourself a 'Seasoned Adventurer'.";
			now next level is 200 minus the score;
		otherwise if the score is less than 250:
			say [C250]"You have reached 'Junior Master' status.";
			now next level is 250 minus the score;
		otherwise if the score is less than 300:
			say [C300]"Your score puts you in Master Adventurer Class C.";
			now next level is 300 minus the score;
		otherwise if the score is less than 330:
			say [C330]"Your score puts you in Master Adventurer Class B.";
			now next level is 330 minus the score;
		otherwise if the score is less than 349:
			say [C349]"Your score puts you in Master Adventurer Class A.";
			now next level is 349 minus the score;
		otherwise:
			say [C9999]"All of Adventuredom gives tribute to you, Adventurer Grandmaster!";
		say line break;
		if next level is greater than zero, say [CT]"To achieve the next higher rating, you need [next level] more point[s].";
		otherwise say [CT]"To achieve the next higher rating would be a neat trick!";
	otherwise:
		say [MT]"If you were to quit now, you would score [score - 4] out of a possible [maximum score].[paragraph break]";
		say [M143]"Do you indeed wish to quit now?";
		say "[line break]>";
		if player consents, follow the advent actually quit rule;
		otherwise say [M54]"OK.[line break]".

The advent scoring rule is listed instead of the announce the score rule in the carry out requesting the score rulebook.

First for printing the player's obituary rule: follow the advent scoring rule.

The print obituary headline rule is not listed in the for printing the player's obituary rulebook.
The print final score rule is not listed in the for printing the player's obituary rulebook.

Section - Parser

Rule for printing a parser error when the latest parser error is the noun did not make sense in that context error (this is the advent confused parser rule):
	if a random chance of 1 in 5 succeeds:
		say [M61]"What?";
	otherwise if a random chance of 1 in 5 succeeds:
		say [M13]"I don't understand that!";
	otherwise:
		say [M60]"I don't know that word."

Rule for printing a parser error when the latest parser error is the noun did not make sense in that context error and the player's command matches "crawl" (this is the vague crawling rule): say [M80]"Which way?" (A).

Section - West

Full west count is a number that varies.
After reading a command when the player's command includes "west":
	increment full west count;
	if full west count is 10, say [M17]"If you prefer, simply type W rather than WEST."

Section - Hints

The hinting rules is a hint based rulebook.
First hinting a hint (called current hint) (this is the hint already used rule):
	if current hint is used, rule fails.
Rule for hinting the cave hint (this is the cave hint area rule):
	unless the player is in Outside_Grate, now turns of cave hint is -1 instead.
Rule for hinting the bird hint (this is the bird hint area rule):
	unless the player is in In_Bird_Chamber, now turns of bird hint is -1 instead.
Rule for hinting the snake hint (this is the snake hint area rule):
	unless the player is in In_Hall_Of_Mt_King, now turns of snake hint is -1 instead.
Rule for hinting the maze hint (this is the maze hint area rule):
	unless the player is in the Maze Area, now turns of maze hint is -1 instead.
Rule for hinting the dark hint (this is the dark hint area rule):
	unless the player is in the Plover Area, now turns of maze hint is -1 instead.
Rule for hinting the witt hint (this is the witt hint area rule):
	unless the player is in At_Witts_End, now turns of maze hint is -1 instead.
Rule for hinting a hint (called current hint) (this is the increment time for hint rule):
	increment turns of current hint;
	unless turns of current hint is at least turns needed of current hint, rule fails.
Rule for hinting the cave hint (this is the cave hint condition rule):
	if the steel grate is locked and the set of keys is not enclosed by the location, provide the cave hint.
Rule for hinting the bird hint (this is the bird hint condition rule):
	if the bird is enclosed by the location and the player encloses the black rod and the noun is the bird, provide the bird hint;
	otherwise rule fails.
Rule for hinting the snake hint (this is the snake hint condition rule):
	if the snake is enclosed by the location and the bird is not enclosed by the location, provide the snake hint.
Rule for hinting the maze hint (this is the maze hint condition rule):
	if nothing is in the location and nothing is in the prior location and the player encloses at least two things, provide the maze hint.
Rule for hinting the dark hint (this is the dark hint condition rule):
	if the emerald is handled and the pyramid is not handled, provide the dark hint.
Rule for hinting the witt hint (this is the witt hint condition rule):
	provide the witt hint.
Last hinting a hint (called current hint) (this is the clear hint time rule):
	now turns of current hint is zero.

The increment time for hint rule is listed before the cave hint condition rule in the hinting rulebook.

To provide (current hint - a hint):
	say question text of current hint;
	say "[paragraph break]>";
	if the player consents:
		say [MT]"I am prepared to give you a hint, but it will cost you [points to deduct of current hint] points.[line break]";
		say [M175]"Do you want the hint?";
		say "[line break]>";
		if player consents:
			say hint text of current hint;
			decrease the score by points to deduct of current hint;
			if power remaining of lantern is greater than 30, increase power remaining of lantern by 30 times points to deduct of current hint;
			now the current hint is used;
			prevent undo;
		otherwise:
			say [M54]"OK.";
	otherwise:
		say [M54]"OK.".

Every turn (this is the hint stage rule):
	Repeat with current hint running through hints:
		follow the hinting rules for the current hint.

Section - History

This is the read about history rule:
	say "This is an excerpt from 'The Craft of Adventure' by Graham Nelson:[paragraph break]";
	say "Perhaps the first adventurer was a mulatto slave named Stephen Bishop, born about 1820: [']slight, graceful, and very handsome[']; a [']quick, daring, enthusiastic['] guide to the Mammoth Cave in the Kentucky karst. The story of the Cave is a curious microcosm of American history. Its discovery is a matter of legend dating back to the 1790s; it is said that a hunter, John Houchin, pursued a wounded bear to a large pit near the Green River and stumbled upon the entrance. The entrance was thick with bats and by the War of 1812 was intensively mined for guano, dissolved into nitrate vats to make saltpetre for gunpowder. After the war prices fell; but the Cave became a minor side-show when a dessicated Indian mummy was found nearby, sitting upright in a stone coffin, surrounded by talismans. In 1815, Fawn Hoof, as she was nicknamed after one of the charms, was taken away by a circus, drawing crowds across America (a tour rather reminiscent of Don McLean's song [']The Legend of Andrew McCrew[']). She ended up in the Smithsonian but by the 1820s the Cave was being called one of the wonders of the world, largely due to her posthumous efforts.[paragraph break]";
	say "By the early nineteenth century European caves were big tourist attractions, but hardly anyone visited the Mammoth, [']wonder of the world['] or not. Nor was it then especially large (the name was a leftover from the miners, who boasted of their mammoth yields of guano). In 1838, Stephen Bishop's owner bought up the Cave. Stephen, as (being a slave) he was invariably called, was by any standards a remarkable man: self-educated in Latin and Greek, he became famous as the [']chief ruler['] of his underground realm. He explored and named much of the layout in his spare time, doubling the known map in a year. The distinctive flavour of the Cave's names -- half-homespun American, half-classical -- started with Stephen: the River Styx, the Snowball Room, Little Bat Avenue, the Giant Dome. Stephen found strange blind fish, snakes, silent crickets, the remains of cave bears (savage, playful creatures, five feet long and four high, which became extinct at the end of the last Ice Age), centuries-old Indian gypsum workings and ever more cave. His 1842 map, drafted entirely from memory, was still in use forty years later.[paragraph break]As a tourist attraction (and, since Stephen's owner was a philanthropist, briefly a sanatorium for tuberculosis, owing to a hopeless medical theory the Cave became big business: for decades nearby caves were hotly seized and legal title endlessly challenged. The neighbouring chain, across Houchins Valley in the Flint Ridge, opened the Great Onyx Cave in 1912. By the 1920s, the Kentucky Cave Wars were in full swing. Rival owners diverted tourists with fake policemen, employed stooges to heckle each other's guided tours, burned down ticket huts, put out libellous and forged advertisements. Cave exploration became so dangerous and secretive that finally in 1941 the U.S. Government stepped in, made much of the area a National Park and effectively banned caving. The gold rush of tourists was, in any case, waning.[paragraph break]";
	say "Convinced that the Mammoth and Flint Ridge caves were all linked in a huge chain, explorers tried secret entrances for years, eventually winning official backing. Throughout the 1960s all connections from Flint Ridge -- difficult and water-filled tunnels -- ended frustratingly in chokes of boulders. A [']reed-thin['] physicist, Patricia Crowther, made the breakthrough in 1972 when she got through the Tight Spot and found a muddy passage: it was a hidden way into the Mammoth Cave.[paragraph break]Under the terms of his owner's will, Stephen Bishop was freed in 1856, at which time the cave boasted 226 avenues, 47 domes, 23 pits and 8 waterfalls. He died a year later, before he could buy his wife and son. In the 1970s, Crowther's muddy passage was found on his map.[paragraph break]The Mammoth Cave is huge, its full extent still a matter of speculation (estimates vary from 300 to 500 miles). Although this game has often been called 'Colossal Cave', it is actually a simulation of the Bedquilt Cave region. Here is Will Crowther's story of how it came about:[paragraph break]";
	say "'I had been involved in a non-computer role-playing game called Dungeons and Dragons at the time, and also I had been actively exploring in caves -- Mammoth Cave in Kentucky in particular. Suddenly, I got involved in a divorce, and that left me a bit pulled apart in various ways. In particular I was missing my kids. Also the caving had stopped, because that had become awkward, so I decided I would fool around and write a program that was a re-creation in fantasy of my caving, and also would be a game for the kids, and perhaps some aspects of the Dungeons and Dragons that I had been playing.[paragraph break]'My idea was that it would be a computer game that would not be intimidating to non-computer people, and that was one of the reasons why I made it so that the player directs the game with natural language input, instead of more standardized commands. My kids thought it was a lot of fun.' [bracket]Quoted in 'Genesis II: Creation and Recreation with Computers', Dale Peterson (1983).[close bracket][paragraph break]";
	say "Crowther's original FORTRAN program had five or so treasures, but no formal scoring. The challenge was really to explore, though there was opposition from for instance the snake. Like the real Bedquilt region, Crowther's simulation has a map on about four levels of depth and is rich in geological detail. A good example is the orange column which descends to the Orange River Rock room (where the bird lives): the real column is of orange travertine, a beautiful mineral found in wet limestone.[paragraph break]The game's language is loaded with references to caving, to [']domes['] and [']crawls[']. A [']slab room['], for instance, is a very old cave whose roof has begun to break away into sharp flakes which litter the floor in a crazy heap. The program's use of the word [']room['] for all manner of caves and places seems slightly sloppy in everyday English, but is widespread in American caving and goes back as far as Stephen Bishop: so the Adventure-games usage of the word [']room['] to mean [']place['] may even be bequeathed from him.[paragraph break]";
	say "The game took its decisive step toward puzzle-solving when Don Woods, a student at Stanford, debugged and expanded it. He tripled the number of treasures and added the non-geological zones: everything from the Troll Bridge onward, together with most of the antechambers on the Bedquilt level. All of the many imitations and extensions of the original Adventure are essentially based on Woods's 350-point edition. (Many bloated, corrupted or enhanced -- it depends how you see it -- versions of the game are in Internet circulation, and the most useful way to identify them is by the maximum attainable score. Many versions exist scoring up to around the 400s and 500s, and one up to 1000. Woods himself continues to release new versions of his game; most of the other extenders haven't his talent.)[paragraph break]";
	say "Although the game has veered away from pure simulation, a good deal of it remains realistic. Cavers do turn back when their carbide lamps flicker; there are indeed mysterious markings and initials on the cave walls, some left by the miners, some by Bishop, some by 1920s explorers. Of course there isn't an active volcano in central Kentucky, nor are there dragons and dwarves. But even these embellishments are, in a sense, derived from tradition: like most of the early role-playing games, [']Adventure['] owes much to J. R. R. Tolkien's [']The Hobbit['], and the passage through the mountains and Moria of [']The Lord of the Rings['] (arguably its most dramatic and atmospheric passage). Tolkien himself, the most successful myth-maker of the twentieth century, worked from the example of Icelandic, Finnish and Welsh sagas.[paragraph break]By 1977 tapes of [']Adventure['] were being circulated widely, by the Digital user group DECUS, amongst others: taking over lunchtimes and weekends wherever it went... but that's another story. (Tracy Kidder's fascinating book [']The Soul of a New Machine['], a journalist's-eye-view of a mainframe computer development group, catches it well.)[paragraph break]".

Section - Final Prompt

The print the final prompt rule response (A) is ">".

Chapter 6 - Scenes

A scene has a number called clock.

Section - When Play begins

This is the set the initial score rule:
	now the score is 36;
	now the last notified score is the score.
The set the initial score rule is listed instead of the fix baseline scoring rule in the startup rulebook.

The when play begins stage rule is listed before the initial room description rule in the startup rulebook.

When play begins (this is the ask about instructions rule):
	say [M65]"[paragraph break]Welcome to Adventure!!  Would you like instructions?";
	say ">";
	if player consents:
		decrease the score by 5;
		follow the notify score changes rule;
		say line break;
		say [M1]"Somewhere nearby is collosal cave, where others have found fortunes in treasure and gold, though it is rumored that some who enter are never seen again.  Magic is said to work in the cave.  I will be your eyes and hands.  Direct me with commands of 1 or 2 words.  I should warn you that I look at only the first five letters of each word, so you'll have to enter 'northeast' as 'ne' to distinguish it from 'north'.  (Should you get stuck, type 'help' for some general hints.  For infor[unicode 173]mation on how to end your adventure, etc., type 'info'.)[line break]                   - - -[line break]This program was originally developed by Willie Crowther.  Most of the features of the current program were added by Don Woods (DON @ SU-AI).  Contact Don if you have any questions, comments, etc.";
		now power remaining of the lantern is 1000;
		say line break;
		say "[bracket]What you just read was the instructions for the original version. This one is a little more advanced and has a modern parser.[close bracket]";
		say line break.

Section - Not Far In

Not Far In is a scene. Not Far In begins when play begins. Not Far In ends when In_Hall_Of_Mists is visited.

When Not Far In ends, increase the score by 25.

Section - Dwarves Unmet

Dwarves Unmet is a scene. Dwarves Unmet begins when Not Far In ends. Dwarves Unmet ends when the axe is on-stage.

Every turn during Dwarves Unmet (this is the waiting to meet a dwarf rule):
	if the location is for dwarves and a random chance of 1 in 20 succeeds:
		let initial dwarf locations be {In_Hall_Of_Mt_King, West_Side_Of_Fissure, At_Y2, Alike_Maze_3, At_Complex_Junction};
		repeat with r running from 1 to 2:
			let n be a random number from 1 to number of entries in initial dwarf locations;
			if a random chance of 1 in 2 succeeds, remove entry n from initial dwarf locations;
		repeat with i running through initial dwarf locations:
			if i is the location, now a random off-stage dwarf is in In_Nugget_Of_Gold_Room;
			otherwise now a random off-stage dwarf is in i;
		move axe to location;
		say [M3]"A litttle dwarf just walked around a corner, saw you, threw a little axe at you which missed, cursed, and ran away.";
		now the pirate is in Dead_End_13.

Section - Dwarves Active

Dwarves active is a scene. Dwarves Active begins when Dwarves Unmet ends. Dwarves Active ends when all dwarves are off-stage. Dwarves Active has a number called madness. Dwarves Active has a number called attackers. Dwarves Active has a number called killers.

Every turn during Dwarves Active (this is the dwarves activity rule):
	repeat with d running through on-stage dwarves:
		follow the moving rules for d;
	let d be the number of dwarves enclosed by the location;
	if d is one:
		say [M4]"There is a threatening little dwarf in the room with you!";
	otherwise if d is greater than one:
		say [MT]"There are [d in words] threatening little dwarves in the room with you!";
	if attackers of Dwarves Active is at least one:
		if madness of Dwarves Active is zero, increment madness of Dwarves Active;
		if the knife is not tried, now the knife is in the location;
		if attackers of Dwarves Active is one:
			say [M5]"One sharp nasty knife is thrown at you!  [run paragraph on]";
			if killers of Dwarves Active is zero, say [M52]"It misses!";
			otherwise say [M53]"It gets you!";
		otherwise:
			let aa be "[attackers of Dwarves active in words]" in title case;
			say [MT]"[aa] of them throw knives at you!  [run paragraph on]";
			if killers of Dwarves active is zero:
				say [M6]"None of them hit you!";
			otherwise:
				let kk be "[killers of Dwarves active in words]" in title case;
				say [M7M]"[kk] of them get[if killers of Dwarves Active is one]s[end if] you!";
		if the killers of Dwarves Active is at least one, end the story;
		now attackers of Dwarves Active is zero;
		now killers of Dwarves Active is zero.

Section - Pirate Active

Pirate Active is a scene. Pirate Active begins when Dwarves Unmet ends. Pirate Active ends when the pirate is off-stage.

Every turn during Pirate Active (this is the pirate activity rule):
	follow the moving rules for the pirate;
	if the pirate is following you:
		if the player encloses a stealable treasure:
			now all stealable treasures enclosed by the location are in Dead_End_13;
			return the pirate to his lair;
			say [M128]"Out from the shadows behind you pounces a bearded pirate!  'Har, har,' he chortles.  'I'll just take all this booty and hide it away with me chest deep in the maze!'  He snatches your treasure and vanishes into the gloom.";
			make no decision;
		otherwise if a treasure is not enclosed by the location:
			now the pirate is wandering;
		if exactly one treasure is unfound and the pirate encloses the chest and the player encloses the lit lantern:
			return the pirate to his lair;
			say [M186]"There are faint rustling noises from the darkness behind you.  As you turn toward them, the beam of your lamp falls across a bearded pirate.  He is carrying a large chest.  'Shiver me timbers!' he cries, 'I've been spotted!  I'd best hie meself off to the maze to hide me chest!'  With that, he vanishes into the gloom.";
			make no decision;
		if the prior location of the pirate is not the location of the pirate and a random chance of 1 in 5 succeeds, say [M127]"There are faint rustling noises from the darkness behind you."

To return the pirate to his lair:
	now the pirate is in Dead_End_13;
	now the prior location of the pirate is Dead_End_13;
	now the pirate is wandering;
	if the pirate encloses the chest:
		now the chest is in Dead_End_13;
		now the message is in Dead_End_14.

Section - Pre-Closing

Pre-Closing is a scene. The clock of pre-Closing is 30. Pre-Closing begins when all treasures are found. Pre-Closing ends when clock of Pre-Closing is 0.

Every turn during Pre-Closing (this is the countdown to closing rule):
	unless the location is an aboveground room or location is At_Y2, decrement clock of Pre-closing.

Section - Cave Closing

Cave Closing is a scene. The clock of Cave Closing is 50. Cave Closing begins when Pre-Closing ends. Cave Closing ends when clock of Cave Closing is 0.

When Cave Closing begins:
	increase the score by 25;
	now the crystal bridge is undescribed;
	now the steel grate is locked;
	now the steel grate is closed;
	now the set of keys is nowhere;
	now all on-stage dwarves are nowhere;
	now the pirate is nowhere;
	now the troll is nowhere;
	now the bear is nowhere;
	now the dragon is nowhere; [Woods commented that he only didn't remove because too difficult]
	say [M129]"A sepulchral voice reverberating through the cave says, 'Cave closing soon.  All adventurers exit immediately through main office.'";
	now The_Main_Office is visited.

Every turn during Cave Closing (this is the countdown during closing rule): decrement the clock of Cave Closing.

Instead of saying xyzzy in In_Debris_Room during Cave Closing:
	if the clock of Cave Closing is greater than 15, now the clock of Cave Closing is 15;
	say [M130]"A mysterious recorded voice groans into life and announces:[line break]'This exit is closed.  Please leave via main office.'"

Instead of saying plugh in At_Y2 during Cave Closing:
	if the clock of Cave Closing is greater than 15, now the clock of Cave Closing is 15;
	say [M130]"A mysterious recorded voice groans into life and announces:[line break]'This exit is closed.  Please leave via main office.'"

Instead of going through the steel grate during Cave Closing:
	if the clock of Cave Closing is greater than 15, now the clock of Cave Closing is 15;
	say [M130]"A mysterious recorded voice groans into life and announces:[line break]'This exit is closed.  Please leave via main office.'"

When Cave Closing ends:
	increase the score by 10;
	now all things enclosed by the player are nowhere;
	move bottle to At_Ne_End;
	if something is enclosed by the bottle, now the first thing held by the bottle is nowhere;
	move plant to At_Ne_End; [missing from I6 and TADS version]
	now the height of the plant is tiny;
	move giant clam to At_Ne_End;
	move brass lantern to At_Ne_End;
	move black rod to At_Ne_End;
	move cage to At_Sw_End; [missing from I6 version]
	move little bird to cage;
	move velvet pillow to At_Sw_End;
	now all things in End Game Area are not handled;
	say [M132]"The sepulchral voice intones, 'The cave is now closed.'  As the echoes fade, there is a blinding flash of light (and a small puff of orange smoke). . . .[line break]As your eyes refocus, you look around and find...";
	prevent undo;
	move player to At_Ne_End as going;
	now the prior location of the player is nothing.
	
Section - Reincarnation

When play ends when the story has not ended finally and deaths of the player is less than 3 (this is the reincarnate player rule):
	decrease the score by 10;
	follow the notify score changes rule;
	say line break;
	if Cave Closing is happening:
		say [M131]"It looks as though you're dead.  Well, seeing as how it's so close to closing time anyway, I think we'll just call it a day.";
		make no decision;
	if deaths of the player is:
		-- 0: say [M81]"Oh dear, you seem to have gotten yourself killed.  I might be able to help you out, but I've never really done this before.  Do you want me to try to reincarnate you?";
		-- 1: say [M83]"You clumsy oaf, you've done it again!  I don't know how long I can keep this up.  Do you want me to try reincarnating you again?";
		-- 2: say [M85]"Now you've really done it!  I'm out of orange smoke!  You don't expect me to do a decent reincarnation without any orange smoke, do you?";
	say line break;
	say ">";
	unless player consents, make no decision;
	if deaths of the player is:
		-- 0:
			say [M82]"All right.  But don't blame me if something goes wr......[line break]          --- POOF!! ---[line break]You are engulfed in a cloud of orange smoke.  Coughing and gasping, you emerge from the smoke and find....";
		-- 1:
			say [M84]"Okay, now where did I put my orange smoke?....  >POOF!<[line break]Everything disappears in a dense cloud of orange smoke.";
		-- 2:
			say [M86]"Okay, if you're so smart, do it yourself!  I'm leaving!";
			make no decision;
	increment deaths of the player;
	if the player encloses the brass lantern:
		move the brass lantern to At_End_Of_Road;
		now the brass lantern is switched off;
		now the brass lantern is unlit;	
	while the player encloses something:
		let o be the first thing held by the player;
		move o to location;
	move the player to Inside_Building;
	now the prior location of the player is Inside_Building;
	prevent undo;
	resume the story.
	
Part 2 - The World

Chapter - The outside world

Section -

[L1]At_End_of_Road is an aboveground room with printed name "At End of Road" and brief description "You're at end of road again.". "You are standing at the end of a road before a small brick building.  Around you is a forest.  A small stream flows out of the building and down a gully."
Understand "end/of/road/street/path/gully" as At_End_of_Road.
West and up is At_Hill_in_Road. East and inside is Inside_Building. Down and south is In_A_Valley. North is In_Forest_1.
Understand "[road]" as west when the location is At_End_Of_Road. Understand "[building]" as east when the location is At_End_Of_Road. Understand "gully/stream/downstream" as south when the location is At_End_Of_Road. Understand "forest" as north when the location is At_End_Of_Road.
At_End_Of_Road travels to Outside_Grate.
Rule for supplying a missing noun while entering and the location is At_End_of_Road: now the noun is east.

[ccr]The well house is a backdrop. "It's a small brick building.  It seems to be a well house." It is in At_End_of_Road, At_Hill_in_Road, and Inside_Building.
Understand "brick/building/small/wellhouse" as the well house.

[ccr]The stream is a backdrop. It is in At_End_of_Road, In_A_Valley, At_Slit_In_Streambed, In_Pit, In_Cavern_With_Waterfall, At_Reservoir, and Inside_Building.
Understand "water/brook/river/lake/small/tumbling/splashing/babbling/rushing/reservoir" as the stream.
Instead of drinking the stream:
	say [M73]"You have taken a drink from the stream.  The water tastes strongly of minerals, but is not unpleasant.  It is extremely cold.";
	rule succeeds.
Instead of taking the stream:
	unless the player encloses the bottle, say [M104]"You have nothing in which to carry it.";
	otherwise try filling the bottle.
Instead of inserting the stream into the bottle, try filling the bottle.
Instead of inserting the stream into something, say [M104]"You have nothing in which to carry it."
Instead of inserting the bottle into the stream, try filling the bottle.
Instead of inserting something into the stream:
	now the noun is nowhere;
	say [I6]"[The noun] washes away with the stream.";
	rule succeeds.
Instead of entering the stream, say [M70]"Your feet are now wet."
Before filling something when the stream is in the location, say "(from the stream)[command clarification break]".
Instead of examining the stream when the location is Inside_Building, try examining the spring.
Does the player mean drinking the stream: it is likely.
Rule for clarifying the parser's choice of the stream while drinking: say "(from the stream)[command clarification break]".

[ccr]A road is a backdrop. "The road is dirt, not yellow brick." It is in At_End_Of_Road, At_Hill_In_Road, and In_Forest_2.
Understand "street/path/dirt" as the road.

The forest is a referable backdrop. [M64]"The trees of the forest are large hardwood oak and maple, with an occasional grove of pine or spruce.  There is quite a bit of undergrowth, largely birch and ash saplings plus nondescript bushes of various sorts.  This time of year visibility is quite restricted by all the leaves, but travel is quite easy if you detour around the spruce and berry bushes." It is in At_End_Of_Road, At_Hill_In_Road, In_A_Valley, In_Forest_1, and In_Forest_2.
Understand "tree/trees/oak/maple/grove/pine/spruce/birch/ash/saplings/bushes/leaves/berry/berries/hardwood" as the forest.

[ccr]A gully is a backdrop. It is in At_End_Of_Road, At_Slit_In_Streambed, and Outside_Grate.

Section -

[L2]At_Hill_in_Road is an aboveground room with printed name "At Hill in Road" and brief description "You're at hill in road.". "You have walked up a hill, still in the forest.  The road slopes back down the other side of the hill.  There is a building in the distance."
Understand "hill/in/road" as At_Hill_In_Road.
North and forward is At_End_of_Road. South is In_Forest_1.
Understand "[road]" or "[building]" as east when the location is At_Hill_In_Road. Understand "forest" as south when the location is At_Hill_In_Road.

[ccr]A hill is scenery in At_Hill_in_Road. "It's just a typical hill."
Understand "bump/incline" as the hill.

[ccr]The other_side of hill is scenery in At_Hill_In_Road with indefinite article "the", printed name "other side of hill", and description "Why not explore it yourself?".
Understand "other/side" as the other_side.

Section -

[L3]Inside_Building is an aboveground room with printed name "Inside Building" and brief description "You're inside building.". "You are inside a building, a well house for a large spring."
Understand "inside/building/well/house/wellhouse" as Inside_Building.
Understand "outdoors" as outside when the location is Inside_Building.
Rule for supplying a missing noun while entering and the location is Inside_Building: now the noun is west.
[L79]Understand "stream" or "downstream" as a mistake ("The stream flows out through a pair of 1 foot diameter sewer pipes.  It would be advisable to use the exit.") when the location is Inside_Building.
After saying xyzzy in Inside_Building:
	unless In_Debris_Room is visited, continue the action; [This is a change from the original made in the I6 version. I kept it because it makes sense that the player should not be able to use a magic word before he discovers it.]
	move the player to In_Debris_Room as going.
After saying plugh in Inside_Building:
	unless At_Y2 is visited, continue the action;
	move the player to At_Y2 as going.
After taking a treasure in Inside_Building:
	decrease the score by deposit points of the noun;
	continue the action.
After dropping a treasure in Inside_Building:
	increase the score by deposit points of the noun;
	say [I6]"Safely deposited."

[ccr]A spring is scenery in Inside_Building. "The stream flows out through a pair of 1 foot diameter sewer pipes."
Understand "large" as the spring.

[ccr]A pair of 1 foot diameter sewer pipes is scenery in Inside_Building. "The stream flows out through a pair of 1 foot diameter sewer pipes."
Understand "pipe/one/sewer-pipes" as the sewer pipes.

[O1]A set of keys is a plural-named thing in Inside_Building with indefinite article "a" and description [ccr]"It's just a normal-looking set of keys.". [D0]"There are some keys on the ground here."
Understand "key/keyring/bunch" as the set of keys.
Instead of unlocking the keys with, say [M55]"You can't unlock the keys."
Does the player mean locking or unlocking something with the keys: it is likely.

[O19]The tasty food is an edible thing in Inside_Building with indefinite article "some" and description [ccr]"Sure looks yummy!". [D0]"There is food here."
Understand "ration/rations/tripe/yummy/delicious/scrumptious" as the tasty food.
After eating the tasty food, say [M72]"Thank you, that was delicious!"

[O2]A brass lantern is a device in Inside_Building with description [ccr]"It is a shiny brass lamp[if switched off].  It is not currently lit.[otherwise if power remaining of lantern is less than 30], glowing dimly.[otherwise], glowing brightly.". [D0+1]"There is a [if switched off]shiny brass lamp [otherwise]lamp shining [end if]nearby."
Understand "lamp/headlamp/headlight/light/shiny" as the brass lantern.
The brass lantern has a number called power remaining. The power remaining is 330.
Every turn when the lantern is switched on (this is the lamp power rule):
	decrement power remaining of the lantern;
	if power remaining of the lantern is 0:
		now the lantern is switched off;
		now the lantern is unlit;
	if the lantern is enclosed by the location:
		if the power remaining of the lantern is at most 30 and fresh batteries are enclosed by the location:
			say [M188]"Your lamp is getting dim.  I'm taking the liberty of replacing the batteries.";
			replace batteries;
		otherwise if the power remaining of the lantern is 0:
			say [M184]"Your lamp has run out of power.";
		otherwise if the power remaining of the lantern is 30:
			if fresh batteries are used:
				say [M189]"Your lamp is getting dim, and you're also out of spare batteries.  You'd best start wrapping this up.";
			otherwise if fresh batteries are in vending machine and Dead_End_14 is visited:
				say [M183]"Your lamp is getting dim.  You'd best start wrapping this up, unless you can find some fresh batteries.   I seem to recall there's a vending machine in the maze.  Bring some coins with you.";
			otherwise if fresh batteries are not in vending machine and fresh batteries are not enclosed by the location:
				say [M187]"Your lamp is getting dim.  You'd best go back for those batteries.";
Instead of doing something in an aboveground room when the power remaining of the lantern is 0:
		say [M185]"There's not much point in wandering around out here, and you can't explore the cave without a lamp.   So let's just call it a day.";
		end the story finally.
Instead of burning the lantern, try switching on the noun.
Instead of rubbing the lantern, say [M75]"Rubbing the electric lamp is not particularly rewarding.  Anyway, nothing exciting happens."
Instead of switching on the lantern when the power remaining of the lantern is at most 0, say [M184]"Your lamp has run out of power."
Instead of inserting the worn-out batteries into the lantern, say [ccr]"Those batteries are dead; they won't do any good at all."
Instead of inserting the fresh batteries into the lantern, replace batteries.
Instead of inserting something into the lantern, say [ccr]"The only thing you might successfully put in the lamp is a fresh pair of batteries."
After switching on the lantern:
	now the lantern is lit;
	say [M39]"Your lamp is now on."
After switching off the lantern:
	now the lantern is unlit;
	say [M40]"Your lamp is now off."
To replace batteries:
	now fresh batteries are nowhere;
	now fresh batteries are used;
	move worn-out batteries to location;
	now power remaining of the lantern is 2500.

[O20]A small bottle is a transparent container in Inside_Building.
Understand "jar/flask" as the bottle.
Rule for writing a paragraph about the bottle:
	if the bottle encloses water:
		say [D0]"There is a bottle of water here.";
	otherwise if the bottle encloses oil:
		say [D2]"There is a bottle of oil here.";
	otherwise:
		say [D1]"There is an empty bottle here."
Instead of taking something enclosed by the bottle, say [M24M]"You are already carrying it (in the bottle)."
Instead of inserting something into the bottle, say [M109M]"You can't fill the bottle with that."
Instead of filling the bottle:
	if something is enclosed by the noun:
		say [M105]"Your bottle is already full.";
	otherwise if the stream is in location:
		move bottled water to bottle;
		say [M107]"Your bottle is now full of water.";
		rule succeeds;
	otherwise if the pool of oil is in location:
		move bottled oil to bottle;
		say [M108]"Your bottle is now full of oil.";
		rule succeeds;
	otherwise:
		say [M106]"There is nothing here with which to fill the bottle."
Instead of emptying the bottle:
	unless something is enclosed by the noun:
		say [ccr]"The bottle is already empty!";
	otherwise:
		now the first thing held by the noun is nowhere;
		say [M77]"Your bottle is empty and the ground is wet.";
		rule succeeds.
Instead of pouring bottle on:
	if the noun contains something (called the contents), try pouring the contents on the second noun;
	otherwise say [ccr]"The bottle is empty."
Instead of drinking the bottle when the bottle encloses the bottled water: try drinking the bottled water.
Accessibility when the bottle is enclosed by the location (this is the convert bottle contents to bottle rule):
	unless something is enclosed by the bottle:
		if the noun is the bottled water or the noun is the bottled oil, now the noun is the bottle;
		rule succeeds.

[O21]The bottled water is a liquid in the small bottle with printed name "water in the bottle" and description [ccr]"It looks like ordinary water to me."
Understand "h2o" as the bottled water.
Rule for printing the name of the bottled water while listing contents: say "water".
Instead of drinking the bottled water:
	now the noun is nowhere;
	say [M74]"The bottle of water is now empty.";
	rule succeeds.
Instead of pouring the bottled water on:
	now the noun is nowhere;
	say [M77]"Your bottle is empty and the ground is wet.";
	rule succeeds.
Does the player mean drinking the bottled water: it is very likely.
Does the player mean pouring the bottled water on: it is very likely.

[O22]The bottled oil is a liquid with printed name "oil in the bottle" and description [ccr]"It looks like ordinary oil to me."
Understand "lubricant/grease" as the bottled oil.
Rule for printing the name of the bottled oil while listing contents: say "oil".
Instead of pouring the bottled oil on:
	now the noun is nowhere;
	say [M77]"Your bottle is empty and the ground is wet.";
	rule succeeds.
Does the player mean pouring the bottled oil on: it is very likely.

Section - 

[L4]In_A_Valley is an aboveground room with printed name "In A Valley" and brief description "You're in valley.". "You are in a valley in the forest beside a stream tumbling along a rocky bed."
Understand "valley" as In_A_Valley.
East, west, and up is In_Forest_1. South and down is At_Slit_In_Streambed.
Understand "upstream" or "[building]" as north when the location is In_A_Valley. Understand "forest" as east when the location is In_A_Valley. Understand "downstream" as south when the location is In_A_Valley.
In_A_Valley travels to Outside_Grate.

[ccr]The streambed is a backdrop. It is in In_A_Valley, At_Slit_In_Streambed, and Outside_Grate.
Understand "bed/rock/small/rocky/bare/dry" as the streambed.

[ccr]A valley is a backdrop with description "[if location is In_A_Valley]You're in it.[otherwise][text of examine undescribed things rule response (A)][line break]". It is in In_A_Valley, In_Forest_1, and In_Forest_2.
Understand "deep" as the valley.

[L5]In_Forest_1 is an aboveground room with printed name "In Forest" and brief description "You're in forest.". "You are in open forest, with a deep valley to one side."
Understand "forest" as In_Forest_1.
West and south is In_Forest_1. North is In_Forest_2.
Understand "valley" as east when the location is In_Forest_1. Understand "forest" as north when the location is In_Forest_1.
Instead of going forward in In_Forest_1, try going north.
Instead of going north from In_Forest_1:
	if a random chance of 1 in 2 succeeds, produce a room description with going spacing conventions; [the equivalent of going nowhere]
	otherwise continue the action.

[L6]In_Forest_2 is an aboveground room with printed name "In Forest" and brief description "You're in forest.". "You are in open forest near both a valley and a road."
North is At_End_Of_Road. East, west, and down is In_A_Valley.
Understand "[road]" as north when the location is In_Forest_2. Understand "valley" as east when the location is In_Forest_2. Understand "forest" as south when the location is In_Forest_2.

Section - 

[L7]At_Slit_In_Streambed is an aboveground room with printed name "At Slit In Streambed" and brief description "You're at slit in streambed.". "At your feet all the water of the stream splashes into a 2-inch slit in the rock.  Downstream the streambed is bare rock."
Understand "slit/in/streambed" as At_Slit_In_Streambed.
East and west is In_Forest_1. South is Outside_Grate. Up from At_Slit_In_Streambed is nowhere.
Instead of going down in At_Slit_In_Streambed, say [M95]"You don't fit through a two-inch slit!"
Understand "upstream" as north when the location is At_Slit_In_Streambed. Understand "forest" as east when the location is At_Slit_In_Streambed. Understand "downstream/rock/bed" as south when the location is At_Slit_In_Streambed. Understand "slit/stream" as down when the location is At_Slit_In_Streambed.
At_Slit_In_Streambed travels to At_End_Of_Road and Outside_Grate[not in original]. Understand "[building]" as At_End_Of_Road when the location is At_Slit_In_Streambed.

[ccr]A 2-inch slit is scenery in At_Slit_In_Streambed. "It's just a 2-inch slit in the rock, through which the stream is flowing."
Understand "two/inch" as the 2-inch slit.
Instead of entering the 2-inch slit, try going down.

Section - 

[L8]Outside_Grate is an aboveground room with printed name "Outside Grate" and brief description "You're outside grate.". "You are in a 20-foot depression floored with bare dirt.  Set into the dirt is a strong steel grate mounted in concrete.  A dry streambed leads into the depression."
Understand "outside/grate/depression" as Outside_Grate.
East, west, and south is In_Forest_1.
Understand "forest" as east when the location is Outside_Grate. Understand "upstream/gully" as north when the location is Outside_Grate.
Outside_Grate travels to At_End_Of_Road. Understand "[building]" as At_End_Of_Road when the location is Outside_Grate.
Instead of going inside in Outside_Grate, try going down.
Rule for supplying a missing noun while entering and the location is Outside_Grate: now the noun is the steel grate.

[ccr]A 20-foot depression is scenery in Outside_Grate. "You're standing in it."
Understand "dirt/twenty/foot/bare" as the depression.

[O3]The steel grate is a lockable locked unopenable open door unlocked by the set of keys with description [ccr]"[if the location is Outside_Grate]It just looks like an ordinary grate mounted in concrete.[otherwise]It's just a 3x3 steel grate mounted in the ceiling.[end if]  It is [if unlocked]open.[otherwise]locked." It is down from Outside_Grate and up from Below_The_Grate.
Understand "lock/gate/grille/metal/strong/grating" as the steel grate.
Rule for writing a paragraph about the steel grate:
	if unlocked, say [D1]"The grate is open.";
	otherwise say [D0]"The grate is locked."
Instead of going through a locked steel grate, say [M93]"You can't go through a locked steel grate!"
After locking the grate with the keys, say [M35]"The grate is now locked."
After unlocking the grate with the keys, say [M36]"The grate is now unlocked."
Instead of opening the grate:
	if the location encloses the keys:
		say "(with [the noun])[command clarification break]";
		try unlocking the grate with the keys;
	otherwise:
		say [M31]"You have no keys!"
Instead of closing the grate:
	if the location encloses the keys:
		say "(with [the noun])[command clarification break]";
		try locking the grate with the keys;
	otherwise:
		say [M31]"You have no keys!"

Chapter - Facilis descensus Averno

[L9]Below_The_Grate is a lighted not for dwarves room with printed name "Below the Grate" and brief description "You're below the grate.". "You are in a small chamber beneath a 3x3 steel grate to the surface.  A low crawl over cobbles leads inward to the west."
Understand "below/grate/entrance" as Below_The_Grate.
West and inside is In_Cobble_Crawl.
Understand "crawl/cobble" as west when the location is Below_The_Grate.
Instead of going outside in Below_The_Grate, try going up.
Below_The_Grate travels to At_Top_Of_Small_Pit and In_Debris_Room.

[ccr]Some cobbles are a backdrop. "They're just ordinary cobbles." They are in In_Cobble_Crawl, In_Debris_Room, and Below_The_Grate.
Understand "cobble/cobblestones/cobblestone/stones/stone" as the cobbles.

Section - 

[L10]In_Cobble_Crawl is a lighted not for dwarves room with printed name "In Cobble Crawl" and brief description "You're in cobble crawl.". "You are crawling over cobbles in a low passage.  There is a dim light at the east end of the passage."
Understand "cobble/crawl" as In_Cobble_Crawl.
West is In_Debris_Room.
Understand "surface" as east when the location is In_Cobble_Crawl. Understand "dark" as west when the location is In_Cobble_Crawl.
Instead of going inside in In_Cobble_Crawl, try going west.
In_Cobble_Crawl travels to At_Top_Of_Small_Pit, In_Debris_Room, and Outside_Grate.

Instead of traveling to Outside_Grate when (the location is In_Cobble_Crawl or the location is In_Debris_Room or the location is In_Awkward_Sloping_E_W_Canyon or the location is In_Bird_Chamber or the location is At_Top_Of_Small_Pit) and the steel grate is locked:
	move player to Below_The_Grate as going;
	rule succeeds.

[O4]The wicker cage is a transparent container in In_Cobble_Crawl with description [ccr]"It's a small wicker cage."
Rule for writing a paragraph about the wicker cage:
	say [D0]"There is a small wicker cage discarded nearby.";
	if the cage encloses something:
		say line break;
		carry out the writing a paragraph about activity with the first thing held by the cage.
Understand "small" as the wicker cage.
Instead of locking or unlocking the wicker cage with, say [M32]"It has no lock."
Instead of opening or closing the wicker cage, say [M32]"It has no lock."
Instead of inserting something into the wicker cage, say [ccr]"The cage isn't big enough to hold [the noun]."

Section - 

[L11]In_Debris_Room is a not for dwarves room with printed name "In Debris Room" and brief description "You're in debris room.". "You are in a debris room filled with stuff washed in from the surface.  A low wide passage with cobbles becomes plugged with mud and debris here, but an awkward canyon leads upward and west.  A note on the wall says 'MAGIC WORD XYZZY.'"
Understand "debris/room" as In_Debris_Room.
Up and west is In_Awkward_Sloping_E_W_Canyon.
Understand "crawl/cobble/passage/tunnel/low" as east when the location is In_Debris_Room. Understand "canyon" as west when the location is In_Debris_Room.
Instead of going inside in In_Debris_Room, try going west.
In_Debris_Room travels to Outside_Grate, Below_The_Grate, and At_Top_Of_Small_Pit.
After saying xyzzy in In_Debris_Room, move player to Inside_Building as going.
	
[ccr]Some debris is scenery in In_Debris_Room. "Yuck."
Understand "stuff/mud" as the debris.

[ccr]A note is scenery in In_Debris_Room. "The note says 'MAGIC WORD XYZZY'."

[O5]A black rod is a thing in In_Debris_Room with printed name "black rod" and description [ccr]"It's a three foot black rod with a rusty star on an end.". [D0]"A three foot black rod with a rusty star on an end lies nearby."
Understand "star/rusty/three/foot/iron" as the black rod.
After waving the black rod when the location contains the fissure:
	if Cave Closing is happening:
		say [M76]"Peculiar. Nothing happens.";
	otherwise if the crystal bridge is described:
		now crystal bridge is undescribed;
		say [O12 D2]"The crystal bridge has vanished!";
	otherwise:
		now crystal bridge is described;
		say initial appearance of crystal bridge;
		say line break.

Section - 

[L12]In_Awkward_Sloping_E_W_Canyon is a not for dwarves room with printed name "In Awkward Sloping E/W Canyon". "You are in an awkward sloping east/west canyon."
Understand "awkward/sloping/e[/]w/canyon" as In_Awkward_Sloping_E_W_Canyon.
Up and west is In_Bird_Chamber.
Instead of going inside in In_Awkward_Sloping_E_W_Canyon, try going west.
In_Awkward_Sloping_E_W_Canyon travels to Outside_Grate, Below_The_Grate, In_Debris_Room, and At_Top_Of_Small_Pit.

Chapter - The little bird in its natural habitat

[L13]In_Bird_Chamber is a not for dwarves room with printed name "In Bird Chamber" and brief description "You're in bird chamber.". "You are in a splendid chamber thirty feet high.  The walls are frozen rivers of orange stone.  An awkward canyon and a good passage exit from east and west sides of the chamber."
Understand "orange/river/bird/chamber" as In_Bird_Chamber.
Down from In_Bird_Chamber and up from In_Bird_Chamber is nowhere. West is At_Top_Of_Small_Pit.
Understand "canyon" as east when the location is In_Bird_Chamber. Understand "passage/tunnel" as west when the location is In_Bird_Chamber.
In_Bird_Chamber travels to Outside_Grate, Below_The_Grate, In_Debris_Room, and At_Top_Of_Small_Pit.

[O8]A little bird is an animal in In_Bird_Chamber with description [ccr]"[if the bird is enclosed by wicker cage]The little bird looks unhappy in the cage[otherwise]The cheerful little bird is sitting here singing[end if]."
Understand "cheerful/mournful" as the little bird.
Rule for printing the name of the little bird while taking inventory: say "little bird in cage".
Rule for writing a paragraph about the little bird:
	if the bird is in the cage, say [D1]"There is a little bird in the cage.";
	otherwise say [D0]"A cheerful little bird is sitting here singing."
Instead of taking or inserting the little bird into when the player encloses the black rod: say [M26]"The bird was unafraid when you entered, but as you approach it becomes disturbed and you cannot catch it."
Instead of inserting the little bird into the wicker cage:
	if the little bird is enclosed by the cage:
		say "The little bird is already in the cage!";
	otherwise:
		unless the player encloses the wicker cage, carry out the implicitly taking activity with the second noun;
		try taking the noun;
		if the cage encloses the noun, rule succeeds.
Instead of removing the little bird from the wicker cage, abide by the free the bird rule.
Instead of taking the little bird:
	if the noun is in the wicker cage:
		try taking the wicker cage;
	otherwise if the wicker cage is not enclosed by the player:
		say [M27]"You can catch the bird, but you cannot carry it.";
	otherwise:
		now the noun is in the wicker cage;
		say [I6]"You catch the bird in the wicker cage.";
		rule succeeds.
Instead of dropping the little bird:
	unless the player encloses the noun, say [M29]"You aren't carrying it!";
	otherwise abide by the free the bird rule.
Instead of giving something to the little bird, say [M100]"It's not hungry (it's merely pinin['] for the fjords).  Besides, you have no bird seed."
Instead of asking the little bird to try doing something, say [I6]"Cheep! Chirp!"
Instead of asking the little bird about something, say [I6]"Cheep! Chirp!"
Instead of answering the little bird that something, say [I6]"Cheep! Chirp!"
Instead of attacking the little bird:
	if Cave Closing has happened:
		say [M137]"Oh, leave the poor unhappy bird alone.";
	otherwise:
		now the noun is nowhere;
		if the snake is on-stage, now the jewelry is elusive;
		say [M45]"The little bird is now dead.  Its body disappears.";
		rule succeeds.
This is the free the bird rule:
	now the bird is in location;
	if the snake is in location:
		now the snake is nowhere;
		say [M30]"The little bird attacks the green snake, and in an astounding flurry drives the snake away.";
	otherwise if the dragon is in location:
		now the bird is nowhere;
		say [M154]"The little bird attacks the green dragon, and in an astounding flurry gets burnt to a cinder.  The ashes blow away.";
		if the snake is on-stage, now the jewelry is elusive;
	otherwise:
		say [I6]"The little bird flies free.";
	rule succeeds.
The carrying requirements rule does nothing when doing something to the little bird and the little bird is in the wicker cage.
The can't put what's not held rule does nothing when putting the little bird on something and the little bird is in the wicker cage.

Section -

[L14]At_Top_Of_Small_Pit is a not for dwarves room with printed name "At Top of Small Pit" and brief description "You're at top of small pit.". "At your feet is a small pit breathing traces of white mist.  A west passage ends here except for a small crack leading on."
Understand "top/of/small/pit" as At_Top_Of_Small_Pit.
Understand "passage/tunnel" as east when the location is At_Top_Of_Small_Pit. Understand "crack" as west when the location is At_Top_Of_Small_Pit.
At_Top_Of_Small_Pit travels to Outside_Grate, Below_The_Grate, and In_Debris_Room.
[L16]Instead of going west in At_Top_Of_Small_Pit, say "The crack is far too small for you to follow."
[L20]Instead of going down from At_Top_Of_Small_Pit when the gold nugget is enclosed by the player:
	say "You are at the bottom of the pit with a broken neck.";
	end the story;
	rule succeeds.
Instead of entering the crack, try going west.

[O7]Some rough stone steps are a open unopenable door. They are down from At_Top_Of_Small_Pit and up from In_Hall_Of_Mists. [D0+1]"Rough stone steps lead [if location is At_Top_Of_Small_Pit]down the pit[otherwise]up the dome[end if]."
Understand "pit" as the steps. Understand "dome/passage/tunnel" as the steps when the location is In_Hall_Of_Mists.
Rule for writing a paragraph about the steps when the player encloses the gold nugget: now the steps are mentioned.

[ccr]A small pit is scenery in At_Top_Of_Small_Pit. "The pit is breathing traces of white mist."

[ccr]A crack is scenery in At_Top_Of_Small_Pit. "The crack is very small -- far too small for you to follow."
Understand "small" as the crack.

[ccr]The mist is a referable backdrop. [M69]"Mist is a white vapor, usually water, seen from time to time in caverns.  It can be found anywhere but is frequently a sign of a deep pit leading down to water."
It is in At_Top_Of_Small_Pit, In_Hall_Of_Mists, On_East_Bank_Of_Fissure, At_Window_On_Pit_1, At_West_End_Of_Hall_Of_Mists, In_Misty_Cavern, In_Mirror_Canyon, At_Reservoir, At_Window_On_Pit_2, and On_Sw_Side_Of_Chasm.
Understand "vapor/wisps/white" as the mist.

Chapter - The caves open up - The Hall of Mists

[L15]In_Hall_Of_Mists is a room with printed name "In Hall of Mists" and brief description "You're in Hall of Mists.". "You are at one end of a vast hall stretching forward out of sight to the west.  There are openings to either side.  Nearby, a wide stone staircase leads downward.  The hall is filled with wisps of white mist swaying to and fro almost as if alive.  A cold wind blows up the staircase.  There is a passage at the top of a dome behind you."
Understand "hall/of/mists" as In_Hall_Of_Mists.
South and left is In_Nugget_Of_Gold_Room. West and forward is On_East_Bank_Of_Fissure. Down and north is In_Hall_Of_Mt_King.
Instead of going east in In_Hall_Of_Mists, try going up.
[L22]Instead of going up from In_Hall_Of_Mists when the gold nugget is enclosed by the player, say "The dome is unclimbable."
Understand "hall" as west when the location is In_Hall_Of_Mists. Understand "stairs" as down when the location is In_Hall_Of_Mists. 
In_Hall_Of_Mists travels to At_Y2. After traveling to At_Y2 when the prior location of the player is In_Hall_Of_Mists, move the player to Jumble_Of_Rock.

[ccr]A wide stone staircase is scenery in In_Hall_Of_Mists. "The staircase leads down."
Understand "stair/stairs" as the stone staircase.

[ccr]A dome is climbable scenery in In_Hall_Of_Mists. "[if the gold nugget is enclosed by the player]I'm not sure you'll be able to get up it with what you're carrying.[otherwise]It looks like you might be able to climb up it."
Instead of climbing the dome, try going up.

Section - 

[L18]In_Nugget_Of_Gold_Room is a room with printed name "In Nugget of Gold Room" and brief description "You're in nugget of gold room.". "This is a low room with a crude note on the wall.  The note says, 'You won't get it up the steps'."
Understand "low/room" as In_Nugget_Of_Gold_Room.
Instead of going outside in In_Nugget_Of_Gold_Room, try going north.
Understand "hall" as north when location is In_Nugget_Of_Gold_Room.

[ccr]A crude note is scenery in In_Nugget_Of_Gold_Room with printed name "note". "The note says, 'You won't get it up the steps'."

[O50]The large gold nugget is a treasure in In_Nugget_Of_Gold_Room with description [ccr]"It's a large sparkling nugget of gold!". "There is a large sparkling nugget of gold here!"
Understand "heavy" as the gold nugget.

Section - 

[L17]On_East_Bank_Of_Fissure is a room with printed name "On East Bank of Fissure" and brief description "You're on east bank of fissure.". "You are on the east bank of a fissure slicing clear across the hall.  The mist is quite thick here, and the fissure is too wide to jump."
Understand "east/e/bank/side/of/fissure" as On_East_Bank_Of_Fissure.
Understand "hall" as east when the location is On_East_Bank_Of_Fissure. Understand "over/across" as west when the location is On_East_Bank_Of_Fissure.
Instead of going forward in On_East_Bank_Of_Fissure:
	if the crystal bridge is described, try going west;
	otherwise try jumping.
Rule for supplying a missing noun while entering and the location contains the crystal bridge: now the noun is the crystal bridge.

[L27]West_Side_Of_Fissure is a room with printed name "West Side of Fissure". "You are on the west side of the fissure in the hall of mists."
Understand "west/w/bank/side/of/fissure" as West_Side_Of_Fissure.
West and north is At_West_End_Of_Hall_Of_Mists. South from West_Side_Of_Fissure is nowhere.
Understand "over/across" as east when the location is West_Side_Of_Fissure.
Instead of going forward in West_Side_Of_Fissure:
	if the crystal bridge is described, try going east;
	otherwise try jumping.
[L40]Before going north from West_Side_Of_Fissure, say "You have crawled through a very low wide passage parallel to and north of the hall of mists."

[O51]Some diamonds are a treasure in West_Side_Of_Fissure with printed name "several diamonds" and description [ccr]"They look to be of the highest quality!". "There are diamonds here!"
Understand "diamond/several/high/quality" as the diamonds.

[O12]The crystal bridge is an undescribed privately-named open unopenable door with description [ccr]"It spans the fissure, thereby providing you a way across.". It is east from West_Side_Of_Fissure and west from On_East_Bank_Of_Fissure. [D1]"A crystal bridge now spans the fissure."
Understand "crystal/bridge" as the crystal bridge when the crystal bridge is described.
Instead of going through an undescribed crystal bridge, say [M97]"There is no way across the fissure."

[ccr]A fissure is a backdrop. "The fissure looks far too wide to jump." It is in On_East_Bank_Of_Fissure and West_Side_Of_Fissure.
Understand "wide" as the fissure.
Instead of jumping in a room containing the fissure:
	if crystal bridge is described:
		say [M96]"I respectfully suggest you go across the bridge instead of jumping.";
	otherwise:
		say [L21]"You didn't make it.";
		end the story;
		rule succeeds.
Instead of entering the fissure, try entering the crystal bridge.

Section - 

[L41]At_West_End_Of_Hall_Of_Mists is a room with printed name "At West End of Hall of Mists" and brief description "You're at west end of Hall of Mists.". "You are at the west end of the hall of mists.  A low wide crawl continues west and another goes north.  To the south is a little passage 6 feet off the floor."
Understand "west/w/end/of/hall/mists" as At_West_End_Of_Hall_Of_Mists.
South and up is Alike_Maze_1. North is West_Side_Of_Fissure. West is At_East_End_Of_Long_Hall. Down from At_West_End_Of_Hall_Of_Mists is nowhere.
Understand "passage/tunnel/climb" as south when the location is At_West_End_Of_Hall_Of_Mists. Understand "crawl" as west when the location is At_West_End_Of_Hall_Of_Mists.
[L59]Before going north from At_West_End_Of_Hall_Of_Mists, say "You have crawled through a very low wide passage parallel to and north of the hall of mists."
Rule for supplying a missing noun while climbing and the location is At_West_End_Of_Hall_Of_Mists:
	now the noun is south;
	now clarified is true.

Chapter - Long Hall to the west of the Hall of Mists

[L60]At_East_End_Of_Long_Hall is a room with printed name "At East End of Long Hall" and brief description "You're at east end of long hall.". "You are at the east end of a very long hall apparently without side chambers.  To the east a low wide crawl slants up.  To the north a round two foot hole slants down."
Understand "east/e/end/of/long/hall" as At_East_End_Of_Long_Hall.
Up is At_West_End_Of_Hall_Of_Mists. West is At_West_End_Of_Long_Hall. Down and north is Crossover.
Understand "crawl" as east when the location is At_East_End_Of_Long_Hall. Understand "hole" as down when the location is At_East_End_Of_Long_Hall.

Section - 

[L61]At_West_End_Of_Long_Hall is a room with printed name "At West End of Long Hall" and brief description "You're at west end of long hall.". "You are at the west end of a very long featureless hall.  The hall joins up with a narrow north/south passage."
Understand "west/w/end/of/long/hall" as At_West_End_Of_Long_Hall.
South is Different_Maze_1. North is Crossover. Up from At_West_End_Of_Long_Hall is nowhere.

Section - 

[L62]Crossover is a room with printed name "N/S and E/W Crossover". "You are at a crossover of a high N/S passage and a low E/W one."
Understand "n[/]s/and/e[/]w" as Crossover.
West is At_East_End_Of_Long_Hall. North is Dead_End_7. Up from Crossover and down from Crossover is nowhere.

[ccr]A cross-over is scenery in Crossover with printed name "crossover". "You know as much as I do at this point."
Understand "crossover/over/cross" as the cross-over.

[L63]Dead_End_7 is a deadend room.

Chapter - The Hall of the Mountain King and side chambers

[L19]In_Hall_Of_Mt_King is a room with printed name "In Hall of Mt. King" and brief description "You're in Hall of Mt. King.". "You are in the hall of the mountain king, with passages off in all directions."
Understand "hall/of/mountain/king" as In_Hall_Of_Mt_King.
East is In_Hall_Of_Mists. North and left is Low_N_S_Passage. South and right is In_South_Side_Chamber. West and forward is In_West_Side_Chamber. Southwest is In_Secret_E_W_Canyon.
Understand "stairs" as up when location is In_Hall_Of_Mt_King.
In_Hall_Of_Mt_King travels to In_Secret_E_W_Canyon.
Instead of going nowhere from In_Hall_Of_Mt_King, say [I6]"Well, perhaps not quite all directions."
[L32]Instead of going from In_Hall_Of_Mt_King when the snake is in the location:
	if noun is north or noun is south or noun is west or noun is left or noun is right or noun is forward or (noun is southwest and a random chance of 13 in 20 succeeds), say "You can't get by the snake.";
	otherwise continue the action.

[O11]The snake is an animal in In_Hall_Of_Mt_King with description [ccr]"I wouldn't mess with it if I were you.". [D0]"A huge green fierce snake bars the way!"
Understand "cobra/asp/huge/fierce/green/ferocious/venemous/venomous/large/big/killer" as the snake.
Instead of asking the snake to try doing something, say [I6]"Hiss!"
Instead of asking the snake about something, say [I6]"Hiss!"
Instead of answering the snake that something, say [I6]"Hiss!"
Instead of throwing something at the snake:
	if the noun is the axe, try attacking the snake;
	otherwise try giving the noun to the snake.
Instead of giving something to the snake:
	if the noun is the little bird:
		now the little bird is nowhere;
		say [M101]"The snake has now devoured your bird.";
		now the jewelry is elusive;
		rule succeeds;
	otherwise:
		say [M102]"There's nothing here it wants to eat (except perhaps you)."
Instead of attacking the snake, say [M46]"Attacking the snake both doesn't work and is very dangerous."

Section - 

[L28]Low_N_S_Passage is a room with printed name "Low N/S Passage". "You are in a low N/S passage at a hole in the floor.  The hole goes down to an E/W passage."
Understand "low/n[/]s/passage" as Low_N_S_Passage.
Down is In_Dirty_Passage. North is At_Y2.
Instead of going outside in Low_N_S_Passage, try going south.
Understand "hall" as south when the location is Low_N_S_Passage. Understand "hole" as down when the location is Low_N_S_Passage.
Low_N_S_Passage travels to At_Y2.

[O52]Some bars of silver are a treasure in Low_N_S_Passage with description [ccr]"They're probably worth a fortune!". [D0]"There are bars of silver here!"

Section - 

[L29]In_South_Side_Chamber is a room with printed name "In South Side Chamber". "You are in the south side chamber."
Understand "south/s/side/chamber" as In_South_Side_Chamber.
Instead of going outside in In_South_Side_Chamber, try going north.
Understand "hall" as north when the location is In_South_Side_Chamber.

[O53]The precious jewelry is a treasure in In_South_Side_Chamber with indefinite article "some" and description [ccr]"It's all quite exquisite!". [D0]"There is precious jewelry here!"
Understand "jewel/jewels/exquisite" as the precious jewelry.

Section - 

[L30]In_West_Side_Chamber is a room with printed name "In West Side Chamber". "You are in the west side chamber of the hall of the mountain king.  A passage continues west and up here."
Understand "west/w/wide/chamber" as In_West_Side_Chamber.
West and up is Crossover.
Instead of going outside in In_West_Side_Chamber, try going east.
Understand "hall" as east when the location is In_West_Side_Chamber.

[O54]Some rare coins are a treasure in In_West_Side_Chamber with indefinite article "many" and description [ccr]"They're a numismatist's dream!". "There are many coins here!"

Chapter - The Y2 Rock Room and environs, slightly below

[L33]At_Y2 is a room with printed name "At 'Y2'" and brief description "You're at 'Y2'.". "You are in a large room, with a passage to the south, a passage to the west, and a wall of broken rock to the east.  There is a large 'Y2' on a rock in the room's center."
Understand "y2" as At_Y2.
East is Jumble_Of_Rock. West is At_Window_On_Pit_1. Up from At_Y2 is nowhere.
Understand "wall/broken" as east when the location is At_Y2.
After looking in At_Y2 when not in darkness:
	unless Cave Closing is happening:
		if a random chance of 1 in 4 succeeds, say [M8]"A hollow voice says, 'PLUGH'.";
	continue the action.
After saying plugh in At_Y2, move player to Inside_Building as going.
After saying plover in At_Y2:
	if In_Plover_Room is unvisited, continue the action;
	if emerald is enclosed by the player:
		move emerald to the location;
	move the player to In_Plover_Room as going.

[ccr]Y2 rock is an enterable scenery supporter in At_Y2 with printed name "'Y2' rock". "There is a large 'Y2' painted on the rock."

Section - 

[L34]Jumble_Of_Rock is a room with printed name "Jumble of Rock". "You are in a jumble of rock, with cracks everywhere."
Understand "jumble/of/rock" as Jumble_Of_Rock.
Down is At_Y2. Up is In_Hall_Of_Mists. West from Jumble_Of_Rock is nowhere.
Jumble_Of_Rock travels to At_Y2.

Section - 

[L35]At_Window_On_Pit_1 is a room with printed name "At Window on Pit" and brief description "You're at window on pit.". "You're at a low window overlooking a huge pit, which extends up out of sight.  A floor is indistinctly visible over 50 feet below.  Traces of white mist cover the floor of the pit, becoming thicker to the right.  Marks in the dust around the window would seem to indicate that someone has been here recently.  Directly across the pit from you and 25 feet away there is a similar window looking into a lighted room.  A shadowy figure can be seen there peering back at you."
Understand "window/on/pit/east/e" as At_Window_On_Pit_1.
At_Window_On_Pit_1 travels to At_Y2.
[L20]Instead of jumping in At_Window_On_Pit_1:
	say "You are at the bottom of the pit with a broken neck.";
	end the story;
	rule succeeds.
Instead of going nowhere from At_Window_On_Pit_1, say [I6]"The only passage is back east to 'Y2'."

[ccr]A window is a backdrop. "It looks like a regular window."
Understand "low" as the window.

[ccr]The huge-pit is a backdrop with printed name "huge pit". "It's so deep you can barely make out the floor below, and the top isn't visible at all."
Understand "deep/large/huge/pit" as the huge-pit.

[ccr]Some marks in the dust are a backdrop. "Evidently you're not alone here."

[O27]A shadowy figure is a not scenery backdrop. [D0]"The shadowy figure seems to be trying to attract your attention."
Understand "shadow/person/individual/mysterious" as the shadowy figure.

The window, huge-pit, marks in the dust, and shadowy figure are in At_Window_On_Pit_1 and At_Window_On_Pit_2.

Section - 

[L36]In_Dirty_Passage is a room with printed name "In Dirty Passage" and brief description "You're in dirty passage.". "You are in a dirty broken passage.  To the east is a crawl.  To the west is a large passage.  Above you is a hole to another passage."
Understand "dirty/passage" as In_Dirty_Passage.
East is On_Brink_Of_Pit. West is In_Dusty_Rock_Room.
Understand "crawl" as east when the location is In_Dirty_Passage. Understand "hole" as up when the location is In_Dirty_Passage.
In_Dirty_Passage travels to In_Bedquilt.

Section - 

[L37]On_Brink_Of_Pit is a room with printed name "On Brink of Pit". "You are on the brink of a small clean climbable pit.  A crawl leads west."
Understand "brink/of/pit" as On_Brink_Of_Pit.
Down is In_Pit.
Understand "crawl" as west when the location is On_Brink_Of_Pit. Understand "pit/climb" as down when the location is On_Brink_Of_Pit.

[ccr]A clean small pit is climbable scenery in On_Brink_Of_Pit with printed name "small pit". "It looks like you might be able to climb down into it."
Understand "climbable" as the clean small pit.
Instead of climbing or entering the clean small pit, try going down.
Rule for supplying a missing noun while entering when the location is On_Brink_Of_Pit: now the noun is the clean small pit.

Section - 

[L38]In_Pit is a not for dwarves room with printed name "In Pit". "You are in the bottom of a small pit with a little stream, which enters and exits through tiny slits."
Understand "in/pit" as In_Pit.
Instead of going outside in In_Pit, try going up.
Instead of going down in In_Pit, say [M95M]"You don't fit through the tiny slits!"
Understand "climb" as up when the location is In_Pit. Understand "slit/stream/upstream/downstream" as down when the location is In_Pit.
Rule for supplying a missing noun while climbing and the location is In_Pit:
	now the noun is up;
	now clarified is true.

[ccr]Some tiny-slits are privately-named scenery in In_Pit with printed name "tiny slits". "The slits form a complex pattern in the rock."
Understand "tiny/slit/slits" as the tiny-slits.

Section - 

[L39]In_Dusty_Rock_Room is a room with printed name "In Dusty Rock Room" and brief description "You're in dusty rock room.". "You are in a large room full of dusty rocks.  There is a big hole in the floor.  There are cracks everywhere, and a passage leading east."
Understand "dusty/rock/room" as In_Dusty_Rock_Room.
Down is At_Complex_Junction.
Understand "passage/tunnel" as east when the location is In_Dusty_Rock_Room. Understand "hole/floor" as down when the location is In_Dusty_Rock_Room.
In_Dusty_Rock_Room travels to In_Bedquilt.

[ccr]Some dusty rocks are scenery in In_Dusty_Rock_Room. "They're just rocks.  (Dusty ones, that is.)".
Understand "boulders/stones/rock/boulder/stone/dirty" as the dusty rocks.
Instead of looking under, pushing, or pulling the dusty rocks, say [I6]"You'd have to blast your way through."

Chapter - A maze of twisty little passages, all alike

The Maze Area is a region.

[L42]Alike_Maze_1 is a maze room in Maze Area.
Up is At_West_End_Of_Hall_Of_Mists. North is Alike_Maze_1. East is Alike_Maze_2. South is Alike_Maze_4. West is Alike_Maze_11.

[L43]Alike_Maze_2 is a maze room in Maze Area.
West is Alike_Maze_1. South is Alike_Maze_3. East is Alike_Maze_4.

[L44]Alike_Maze_3 is a maze room in Maze Area.
East is Alike_Maze_2. Down is Dead_End_3. South is Alike_Maze_6. North is Dead_End_10[13]. West from Alike_Maze_3 is nowhere.

[L45]Alike_Maze_4 is a maze room in Maze Area.
West is Alike_Maze_1. North is Alike_Maze_2. East is Dead_End_1. South is Dead_End_2. Up and down is Alike_Maze_14.

[L49]Alike_Maze_5 is a maze room in Maze Area.
East is Alike_Maze_6. West is Alike_Maze_7.

[L50]Alike_Maze_6 is a maze room in Maze Area.
East is Alike_Maze_3. West is Alike_Maze_5. Down is Alike_Maze_7. South is Alike_Maze_8. North from Alike_Maze_6 is nowhere.

[L46]Dead_End_1 is a forbidden deadend room in Maze Area.

[L47]Dead_End_2 is a forbidden deadend room in Maze Area.
East[West] is Alike_Maze_4. North from Dead_End_2 is nowhere.

[L48]Dead_End_3 is a forbidden deadend room in Maze Area.

[L51]Alike_Maze_7 is a maze room in Maze Area.
West is Alike_Maze_5. Up is Alike_Maze_6. East is Alike_Maze_8. South is Alike_Maze_9.

[L52]Alike_Maze_8 is a maze room in Maze Area.
West is Alike_Maze_6. East is Alike_Maze_7. South is Alike_Maze_8. Up is Alike_Maze_9. North is Alike_Maze_10. Down is Dead_End_12.

[L53]Alike_Maze_9 is a maze room in Maze Area.
West is Alike_Maze_7. North is Alike_Maze_8. South is Dead_End_4. East from Alike_Maze_9 and down from Alike_Maze_9 is nowhere.

[L54]Dead_End_4 is a forbidden deadend room in Maze Area.
West is Alike_Maze_9. North from Dead_End_4 is nowhere.

[L55]Alike_Maze_10 is a maze room in Maze Area.
West is Alike_Maze_8. North is Alike_Maze_10. Down is Dead_End_5. East is At_Brink_Of_Pit. South from Alike_Maze_10 is nowhere.

[L56]Dead_End_5 is a forbidden deadend room in Maze Area.

Section - 

[L57]At_Brink_Of_Pit is a room with printed name "At Brink of Pit" and brief description "You're at brink of pit.". "You are on the brink of a thirty foot pit with a massive orange column down one wall.  You could climb down here but you could not get back up.  The maze continues at this level."
Understand "brink/of/pit" as At_Brink_Of_Pit.
Down is In_Bird_Chamber. South is Dead_End_6. North is Alike_Maze_12. East is Alike_Maze_13.

[ccr]A massive orange column is climbable scenery in At_Brink_Of_Pit. "It looks like you could climb down it."
Understand "big/huge" as the column.
Instead of climbing the column, try going down.

[ccr]A thirty-foot pit is scenery in At_Brink_Of_Pit with printed name "pit". "You'll have to climb down to find out anything more..."
Understand "thirty/foot" as the pit.
Instead of climbing the thirty-foot pit, try going down.

[L58]Dead_End_6 is a forbidden deadend room.
East is At_Brink_Of_Pit. North from Dead_End_6 is nowhere.

Chapter - A line of three vital junctions, east to west

[L64]At_Complex_Junction is a room with printed name "At Complex Junction" and brief description "You're at complex junction.". "You are at a complex junction.  A low hands and knees passage from the north joins a higher crawl from the east to make a walking passage going west.  There is also a large room above.  The air is damp here."
Understand "complex/junction" as At_Complex_Junction.
West is In_Bedquilt. North is In_Shell_Room. East is In_Anteroom. Down from At_Complex_Junction is nowhere.
Understand "climb/room" as up when the location is At_Complex_Junction.
At_Complex_Junction travels to In_Bedquilt and In_Shell_Room.
Rule for supplying a missing noun while climbing and the location is At_Complex_Junction:
	now the noun is up;
	now clarified is true.

Section - 

[L65]In_Bedquilt is a room with printed name "In Bedquilt". "You are in bedquilt, a long east/west passage with holes everywhere.  To explore at random select north, south, up, or down."
Understand "bedquilt" as In_Bedquilt.
West is In_Swiss_Cheese_Room. South is In_Slab_Room. Up is In_Dusty_Rock_Room. North is At_Junction_Of_Three. Down is In_Anteroom. Southwest from In_Bedquilt is nowhere.
In_Bedquilt travels to In_Slab_Room.
Instead of going in In_Bedquilt:
	let destiny be a room;
	if (the noun is south or the noun is up or the noun is down) and a random chance of 4 in 5 succeeds:
		let destiny be In_Bedquilt;
	otherwise if the noun is up and a random chance of 1 in 2 succeeds:
		let destiny be In_Secret_N_S_Canyon_1;
	if the noun is north and a random chance of 3 in 5 succeeds:
		let destiny be In_Bedquilt;
	otherwise if the noun is north and a random chance of 3 in 4 succeeds:
		let destiny be In_Large_Low_Room;
	if destiny is In_Bedquilt:
		say [M56]"You have crawled around in some little holes and wound up back in the main passage.";
	otherwise if destiny is nothing:
		continue the action;
	otherwise:
		move player to destiny as going;
		rule succeeds.

Section - 

[L66]In_Swiss_Cheese_Room is a room with printed name "In Swiss Cheese Room" and brief description "You're in Swiss Cheese Room.". "You are in a room whose walls resemble swiss cheese.  Obvious passages go west, east, ne, and nw.  Part of the room is occupied by a large bedrock block."
Understand "swiss/cheese/room" as In_Swiss_Cheese_Room.
West is At_East_End_Of_Twopit_Room. South is In_Tall_E_W_Canyon. Northeast is In_Bedquilt. Northwest is In_Oriental_Room. East is In_Soft_Room.
In_Swiss_Cheese_Room travels to In_Tall_E_W_Canyon and In_Oriental_Room.
Instead of going in In_Swiss_Cheese_Room:
	if (the noun is south and a random chance of 4 in 5 succeeds) or (the noun is northwest and a random chance of 1 in 2 succeeds):
		say [M56]"You have crawled around in some little holes and wound up back in the main passage.";
	otherwise:
		continue the action.

[ccr]A bedrock block is scenery in In_Swiss_Cheese_Room. "It's just a huge block."
Understand "large" as the block.
Instead of looking under, pushing, pulling, or taking the bedrock block, say [ccr]"Surely you're joking."

Chapter - The Twopit Room area

[L23]At_West_End_Of_Twopit_Room is a twopit room with printed name "At West End of Twopit Room" and brief description "You're at west end of Twopit Room.". "You are at the west end of the twopit room.  There is a large hole in the wall above the pit at this end of the room."
Understand "west/w/end/of/twopit/room" as At_West_End_Of_Twopit_Room.
East is At_East_End_Of_Twopit_Room. West is In_Slab_Room. Down is In_West_Pit.
Instead of going up in At_West_End_Of_Twopit_Room, say [M148]"It is too far up for you to reach."
Understand "across" as east when the location is At_West_End_Of_Twopit_Room. Understand "pit" as down when the location is At_West_End_Of_Twopit_Room. Understand "hole" as up when the location is At_West_End_Of_Twopit_Room.
At_West_End_Of_Twopit_Room travels to In_Slab_Room.

[O25]The beanstalk is a not scenery climbable backdrop with printed name "[if height of plant is tall]top of 12-foot-tall beanstalk[otherwise]huge beanstalk".
Understand "plant/stalk/bean/giant/tiny/little/murmuring/twelve/foot/tall/bellowing" as the beanstalk.
Rule for writing a paragraph about the beanstalk:
	if height of plant is tall, say [D1]"The top of a 12-foot-tall beanstalk is poking out of the west pit.";
	otherwise say [D2]"There is a huge beanstalk growing out of the west pit up to the hole."
Instead of examining the beanstalk:
	carry out the writing a paragraph about activity with the beanstalk;
	rule succeeds.
Instead of climbing the beanstalk:
	if height of plant is huge, try climbing the plant;
	otherwise continue the action.

[ccr]The w hole above pit is a backdrop. "The hole is in the wall above the pit at this end of the room.". It is in In_West_Pit and At_West_End_Of_Twopit_Room.
Understand "large" as the w hole above pit.
Instead of entering the w hole above pit, try going up.

Section - 

[L25]In_West_Pit is a not for dwarves room with printed name "In West Pit" and brief description "You're in west pit.". "You are at the bottom of the western pit in the twopit room.  There is a large hole in the wall about 25 feet above you."
Understand "in/west/pit" as In_West_Pit.
Instead of going outside in In_West_Pit, try going up.

[O24]The plant is a climbable fixed in place thing in In_West_Pit with printed name "[if height of plant is tiny]plant[otherwise if height of plant is tall]beanstalk[otherwise]giant beanstalk". The plant has a height. The height of the plant is usually tiny.
Understand "beanstalk/stalk/bean/giant/tiny/little/murmuring/twelve/foot/tall/bellowing" as the plant.
Rule for writing a paragraph about the plant:
	if height of plant is:
		-- tiny: say [D0]"There is a tiny little plant in the pit, murmuring 'Water, water, ...'";
		-- tall: say [D2]"There is a 12-foot-tall beanstalk stretching up out of the pit, bellowing 'Water!! Water!!'";
		-- huge: say [D4]"There is a gigantic beanstalk stretching all the way up to the hole."
[L31]Instead of climbing the plant:
	if height of plant is:
		-- tiny:
			say [L89]"There is nothing here to climb.  Use 'up' or 'out' to leave the pit.";
		-- tall:
			say [L90]"You have climbed up the plant and out of the pit.";
			try going up;
		-- huge:
			say [L26]"You clamber up the plant and scurry through the hole at the top.";
			move player to In_Narrow_Corridor as going;
			rule succeeds.
Instead of taking the plant when the height of the plant is tiny, say [M115]"The plant has exceptionally deep roots and cannot be pulled free."
Instead of pouring the bottled oil on the plant:
	now the bottled oil is nowhere;
	say [M112]"The plant indignantly shakes the oil off its leaves and asks, 'Water?'";
	rule succeeds.
Instead of pouring the bottled water on the plant:
	now the bottled water is nowhere;
	if height of the second noun is:
		-- tiny:
			say [D1]"The plant spurts into furious growth for a few seconds.";
			move beanstalk backdrop to all twopit rooms;
			now height of the second noun is tall;
		-- tall:
			say [D3]"The plant grows explosively, almost filling the bottom of the pit.";
			now height of the second noun is huge;
		-- huge:
			say [D5]"You've over-watered the plant! It's shriveling up! It's, it's...";
			now the beanstalk is nowhere;
			now height of the second noun is tiny;
	say line break;
	carry out the writing a paragraph about activity with the plant;
	rule succeeds.
Instead of examining the plant:
	carry out the writing a paragraph about activity with the plant;
	rule succeeds.
Rule for supplying a missing second noun while pouring and the plant is in the location:
	now the second noun is the plant;
	say "(on [the second noun])[command clarification break]".

Section - 

[L67]At_East_End_Of_Twopit_Room is a twopit room with printed name "At East End of Twopit Room" and brief description "You're at east end of Twopit Room.". "You are at the east end of the twopit room.  The floor here is littered with thin rock slabs, which make it easy to descend the pits.  There is a path here bypassing the pits to connect passages from east and west.  There are holes all over, but the only big one is on the wall directly over the west pit where you can't get to it."
Understand "east/e/end/of/twopit/room" as At_East_End_Of_Twopit_Room.
Down is In_East_Pit.
Understand "across" as west when the location is At_East_End_Of_Twopit_Room. Understand "pit" as down when the location is At_East_End_Of_Twopit_Room.

[ccr]Some thin rock slabs are scenery in At_East_End_Of_Twopit_Room. "They almost form natural stairs down into the pit."
Understand "slab/rocks/stairs" as the thin rock slabs.
Instead of looking under, pushing, pulling, or taking the thin rock slabs, say [ccr+I6]"Surely you're joking. You'd have to blast them aside."

Section - 

[L24]In_East_Pit is a not for dwarves room with printed name "In East Pit" and brief description "You're in east pit.". "You are at the bottom of the eastern pit in the twopit room.  There is a small pool of oil in one corner of the pit."
Understand "in/east/e/pit" as In_East_Pit.
Instead of going outside in In_East_Pit, try going up.

[ccr]A pool of oil is scenery in In_East_Pit. "It looks like ordinary oil."
Understand "small" as the pool of oil.
Instead of taking the pool of oil:
	unless the player encloses the bottle, say [M104]"You have nothing in which to carry it.";
	otherwise try filling the bottle.
Instead of inserting the pool of oil into the bottle, try filling the bottle.
Instead of inserting the pool of oil into something, say [M104]"You have nothing in which to carry it."

[ccr]The e hole above pit is a backdrop. "The hole is in the wall above you.". It is in In_East_Pit and At_East_End_Of_Twopit_Room.
Understand "large" as e hole above pit.

Section - 

[L68]In_Slab_Room is a room with printed name "In Slab Room" and brief description "You're in Slab Room.". "You are in a large low circular chamber whose floor is an immense slab fallen from the ceiling (slab room).  East and west there once were large passages, but they are now filled with boulders.  Low small passages go north and south, and the south one quickly bends west around the boulders."
Understand "slab/room" as In_Slab_Room.
South is At_West_End_Of_Twopit_Room. Up is In_Secret_N_S_Canyon_0. East from In_Slab_Room is nowhere.
Understand "climb" as up when the location is In_Slab_Room.
Rule for supplying a missing noun while climbing and the location is In_Slab_Room:
	now the noun is up;
	now clarified is true.

[ccr]A slab is scenery in In_Slab_Room. "It is now the floor here."
Understand "immense" as the slab.
Instead of looking under, pushing, pulling, or taking the slab, say [I6]"Surely you're joking."

[ccr]Some boulders are scenery in In_Slab_Room. "They're just ordinary boulders."
Understand "boulder/rocks/stones" as the boulders.

Chapter - A small network of Canyons, mainly Secret

[L69]In_Secret_N_S_Canyon_0 is a room with printed name "In Secret N/S Canyon". "You are in a secret N/S canyon above a large room."
Understand "secret/n[/]s/canyon" as In_Secret_N_S_Canyon_0.
South is In_Secret_Canyon. North is In_Mirror_Canyon.
In_Secret_N_S_Canyon_0 travels to In_Slab_Room and At_Reservoir.

[L70]In_Secret_N_S_Canyon_1 is a room with printed name "In Secret N/S Canyon". "You are in a secret N/S canyon above a sizable passage."
Understand "secret/n[/]s/canyon" as In_Secret_N_S_Canyon_1.
North is At_Junction_Of_Three. Down is In_Bedquilt. South is Atop_Stalactite.
Understand "passage" as down when the location is In_Secret_N_S_Canyon_1.

[L71]At_Junction_Of_Three is a room with printed name "At Junction of Three Secret Canyons" and brief description "You're at junction of three secret canyons.". "You are in a secret canyon at a junction of three canyons, bearing north, south, and se.  The north one is as tall as the other two combined."
Understand "junction/of/three/secret/canyons" as At_Junction_Of_Three.
South is In_Secret_N_S_Canyon_1. Southeast is In_Bedquilt. North is At_Window_On_Pit_2. East from At_Junction_Of_Three is nowhere.

[L72]In_Large_Low_Room is a room with printed name "In Large Low Room". "You are in a large low room.  Crawls lead north, se, and sw."
Understand "large/low/room" as In_Large_Low_Room.
Southwest is In_Sloping_Corridor. Southeast is In_Oriental_Room. North is Dead_End_Crawl. Up from In_Large_Low_Room and east from In_Large_Low_Room is nowhere.
In_Large_Low_Room travels to In_Bedquilt and In_Oriental_Room.

[L73]Dead_End_Crawl is a deadend room with printed name "Dead End Crawl". "This is a dead end crawl."
Understand "dead/end/crawl" as Dead_End_Crawl.

[L74]In_Secret_E_W_Canyon is a room with printed name "In Secret E/W Canyon Above Tight Canyon" and brief description "You're in secret E/W canyon above tight canyon.". "You are in a secret canyon which here runs E/W.  It crosses over a very tight canyon 15 feet below.  If you go down you may not be able to get back up."
Understand "secret/e[/]w/canyon/above/tight/canyon" as In_Secret_E_W_Canyon.
East is In_Hall_Of_Mt_King. West is In_Secret_Canyon. Down is In_N_S_Canyon. Northeast from In_Secret_E_W_Canyon is nowhere.

[L75]In_N_S_Canyon is a room with printed name "In N/S Canyon". "You are at a wide place in a very tight N/S canyon."
Understand "n[/]s/canyon" as In_N_S_Canyon.
South is Canyon_Dead_End. North is In_Tall_E_W_Canyon. Up from In_N_S_Canyon is nowhere.

[L76]Canyon_Dead_End is a room with printed name "Canyon Dead End". "The canyon here becomes too tight to go further south."

[L77]In_Tall_E_W_Canyon is a room with printed name "In Tall E/W Canyon". "You are in a tall E/W canyon.  A low tight crawl goes 3 feet north and seems to open up."
Understand "tall/e[/]w/canyon" as In_Tall_E_W_Canyon.
East is In_N_S_Canyon. West is Dead_End_8. North is In_Swiss_Cheese_Room. South from In_Tall_E_W_Canyon is nowhere.
Understand "crawl" as north when the location is In_Tall_E_W_Canyon.

Section - 

[L111]Atop_Stalactite is a room with printed name "Atop Stalactite" and brief description "You're at top of stalactite.". "A large stalactite extends from the roof and almost reaches the floor below.  You could climb down it, and jump from it to the floor, but having done so you would be unable to reach it to climb back up."
Understand "atop/stalactite" as Atop_Stalactite.
Instead of going down in Atop_Stalactite:
	if a random chance of 2 in 5 succeeds:
		move the player to Alike_Maze_6 as going;
		rule succeeds;
	if a random chance of 1 in 2 succeeds:
		move the player to Alike_Maze_9 as going;
		rule succeeds;
	move the player to Alike_Maze_4 as going;
	rule succeeds.
Instead of jumping or climbing in Atop_Stalactite, try going down.

[O26]A stalactite is climbable scenery in Atop_Stalactite. [ccr]"You could probably climb down it, but you can forget coming back up."
Understand "stalagmite/stalagtite/large" as the stalactite.
Instead of looking under, pushing, or taking the stalactite, say [ccr]"Do get a grip on yourself."

Chapter - Here be dragons

[L119+L120+L121]In_Secret_Canyon is a room with printed name "In Secret Canyon". "You are in a secret canyon which exits to the north and east." In_Secret_Canyon has a room called approach.
Understand "secret/canyon" as In_Secret_Canyon.
After going to In_Secret_Canyon:
	now the approach of In_Secret_Canyon is the room gone from;
	continue the action.
Instead of going forward in In_Secret_Canyon:
	if the approach of In_Secret_Canyon is In_Secret_N_S_Canyon_0, try going east;
	otherwise try going north.
Instead of going outside in In_Secret_Canyon:
	move the player to the approach of In_Secret_Canyon as going;
	rule succeeds.
Instead of going in In_Secret_Canyon when the dragon is on-stage:
	unless the room gone to is the approach of In_Secret_Canyon, say [M153]"The dragon looks rather nasty.  You'd best not try to get by." instead;
	otherwise continue the action.

[O31]A dragon is an animal in In_Secret_Canyon with description [ccr]"I wouldn't mess with it if I were you.". [D0]"A huge green fierce dragon bars the way![no line break]".
Understand "monster/beast/lizard/huge/green/fierce/scaly" as the dragon.
The dragon can be being attacked.
Instead of attacking the dragon:
	now the noun is being attacked;
	say [M49]"With what?  Your bare hands?"
Instead of giving something to the dragon, say [M102]"There's nothing here it wants to eat (except perhaps you)."
Instead of throwing something at the dragon, say [ccr]"You'd probably be better off using your bare hands than that thing!"
Instead of throwing axe at the dragon:
	move axe to location;
	say [M152]"The axe bounces harmlessly off the dragon's thick scales.";
	rule succeeds.
Instead of saying yes in In_Secret_Canyon when dragon is being attacked:
		now the dragon is nowhere;
		move the dragon's carcass to location;
		now the dragon is not being attacked;
		now the persian rug is portable;
		say [D1]"Congratulations!  You have just vanquished a dragon with your bare hands!  (Unbelievable, isn't it?)";
		increase the score by 2;
		rule succeeds.
Instead of saying no in In_Secret_Canyon when dragon is being attacked:
		now the dragon is not being attacked;
		say [I6]"I should think not.";
		rule succeeds.
Instead of doing something when dragon is being attacked:
		now the dragon is not being attacked;
		continue the action.

[O62]A persian rug is a fixed in place treasure in In_Secret_Canyon with description [ccr]"[if the dragon is in the location]The dragon is sprawled out on the Persian rug!![otherwise if the player does not enclose the rug]The Persian rug is spread out on the floor here.[otherwise]The Persian rug is the finest you've ever seen!" and deposit points 14.
Understand "fine/finest/dragon's" as the persian rug.
Rule for writing a paragraph about the persian rug:
	if the dragon is in the location, say [D1]"The dragon is sprawled out on a Persian rug!!";
	otherwise say [D0]"There is a Persian rug spread out on the floor!"

[ccr]The dragon's carcass is a fixed in place thing. [O31D2]"The body of a huge green dead dragon is lying off to one side."
Understand "dragon/corpse/dead" as the dragon's carcass.
Instead of attacking the dragon's carcass, say [M167]"For crying out loud, the poor thing is already dead!".
Instead of giving something to the dragon's carcass, say [M110]"Don't be ridiculous!".

Chapter - And more of the Alike Maze

[L78]Dead_End_8 is a deadend room. "The canyon runs into a mass of boulders -- dead end."
South is In_Tall_E_W_Canyon. East from Dead_End_8 is nowhere.

[ccr]A mass of boulders is scenery in Dead_End_8. "They're just like ordinary boulders."

[L80]Alike_Maze_11 is a maze room in Maze Area.
North is Alike_Maze_1. South and west is Alike_Maze_11. East is Dead_End_9.

[L81]Dead_End_9 is a deadend room in Maze Area.

[L82]Dead_End_10 is a forbidden deadend room in Maze Area.

[L83]Alike_Maze_12 is a maze room.
East is Alike_Maze_13. West is Dead_End_11.

[L84]Alike_Maze_13 is a maze room.
North is At_Brink_Of_Pit. West is Alike_Maze_12. Northwest is Dead_End_13.

[L85]Dead_End_11 is a forbidden deadend room.

[L86]Dead_End_12 is a forbidden deadend room in Maze Area.

[L87]Alike_Maze_14 is a maze room in Maze Area.

[L114]Dead_End_13 is a deadend room.
Understand "pirate's/dead/end/treasure/chest" as Dead_End_13.
After going to Dead_End_13:
	if the treasure chest is enclosed by the room gone to, now the pirate is nowhere;
	continue the action.

[O55]A treasure chest is a treasure with description [ccr]"It's the pirate's treasure chest, filled with riches of all kinds!" and deposit points 12. [D0]"The pirate's treasure chest is here!" The pirate carries the chest.
Understand "box/riches/pirate/pirate's" as the treasure chest.

Chapter - Above the beanstalk- the Giant Room and the Waterfall

[L88]In_Narrow_Corridor is a room with printed name "In Narrow Corridor" and brief description "You're in narrow corridor.". "You are in a long, narrow corridor stretching out of sight to the west.  At the eastern end is a hole through which you can see a profusion of leaves."
Understand "narrow/corridor" as In_Narrow_Corridor.
Down and east is In_West_Pit. West is In_Giant_Room. North from In_Narrow_Corridor is nowhere.
In_Narrow_Corridor travels to In_Giant_Room.
[L20]Instead of jumping in In_Narrow_Corridor:
	say "You are at the bottom of the pit with a broken neck.";
	end the story;
	rule succeeds.

[ccr]Some leaves are climbable scenery in In_Narrow_Corridor. "The leaves appear to be attached to the beanstalk you climbed to get here."
Understand "leaf/plant/tree/stalk/beanstalk/profusion" as the leaves.
Instead of climbing the leaves, try going down.

Section -

[L91]At_Steep_Incline is a room with printed name "At Steep Incline Above Large Room" and brief description "You're at steep incline above large room.". "You are at the top of a steep incline above a large room.  You could climb down here, but you would not be able to climb up.  There is a passage leading back to the north."
Understand "steep/incline/above/large/room" as At_Steep_Incline.
North is In_Cavern_With_Waterfall. Down is In_Large_Low_Room. East from At_Steep_Incline is nowhere.
Understand "cavern/passage" as north when the location is At_Steep_Incline. Understand "climb" as down when the location is At_Steep_Incline.
Rule for supplying a missing noun while climbing and the location is At_Steep_Incline:
	now the noun is down;
	now clarified is true.

Section - 

[L92]In_Giant_Room is a room with printed name "In Giant Room" and brief description "You're in giant room.". "You are in the giant room.  The ceiling here is too high up for your lamp to show it.  Cavernous passages lead east, north, and south.  On the west wall is scrawled the inscription, 'FEE FIE FOE FOO' [bracket]sic[close bracket]."
Understand "giant/room" as In_Giant_Room.
South is In_Narrow_Corridor. East is At_Recent_Cave_In. North is In_Immense_N_S_Passage.

[ccr]A scrawled inscription is scenery in In_Giant_Room. "It says, 'Fee fie foe foo [bracket]sic[close bracket].'".
Understand "writing/scrawl" as the scrawled inscription.

[O56]A nest of golden eggs is a treasure in In_Giant_Room with printed name "golden eggs" and description [ccr]"The nest is filled with beautiful golden eggs!" and deposit points 14. [D0]"There is a large nest here, full of golden eggs!"
Understand "egg/beautiful" as the nest.

Section -

[L93]At_Recent_Cave_In is a room with printed name "At Recent Cave-in". "The passage here is blocked by a recent cave-in."
South is In_Giant_Room. West from At_Recent_Cave_In is nowhere.
At_Recent_Cave_In travels to In_Giant_Room.

Section -

[L94]In_Immense_N_S_Passage is a room with printed name "In Immense N/S Passage". "You are at one end of an immense north/south passage."
Understand "immense/n[/]s/passage" as In_Immense_N_S_Passage.
South is In_Giant_Room.
Understand "passage" as south when the location is In_Immense_N_S_Passage.
In_Immense_N_S_Passage travels to In_Giant_Room and In_Cavern_With_Waterfall.

[O9]The rusty door is a locked door with description [ccr]"It's just a big iron door.". It is north from In_Immense_N_S_Passage. Through it is In_Cavern_With_Waterfall. [D0+D1]"The way north [if locked]is barred by [otherwise]leads through [end if]a massive, rusty, iron door."
Understand "hinge/hinges/massive/iron" as the rusty door.
Instead of opening the locked rusty door, say [M111]"The door is extremely rusty and refuses to open."
Instead of going through a locked rusty door, try opening the rusty door.
Instead of opening or closing the unlocked rusty door, say [M54]"OK."
Instead of pouring oil on the rusty door:
	if the bottle is enclosed by the player and the bottled oil is in the bottle:
		now the bottled oil is nowhere;
		now the rusty door is unlocked;
		say [M114]"The oil has freed up the hinges so that the door will now move, although it requires some effort.";
		rule succeeds;
	otherwise:
		say [ccr]"You have nothing to oil it with."
Instead of pouring water on the rusty door:
	if the bottle is enclosed by the player and the bottled water is in the bottle:
		now the bottled water is nowhere;
		now the noun is locked;
		now the noun is closed;
		say [M113]"The hinges are quite thoroughly rusted now and won't budge.";
		rule succeeds;
	otherwise:
		say "You have nothing to water it with."
Rule for supplying a missing second noun while pouring and the rusty door is in the location:
	now the second noun is the rusty door;
	say "(on [the second noun])[command clarification break]".

Section -

[L95]In_Cavern_With_Waterfall is a room with printed name "In Cavern With Waterfall" and brief description "You're in cavern with waterfall.". "You are in a magnificent cavern with a rushing stream, which cascades over a sparkling waterfall into a roaring whirlpool which disappears through a hole in the floor.  Passages exit to the south and west."
Understand "cavern/with/waterfall" as In_Cavern_With_Waterfall.
South is In_Immense_N_S_Passage. West is At_Steep_Incline.
In_Cavern_With_Waterfall travels to In_Giant_Room.

[ccr]A waterfall is scenery in In_Cavern_With_Waterfall. "Wouldn't want to go down in a barrel!"
Understand "whirlpool/sparkling/whirling" as the waterfall.

[O57]A jeweled trident is a treasure in In_Cavern_With_Waterfall with description [ccr]"The trident is covered with fabulous jewels!" and deposit points 14. [D0]"There is a jewel-encrusted trident here!"
Understand "jewel-encrusted/encrusted/fabulous" as the trident.

Chapter - The caves around Bedquilt

[L96]In_Soft_Room is a room with printed name "In Soft Room" and brief description "You're in soft room.". "You are in the soft room.  The walls are covered with heavy curtains, the floor with a thick pile carpet.  Moss covers the ceiling."
Understand "soft/room" as In_Soft_Room.

[O40]A carpet is scenery in In_Soft_Room. [ccr]"The carpet is quite plush."
Understand "shag/pile/heavy/thick" as the carpet.

[ccr]Some curtains are scenery in In_Soft_Room. "They seem to absorb sound very well."
Understand "curtain/heavy/thick" as the curtains.
Instead of taking the curtains, say [ccr]"Now don't go ripping up the place!"
Instead of looking under or searching the curtains, say [ccr]"You don't find anything exciting behind the curtains."

[O40]The moss is scenery in In_Soft_Room with description [ccr]"It just looks like your typical, everyday moss." and indefinite article "some".
Understand "typical/everyday" as the moss.

[O10]A velvet pillow is a thing in In_Soft_Room with description "It's just a small velvet pillow.". [D0]"A small velvet pillow lies on the floor."
Understand "small" as the pillow.

Section -

[L97]In_Oriental_Room is a room with printed name "In Oriental Room" and brief description "You're in Oriental room.". "This is the oriental room.  Ancient oriental cave drawings cover the walls.  A gently sloping passage leads upward to the north, another passage leads se, and a hands and knees crawl leads west."
Understand "oriental/room" as In_Oriental_room.
West is In_Large_Low_Room. Southeast is In_Swiss_Cheese_Room. Up and north is In_Misty_Cavern. Northwest from In_Oriental_Room is nowhere.
Understand "crawl" as west when the location is In_Oriental_Room.
In_Oriental_Room travels to In_Misty_Cavern.

[O29]Some ancient oriental drawings are scenery in In_Oriental_Room. [ccr]"They seem to depict people and animals."
Understand "paintings/art/cave" as the drawings.

[O58]The ming vase is a treasure in In_Oriental_Room with description [ccr]"It's a delicate, precious, ming vase!" and deposit points 14. [D0]"There is a delicate, precious, ming vase here."
Understand "delicate" as the ming vase.
After dropping the ming vase:
	if velvet pillow is in location:
		say [D1]"The vase is now resting, delicately, on a velvet pillow.";
	otherwise:
		now the ming vase is nowhere;
		move shards to location;
		say [D3]"The ming vase drops with a delicate crash."
Instead of attacking or breaking the ming vase:
	now the ming vase is nowhere;
	move shards to location;
	say [M198]"You have taken the vase and hurled it delicately to the ground.";
	rule succeeds.
Instead of inserting something into the ming vase, try filling the ming vase.
Instead of filling the ming vase:
	unless the player encloses the ming vase, say [M29]"You aren't carrying it.";
	otherwise say [M144]"There is nothing here with which to fill the vase."
Instead of filling the ming vase when the stream is in the location, try inserting the ming vase into the stream.
Instead of inserting the ming vase into the stream:
	now the ming vase is nowhere;
	move shards to location;
	say [M145]"The sudden change in temperature has delicately shattered the vase.";
	rule succeeds.

[ccr]Some worthless shards of pottery are a thing with description "They look to be the remains of what was once a beautiful vase. I guess some oaf must have dropped it.". [O58D2]"The floor is littered with worthless shards of pottery."
Understand "remains/vase" as the shards.

Section - 

[L98]In_Misty_Cavern is a room with printed name "In Misty Cavern" and brief description "You're in misty cavern.". "You are following a wide path around the outer edge of a large cavern.  Far below, through a heavy white mist, strange splashing noises can be heard.  The mist rises up through a fissure in the ceiling.  The path exits to the south and west."
Understand "misty/cavern" as In_Misty_Cavern.
South is In_Oriental_Room. West is In_Alcove. Down from In_Misty_Cavern and southeast from In_Misty_Cavern is nowhere.
In_Misty_Cavern travels to In_Oriental_Room.

[ccr]A ceiling fissure is scenery in In_Misty_Cavern with printed name "fissure". "You can't really get close enough to examine it."

Chapter - Plovers and pyramids

The Plover Area is a region. 

[L99]In_Alcove is a room in the Plover Area with printed name "In Alcove" and brief description "You're in alcove.". "You are in an alcove.  A small northwest path seems to widen after a short distance.  An extremely tight tunnel leads east.  It looks like a very tight squeeze.  An eerie light can be seen at the other end."
Understand "alcove" as In_Alcove.
Northwest is In_Misty_Cavern. East is In_Plover_Room.
Understand "passage" as east when the location is In_Alcove.
In_Alcove travels to In_Misty_Cavern.
Instead of going east from In_Alcove when the number of things enclosed by the player is greater than one or (the number of things enclosed by the player is one and the player does not enclose the emerald), say [M117]"Something you're carrying won't fit through the tunnel with you. You'd best take inventory and drop something."

Section - 

[L100]In_Plover_Room is a lighted room in the Plover Area with printed name "In Plover Room" and brief description "You're in plover room.". "You're in a small chamber lit by an eerie green light.  An extremely narrow tunnel exits to the west.  A dark corridor leads northeast."
Understand "plover/room" as In_Plover_Room.
Northeast is In_Dark_Room. North from In_Plover_Room is nowhere.
Understand "passage" as west when the location is In_Plover_Room. Understand "dark" as northeast when the location is In_Plover_Room.
Instead of going west from In_Plover_Room when the number of things enclosed by the player is greater than one or (the number of things enclosed by the player is one and the player does not enclose the emerald), say [M117]"Something you're carrying won't fit through the tunnel with you. You'd best take inventory and drop something."
After saying plover in In_Plover_Room:
	if player encloses the emerald, move the emerald to In_Plover_Room;
	move the player to At_Y2 as going.
Instead of going outside in In_Plover_Room, try going west.

[O59]An emerald the size of a plover's egg is a treasure in In_Plover_Room with printed name "egg-sized emerald" and description [ccr]"Plover's eggs, by the way, are quite large." and deposit points 14. [D0]"There is an emerald here the size of a plover's egg!"
Understand "egg-sized/sized" as the emerald.

Section - 

[L101]In_Dark_Room is a not for dwarves room in the Plover Area with printed name "In Dark Room" and brief description "You're in dark-room.". "You're in the dark-room.  A corridor leading south is the only exit."
Understand "dark/room" as In_Dark_Room.
South is In_Plover_Room. Southwest from In_Dark_Room is nowhere.
In_Dark_Room travels to In_Plover_Room.

[O13]A stone tablet is a fixed in place thing in In_Dark_Room with description [M196]"'CONGRATULATIONS ON BRINGING LIGHT INTO THE DARK-ROOM!'". [D0]"A massive stone tablet imbedded in the wall reads: 'CONGRATULATIONS ON BRINGING LIGHT INTO THE DARK-ROOM!'"
Understand "massive" as the stone tablet.
instead of reading the stone tablet, try examining the noun.

[O60]A platinum pyramid is a treasure in In_Dark_Room with description [ccr]"The platinum pyramid is 8 inches on a side!" and deposit points 14. [D0]"There is a platinum pyramid here, 8 inches on a side!"
Understand "pyramidal" as the pyramid.

Chapter - North of the complex junction- a long up-down corridor

[L102]In_Arched_Hall is a room with printed name "In Arched Hall" and brief description "You're in arched hall.". "You are in an arched hall.  A coral passage once continued up and east from here, but is now blocked by debris.  The air smells of sea water."
Understand "arched/hall" as In_Arched_Hall.
Down is In_Shell_Room.
In_Arched_Hall, In_Ragged_Corridor, and In_A_Cul_De_Sac travel to In_Shell_Room.

Section - 

[L103]In_Shell_Room is a room with printed name "In Shell Room" and brief description "You're in shell room.". "You're in a large room carved out of sedimentary rock.  The floor and walls are littered with bits of shells imbedded in the stone.  A shallow passage proceeds downward, and a somewhat steeper one leads up.  A low hands and knees passage enters from the south."
Understand "shell/room" as In_Shell_Room.
Down is In_Ragged_Corridor.
In_Shell_Room travels to In_Arched_Hall.
Instead of going south from In_Shell_Room when the giant clam is enclosed by the player:
	if the giant clam is discovered, say [M119]"You can't fit this five-foot oyster through that little passage!";
	otherwise say [M118]"You can't fit this five-foot clam through that little passage!"

[O14+O15]A giant clam is a thing in In_Shell_Room with printed name "giant [if discovered]oyster[otherwise]clam". [ccr]"A giant bivalve of some kind." The clam can be discovered. The clam can be hinted.
Understand "oyster/bivalve" as the clam.
Rule for printing the name of the giant clam while taking inventory: say "giant [if discovered]oyster  >GROAN!<[otherwise]clam  >GRUNT!<".
Rule for writing a paragraph about the giant clam:
	if the clam is discovered, say [O15D0]"There is an enormous oyster here with its shell tightly closed.";
	otherwise say [O14D0]"There is an enormous clam here with its shell tightly closed."
Instead of opening the giant clam, try unlocking the clam with the player.
Instead of unlocking the clam with something:
	if the clam is discovered, say [M123]"You don't have anything strong enough to open the oyster.";
	otherwise say [M122]"You don't have anything strong enough to open the clam."
Instead of unlocking the clam with the trident:
	if the clam is discovered:
		if the player encloses the clam, say [M121]"I advise you to put down the oyster before opening it.  >WRENCH!<";
		otherwise say [M125]"The oyster creaks open, revealing nothing but oyster inside.  It promptly snaps shut again.";
	otherwise:
		if the player encloses the clam:
			say [M120]"I advise you to put down the clam before opening it.  >STRAIN!<";
		otherwise:
			now the noun is discovered;
			move pearl to In_A_Cul_De_Sac;
			say [M124]"A glistening pearl falls out of the clam and rolls away.  Goodness, this must really be an oyster.  (I never was very good at identifying bivalves.)  Whatever it is, it has now snapped shut again.";
			rule succeeds.
Instead of attacking the giant clam, say [M150]"The shell is very strong and is impervious to attack."
After taking the giant clam when the location is in End Game Area, say [O15D1]"Interesting.  There seems to be something written on the underside of the oyster."
Instead of reading or examining the handled giant clam in End Game Area:
	unless the giant clam is hinted:
		say [M192]"Hmmm, this looks like a clue, which means it'll cost you 10 points to read it.  Should I go ahead and read it anyway?";
		say "[line break]>";
		if player consents:
			now the giant clam is hinted;
			say [M193]"It says, 'There is something strange about this place, such that one of the words I've always known now has a new effect.'";
			decrease the score by 10;
			prevent undo;
	otherwise:
		say [M194]"It says the same thing it did before.";
	rule succeeds.

[O61]A glistening pearl is a treasure with description [ccr]"It's incredibly large!" and deposit points 14. [D0]"Off to one side lies a glistening pearl!"
Understand "incredible/incredibly/large'" as the pearl.

Section - 

[L104]In_Ragged_Corridor is a room with printed name "In Ragged Corridor". "You are in a long sloping corridor with ragged sharp walls."
Understand "ragged/corridor" as In_Ragged_Corridor.
Down is In_A_Cul_De_Sac. Inside from In_Ragged_Corridor is nowhere.

[L105]In_A_Cul_De_Sac is a room with printed name "In a Cul-de-Sac". "You are in a cul-de-sac about eight feet across."
Understand "cul-de-sac/cul/de/sac" as In_A_Cul_De_Sac.
Outside is In_Ragged_Corridor.

Chapter - Witt's End - Cave under construction

[L106]In_Anteroom is a room with printed name "In Anteroom" and brief description "You're in anteroom.". "You are in an anteroom leading to a large passage to the east.  Small passages go west and up.  The remnants of recent digging are evident.  A sign in midair here says 'Cave under construction beyond this point.  Proceed at own risk.  [bracket]Witt Construction Company[close bracket]'".
Understand "anteroom" as In_Anteroom.
Up is At_Complex_Junction. West is In_Bedquilt. East is At_Witts_End.

[ccr]A sign is scenery in In_Anteroom with description "It's hanging way above your head."
Understand "witt/company/construction" as the sign.
Instead of reading the sign:
	say [ccr]"It says, 'Cave under construction beyond this point.  Proceed at own risk.  [bracket]Witt Construction Company[close bracket]'";
	rule succeeds.

[O16]Some recent issues of Spelunker Today are a thing in In_Anteroom with printed name "recent issues of 'Spelunker Today'", indefinite article "a few", and description [M190]"I'm afraid the magazines are written in Dwarvish.". [D0]"There are a few recent issues of 'Spelunker Today' magazine here."
Understand "magazines/magazine/issue" as the issues.
After taking the issues when the player is in At_Witts_End:
	decrement the score;
	continue the action.
After dropping the issues when the player is in At_Witts_End:
	increment the score;
	continue the action.
Instead of reading the issues, try examining the noun.

Section - 

[L108]At_Witts_End is a room with printed name "At Witt's End" and brief description "You're at Witt's End.". "You are at Witt's End.  Passages lead off in *ALL* directions."
Understand "witt's/witts/end" as At_Witts_End.
Instead of going west from At_Witts_End, say [M126]"You have crawled around in some little holes and found your way blocked by a recent cave-in. You are now back in the main passage."
Instead of going nowhere from At_Witts_End:
	if a random chance of 19 in 20 succeeds:
		say [M56]"You have crawled around in some little holes and wound up back in the main passage.";
	otherwise:
		move the player to In_Anteroom as going;
		rule succeeds.

Chapter - North of the secret canyons, on the other side of the pit

[L109]In_Mirror_Canyon is a room with printed name "In Mirror Canyon" and brief description "You're in mirror canyon.". "You are in a north/south canyon about 25 feet across.  The floor is covered by white mist seeping in from the north.  The walls extend upward for well over 100 feet.  Suspended from some unseen point far above you, an enormous two-sided mirror is hanging parallel to and midway between the canyon walls.  (The mirror is obviously provided for the use of the dwarves, who as you know, are extremely vain.)  A small window can be seen in either wall, some fifty feet up."
Understand "mirror/canyon" as In_Mirror_Canyon.
North is At_Reservoir. Inside from In_Mirror_Canyon is nowhere.
In_Mirror_Canyon travels to At_Reservoir.

[O23]A suspended mirror is scenery in In_Mirror_Canyon with description [ccr]"The mirror is obviously provided for the use of the dwarves, who as you know, are extremely vain."
Understand "massive/enormous/hanging/dwarves'/two-sided/two/sided" as the mirror.
Instead of attacking, breaking, or taking the mirror, say [M148]"It is too far up for you to reach."

Section - 

[L110]At_Window_On_Pit_2 is a room with printed name "At Window on Pit" and brief description "You're at window on pit.". "You're at a low window overlooking a huge pit, which extends up out of sight.  A floor is indistinctly visible over 50 feet below.  Traces of white mist cover the floor of the pit, becoming thicker to the left.  Marks in the dust around the window would seem to indicate that someone has been here recently.  Directly across the pit from you and 25 feet away there is a similar window looking into a lighted room.  A shadowy figure can be seen there peering back at you."
Understand "window/on/pit/west/w" as At_Window_On_Pit_2.
West is At_Junction_Of_Three. South from At_Window_On_Pit_2 is nowhere.
Instead of going nowhere from At_Window_On_Pit_2, say [I6]"The only passage is back west to the junction."
[L20]Instead of jumping in At_Window_On_Pit_2:
	say "You are at the bottom of the pit with a broken neck.";
	end the story;
	rule succeeds.

Section - 

[L113]At_Reservoir is a room with printed name "At Reservoir" and brief description "You're at reservoir.". "You are at the edge of a large underground reservoir.  An opaque cloud of white mist fills the room and rises rapidly upward.  The lake is fed by a stream, which tumbles out of a hole in the wall about 10 feet overhead and splashes noisily into the water somewhere within the mist.  The only passage goes back toward the south."
Understand "reservoir" as At_Reservoir.
Outside is In_Mirror_Canyon.[In the original code there was another number for a motion verb for going this path but no word to match the number]

Chapter - The Chasm and the Troll Bridge

[L118]In_Sloping_Corridor is a room with printed name "In Sloping Corridor" and brief description "You're in sloping corridor.". "You are in a long winding corridor sloping out of sight in both directions."
Understand "sloping/corridor" as In_Sloping_Corridor.
Down is In_Large_Low_Room. Up is On_Sw_Side_Of_Chasm. Northeast from In_Sloping_Corridor is nowhere.
Instead of going nowhere from In_Sloping_Corridor, say [I6]"The corridor slopes steeply up and down."

[L117]On_Sw_Side_Of_Chasm is a room with printed name "On SW Side of Chasm" and brief description "You're on SW side of chasm.". "You are on one side of a large, deep chasm.  A heavy white mist rising up from below obscures all view of the far side.  A southwest path leads away from the chasm into a winding corridor."
Understand "southwest/sw/side/of/chasm" as On_Sw_Side_Of_Chasm.
Down and southwest is In_Sloping_Corridor.
Understand "over/cross/across" as northeast when the location is On_Sw_Side_Of_Chasm.
Instead of going nowhere from On_Sw_Side_Of_Chasm, say [I6]"The path winds southwest."

[O32]The rickety bridge is an open unopenable door with description [ccr]"It just looks like an ordinary, but unstable, bridge.". It is northeast from On_Sw_Side_Of_Chasm and southwest from On_Ne_Side_Of_Chasm. The rickety bridge can be wrecked.
Understand "unstable/wobbly/rope" as the rickety bridge.
Rule for writing a paragraph about the rickety bridge:
	say [D0]"A rickety wooden bridge extends across the chasm, vanishing into the mist.  A sign posted on the bridge reads, 'Stop! Pay troll!'[line break]";
	unless troll is in location, say [O34D0]"[line break]The troll is nowhere to be seen."
Rule for writing a paragraph about the wrecked rickety bridge: say [D1]"The wreckage of the troll bridge (and a dead bear) can be seen at the bottom of the chasm."
Understand "chasm" as the rickety bridge when the rickety bridge is wrecked.
Instead of doing something to the wrecked rickety bridge, say [I6]"The wreckage is too far below."
Instead of going through the wrecked rickety bridge, say [M161]"There is no longer any way across the chasm."
Instead of going through the rickety bridge when the troll is on-stage:
	if troll is placated:
		now troll is not placated;
		continue the action;
	otherwise if the troll is in location:
		say [M160]"The troll refuses to let you cross.";
	otherwise:
		move troll to location;
		say [O33D1]"The troll steps out from beneath the bridge and blocks your way."
After going through the rickety bridge when the bear is following you:
		now the bear is nowhere;
		now the bear is wandering;
		now rickety bridge is wrecked;
		if the spices are unfound, now the spices are elusive;
		if the clam is not discovered and (the clam is in Beyond Troll Area or the trident is in Beyond Troll Area), now the pearl is elusive; [not coded in the original but sounds reasonable]
		say [M162]"Just as you reach the other side, the bridge buckles beneath the weight of the bear, which was still following you around. You scrabble desperately for support, but as the bridge collapses you stumble back and fall into the chasm.";
		end the story.
Instead of jumping in a room that contains the rickety bridge:
	unless the rickety bridge is wrecked:
		say [M96]"I respectfully suggest you go across the bridge instead of jumping.";
	otherwise:
		say [L21]"You didn't make it.";
		end the story;
		rule succeeds.
		
The dead-bear is privately-named scenery with printed name "dead bear". Understand "dead/bear" as the dead-bear.
Instead of attacking the dead-bear, say [M167]"For crying out loud, the poor thing is already dead!"

[O33]A burly troll is a man in On_Sw_Side_Of_Chasm with description [ccr]"Trolls are close relatives with rocks and have skin as tough as that of a rhinoceros.". [D0]"A burly troll stands by the bridge and insists you throw him a treasure before you may cross." The troll can be placated.
Instead of attacking the troll, say [M157]"Trolls are close relatives with the rocks and have skin as tough as a rhinoceros hide.  The troll fends off your blows effortlessly."
Instead of giving something to the troll:
	if the noun is a treasure:
		now the noun is nowhere;
		move troll to rickety bridge;
		now the troll is placated;
		say [M159]"The troll catches your treasure and scurries away out of sight.";
		rule succeeds;
	otherwise if the noun is the tasty food:
		say [M182]"Gluttony is not one of the troll's vices.  Avarice, however, is.";
	otherwise if the noun is the axe:
		say [M158M]"The troll deftly catches the axe, examines it carefully, and tosses it back, declaring, 'Good workmanship, but it's not valuable enough.'";
	otherwise:
		continue the action.
Instead of throwing something at the troll, try giving the noun to the troll.
Instead of asking the troll to try doing something, say [I6]"You'll be lucky."
Instead of answering the troll that something, say [I6]"Trolls make poor conversation."
Instead of asking the troll about something, say [I6]"Trolls make poor conversation."

Section - 

The Beyond Troll Area is a region.

[L122]On_Ne_Side_Of_Chasm is a forbidden not for dwarves room in Beyond Troll Area with printed name "On NE Side of Chasm" and brief description "You're on NE side of chasm.". "You are on the far side of the chasm.  A northeast path leads away from the chasm on this side."
Understand "northeast/ne/side/of/chasm" as On_Ne_Side_Of_Chasm.
Northeast is In_Corridor. East from On_Ne_Side_Of_Chasm is nowhere.
Understand "over/cross/across" as southwest when the location is On_Ne_Side_Of_Chasm.

[L123]In_Corridor is a forbidden room in Beyond Troll Area with printed name "In Corridor" and brief description "You're in corridor.". "You're in a long east/west corridor.  A faint rumbling noise can be heard in the distance."
Understand "corridor" as In_Corridor.
West is On_Ne_Side_Of_Chasm. East is At_Fork_In_Path. Southwest from In_Corridor is nowhere.
In_Corridor travels to At_Fork_In_Path, At_Breath_Taking_View, and In_Front_Of_Barren_Room.

Chapter - The Volcano

[L124]At_Fork_In_Path is a forbidden room in Beyond Troll Area with printed name "At Fork in Path" and brief description "You're at fork in path.". "The path forks here.  The left fork leads northeast.  A dull rumbling seems to get louder in that direction.  The right fork leads southeast down a gentle slope.  The main corridor enters from the west."
Understand "fork/in/path" as At_Fork_In_Path.
Northeast is At_Junction_With_Warm_Walls. Southeast and down is In_Limestone_Passage. South from At_Fork_In_Path and north from At_Fork_In_Path is nowhere.
Understand "left" as northeast when the location is At_Fork_In_Path. Understand "right" as southeast when the location is At_Fork_In_Path.
At_Fork_In_Path travels to At_Breath_Taking_View and In_Front_Of_Barren_Room.

Section - 

[L125]At_Junction_With_Warm_Walls is a forbidden room in Beyond Troll Area with printed name "At Junction With Warm Walls" and brief description "You're at junction with warm walls.". "The walls are quite warm here.  From the north can be heard a steady roar, so loud that the entire cave seems to be trembling.  Another passage leads south, and a low crawl goes east."
Understand "junction/with/warm/walls" as At_Junction_With_Warm_Walls.
South is At_Fork_In_Path. North is At_Breath_Taking_View. East is In_Chamber_Of_Boulders. Southwest from At_Junction_With_Warm_Walls and inside from At_Junction_With_Warm_Walls is nowhere.
Understand "crawl" as east when the location is At_Junction_With_Warm_Walls.
At_Junction_With_Warm_Walls travels to At_Fork_In_Path and At_Breath_Taking_View.

Section - 

[L126]At_Breath_Taking_View is a forbidden lighted room in Beyond Troll Area with printed name "At Breath-Taking View" and brief description "You're at breath-taking view.". "You are on the edge of a breath-taking view.  Far below you is an active volcano, from which great gouts of molten lava come surging  out, cascading back down into the depths.  The glowing rock fills the farthest reaches of the cavern with a blood-red glare, giving everything an eerie, macabre appearance.  The air is filled with flickering sparks of ash and a heavy smell of brimstone.  The walls are hot to the touch, and the thundering of the volcano drowns out all other sounds.  Embedded in the jagged roof far overhead are myriad twisted formations composed of pure white alabaster, which scatter the murky light into sinister apparitions upon the walls.  To one side is a deep gorge, filled with a bizarre chaos of tortured rock which seems to have been crafted by the devil himself.  An immense river of fire crashes out from the depths of the volcano, burns its way through the gorge, and plummets into a bottomless pit far off to your left.  To the right, an immense geyser of blistering steam erupts continuously from a barren island in the center of a sulfurous lake, which bubbles ominously.  The far right wall is aflame with an incandescence of its own, which lends an additional infernal splendor to the already hellish scene.  A dark, forboding passage exits to the south."
Understand "breath-taking/breathtaking/breath/taking/view" as At_Breath_Taking_View.
Outside is At_Junction_With_Warm_Walls.
Understand "passage" as south when the location is At_Breath_Taking_View.
At_Breath_Taking_View travels to At_Fork_In_Path.
Instead of going down in At_Breath_Taking_View, say [M110]"Don't be ridiculous!"
Instead of jumping in At_Breath_Taking_View, try going down.

[O37]An active volcano is scenery in At_Breath_Taking_View. [ccr]"Great gouts of molten lava come surging out of the volcano and go cascading back down into the depths. The glowing rock fills the farthest reaches of the cavern with a blood-red glare, giving everything an eerie, macabre appearance."
Understand "geyser/rock/glowing/blood/blood-red/red/eerie/macabre" as the volcano.

[ccr]Some sparks of ash are scenery in At_Breath_Taking_View. "The sparks too far away for you to get a good look at them."
Understand "spark/sparks/ash/air/flickering" as the sparks.

[ccr]A jagged roof is scenery in At_Breath_Taking_View. "Embedded in the jagged roof far overhead are myriad twisted formations composed of pure white alabaster, which scatter the murky light into sinister apparitions upon the walls."
Understand "formations/light/apparaitions/twsited/murky/sinister" as the jagged roof.

[ccr]A deep gorge is scenery in At_Breath_Taking_View. "The gorge is filled with a bizarre chaos of tortured rock which seems to have been crafted by the devil himself."
Understand "chaos/rock/bizarre/tortured" as the gorge.

[ccr]A river of fire is scenery in At_Breath_Taking_View. "The river of fire crashes out from the depths of the volcano, burns its way through the gorge, and plummets into a bottomless pit far off to your left."
Understand "depth/pit/fiery/bottomless" as the river of fire.

[O37]An immense geyser is scenery in At_Breath_Taking_View. [ccr]"The geyser of blistering steam erupts continuously from a barren island in the center of a sulfurous lake, which bubbles ominously."
Understand "steam/island/lake/blistering/barren/sulfrous/sulferous/sulpherous/sulphrous/bubbling" as the geyser.

Section - 

[L127]In_Chamber_Of_Boulders is a forbidden room in Beyond Troll Area with printed name "In Chamber of Boulders" and brief description "You're in chamber of boulders.". "You are in a small chamber filled with large boulders.  The walls are very warm, causing the air in the room to be almost stifling from the heat.  The only exit is a crawl heading west, through which is coming a low rumbling."
Understand "chamber/of/boulders" as In_Chamber_Of_Boulders.
Outside is At_Junction_With_Warm_Walls.
Understand "crawl" as west when the location is In_Chamber_Of_Boulders.
In_Chamber_Of_Boulders travels to At_Fork_In_Path and At_Breath_Taking_View.

[ccr]Some warm boulders are scenery in In_Chamber_Of_Boulders. "They're just ordinary boulders. They're warm."
Understand "boulder/rocks/stones" as the boulders.
Instead of looking under, pushing, or pulling the warm boulders, say [I6]"You'd have to blast them aside."

[O63]Some rare spices are a treasure in In_Chamber_Of_Boulders with description [ccr]"They smell wonderfully exotic!" and deposit points 14. [D0]"There are rare spices here!"
Understand "spice/exotic" as the rare spices.
Instead of smelling the rare spices, try examining the noun.

Section - 

[L128]In_Limestone_Passage is a forbidden room in Beyond Troll Area with printed name "In Limestone Passage" and brief description "You're in limestone passage.". "You are walking along a gently sloping north/south passage lined with oddly shaped limestone formations."
Understand "limestone/passage" as In_Limestone_Passage.
North is At_Fork_In_Path. South and down is In_Front_Of_Barren_Room.
In_Limestone_Passage travels to At_Fork_In_Path, At_Breath_Taking_View, and In_Front_Of_Barren_Room.

[ccr]Some limestone formations are scenery in In_Limestone_Passage. "Every now and then a particularly strange shape catches your eye."
Understand "shape/shapes/lime/stone/oddly/shaped/oddly-shaped" as the limestone formations.

Chapter - If you go down to the woods today

[L129]In_Front_Of_Barren_Room is a forbidden room in Beyond Troll Area with printed name "In Front of Barren Room" and brief description "You're in front of barren room.". "You are standing at the entrance to a large, barren room.  A sign posted above the entrance reads:  'Caution!  Bear in room!'".
Understand "front/of/entrance/to/barren/room" as In_Front_Of_Barren_Room.
West is In_Limestone_Passage. East and inside is In_Barren_Room. North from In_Front_Of_Barren_Room is nowhere.
In_Front_Of_Barren_Room travels to At_Fork_In_Path, At_Breath_Taking_View, and In_Barren_Room.

[ccr]A caution sign is scenery in In_Front_Of_Barren_Room. "The sign reads, 'Caution!  Bear in room!'".
Understand "barren/room" as the caution sign.
Instead of reading the caution sign, try examining the noun.

Section - 

[L130]In_Barren_Room is a forbidden room in Beyond Troll Area with printed name "In Barren Room" and brief description "You're in barren room.". "You are inside a barren room.  The center of the room is completely empty except for some dust.  Marks in the dust lead away toward the far end of the room.  The only exit is the way you came in."
Understand "in/barren/room" as In_Barren_Room.
In_Barren_Room travels to At_Fork_In_Path and At_Breath_Taking_View.

[ccr]The ordinary dust is scenery in In_Barren_Room with indefinite article "some" and printed name "dust". "It just looks like ordinary dust."
Understand "marks" as the ordinary dust.

[O35]A large cave bear is an animal in In_Barren_Room with description "The bear is extremely large, [if the bear is friendly]but appears to be friendly.[otherwise]and seems quite ferocious!".
Understand "tame/ferocious" as the bear. The bear is either friendly or ferocious. The bear is either free or chained.
Rule for writing a paragraph about the bear:
	if the bear is following you:
		say [M141]"You are being followed by a very large, tame bear.";
	otherwise if the bear is ferocious:
		say [D0]"There is a ferocious cave bear eyeing you from the far end of the room!";
	otherwise if the player is in In_Barren_Room:
		say [D1]"There is a gentle cave bear sitting placidly in one corner.";
	otherwise:
		say [D2]"There is a contented-looking bear wandering about nearby."
Instead of attacking the bear when the axe is enclosed by the player, try throwing the axe at the bear.
Instead of attacking the bear:
	if the noun is friendly, say [M166]"The bear is confused; he only wants to be your friend.";
	otherwise say [M165]"With what?  Your bare hands?  Against *HIS* bear hands??"
Instead of throwing something at the bear, try giving the noun to the bear.
Instead of throwing the axe at the bear:
	if the bear is friendly:
		say [M166]"The bear is confused; he only wants to be your friend.";
	otherwise:
		move axe to location;
		now the axe is near the bear;
		say [M164]"The axe misses and lands near the bear where you can't get at it.";
		rule succeeds.
Instead of giving the tasty food to the bear:
	now the axe is not near the bear;
	now the tasty food is nowhere;
	now the bear is friendly;
	say [M168]"The bear eagerly wolfs down your food, after which he seems to calm down considerably and even becomes rather friendly.";
	rule succeeds.
Instead of giving something to the bear:
	if the bear is friendly, say [M174]"There is nothing here to eat.";
	otherwise say [M102]"There's nothing here it wants to eat (except perhaps you)."
Instead of asking the bear to try doing something, say [I6]"This is a Bear of very little brain."
Instead of asking the bear about something, say [I6]"This is a Bear of very little brain."
Instead of answering the bear that something, say [I6]"This is a Bear of very little brain."
Instead of taking the ferocious bear, say [M25]"You can't be serious!"
Instead of taking the friendly chained bear, say [M169]"The bear is still chained to the wall."
Instead of taking the friendly free bear:
	now the bear is following you;
	say [ccr]"Ok, the bear's now following you around.";
	rule succeeds.
Instead of dropping the bear:
	if the bear is wandering:
		say [M29]"You aren't carrying it.";
	otherwise:
		now the bear is wandering;
		if troll is in the location:
			now the troll is nowhere;
			say [M163]"The bear lumbers toward the troll, who lets out a startled shriek and scurries away.  The bear soon gives up the pursuit and wanders back.";
		otherwise:
			say [ccr]"The bear wanders away from you.";
		rule succeeds.
After taking inventory when the bear is following you, say [M141]"You are being followed by a very large, tame bear."
After going when the bear is following you:
	move bear to location;
	continue the action.
Rule for choosing notable locale objects for In_Barren_Room when the chain is locked (this is the put chain after bear rule):
	set the locale priority of the chain to 4;
	continue the activity.

[O64]A golden chain is a lockable locked treasure in In_Barren_Room with description [ccr]"The chain has thick links of solid gold!" and deposit points 14. The chain can be lockable. The chain can be locked or unlocked. The set of keys unlocks the chain.
Understand "links/shackles/solid/gold/thick/chains" as the chain.
Rule for writing a paragraph about the chain:
	if the chain is locked and the bear is chained:
		say [D1]"The bear is locked to the wall with a golden chain!";
	otherwise if the chain is locked and the bear is free:
		say [D0]"There is a golden chain locked to the wall!";
	otherwise:
		say [D2]"There is a golden chain lying in a heap on the floor!"
Instead of taking the locked chain:
	if bear is friendly, say [M170]"The chain is still locked.";
	otherwise say [M25]"You can't be serious!"
Instead of unlocking the chain with something when the bear is not friendly, say [M41]"There is no way to get past the bear to unlock the chain, which is probably just as well."
Instead of locking the unlocked chain with the keys:
	if the location is In_Barren_Room:
		say [M172]"The chain is now locked.";
		move the chain to the location;
		now the chain is locked;
		rule succeeds;
	otherwise:
		say [M173]"There is nothing here to which the chain can be locked."
After unlocking the chain with something:
	say [M171]"The chain is now unlocked.";
	now the chain is unlocked;
	if the bear is chained:
		now the bear is free;
		increase the score by 2.

Chapter - The Different Maze

[L107]Different_Maze_1 is a diffmaze room. "You are in a maze of twisty little passages, all different."
South is Different_Maze_3.
Southwest is Different_Maze_4.
Northeast is Different_Maze_5.
Southeast is Different_Maze_6.
Up is Different_Maze_7.
Northwest is Different_Maze_8.
East is Different_Maze_9.
West is Different_Maze_10.
North is Different_Maze_11.
Down is At_West_End_Of_Long_Hall.

[L112]Different_Maze_2 is a diffmaze room. "You are in a little maze of twisting passages, all different."
Southwest is Different_Maze_3.
North is Different_Maze_4.
East is Different_Maze_5.
Northwest is Different_Maze_6.
Southeast is Different_Maze_7.
Northeast is Different_Maze_8.
West is Different_Maze_9.
Down is Different_Maze_10.
Up is Different_Maze_11.
South is Dead_End_14.

[L131]Different_Maze_3 is a diffmaze room. "You are in a maze of twisting little passages, all different."
West is Different_Maze_1.
Southeast is Different_Maze_4.
Northwest is Different_Maze_5.
Southwest is Different_Maze_6.
Northeast is Different_Maze_7.
Up is Different_Maze_8.
Down is Different_Maze_9.
North is Different_Maze_10.
South is Different_Maze_11.
East is Different_Maze_2.

[L132]Different_Maze_4 is a diffmaze room. "You are in a little maze of twisty passages, all different."
Northwest is Different_Maze_1.
Up is Different_Maze_3.drop
South is Different_Maze_6.
West is Different_Maze_7.
Southwest is Different_Maze_8.
Northeast is Different_Maze_9.
East is Different_Maze_10.
Down is Different_Maze_11.
Southeast is Different_Maze_2.

[L133]Different_Maze_5 is a diffmaze room. "You are in a twisting maze of little passages, all different."
Up is Different_Maze_1.
Down is Different_Maze_3.
West is Different_Maze_4.
Northeast is Different_Maze_6.
Southwest is Different_Maze_7.
East is Different_Maze_8.
North is Different_Maze_9.
Northwest is Different_Maze_10.
Southeast is Different_Maze_11.
South is Different_Maze_2.

[L134]Different_Maze_6 is a diffmaze room. "You are in a twisting little maze of passages, all different."
Northeast is Different_Maze_1.
North is Different_Maze_3.
Northwest is Different_Maze_4.
Southeast is Different_Maze_5.
East is Different_Maze_7.
Down is Different_Maze_8.
South is Different_Maze_9.
Up is Different_Maze_10.
West is Different_Maze_11.
Southwest is Different_Maze_2.

[L135]Different_Maze_7 is a diffmaze room. "You are in a twisty little maze of passages, all different."
North is Different_Maze_1.
Southeast is Different_Maze_3.
Down is Different_Maze_4.
South is Different_Maze_5.
East is Different_Maze_6.
West is Different_Maze_8.
Southwest is Different_Maze_9.
Northeast is Different_Maze_10.
Northwest is Different_Maze_11.
Up is Different_Maze_2.

[L136]Different_Maze_8 is a diffmaze room. "You are in a twisty maze of little passages, all different."
East is Different_Maze_1.
West is Different_Maze_3.
Up is Different_Maze_4.
Southwest is Different_Maze_5.
Down is Different_Maze_6.
South is Different_Maze_7.
Northwest is Different_Maze_9.
Southeast is Different_Maze_10.
Northeast is Different_Maze_11.
North is Different_Maze_2.

[L137]Different_Maze_9 is a diffmaze room. "You are in a little twisty maze of passages, all different."
Southeast is Different_Maze_1.
Northeast is Different_Maze_3.
South is Different_Maze_4.
Down is Different_Maze_5.
Up is Different_Maze_6.
Northwest is Different_Maze_7.
North is Different_Maze_8.
Southwest is Different_Maze_10.
East is Different_Maze_11.
West is Different_Maze_2.

[L138]Different_Maze_10 is a diffmaze room. "You are in a maze of little twisting passages, all different."
Down is Different_Maze_1.
East is Different_Maze_3.
Northeast is Different_Maze_4.
Up is Different_Maze_5.
West is Different_Maze_6.
North is Different_Maze_7.
South is Different_Maze_8.
Southeast is Different_Maze_9.
Southwest is Different_Maze_11.
Northwest is Different_Maze_2.

[L139]Different_Maze_11 is a diffmaze room. "You are in a maze of little twisty passages, all different."
Southwest is Different_Maze_1.
Northwest is Different_Maze_3.
East is Different_Maze_4.
West is Different_Maze_5.
North is Different_Maze_6.
Down is Different_Maze_7.
Southeast is Different_Maze_8.
Up is Different_Maze_9.
South is Different_Maze_10.
Northeast is Different_Maze_2.

Section -

[L140]Dead_End_14 is a deadend room.
Understand "dead/end/near/vending/machine" as Dead_End_14.

[O38]A vending machine is a closed container in Dead_End_14. [D0]"There is a massive vending machine here.  The instructions on the vending machine read: 'Drop coins here to receive fresh batteries.'". It is scenery.
Understand "slot/massive/battery/coin" as the vending machine.
Instead of dropping the coins in Dead_End_14, try inserting the noun into the vending machine.
Instead of inserting the rare coins into the vending machine:
	move fresh batteries to location;
	now the rare coins are nowhere;
	say [ccr]"Soon after you insert the coins in the coin slot, the vending machine makes a grinding sound, and a set of fresh batteries falls at your feet.";
	rule succeeds.
Instead of inserting something into the vending machine, say [ccr]"The machine seems to be designed to take coins."
Instead of attacking or breaking the vending machine, say [ccr]"The machine is quite sturdy and survives your attack without getting so much as a scratch."
Instead of looking under the vending machine, say [ccr]"You don't find anything under the machine."
Instead of searching the vending machine, say [I6]"You can't get inside the machine."
Instead of taking the vending machine, say [ccr]"The vending machine is far too heavy to move."

[O36]A message is a fixed in place thing with printed name "message in the dust" and description [M191]"'This is not the maze where the pirate leaves his treasure chest.'". [D0]"There is a message scrawled in the dust in a flowery script, reading: 'This is not the maze where the pirate leaves his treasure chest.'".
Understand "scrawl/writing/script/scrawled/flowery" as the message.
Instead of reading the message, try examining the noun.

[O39]Some fresh batteries are a thing with description [ccr]"They look like ordinary batteries. (A sepulchral voice says, 'Still going!')". [D0]"There are fresh batteries here." They are in the vending machine.
Understand "battery" as the fresh batteries.
The fresh batteries can be used.

[ccr]Some worn-out batteries are a thing with description "They look like ordinary batteries.". [O39D1]"Some worn-out batteries have been discarded nearby."
Understand "battery/worn/out" as the worn-out batteries.

Chapter - Dwarves and Pirate

There are 5 dwarves.
Instead of throwing something at a dwarf, try giving the noun to the second noun.
Instead of giving the tasty food to a dwarf:
	say [M103]"You fool, dwarves eat only coal!  Now you've made him *REALLY* mad!!";
	increment the madness of Dwarves Active.
Instead of giving something to a dwarf: say [M174]"There is nothing here to eat."
Instead of attacking a dwarf, say [M49]"With what?  Your bare hands?"
Before going when a dwarf is enclosed by the location:
	repeat with p running through following you dwarves:
		if the room gone to is the prior location of p, say [M2]"A little dwarf with a big knife blocks your way." instead.

[O28]The dwarf's axe is a thing with description [ccr]"It's just a little axe.". [D0]"There is a little axe here."
Understand "little/dwarven" as the axe. The axe can be near the bear.
Rule for writing a paragraph about the near the bear axe:
	say [D1]"There is a little axe lying beside the bear."
Instead of examining the near the bear axe, say [ccr]"It's lying beside the bear."
Instead of taking the near the bear axe, say [ccr]"No chance.  It's lying beside the ferocious bear, quite within harm's way."
Instead of throwing the axe at a dwarf:
	move axe to location;
	if a random chance of 1 in 3 succeeds:
		now the second noun is nowhere;
		say [M47][M149]"You killed a little dwarf[first time].  The body vanishes in a cloud of greasy black smoke[only].";
	otherwise:
		say [M48]"You attack a little dwarf, but he dodges out of the way.";
	rule succeeds.

The dwarf's knife is an undescribed thing. Understand "knives" as the dwarf's knife. The knife can be tried.
Instead of taking or examining the knife:
	say [M116]"The dwarves['] knives vanish as they strike the walls of the cave.";
	now the knife is tried;
	now the knife is nowhere.

[O30]The pirate is an undescribed man.

Chapter - The End Game

The End Game Area is a region.
Rule for writing a paragraph about something (called the item) when the location is in End Game Area:
	unless the item is handled, now the item is mentioned.

Section -

[L115]At_Ne_End is a lighted room in End Game Area with printed name "At NE End" and brief description "You're at NE end.". "You are at the northeast end of an immense room, even larger than the giant room.  It appears to be a repository for the 'Adventure' program.  Massive torches far overhead bathe the room with smoky yellow light.  Scattered about you can be seen a pile of bottles (all of them empty), a nursery of young beanstalks murmuring quietly, a bed of oysters, a bundle of black rods with rusty stars on their ends, and a collection of brass lanterns.  Off to one side a great many dwarves are sleeping on the floor, snoring loudly.  A sign nearby reads: 'Do not disturb the dwarves!'  An immense mirror is hanging against one wall, and stretches to the other end of the room, where various other sundry objects can be glimpsed dimly in the distance."
Understand "northeast/ne/end/of/repository" as At_Ne_End.
Southwest is At_Sw_End.

[ccr]An enormous mirror is a backdrop with description "It looks like an ordinary, albeit enormous, mirror." It is in At_Ne_End and At_Sw_End.
Understand "huge/big/large/suspended/hanging/vanity/dwarvish" as the enormous mirror.
Instead of attacking or breaking the enormous mirror:
	say [M197]"You strike the mirror a resounding blow, whereupon it shatters into a myriad tiny fragments.[paragraph break]";
	wake the sleeping dwarves;
	rule succeeds.

[ccr]A collection of adventure game materials is a backdrop with description "You've seen everything in here already, albeit in somewhat different contexts.". It is in At_Ne_End and At_Sw_End.
Understand "stuff/junk/torches/objects/repository/massive/sundry" as the materials when the player is in At_Ne_End.
Understand "pit/snake/snakes/fierce/green/stuff/junk/repository/massive/sundry" as the materials when the player is in At_Sw_End.
Instead of taking the materials, say [ccr]"Realizing that by removing the loot here you'd be ruining the game for future players, you leave the 'Adventure' materials where they are."

[ccr]Some sleeping dwarves are men in At_Ne_End with indefinite article "many" and description "I wouldn't bother the dwarves if I were you."
Understand "dwarf/snoring/dozing/snoozing" as the sleeping dwarves.
Instead of taking the sleeping dwarves, say [I6]"What, all of them?"
Instead of waking the sleeping dwarves:
	say [M199]"You prod the nearest dwarf, who wakes up grumpily, takes one look at you, curses, and grabs for his axe.[paragraph break]";
	wake the sleeping dwarves;
	rule succeeds.
Instead of attacking the sleeping dwarves:
	wake the sleeping dwarves;
	rule succeeds.

To wake the sleeping dwarves:
	say [M136]"The resulting ruckus has awakened the dwarves.  There are now several threatening little dwarves in the room with you!  Most of them throw knives at you!  All of them get you!";
	end the story finally.

Section - 

[L116]At_Sw_End is a lighted room in End Game Area with printed name "At SW End" and brief description "You're at SW end.". "You are at the southwest end of the repository.  To one side is a pit full of fierce green snakes.  On the other side is a row of small wicker cages, each of which contains a little sulking bird.  In one corner is a bundle of black rods with rusty marks on their ends.  A large number of velvet pillows are scattered about on the floor.  A vast mirror stretches off to the northeast.  At your feet is a large steel grate, next to which is a sign which reads, 'TREASURE VAULT.  Keys in main office.'".
Understand "southwest/sw/end/of/repository" as At_Sw_End.

[ccr]The repository grate is a locked scenery door with printed name "steel grate" and description "It just looks like an ordinary steel grate.". It is down from At_Sw_End.
Understand "ordinary/steel/grating" as the repository grate.

[O6]The mark rod is a thing in At_Sw_End with printed name "black rod" and description "It's a three foot black rod with a rusty mark on an end.". [D0]"A three foot black rod with a rusty mark on an end lies nearby."
Understand "black/rusty/three/foot/iron/explosive/dynamite/blast" as the mark rod.
After deciding the scope of the player when the location is in End Game Area: place the mark rod in scope.

Instead of finding something in End Game Area, say [M138]"I daresay whatever you want is around here somewhere."

Instead of blasting some object with in At_Sw_End when the mark rod is in At_Ne_End:
	increase the score by 35;
	say [M133]"There is a loud explosion, and a twenty-foot hole appears in the far wall, burying the dwarves in the rubble.  You march through the hole and find yourself in the main office, where a cheering band of friendly elves carry the conquering adventurer off into the sunset.";
	end the story finally;
	rule succeeds.
Instead of blasting some object with in At_Ne_End when the mark rod is in At_Sw_End:
	increase the score by 20;
	say [M134]"There is a loud explosion, and a twenty-foot hole appears in the far wall, burying the snakes in the rubble.  A river of molten lava pours in through the hole, destroying everything in its path, including you!";
	end the story finally;
	rule succeeds.
Instead of blasting some object with the mark rod:
	say [M135]"There is a loud explosion, and you are suddenly splashed across the walls of the room.";
	end the story finally;
	rule succeeds.

Section -

The_Main_Office is a room. Understand "main/office" or "main office" as The_Main_Office.
[this is so the player can name the main office and the parser will understand]

Chapter - Map

Index map with
	room-colour of aboveground rooms set to "Yellow Green",
	room-colour of maze rooms set to "Sky Blue",
	room-colour of deadend rooms set to "Sky Blue",
	room-colour of At_Brink_Of_Pit set to "Sky Blue",
	room-colour of diffmaze rooms set to "Tomato",
	room-colour of Dead_End_7 set to "Light Grey",
	room-colour of Dead_End_8 set to "Light Grey",
	room-colour of Dead_End_14 set to "Tomato",
	room-size of deadend rooms set to 18.

Index map with
	At_Hill_in_Road mapped west of At_End_of_Road,
	In_Forest_1 mapped south of At_Hill_in_Road,
	In_Forest_2 mapped east of In_A_Valley,
	Alike_Maze_4 mapped southeast of Alike_Maze_2,
	Dead_End_9 mapped southwest of Alike_Maze_1,
	Alike_Maze_14 mapped southeast of Alike_Maze_4,
	Dead_End_10 mapped south of Alike_Maze_1,
	Alike_Maze_8 mapped southeast of Alike_Maze_6,
	Alike_Maze_9 mapped southeast of Alike_Maze_8,
	Alike_Maze_7 mapped southwest of Alike_Maze_6,
	Alike_Maze_10 mapped northeast of Alike_Maze_9,
	West_Side_Of_Fissure mapped east of At_West_End_Of_Hall_Of_Mists,
	Different_Maze_1 mapped south of At_West_End_Of_Long_Hall,
	At_Junction_With_Warm_Walls mapped northeast of At_Fork_In_Path.
	
Index map with EPS file.

Chapter - Testing

Test grate with "in/take all/out/s/s/s/unlock/d".

Test bird with "w/get cage/on/w/w/w/get bird/w/d/n/drop bird".

Test all with "test grate/test bird".		