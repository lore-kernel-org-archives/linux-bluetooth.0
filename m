Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040310150142.GD1127@pangeia.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] local name in hciemu
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Mar 2004 12:01:43 -0300


Hi,

I try use hciemu and try set localname of interface.

If I try:
hciemu  -n 00:07:E0:0D:C3:48
hciemu[9823]: HCI Emulation daemon ver 1.0 started

And run hciconfig I get: 
hciconfig hci0
hci0:   Type: VHCI
        BD Address: 00:07:E0:0D:C3:48 ACL MTU: 1000:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:20 errors:0
        TX bytes:1332 acl:0 sco:0 commands:20 errors:0

But hciconfig -a failed :
hci0:   Type: VHCI
        BD Address: 00:07:E0:0D:C3:48 ACL MTU: 1000:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:20 errors:0
        TX bytes:1332 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xff 0xff 0xff 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0. Input/output error(5)

If I try set (hciconfig hci0 name "localname")  I get same error.

Any hints? 

./nelson -murilo



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
