Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/5] Bluetooth: Fix context in RFCOMM tty
Date: Tue, 27 Dec 2011 15:28:45 -0200
Message-Id: <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We now run in process context, no need to disable interrupts.
Calls from the tty layer also run in process context.

rw_lock was converted to spinlock, we have more writers than readers in
this case.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/tty.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index fa8f4de5..a2d4f51 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -76,7 +76,7 @@ struct rfcomm_dev {
 };
 
 static LIST_HEAD(rfcomm_dev_list);
-static DEFINE_RWLOCK(rfcomm_dev_lock);
+static DEFINE_SPINLOCK(rfcomm_dev_lock);
 
 static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb);
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err);
@@ -146,7 +146,7 @@ static inline struct rfcomm_dev *rfcomm_dev_get(int id)
 {
 	struct rfcomm_dev *dev;
 
-	read_lock(&rfcomm_dev_lock);
+	spin_lock(&rfcomm_dev_lock);
 
 	dev = __rfcomm_dev_get(id);
 
@@ -157,7 +157,7 @@ static inline struct rfcomm_dev *rfcomm_dev_get(int id)
 			rfcomm_dev_hold(dev);
 	}
 
-	read_unlock(&rfcomm_dev_lock);
+	spin_unlock(&rfcomm_dev_lock);
 
 	return dev;
 }
@@ -205,7 +205,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (!dev)
 		return -ENOMEM;
 
-	write_lock_bh(&rfcomm_dev_lock);
+	spin_lock(&rfcomm_dev_lock);
 
 	if (req->dev_id < 0) {
 		dev->id = 0;
@@ -290,7 +290,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	__module_get(THIS_MODULE);
 
 out:
-	write_unlock_bh(&rfcomm_dev_lock);
+	spin_unlock(&rfcomm_dev_lock);
 
 	if (err < 0)
 		goto free;
@@ -327,9 +327,9 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
 	if (atomic_read(&dev->opened) > 0)
 		return;
 
-	write_lock_bh(&rfcomm_dev_lock);
+	spin_lock(&rfcomm_dev_lock);
 	list_del_init(&dev->list);
-	write_unlock_bh(&rfcomm_dev_lock);
+	spin_unlock(&rfcomm_dev_lock);
 
 	rfcomm_dev_put(dev);
 }
@@ -473,7 +473,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	di = dl->dev_info;
 
-	read_lock_bh(&rfcomm_dev_lock);
+	spin_lock(&rfcomm_dev_lock);
 
 	list_for_each_entry(dev, &rfcomm_dev_list, list) {
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
@@ -488,7 +488,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 			break;
 	}
 
-	read_unlock_bh(&rfcomm_dev_lock);
+	spin_unlock(&rfcomm_dev_lock);
 
 	dl->dev_num = n;
 	size = sizeof(*dl) + n * sizeof(*di);
@@ -766,9 +766,9 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 		rfcomm_dlc_unlock(dev->dlc);
 
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
-			write_lock_bh(&rfcomm_dev_lock);
+			spin_lock(&rfcomm_dev_lock);
 			list_del_init(&dev->list);
-			write_unlock_bh(&rfcomm_dev_lock);
+			spin_unlock(&rfcomm_dev_lock);
 
 			rfcomm_dev_put(dev);
 		}
-- 
1.7.7.5

