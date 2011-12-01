Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 2/3] Bluetooth: Remove magic bluetooth version numbers
Date: Thu,  1 Dec 2011 14:33:27 +0200
Message-Id: <1322742808-8507-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322742808-8507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322742808-8507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use bluetooth names instead of BT SIG assigned numbers

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |    5 +++++
 net/bluetooth/hci_conn.c          |    2 +-
 net/bluetooth/hci_event.c         |    6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 38cd3da..97264fc 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -36,6 +36,11 @@
 #define PF_BLUETOOTH	AF_BLUETOOTH
 #endif
 
+/* Bluetooth versions */
+#define BLUETOOTH_VER_1_1	1
+#define BLUETOOTH_VER_1_2	2
+#define BLUETOOTH_VER_2_0	3
+
 /* Reserv for core and drivers use */
 #define BT_SKB_RESERVE	8
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index de0b93e..b328ac6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -123,7 +123,7 @@ static void hci_acl_connect_cancel(struct hci_conn *conn)
 
 	BT_DBG("%p", conn);
 
-	if (conn->hdev->hci_ver < 2)
+	if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return;
 
 	bacpy(&cp.bdaddr, &conn->dst);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c6784da..445da8d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -498,7 +498,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 
 	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
 	 * any event mask for pre 1.2 devices */
-	if (hdev->lmp_ver <= 1)
+	if (hdev->lmp_ver <= BLUETOOTH_VER_1_1)
 		return;
 
 	events[4] |= 0x01; /* Flow Specification Complete */
@@ -562,7 +562,7 @@ static void hci_setup(struct hci_dev *hdev)
 {
 	hci_setup_event_mask(hdev);
 
-	if (hdev->hci_ver > 1)
+	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
@@ -1507,7 +1507,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		}
 
 		/* Set packet type for incoming connection */
-		if (!conn->out && hdev->hci_ver < 3) {
+		if (!conn->out && hdev->hci_ver < BLUETOOTH_VER_2_0) {
 			struct hci_cp_change_conn_ptype cp;
 			cp.handle = ev->handle;
 			cp.pkt_type = cpu_to_le16(conn->pkt_type);
-- 
1.7.4.1

