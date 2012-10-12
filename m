Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 4/7] Bluetooth: Send EFS Conf Rsp only for BR/EDR chan
Date: Fri, 12 Oct 2012 17:10:02 +0300
Message-Id: <1350051005-6015-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not send EFS Configuration Response for High Speed channel yet.
It will be sent after receiving Logical Link Complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 38b058d..1e717fd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3718,7 +3718,11 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 		/* check compatibility */
 
-		l2cap_send_efs_conf_rsp(chan, rsp, cmd->ident, flags);
+		/* Send rsp for BR/EDR channel */
+		if (!chan->ctrl_id)
+			l2cap_send_efs_conf_rsp(chan, rsp, cmd->ident, flags);
+		else
+			chan->ident = cmd->ident;
 	}
 
 unlock:
@@ -3767,7 +3771,11 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 			/* check compatibility */
 
-			l2cap_send_efs_conf_rsp(chan, buf, cmd->ident, 0);
+			if (!chan->ctrl_id)
+				l2cap_send_efs_conf_rsp(chan, buf, cmd->ident,
+							0);
+			else
+				chan->ident = cmd->ident;
 		}
 		goto done;
 
-- 
1.7.9.5

