Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-2If04tWJGFSjXn4+DQ8h"
Message-Id: <1078361235.2921.12.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Problem with the i-Tec dongle solved
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
Date: Thu, 04 Mar 2004 01:47:15 +0100


--=-2If04tWJGFSjXn4+DQ8h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks,

I got the problematic i-Tec dongle working. The important thing is to
send a HCI_Reset as the first command at initialization. We don't do
this, but I can't remember why not. Maybe there were some problematic
chips in the early times of BlueZ. The attached patch is against 2.6.

And here is the new dongle:

hci0:   Type: USB
        BD Address: 00:03:C9:xx:xx:xx ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:303 acl:0 sco:0 commands:14 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> 
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <power control> <transparent SCO> <enhanced iscan> 
                <interlaced iscan> <interlaced pscan> <AFH cap. slave> <AFH cap. master> 
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'Broadcom BCM2035'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x69 LMP Ver: 1.1 (0x1) LMP Subver: 0xe00
        Manufacturer: Broadcom Corporation (15)

The nice thing is that it already supports AFH ;)

Regards

Marcel


--=-2If04tWJGFSjXn4+DQ8h
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== net/bluetooth/hci_core.c 1.25 vs edited =====
--- 1.25/net/bluetooth/hci_core.c	Thu Feb 26 00:53:38 2004
+++ edited/net/bluetooth/hci_core.c	Thu Mar  4 01:06:44 2004
@@ -189,6 +189,9 @@
 
 	/* Mandatory initialization */
 
+	/* Reset */
+	hci_send_cmd(hdev, OGF_HOST_CTL, OCF_RESET, 0, NULL);
+
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_LOCAL_FEATURES, 0, NULL);
 

--=-2If04tWJGFSjXn4+DQ8h--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
