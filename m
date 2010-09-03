Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: remove unused variable from cmtp
Date: Fri,  3 Sep 2010 18:43:56 -0300
Message-Id: <1283550237-6066-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A value was attributed 'src', but no one was using

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/cmtp/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index d4c6af0..d461606 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -321,12 +321,11 @@ static int cmtp_session(void *arg)
 int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 {
 	struct cmtp_session *session, *s;
-	bdaddr_t src, dst;
+	bdaddr_t dst;
 	int i, err;
 
 	BT_DBG("");
 
-	baswap(&src, &bt_sk(sock->sk)->src);
 	baswap(&dst, &bt_sk(sock->sk)->dst);
 
 	session = kzalloc(sizeof(struct cmtp_session), GFP_KERNEL);
-- 
1.7.2.2

