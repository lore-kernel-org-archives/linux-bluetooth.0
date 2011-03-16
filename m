Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add define for the maximum name length on HCI level
Date: Wed, 16 Mar 2011 14:29:35 +0200
Message-Id: <1300278577-23068-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
References: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a clear define for the maximum device name length in HCI
messages and thereby avoids magic numbers in the code.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci.h      |    8 +++++---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/hci_sysfs.c        |    6 +++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ec6acf2..1cd031c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -535,15 +535,17 @@ struct hci_cp_delete_stored_link_key {
 	__u8     delete_all;
 } __packed;
 
+#define HCI_MAX_NAME_LENGTH		248
+
 #define HCI_OP_WRITE_LOCAL_NAME		0x0c13
 struct hci_cp_write_local_name {
-	__u8     name[248];
+	__u8     name[HCI_MAX_NAME_LENGTH];
 } __packed;
 
 #define HCI_OP_READ_LOCAL_NAME		0x0c14
 struct hci_rp_read_local_name {
 	__u8     status;
-	__u8     name[248];
+	__u8     name[HCI_MAX_NAME_LENGTH];
 } __packed;
 
 #define HCI_OP_WRITE_CA_TIMEOUT		0x0c16
@@ -745,7 +747,7 @@ struct hci_ev_auth_complete {
 struct hci_ev_remote_name {
 	__u8     status;
 	bdaddr_t bdaddr;
-	__u8     name[248];
+	__u8     name[HCI_MAX_NAME_LENGTH];
 } __packed;
 
 #define HCI_EV_ENCRYPT_CHANGE		0x08
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 441dadb..9aabb14 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -94,7 +94,7 @@ struct hci_dev {
 	__u8		bus;
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
-	__u8		dev_name[248];
+	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		dev_class[3];
 	__u8		major_class;
 	__u8		minor_class;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3fbfa50..91ef526 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -200,7 +200,7 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
-	memcpy(hdev->dev_name, sent, 248);
+	memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 }
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -212,7 +212,7 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	memcpy(hdev->dev_name, rp->name, 248);
+	memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH);
 }
 
 static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 3c838a6..e544216 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -216,13 +216,13 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr, char
 static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char name[249];
+	char name[HCI_MAX_NAME_LENGTH + 1];
 	int i;
 
-	for (i = 0; i < 248; i++)
+	for (i = 0; i < HCI_MAX_NAME_LENGTH; i++)
 		name[i] = hdev->dev_name[i];
 
-	name[248] = '\0';
+	name[HCI_MAX_NAME_LENGTH] = '\0';
 	return sprintf(buf, "%s\n", name);
 }
 
-- 
1.7.4.1

