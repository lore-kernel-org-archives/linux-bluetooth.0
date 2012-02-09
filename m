Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 03/16] Bluetooth: Do not use sk lock in get_chan functions
Date: Thu,  9 Feb 2012 16:17:24 +0200
Message-Id: <1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When needed we take explicit lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae08944..dcf4792 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -105,9 +105,8 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
-	if (c)
-		lock_sock(c->sk);
 	mutex_unlock(&conn->chan_lock);
+
 	return c;
 }
 
@@ -128,9 +127,8 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
-	if (c)
-		lock_sock(c->sk);
 	mutex_unlock(&conn->chan_lock);
+
 	return c;
 }
 
-- 
1.7.8.3

