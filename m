Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403310134.14280.ach@mpe.mpg.de>
Subject: [Bluez-users] bug link_key: no connection after AP was once accessed with Win XP AVM tools
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 31 Mar 2004 01:34:14 +0200

Hi,
to explore my AVM AP-X I once used WinXP.  After rebooting into
linux.  ciptool was unable to connect to the AP.  Fix/hack was to
shutdown hcid, move /etc/bluetooth/link_key away and restart hcid.
(I'm proud of this wild guess that fixed it ;)
Then I got a pin prompt again and everything started working again.

With the 'unusable-after-winxp-usage' link_key file I get

# ciptool connect 00:04:0E:85:34:F3
Can't connect L2CAP socket: Connection timed out

# hcidump -x gives:
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
  F3 34 85 0E 04 00 18 CC 02 00 00 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Link Key Request(0x17) plen 6
  F3 34 85 0E 04 00
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  F3 34 85 0E 04 00 EE 90 55 76 1E 90 F2 DB 52 22 16 F7 5E 15
  A7 F5
> HCI Event: Connect Complete(0x03) plen 11
  05 00 00 F3 34 85 0E 04 00 01 00

I use debian testing with 2.6.4 and
ii  bluez-hcidump              1.5-2                      Analyses Bluetooth HCI packets
ii  bluez-pan                  1.1rel-3                   Personal area networking for Bluetooth devices
ii  bluez-pin                  0.22-1                     Bluetooth PIN helper with D-BUS support
ii  bluez-sdp                  1.5-2                      BlueZ Bluetooth SDP daemon and tool
ii  bluez-utils                2.4-6                      Utilities for controlling Bluetooth devices

Here's hcid.conf

allee(0) ~ $ tcgrep -v '^(\s*#|$)' /etc/bluetooth/hcid.conf
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /usr/bin/bluepin.ach;
}
device {
        name "%h-%d";
        class 0x100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
        auth enable;
        encrypt enable;
}

-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
