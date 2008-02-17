Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU140-W76F2261C8313336A0D258CB200@phx.gbl>
From: mountain rides <gstaad22@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 17 Feb 2008 17:07:40 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Connecting to a two-way headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hi,

Apologies if I'm asking a repeated question, but my search just now didn't =
pick up any answers.

I'm trying to get a speaker-and-microphone headset working.

More exactly . . .

I have a new Sony Ericsson HBH-PV702 Bluetooth headset - that is, a headset=
 not with just speakers, but with both a speaker and microphone.  =


I also have a Dell Inspiron 6400 with Bluetooth built-in, on which I'm runn=
ing Debian Lenny (Linux 2.6.22-3-amd64 #1 SMP Sun Nov 4 18:18:09 UTC 2007 x=
86_64 GNU/Linux).

I would like to use the headset with Twinkle, which is also installed and o=
ften used (with a run-of-the-mill wired headset).

I have several bluetooth-related Debian packages installed, for example: "b=
luetooth" (3.24-1+b1); "bluetooth-alsa" (0.5cvs20070327-1); "bluetooth-audi=
o" (3.4-1+b1); "bluez-gnome" (0.13-1); "bluez-utils" (3.24-1+b1); "gnome-bl=
uetooth" (0.9.1-1); "gnome-vfs-obexftp" (0.4-1); "libbluetooth2" (3.24-1); =
"libbtctl4" (0.9.0-2); libgnomebt0 (0.9.1-1); "libsbc0" (0.0cvs20070728-1);=
 etc.  (This, according to Synaptic.)

>>From the headset's user's manual, I have learned that to connect it to anot=
her device, I must first "prepare" the headset - which I assume means put i=
t into "pairing" mode by pressing both volume-up and volume-down buttons si=
multaneously until the LED alternates red/green.

I learned from various sources on the net, that to connect my computer to t=
he headset, as the root user I must run the command:

hcitool scan

to discern the headset's (what-I'm-calling-"MAC") address:

Scanning ...
	00:1C:A4:20:CE:BE	HBH-PV702

And, once I have that address, I can use it with the hcitool cc command to =
connect to the headset

hcitool cc 00:1C:A4:20:CE:BE

The response to which in /var/log/syslog is

22:45:56 NetworkManager:  [1202852568.559130] nm_hal_device_added(): New de=
vice added (hal udi is '/org/freedesktop/Hal/devices/bluetooth_acl_1ca420ce=
be'). =

22:45:56 hcid[3320]: link_key_request (sba=3D00:16:CF:CF:09:16, dba=3D00:1C=
:A4:20:CE:BE)
22:45:57 NetworkManager:  [1202852571.034919] nm_hal_device_removed(): Devi=
ce removed (hal udi is '/org/freedesktop/Hal/devices/bluetooth_acl_1ca420ce=
be'). =


So my question is:

Is this right?  (It seems strange to me that the device would be removed on=
e second after it has been added.) =


If so, what would be the next step towards using the headset?  If not, how =
can I make it what it should be?

Or am I going about this completely the wrong way?

In case it helps to answer those questions, I'll provide a couple other thi=
ngs I've noticed:

I have a what is called a "Bluetooth Applet" in what I call my desktop's ta=
skbar.  When I right-click on it and select "Browse Devices", I get a one-i=
tem list of devices: "HBH-PV702 Headset".  The first time I ran

hcitool info 00:1C:A4:20:CE:BE

I was prompted by a graphical (rather than command-line) prompt (seemingly =
from the applet) saying "Pairing request for device: HBH-PV702 (00:1C:A4:20=
:CE:BE) Enter passkey for authentication:"

I entered "0000" (as mentioned in the headset's user's manual) and clicked =
the prompt's "OK" button, and the following was then printed in the command=
-prompt window where I had entered the hcitool info command:

BD Address:  00:1C:A4:20:CE:BE
LMP Version: 1.2 (0x2) LMP Subversion: 0x73b
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
	    =

	     =

	     =

	   =

	  =


Moreover, a padlock-icon also appeared in the applet's device-list between =
"HBH-PV702" and "Headset".  What this padlock means . . .  I have no idea.

But that passkey prompt was a one-time-only phenomenon.  Every subsequent h=
citool info command returns the same response in the command-prompt window =
- with no further prompt for a "passkey".  And the padlock remains.

I get the impression I'm way off track.


_________________________________________________________________
Climb to the top of the charts!=A0Play the word scramble challenge with sta=
r power.
http://club.live.com/star_shuffle.aspx?icid=3Dstarshuffle_wlmailtextlink_jan
-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
