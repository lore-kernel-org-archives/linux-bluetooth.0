Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add hdev->short_name for EIR generation
Date: Wed, 22 Feb 2012 21:06:53 +0200
Message-Id: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's possible to provide a short name through the mgmt interface and
this name can be used for EIR generation when the full name doesn't fit
there. This patch adds the preliminary tracking of the provided short
name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 include/net/bluetooth/mgmt.h     |    2 +-
 net/bluetooth/mgmt.c             |    3 +++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 24dd770..3fcc7f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -129,6 +129,8 @@ struct le_scan_params {
 	int timeout;
 };
 
+#define HCI_MAX_SHORT_NAME_LENGTH	10
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -141,6 +143,7 @@ struct hci_dev {
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
+	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
 	__u8		dev_class[3];
 	__u8		major_class;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ac59cdd..495668c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -75,7 +75,7 @@ struct mgmt_rp_read_index_list {
 /* Reserve one extra byte for names in management messages so that they
  * are always guaranteed to be nul-terminated */
 #define MGMT_MAX_NAME_LENGTH		(HCI_MAX_NAME_LENGTH + 1)
-#define MGMT_MAX_SHORT_NAME_LENGTH	(10 + 1)
+#define MGMT_MAX_SHORT_NAME_LENGTH	(HCI_MAX_SHORT_NAME_LENGTH + 1)
 
 #define MGMT_SETTING_POWERED		0x00000001
 #define MGMT_SETTING_CONNECTABLE	0x00000002
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 16bddd2..3f6a2df 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2273,6 +2273,9 @@ static int set_local_name(struct sock *sk, u16 index, void *data,
 		goto failed;
 	}
 
+	memcpy(hdev->short_name, mgmt_cp->short_name,
+						sizeof(hdev->short_name));
+
 	memcpy(hci_cp.name, mgmt_cp->name, sizeof(hci_cp.name));
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(hci_cp),
 								&hci_cp);
-- 
1.7.9

