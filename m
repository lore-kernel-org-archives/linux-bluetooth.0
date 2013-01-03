Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/2] Bluetooth: Move hci_outgoing_auth_needed() to hci_conn.c
Date: Thu, 03 Jan 2013 18:35:28 +0530
Message-id: <1357218329-21399-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is done so that other files can use this function

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
 net/bluetooth/hci_event.c        |   18 ------------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 014a2ea..2e1897c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -706,6 +706,7 @@ int hci_get_dev_info(void __user *arg);
 int hci_get_conn_list(void __user *arg);
 int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
+int hci_outgoing_auth_needed(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..7fbabae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1027,3 +1027,20 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
 
 	return hchan;
 }
+
+int hci_outgoing_auth_needed(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	if (conn->state != BT_CONFIG || !conn->out)
+		return 0;
+
+	if (conn->pending_sec_level == BT_SECURITY_SDP)
+		return 0;
+
+	/* Only request authentication for SSP connections or non-SSP
+	 * devices with sec_level HIGH or if MITM protection is requested */
+	if (!hci_conn_ssp_enabled(conn) && !(conn->auth_type & 0x01) &&
+	    conn->pending_sec_level != BT_SECURITY_HIGH)
+		return 0;
+
+	return 1;
+}
\ No newline at end of file
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 705078a..720d5ec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1509,24 +1509,6 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static int hci_outgoing_auth_needed(struct hci_dev *hdev,
-				    struct hci_conn *conn)
-{
-	if (conn->state != BT_CONFIG || !conn->out)
-		return 0;
-
-	if (conn->pending_sec_level == BT_SECURITY_SDP)
-		return 0;
-
-	/* Only request authentication for SSP connections or non-SSP
-	 * devices with sec_level HIGH or if MITM protection is requested */
-	if (!hci_conn_ssp_enabled(conn) && !(conn->auth_type & 0x01) &&
-	    conn->pending_sec_level != BT_SECURITY_HIGH)
-		return 0;
-
-	return 1;
-}
-
 static int hci_resolve_name(struct hci_dev *hdev,
 				   struct inquiry_entry *e)
 {
-- 
1.7.9.5

