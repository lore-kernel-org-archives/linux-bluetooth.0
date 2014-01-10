Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 16/19] emulator/bthost: Add implementation to PN RSP
Date: Fri, 10 Jan 2014 10:18:26 +0100
Message-Id: <1389345509-27206-17-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will send sabm command if PN_RSP will be received.
---
 emulator/bthost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index ebf8789..96200a0 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1516,6 +1516,9 @@ static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
 							rfcomm_fcs(buf);
 
 		send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	} else if (bthost->rfcomm_conn_data) {
+		rfcomm_sabm_send(bthost, conn, l2conn,
+				1, bthost->rfcomm_conn_data->channel * 2);
 	}
 }
 
-- 
1.8.3.1

