Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: Add Authentication Failed reason to Disconnected Mgmt event
Date: Fri, 24 Jun 2016 11:59:34 +0200
Message-Id: <1466762374-4221-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If link is disconnected due to Authentication Failure (PIN or Key
Missing status) userspace will be notified about this with proper error
code. Many LE profiles define "PIN or Key Missing" status as indication
of remote lost bond so this allows userspace to take action on this.

@ Device Connected: 88:63:DF:88:0E:83 (1) flags 0x0000
        02 01 1a 05 03 0a 18 0d 18 0b 09 48 65 61 72 74  ...........Heart
        20 52 61 74 65                                    Rate
> HCI Event: Command Status (0x0f) plen 4
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 3585 flags 0x02 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: LE Meta Event (0x3e) plen 12
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 3585
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 3585
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 26201cd479a0921b6f949f0b1fa8dc82
> HCI Event: Command Status (0x0f) plen 4
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Change (0x08) plen 4
        Status: PIN or Key Missing (0x06)
        Handle: 3585
        Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 3585
        Reason: Authentication Failure (0x05)
> HCI Event: Command Status (0x0f) plen 4
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 3585
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 88:63:DF:88:0E:83 (1) reason 4

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  1 +
 net/bluetooth/hci_event.c        | 11 ++++++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index eefcf3e..0d450dc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -445,6 +445,7 @@ enum {
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_UNKNOWN_CONN_ID	0x02
 #define HCI_ERROR_AUTH_FAILURE		0x05
+#define HCI_ERROR_PIN_OR_KEY_MISSING	0x06
 #define HCI_ERROR_MEMORY_EXCEEDED	0x07
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
 #define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dc71473..77d7fe1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -654,6 +654,7 @@ enum {
 	HCI_CONN_PARAM_REMOVAL_PEND,
 	HCI_CONN_NEW_LINK_KEY,
 	HCI_CONN_SCANNING,
+	HCI_CONN_AUTH_FAILURE,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ea73e08..7647964 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -645,6 +645,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_TIMEOUT	0x01
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
+#define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b3dd5..6e0272a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2332,7 +2332,7 @@ static u8 hci_to_mgmt_reason(u8 err)
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
-	u8 reason = hci_to_mgmt_reason(ev->reason);
+	u8 reason;
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	bool mgmt_connected;
@@ -2355,6 +2355,12 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->state = BT_CLOSED;
 
 	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
+
+	if (test_bit(HCI_CONN_AUTH_FAILURE, &conn->flags))
+		reason = MGMT_DEV_DISCONN_AUTH_FAILURE;
+	else
+		reason = hci_to_mgmt_reason(ev->reason);
+
 	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
 				reason, mgmt_connected);
 
@@ -2613,6 +2619,9 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 	if (ev->status && conn->state == BT_CONNECTED) {
+		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
+			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
+
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
 		goto unlock;
-- 
2.7.4

On behalf of SCHILLER Medical SAS.
