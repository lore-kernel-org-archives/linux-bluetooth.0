Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <30ed240e0704030441o2bf1033fjd48ee48126da20f@mail.gmail.com>
Date: Tue, 3 Apr 2007 21:41:38 +1000
From: "Brett Owen Rees VK2TMG " <breree@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] problems with getting Plan tronics M1000 to pair
	on Ubuntu system
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I tried pairing and then tried a connect - do I have a PIN issue?

Thanks,
Brett

root@vk2tmg:/etc/bluetooth# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:03:89:02:46:BD mode 1 clkoffset 0x0d76 class 0x200404
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:03:89:02:46:BD mode 1 clkoffset 0x0d76 (valid)
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:03:89:02:46:BD name 'M1000 by Plantronics'
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:03:89:02:46:BD ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:02:46:BD
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:03:89:02:46:BD
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:03:89:02:46:BD
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:03:89:02:46:BD
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:03:89:02:46:BD
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:03:89:02:46:BD
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 41 bdaddr 00:03:89:02:46:BD type ACL encrypt 0x00
    Error: PIN or Key Missing



-- 
===============
Brett Rees VK2TMG

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
