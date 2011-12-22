Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 07/12] Bluetooth: Remove lock from inquiry_cache
Date: Thu, 22 Dec 2011 16:56:08 -0200
Message-Id: <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It was never used, so removing it.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4ff08d6..37d7cb8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -50,7 +50,6 @@ struct inquiry_entry {
 };
 
 struct inquiry_cache {
-	spinlock_t		lock;
 	__u32			timestamp;
 	struct inquiry_entry	*list;
 };
@@ -349,15 +348,9 @@ extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
 
-#define inquiry_cache_lock(c)		spin_lock(&c->lock)
-#define inquiry_cache_unlock(c)		spin_unlock(&c->lock)
-#define inquiry_cache_lock_bh(c)	spin_lock_bh(&c->lock)
-#define inquiry_cache_unlock_bh(c)	spin_unlock_bh(&c->lock)
-
 static inline void inquiry_cache_init(struct hci_dev *hdev)
 {
 	struct inquiry_cache *c = &hdev->inq_cache;
-	spin_lock_init(&c->lock);
 	c->list = NULL;
 }
 
-- 
1.7.6.4

