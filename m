Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Fix race on incoming connection
Date: Fri, 29 Aug 2014 22:39:26 +0200
Message-Id: <1409344766-6798-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix race on incoming connection which leads to situaction
when New Link Key Event is sent to user space before Device Connected
Event.

Logs:
> HCI Event: Connect Request (0x04) plen 10
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Role: Slave (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 42
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
> HCI Event: IO Capability Response (0x32) plen 9
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication: No Bonding - MITM not required (0x00)
> HCI Event: IO Capability Request (0x31) plen 6
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
        Handle: 42
> HCI Event: Command Status (0x0f) plen 4
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11
        Handle: 42
        Features: 0xa4 0x08 0x00 0xc0 0x18 0x1e 0x79 0x83
          Encryption
          Role switch
          Sniff mode
          SCO link
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Extended features
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication: No Bonding - MITM not required (0x00)
> HCI Event: User Confirmation Request (0x33) plen 10
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Passkey: 000000
> HCI Event: Command Complete (0x0e) plen 10
      IO Capability Request Reply (0x01|0x002b) ncmd 1
        Status: Success (0x00)
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
        Handle: 42
        Page: 1
> HCI Event: Command Status (0x0f) plen 4
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13
        Status: Success (0x00)
        Handle: 42
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
> HCI Event: Command Complete (0x0e) plen 10
        Status: Success (0x00)
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
> HCI Event: Simple Pairing Complete (0x36) plen 7
        Status: Success (0x00)
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
> HCI Event: Link Key Notification (0x18) plen 23
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Link key: 00010203040506070809000102030405
        Key type: Unauthenticated Combination key from P-256 (0x07)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255
        Status: Success (0x00)
        Address: 00:AA:01:01:00:00 (OUI 00-AA-01)
        Name:
> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 42
        Encryption: Enabled with E0 (0x01)
@ New Link Key: 00:AA:01:01:00:00 (0)
@ Device Connected: 00:AA:01:01:00:00 (0) flags 0x0000

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/hci_event.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e6a496a..55c9d12 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3649,6 +3649,18 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	/* If flag HCI_CONN_MGMT_CONNECTED is not set in this point of time
+	 * that means remote is very quick with authenthication request and
+	 * kernel did make to ask for features and remote name.
+	 * To make sure that userspace will get device connected event before
+	 * any pairing related events, lets set HCI_CONN_MGMT_CONNECTED flag
+	 * here and send device connected event.
+	 */
+	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_connected(hdev, &conn->dst, conn->type,
+				      conn->dst_type, 0, NULL, 0,
+				      conn->dev_class);
+
 	hci_conn_hold(conn);
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-- 
1.8.4

