Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alexandre Boeglin <alex@nexedi.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504292235.51740.alex@nexedi.com>
Subject: [Bluez-users] Stowaway Thinkoutside / Dell axim keyboard
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
Date: Fri, 29 Apr 2005 22:35:51 +0000

Hello,

I just tested my Dell Axim bluetooth keyboard under linux/x86, and it
worked fine !

FYI, the dell keyboard is exactly the same as the stowaway
Thinkoutside, the only differences are that it has dell written on it,
and that it's sold $40 cheaper than thinkoutside.

[root@alex-laptop bluetooth]# hcitool inq
Inquiring ...
        00:03:C9:57:12:36       clock offset: 0x2352    class: 0x002540

[root@alex-laptop bluetooth]# hcitool info 00:03:C9:57:12:36
Requesting information ...
        BD Address:  00:03:C9:57:12:36
        Device Name: Think Outside Keyboard
        LMP Version: 1.2 (0x2) LMP Subversion: 0x4100
        Manufacturer: Broadcom Corporation (15)
        Features: 0xbc 0x02 0x04 0x28 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <RSSI> <power control> <enhanced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

Apr 29 21:55:01 alex-laptop hidd: New HID device 00:03:C9:57:12:36 (Broadcom Corp. Keyboard)

It the french/azerty version, and some of the keycodes (there are two
function keys for extended characters) seem to be wrongly assigned ...
Where should I look for if I want to try to fix these ?

Please no not hesitate to ask if you want me to fetch more usefull
information from the keyboard.

Regard,
Alex


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
