Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Make the function sco_conn_del have a return type of void
Date: Tue, 18 Aug 2015 21:23:01 -0400
Message-Id: <1439947381-11251-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This makes the function sco_conn_del have a return type of void now
due to this function always running successfully and thus never
needing to signal its caller when a non recoverable internal failure
occurs by returning a error code to its respective caller.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/sco.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 688a040..f315c8d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -154,13 +154,13 @@ static void sco_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
-static int sco_conn_del(struct hci_conn *hcon, int err)
+static void sco_conn_del(struct hci_conn *hcon, int err)
 {
 	struct sco_conn *conn = hcon->sco_data;
 	struct sock *sk;
 
 	if (!conn)
-		return 0;
+		return;
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
@@ -179,7 +179,6 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 
 	hcon->sco_data = NULL;
 	kfree(conn);
-	return 0;
 }
 
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
-- 
2.1.4
