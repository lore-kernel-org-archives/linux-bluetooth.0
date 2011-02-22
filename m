Return-Path: <cyrus@holtmann.org>
From: Feng Tang <feng.tang@intel.com>
To: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] Bluetooth: l2cap: fix a NULL pointer oops in l2cap_conn_start
Date: Tue, 22 Feb 2011 16:03:24 +0800
Message-Id: <1298361804-11733-1-git-send-email-feng.tang@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When I try to setup a PAND connection between the sever and client,
the server side always get a NULL pointer oops in l2cap_conn_start()
right after the client run "pand -r PANU -c sever_addr". Don't have
the boot log as it's an immediate hang.

Simply adding this "if (parent)" check will fix it, don't know whether
it fix the real problem. Anyway, send it as a hint.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 net/bluetooth/l2cap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 675614e..150366f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -583,8 +583,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					parent->sk_data_ready(parent, 0);
 
+					if (parent)
+						parent->sk_data_ready(parent, 0);
 				} else {
 					sk->sk_state = BT_CONFIG;
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-- 
1.7.0.4
