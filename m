Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 11/20] Bluetooth: A2MP: Helper functions to count HCI devs
Date: Thu, 22 Dec 2011 13:06:17 +0200
Message-Id: <1324551986-29431-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper functions used to cound HCI devices (AMP controllers) and
build controller list packet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    2 ++
 include/net/bluetooth/hci_core.h |   14 ++++++++++++++
 net/bluetooth/a2mp.c             |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cd52d21..3d3cc5d 100644
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
index 25c161a..bd72ef7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -594,6 +594,20 @@ static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
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
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b1400ad..c18eb59 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -13,6 +13,7 @@
 */
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
@@ -67,6 +68,39 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
+{
+	cl->id = 0;
+	cl->type = 0;
+	cl->status = 1;
+}
+
+static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
+{
+	int i = 0;
+	struct hci_dev *hdev;
+
+	read_lock_bh(&hci_dev_list_lock);
+
+	__a2mp_cl_bredr(cl);
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		/* Iterate through AMP controllers */
+		if (hdev->id == HCI_BREDR_ID)
+			continue;
+
+		/* Starting from second entry */
+		if (++i >= num_ctrl)
+			goto out;
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

