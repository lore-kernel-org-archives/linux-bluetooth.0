Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 12/21] Bluetooth: A2MP: Helper functions to count HCI devs
Date: Thu, 10 Nov 2011 16:54:19 +0200
Message-Id: <1320936868-7978-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper functions used to cound HCI devices (AMP controllers) and
build controller list packet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    2 ++
 include/net/bluetooth/hci_core.h |   14 ++++++++++++++
 net/bluetooth/a2mp.c             |   31 +++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 139ce2a..77a071a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -56,6 +56,8 @@
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
+#define HCI_BREDR_ID	0
+
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_NO_RESET,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a5a05d..58ad764 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -591,6 +591,20 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 	return NULL;
 }
 
+static inline uint8_t hci_num_ctrl(void)
+{
+	uint8_t count = 0;
+	struct list_head *p;
+
+	read_lock_bh(&hci_dev_list_lock);
+	list_for_each(p, &hci_dev_list) {
+		count++;
+	}
+	read_unlock_bh(&hci_dev_list_lock);
+
+	return count;
+}
+
 #define hci_dev_lock(d)		spin_lock(&d->lock)
 #define hci_dev_unlock(d)	spin_unlock(&d->lock)
 #define hci_dev_lock_bh(d)	spin_lock_bh(&d->lock)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 800a7a8..7f931a1 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -75,6 +75,37 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
+{
+	cl->id = 0;
+	cl->type = 0;
+	cl->status = 1;
+}
+
+static void __a2mp_add_cl(struct a2mp_cl *cl, u8 num_ctrl)
+{
+	int i = 0;
+	struct hci_dev *hdev;
+
+	read_lock_bh(&hci_dev_list_lock);
+
+	__a2mp_cl_bredr(cl);
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		if (i++ >= num_ctrl)
+			goto out;
+
+		if (hdev->id == HCI_BREDR_ID)
+			continue;
+
+		cl[i].id = hdev->id;
+		cl[i].type = hdev->amp_type;
+		cl[i].status = hdev->amp_status;
+	}
+out:
+	read_unlock_bh(&hci_dev_list_lock);
+}
+
 /* Processing A2MP messages */
 static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
 							struct a2mp_cmd *hdr)
-- 
1.7.4.1

