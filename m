Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@thedragonsedge.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507132152.30541.Linux@thedragonsedge.com>
Subject: [Bluez-users] Microsoft Intellimouse Explorer Scroll wheel help
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 13 Jul 2005 21:52:30 -0600

Hey folks,

I have the Microsoft Optical Desktop Elite for Bluetooth.  The mouse and 
keyboard work great (aside from the keyboard refusing to wake up once which 
may have been a fluke).

A few more things need to be done for full operability, but the first is to 
get the scroll wheel on the mouse working. 

To that end i have tried the setups at the following pages:

http://dorward.me.uk/linux/mouse/
http://www.linuxforums.org/forum/viewtopic.php?t=19182&highlight=imwheel
http://www.ussg.iu.edu/hypermail/linux/kernel/0404.1/0518.html
http://www.personal.psu.edu/users/g/c/gca101/linux_howtos/intellimouse.html
 and  

http://linuxreviews.org/howtos/xfree/mouse/index.html.en#toc2  (This one seems 
to be the most relevant since my mouse also has the tilt wheel so the number 
of buttons matches)

None of these configurations work for me.  
My xorg.conf is InputDevice section is currently set up as follows:

Section "InputDevice"

# Identifier and driver

    Identifier					"IntellimouseExplorer"
    Driver					"mouse"
    Option	"SendCoreEvents"	"true"
    Option	"Protocol"     	"ExplorerPS/2"
    Option	"Device"       	"/dev/input/mice"
    Option "ZAxisMapping"	     "8 9"
    Option	"Buttons"      	"9"
    Option	"Emulate3Buttons" 	"false"
    Option	"Name" 			"AutoDetected"
    Option	"Vendor" 			"AutoDetected" 
# Executable script /etc/X11/xinit/xinitrc.d/xmousebuttons contains:
# /usr/X11R6/bin/xmodmap -e "pointer = 1 2 3 6 7 8 9 4 5"
# Result is the scroll wheel and back/forward thumb buttons work.
EndSection

I have been running the xmod  and imwheel (sometimes) command in a terminal as 
a normal user when i log in.

For what it
The middle button works, as do left/right but not the scroll wheel nor the 
side buttons.

xev does not display anything when the side buttons or wheel is rotated.

Does anyone else have this mouse and if so how did you get your scroll wheel 
to work?

Does anyone have the tilt working?

Does the wheel on the keyboard map the same way the mouse wheel does (i would 
imagine not since the keyboard wheel does not depress)

For what it's worth i am on linux 2.6.12 and xorg 6.8.2, imwheel 1.0.0pre12. 
Everything is compiled from source. My system is an AMD 64 3000.

Thank you in advance for the help.

Bearcat M. Sandor



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
