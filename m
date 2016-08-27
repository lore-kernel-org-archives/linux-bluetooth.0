Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Introduce helper to pack mgmt version information
Date: Sat, 27 Aug 2016 20:23:39 +0200
Message-Id: <1472322221-86761-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mgmt version information will be also needed for the control
changell tracing feature. This provides a helper to pack them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cc349f633570..9f181b583b96 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1451,6 +1451,7 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 
+void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7639290b6de3..9071886df194 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -278,6 +278,14 @@ static u8 le_addr_type(u8 mgmt_addr_type)
 		return ADDR_LE_DEV_RANDOM;
 }
 
+void mgmt_fill_version_info(void *ver)
+{
+	struct mgmt_rp_read_version *rp = ver;
+
+	rp->version = MGMT_VERSION;
+	rp->revision = cpu_to_le16(MGMT_REVISION);
+}
+
 static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 data_len)
 {
@@ -285,8 +293,7 @@ static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("sock %p", sk);
 
-	rp.version = MGMT_VERSION;
-	rp.revision = cpu_to_le16(MGMT_REVISION);
+	mgmt_fill_version_info(&rp);
 
 	return mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, 0,
 				 &rp, sizeof(rp));
-- 
2.7.4

