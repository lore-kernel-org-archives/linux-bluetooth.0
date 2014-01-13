Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] emulator/bthost: Fix sending L2CAP config req
Date: Mon, 13 Jan 2014 11:36:33 +0100
Message-Id: <1389609393-10860-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send L2CAP config request with correct dcid field. It worked
well only if scid and dcid of L2CAP connection were the same.
---
 emulator/bthost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 96d375f..f3bd4c6 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -968,7 +968,7 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 							le16_to_cpu(psm));
 
 		memset(&conf_req, 0, sizeof(conf_req));
-		conf_req.dcid = rsp.dcid;
+		conf_req.dcid = rsp.scid;
 
 		l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_CONFIG_REQ, 0,
 						&conf_req, sizeof(conf_req));
-- 
1.8.3.1

