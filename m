Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 11/20] Bluetooth: A2MP: helper functions to count HCI devs
Date: Wed,  2 Nov 2011 16:02:39 +0200
Message-Id: <1320242568-372-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper functions used to cound HCI devices (AMP controllers) and
build controller list packet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   14 ++++++++++++++
 net/bluetooth/a2mp.c             |   27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d037516..a9e5168 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -543,6 +543,20 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
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
index 996a9dc..e10924e 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -71,6 +71,33 @@ static void a2mp_send(struct socket *a2mp_sock, u8 code, u8 ident, u16 len,
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
+		if (++i >= num_ctrl)
+			goto out;
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

