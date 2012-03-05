Return-Path: <cyrus@holtmann.org>
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
Subject: [RFC] Bluetooth: Set security level on incoming pairing request
Date: Mon,  5 Mar 2012 20:09:38 +0200
Message-Id: <1330970978-10963-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a master would like to raise the security level, it will send a
pairing request. While the pending security level is set on an incoming
security request (from a slave), it is not set on a pairing request. As
a result, the security level would not be raised on the slave in such
case.

Fix this by setting the pending security when receiving pairing
requests according to the requested authorization.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 net/bluetooth/smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ebf50065..17bf2ae 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -592,6 +592,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (req->auth_req & SMP_AUTH_BONDING)
 		auth = req->auth_req;
 
+	conn->hcon->pending_sec_level = authreq_to_seclevel(auth);
+
 	build_pairing_cmd(conn, req, &rsp, auth);
 
 	key_size = min(req->max_key_size, rsp.max_key_size);
-- 
1.7.7.6

