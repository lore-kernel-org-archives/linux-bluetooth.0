Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pete Stevens <pete@ex-parrot.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0502231536460.9757@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] hcitool bug
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
Date: Wed, 23 Feb 2005 15:41:45 +0000 (GMT)

Hi,

This confuses me, can anyone explain why I get this?

[root@pstevens bluetooth-pc-tag]# hcitool dev
Devices:
        hci0    00:0C:76:47:6A:94

[root@pstevens bluetooth-pc-tag]# hcitool -i 00:0C:76:47:6A:94 info
00:0E:6D:13:D8:74
Requesting information ...
Get connection info failed: No such file or directory

[root@pstevens bluetooth-pc-tag]# hcitool info 00:0E:6D:13:D8:74
Requesting information ...
        BD Address:  00:0E:6D:13:D8:74
        Device Name: Nokia 7600
        LMP Version: 1.1 (0x1) LMP Subversion: 0x24d
        Manufacturer: Nokia Mobile Phones (1)
        Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <SCO link>
                <HV3 packets> <CVSD>


If I specify the dongle by mac address it fails to get the info of the device.

For extra info

[root@pstevens bluetooth-pc-tag]# uname -a
Linux pstevens.hypertag.local 2.6.10-1.9_FC2 #1 Thu Jan 13 17:54:57 EST 2005
i686 athlon i386 GNU/Linux

[root@pstevens bluetooth-pc-tag]# hcitool --help
hcitool - HCI Tool ver 2.4


Any got any ideas why this doesn't work?

Thanks,

Pete Stevens

--
Pete Stevens
pete@ex-parrot.com
http://www.ex-parrot.com/~pete/

    People always ask me, "Where were you when Kennedy was shot?" Well, I don't
                                                                 have an alibi.
                                                                 -- Emo Philips


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
