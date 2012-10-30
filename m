Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 10/12] Bluetooth: AMP: Check for hs_hcon instead of ctrl_id
Date: Tue, 30 Oct 2012 17:53:02 +0200
Message-Id: <1351612384-12392-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When deciding whether to send EFS configuration response with success,
check rather for existence of High Speed physical link hs_hcon then
ctrl_id. There might be cases when there is ctrl_id but high speed link
is not established yet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bb2cd9e..bdffc4c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3921,7 +3921,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		/* check compatibility */
 
 		/* Send rsp for BR/EDR channel */
-		if (!chan->ctrl_id)
+		if (!chan->hs_hcon)
 			l2cap_send_efs_conf_rsp(chan, rsp, cmd->ident, flags);
 		else
 			chan->ident = cmd->ident;
@@ -3971,7 +3971,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				goto done;
 			}
 
-			if (!chan->ctrl_id) {
+			if (!chan->hs_hcon) {
 				l2cap_send_efs_conf_rsp(chan, buf, cmd->ident,
 							0);
 			} else {
-- 
1.7.9.5

