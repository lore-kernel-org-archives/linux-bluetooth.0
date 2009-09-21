Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/4] Bluetooth: Put Basic Mode to be the default when using SOCK_SEQPACKET
Date: Mon, 21 Sep 2009 11:07:26 -0300
Message-Id: <1253542049-8503-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When no one specifies the mode and sk_type is SOCK_SEQPACKET Basic Mode
shall me used.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b030125..9d586fb 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2202,7 +2202,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_ERTM };
+	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	void *ptr = req->data;
 
 	BT_DBG("sk %p", sk);
-- 
1.6.3.3

