Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: mgmt: Add local name information to read_info reply
Date: Wed, 16 Mar 2011 14:29:36 +0200
Message-Id: <1300278577-23068-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
References: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds the name of the adapter to the reply of the read_info
management command.

The management messages reserve 249 bytes for the name instead of 248
(like in the HCI spec) so that there is always a guarantee that it is
nul-terminated. That way it can safely be passed onto string
manipulation functions.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |    5 +++++
 net/bluetooth/mgmt.c         |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5fabfa8..7d0749b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -41,6 +41,10 @@ struct mgmt_rp_read_index_list {
 	__le16 index[0];
 } __packed;
 
+/* Reserve one extra byte for names in management messages so that they
+ * are always guaranteed to be nul-terminated */
+#define MGMT_MAX_NAME_LENGTH		(HCI_MAX_NAME_LENGTH + 1)
+
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
 	__u8 type;
@@ -55,6 +59,7 @@ struct mgmt_rp_read_info {
 	__u16 manufacturer;
 	__u8 hci_ver;
 	__u16 hci_rev;
+	__u8 name[MGMT_MAX_NAME_LENGTH];
 } __packed;
 
 struct mgmt_mode {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4476d8e..67529c8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -183,6 +183,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
+	memset(&rp, 0, sizeof(rp));
+
 	rp.type = hdev->dev_type;
 
 	rp.powered = test_bit(HCI_UP, &hdev->flags);
@@ -204,6 +206,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 	rp.hci_ver = hdev->hci_ver;
 	put_unaligned_le16(hdev->hci_rev, &rp.hci_rev);
 
+	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
+
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-- 
1.7.4.1

