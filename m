Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 17/19] emulator/bthost: Call rfcomm_connect_cb when connected
Date: Fri, 10 Jan 2014 10:18:27 +0100
Message-Id: <1389345509-27206-18-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will call connect callback when connected or failed to connect.
---
 emulator/bthost.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 96200a0..9b342ce 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1452,6 +1452,15 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 							rfcomm_fcs(buf);
 
 		send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	} else if (bthost->rfcomm_conn_data &&
+				bthost->rfcomm_conn_data->channel == channel) {
+		if (bthost->rfcomm_conn_data->cb)
+			bthost->rfcomm_conn_data->cb(conn->handle,
+							l2conn->scid, channel,
+					bthost->rfcomm_conn_data->user_data,
+									true);
+		free(bthost->rfcomm_conn_data);
+		bthost->rfcomm_conn_data = NULL;
 	}
 }
 
@@ -1459,6 +1468,19 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
 {
+	const struct rfcomm_cmd *hdr = data;
+	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+
+	if (bthost->rfcomm_conn_data &&
+				bthost->rfcomm_conn_data->channel == channel) {
+		if (bthost->rfcomm_conn_data->cb)
+			bthost->rfcomm_conn_data->cb(conn->handle,
+							l2conn->scid, channel,
+					bthost->rfcomm_conn_data->user_data,
+									false);
+		free(bthost->rfcomm_conn_data);
+		bthost->rfcomm_conn_data = NULL;
+	}
 }
 
 static void rfcomm_msc_recv(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

