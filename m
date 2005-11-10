Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Cc: "Richard Pettitt" <richard.pettitt@coulomb.co.uk>,
   "Victor Alvarez" <victor.alvarez@globalcharge.com>
Subject: RE: [Bluez-users] bluez and asterisk
Message-ID: <HCEOIFALKKLBLJPENPNOIEEKCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1131577119.5544.151.camel@blade>
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
Date: Thu, 10 Nov 2005 13:07:03 -0000

Hi Marcel,

> Check the loaded modules. Maybe only sco.ko is missing.

That's just what I was reading up on; After some trial and error, I found
out that we need to load sco, rfcomm, and start the sdp server (sdpd) before
asterisk will startup without error.

I have one little problem with 'passcode'; I am prompted for a passcode on
the mobile phone (6310i) - whether the right code is entered or not, it
attempts to connect but then fails.

I have tried 'rfcomm connect <dev> <bdaddr> [<channel>]' command also, but
again the passcode fails when prompted.
The exact command is:

rfcomm connect 0 00:0E:6D:34:BD:B1 3

The exact error is:

Can't connect RFCOMM socket: Resource temporarily unavailable

PLEASE SOMEONE, any ideas??

Couple of things:

1. I have created a rfcomm0 device
2. I have gone into hcid.conf and edditted the pin_helper entry by pointing
it to a file I created with the code:
	#!/bin/sh
	echo "PIN:999"
3. I have also editted the /etc/bkuetooth/pin file and replaced 'Bluez'
(which was the only thing in the file) with 999 - This I am not at all sure
about.

I am very very very very close. Please someone help me fix this thing before
I die, in which case I will rest on your conscience forever!!!!! ;)

FYI:

hciconfig -a gives:

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2020 acl:64 sco:0 events:123 errors:0
        TX bytes:1269 acl:58 sco:0 commands:24 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
0x175
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hcio revision gives:

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 14.7
        Chip version: BlueCore02-External (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI

hcitool info bdaddr:

Requesting information ...
        BD Address:  00:0E:6D:34:BD:B1
        Device Name: Nokia 6310i
        LMP Version: 1.1 (0x1) LMP Subversion: 0x23b
        Manufacturer: Nokia Mobile Phones (1)
        Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <SCO link>
                <HV3 packets> <CVSD> <flow control (MB)



Best regards,

Khaled




-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Marcel
Holtmann
Sent: 09 November 2005 22:59
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] bluez and asterisk


Hi Khaled,

> I do apologise...didn't mean to offend anyone :) especially in this hour
of
> need! I suppose black and blue does resemble the beeting I have taken as a
> result of my efforts to get this implemented...

don't worry that much, but people tend to ignore hard to read messages
and multiple colors make emails hard to hard to read. The invention of
HTML emails was totally stupid and unneeded ;)

> Any idea on my problem Marcel? I have been reading the list but cannot
find
> much related to my issue; perhaps it is a good idea to discuss it...

Check the loaded modules. Maybe only sco.ko is missing.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
