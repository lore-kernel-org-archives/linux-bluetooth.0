Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 02/12] Bluetooth: Change SCO conn lock to mutex
Date: Thu, 22 Dec 2011 16:56:03 -0200
Message-Id: <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As part of the moving to process context, we will need to change
bh_lock_sock() to lock_sock() in the SCO code, but first the SCO
connection lock need to be moved to mutex otherwise we can not use
lock_sock() in a region locked by it. (i.e., we can't sleep inside a
spinlock critical session)

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/sco.h |    6 +++---
 net/bluetooth/sco.c         |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index fc1cf9d..1bd0d62 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -58,14 +58,14 @@ struct sco_conn {
 	bdaddr_t	*dst;
 	bdaddr_t	*src;
 
-	spinlock_t	lock;
+	struct mutex	lock;
 	struct sock	*sk;
 
 	unsigned int    mtu;
 };
 
-#define sco_conn_lock(c)	spin_lock(&c->lock);
-#define sco_conn_unlock(c)	spin_unlock(&c->lock);
+#define sco_conn_lock(c)	mutex_lock(&c->lock);
+#define sco_conn_unlock(c)	mutex_unlock(&c->lock);
 
 /* ----- SCO socket info ----- */
 #define sco_pi(sk) ((struct sco_pinfo *) sk)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8057a4b..36fe9eb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -114,7 +114,7 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon, __u8 status)
 	if (!conn)
 		return NULL;
 
-	spin_lock_init(&conn->lock);
+	mutex_init(&conn->lock);
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
-- 
1.7.6.4

