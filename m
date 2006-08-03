Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Warp <warp@adygtelecom.com>
To: bluez-devel@lists.sourceforge.net
Message-Id: <1154607738.10276.11.camel@warptech>
Mime-Version: 1.0
Date: Thu, 03 Aug 2006 16:22:18 +0400
Subject: [Bluez-devel] Mobidick BDU33A + SCO
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

Hi,

I have problem with SCO link over Mobidick BDU33A , after 1-3 minutes
established connection adapter may restart. 
My configuration:

hciconfig hci0 -a
hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:101 acl:0 sco:0 events:13 errors:0
        TX bytes:300 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Bluez-0'
        Class: 0x200404
        Service Classes: Audio
        Device Class: Audio/Video, Device conforms to the Headset
profile
        HCI Ver: 2.0 (0x3) HCI Rev: 0x6e6 LMP Ver: 2.0 (0x3) LMP Subver:
0x6e6
        Manufacturer: Cambridge Silicon Radio (10)

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
        Build 1766
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI

# hciconfig hci0 voice
hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
        Voice setting: 0x0060 (Default Condition)
        Input Coding: Linear
        Input Data Format: 2's complement
        Input Sample Size: 16 bit
        # of bits padding at MSB: 0
        Air Coding Format: CVSD


Kernel 2.6.17.7 with patch from bluez.org

Latest libs & utils.

Howto fix this problem?

Best Reagrds,
 Warp.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
