Return-Path: <cyrus@holtmann.org>
Message-ID: <49886819.2030401@access-company.com>
Date: Tue, 03 Feb 2009 16:51:53 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ pairing failure and kernel 2.6.24 crash
Content-Type: multipart/mixed;
 boundary="------------040206030502010407080708"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040206030502010407080708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am working with BlueZ 3.22, kernel 2.6.24 on ARM and found 2 problems :

-  I am not able to pair with some phones (Nokia N70 and sony-ericsson 
P800). After some investigations, I found that a "L2CAP information 
request packet" is sent just after the ACL connection. Both phones reply 
with "command rejected" error, then disconnect the ACL link before BlueZ 
is able to finish the pairing (see attached traces).

- with some other phones (LG 990 Viewty and sony-ericsson T610), the 
kernel crashes after pairing initiated by the phone is completed.

For the first problem I removed the send of the "L2CAP information 
request packet" in the kernel (see attached patch). This fixes both 
problems.

I did not found any usage of the remote L2CAP information in kernel.
Is sending "L2CAP information request packet" mandatory for upper layer 
and/or qualification ?
Is my fix OK ?

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------


--------------040206030502010407080708
Content-Type: text/plain;
 name="P800-traces.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="P800-traces.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2008-12-08 18:59:46.112548 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:D9:14:D0:85 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2008-12-08 18:59:46.118621 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2008-12-08 18:59:46.861053 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0A:D9:14:D0:85 type ACL encrypt 0x00
2008-12-08 18:59:46.861145 < ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2008-12-08 18:59:46.861175 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
2008-12-08 18:59:46.861694 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 2
2008-12-08 18:59:46.861724 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x07
    Link policy: RSWITCH HOLD SNIFF 
2008-12-08 18:59:46.865875 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2008-12-08 18:59:46.865936 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0A:D9:14:D0:85 mode 2 clkoffset 0x0000
2008-12-08 18:59:46.869110 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x0c ncmd 0
    Error: Command Disallowed
2008-12-08 18:59:46.927276 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2008-12-08 18:59:46.952514 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2008-12-08 18:59:46.956176 > ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
      Command not understood
2008-12-08 18:59:46.956970 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
2008-12-08 18:59:46.960357 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2008-12-08 18:59:46.960418 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 1
2008-12-08 18:59:46.961029 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 2
    status 0x00 handle 1
2008-12-08 18:59:46.963562 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2008-12-08 18:59:46.964233 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:D9:14:D0:85
2008-12-08 18:59:46.972442 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0A:D9:14:D0:85
2008-12-08 18:59:46.977661 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
2008-12-08 18:59:46.978271 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:D9:14:D0:85
2008-12-08 18:59:51.145141 > HCI Event: Auth Complete (0x06) plen 3
    status 0x05 handle 1
    Error: Authentication Failure
2008-12-08 18:59:51.145690 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 2
2008-12-08 18:59:51.176605 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection


--------------040206030502010407080708
Content-Type: text/x-diff;
 name="l2cap_info_req_remove.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="l2cap_info_req_remove.diff"

--- 2.6_kernel.orig/net/bluetooth/l2cap.c	2008-11-27 04:58:06.000000000 +0100
+++ 2.6_kernel/net/bluetooth/l2cap.c	2009-02-03 16:43:18.000000000 +0100
@@ -2064,7 +2064,7 @@
 	if (!status) {
 		conn = l2cap_conn_add(hcon, status);
 		if (conn)
-			l2cap_conn_ready(conn);
+			l2cap_conn_start(conn);
 	} else
 		l2cap_conn_del(hcon, bt_err(status));
 

--------------040206030502010407080708--
