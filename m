Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Convert internal SCO spinlock into a mutex
Date: Mon, 14 Jul 2014 01:28:05 +0200
Message-Id: <1405294085-41398-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the HCI even processing is done in a workqueue, there is no
need to use a spinlock inside the SCO support. Convert this into
a mutex.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 4d67b0354d23..e35be32ab0b5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -44,14 +44,14 @@ static struct bt_sock_list sco_sk_list = {
 struct sco_conn {
 	struct hci_conn	*hcon;
 
-	spinlock_t	lock;
+	struct mutex	lock;
 	struct sock	*sk;
 
 	unsigned int    mtu;
 };
 
-#define sco_conn_lock(c)	spin_lock(&c->lock);
-#define sco_conn_unlock(c)	spin_unlock(&c->lock);
+#define sco_conn_lock(c)	mutex_lock(&c->lock);
+#define sco_conn_unlock(c)	mutex_unlock(&c->lock);
 
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
@@ -112,7 +112,7 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	if (!conn)
 		return NULL;
 
-	spin_lock_init(&conn->lock);
+	mutex_init(&conn->lock);
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
-- 
1.9.3

