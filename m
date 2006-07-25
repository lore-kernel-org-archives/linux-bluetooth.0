Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 25 Jul 2006 12:40:02 -0600
MIME-Version: 1.0
Message-Id: <200607251240.03201.Bearcat@feline-soul.com>
Subject: [Bluez-users] Page timeout on Logetech cordless elite keyboard but
	mouse works
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello folks,

I am running sourcemage gnu/linux. My kernel is 2.6.17 and blues-libs and 
bluez-utils are versions 3.1. I have a Logitech cordless elite set (keyboard 
and MX 900 mouse).

The basis for my work on it so far is here: 
http://www.bueche.ch/comp/mx900/mx900.html

The logitech hub switches over to hci just fine and the mouse is successfully 
connected via blue tooth. (Note, both mouse and kb work in pure hid mode with 
no bluetooth). I need the bluetooth hub working as i will be getting a 
headset this week, that i need to have operational

However, i can not get the keyboard to connect. When i enter a "hidd --connect 
00:07:61:1d:29:32" i get "Can't get device information: Host is down" from 
the terminal  and "Problem connecting with 00:07:61:1d:29:32: Page Timeout" 
on a kdebluetooth tool tip.

I have hit the connect button on the keyboard repeatedly and even taken out a 
battery for a few seconds. I have verified that i am using the correct MAC 
address via the printing on the bottom of the keyboard.

I'll be happy to provide what ever config info you all need to help me resolve 
this.

One thought is that i do have a spare keyboard plugged into the keyboard port 
while i'm testing, or else i would not be able to type the commands to 
connect the bluetooth one.  Could this be blocking it? If so, how the heck 
would i resolve that?!

Thank you for your time,

Bearcat M. Sandor

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
Jabber: bearcatsandor@jabber.org


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
