Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Flo <flolp@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604121641.01999.flolp@gmx.de>
Subject: [Bluez-devel] 2 broadcom chipset results with sco-mtu-patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Apr 2006 16:41:01 +0200

Hello bluez-devel, just dropping a note about my Broadcom tryouts...
(and the other hardware I had at hands - hope its useful)

I used 
kernel 2.6.16.2 from kernel.org
the sco-mtu.patch
the cvs btsco version I downloaded on 12th April 06.
The patch did not break anything...

working hardware:
Belkin F8T012 (Broadcom, with patch)
D-Link DBT-120 (Cambridge, with/without patch)
Motorola H300 [Headset] - works fine with btsco here, I think it can
be put on the list.

NOT working hardware:
Sitecom CN-500V2 (Broadcom, not at all)

Hardware details:

Motorola H300
hcitool info **:**:**:**:**:**
Requesting information ...
        BD Address:  **:**:**:**:**:**
        Device Name: Motorola H300
        LMP Version: 2.0 (0x3) LMP Subversion: 0x977
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <transparent SCO> <AFH cap. slave>
                <AFH cap. master>

Sitecom CN-500V2
hcitool hci0 revision
hci0:   Type: USB
        BD Address: **:**:**:**:**:** ACL MTU: 377:10 SCO MTU: 64:8
        Firmware 0.3 / 9


Belkin F8T012
hcitool hci0 revision
hci0:   Type: USB
        BD Address: **:**:**:**:**:** ACL MTU: 1017:8 SCO MTU: 64:8
        Firmware 8192.65 / 39

D-Link DBT-120
hcitool hci0 revision
hci0:   Type: USB
        BD Address: **:**:**:**:**:** ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

Get back to me for more details if necessary, greetings

Flo


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
