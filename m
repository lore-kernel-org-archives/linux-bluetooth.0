Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050626224545.GA14629@pangeia.com.br>
References: <OF6C4333A9.A9953808-ONC125702A.00447737-C125702A.0049AD28@dcx.dcx> <1119627686.7129.5.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1119627686.7129.5.camel@notepaq>
Subject: [Bluez-devel] Function not implemented (38)
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
Date: Sun, 26 Jun 2005 19:45:45 -0300


Sorry, but I don=B4t found it in docs/faq.=20

I try use csrsniff (and bpasniff) and both failed with same error:
# csrsniff 00:60:57:XX:XX:XX
Can't find sniffer at hci0: Function not implemented (38)

My system is:
# uname -a; hciconfig hci0 revision; hciconfig hci0
Linux debian 2.6.12-mh1 #3 Sun Jun 26 17:51:28 BRT 2005 i686 GNU/Linux
hci0:   Type: USB
        BD Address: 00:10:60:AA:9B:5B ACL MTU: 192:8 SCO MTU: 64:8
        HCI 17.11
        Chip version: BlueCore02
hci0:   Type: USB
        BD Address: 00:10:60:AA:9B:5B ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING=20
        RX bytes:1532 acl:0 sco:0 events:60 errors:0
        TX bytes:850 acl:0 sco:0 commands:56 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: SLAVE ACCEPT=20
        Name: 'message'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver: =
0x460
        Manufacturer: Cambridge Silicon Radio (10)

Any hits is welcome and thanks in advance.

./nelson -murilo


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
