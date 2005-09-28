Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <433AD61D.1050307@cyberserver.dk>
From: Preben Holm <preben@cyberserver.dk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Problem with bluetooth sound... working but not working
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
Date: Wed, 28 Sep 2005 19:42:53 +0200

Hi everyone,

I'm new to this list, ny name is Preben and from Denmark...

Hardware:
Logitech F-0228A    headset
Trust BT-1300TP     bluetooth usb adapter

lsusb  (the mouse is a logitech, so the chip must be broadcom):
-----------------
Bus 001 Device 003: ID 046d:c50a Logitech, Inc.
Bus 001 Device 002: ID 0a5c:200a Broadcom Corp.
Bus 001 Device 001: ID 0000:0000
-----------------

The problem is, that all seems to work fine, but no sound will play.


This is the output from btsco when in verbose mode.
--------------
preben@laptop run $ ./connect_headset
btsco v0.4c
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=13
Sending up speaker change 13
recieved AT+CKPD=200
recieved AT+VGS=13
Sending up speaker change 13
recieved AT+VGS=12
Sending up speaker change 12
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=12
Sending up speaker change 12
recieved AT+VGS=13
Sending up speaker change 13
preben@laptop run $
--------------

Only "noise" is present in the speaker when trying to play with
   aplay -B 1000000 -D plughw:Headset ../call_in.wav

and it doesn't stop either.



Output from  hciconfig hci0 revision
-------------
laptop preben # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0E:A1:33:94:FE ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 263.3 / 9
laptop preben #
-------------


Similar configurations (headset+dongle) works on windows-computers, but 
why isn't there a SCO: HCI/PCM in the hciconfig hci0 revision output.

I'm using gentoo and in portage there are firmware for broadcom devices. 
Should this somehow be stuffed into the device or???


This is the scripts I use for init:
------------
/etc/init.d/bluetooth start
hciconfig hci0 voice 0x0060
modprobe snd-bt-sco
------------

and
------------
btsco -v 00:0D:44:2F:4B:25
------------

I would really like this to work...


Thanks
Preben


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
