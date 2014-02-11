Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] emulator/bthost: Check length of received RFCOMM UA frames
Date: Tue, 11 Feb 2014 11:51:01 +0100
Message-Id: <1392115862-19752-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check length of RFCOMM UA frames and ignore if frame is too short.
---
 emulator/bthost.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 33a0544..ab90f4c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1619,14 +1619,20 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 				uint16_t len)
 {
 	const struct rfcomm_cmd *ua_hdr = data;
-	uint8_t channel = RFCOMM_GET_CHANNEL(ua_hdr->address);
+	uint8_t channel;
 	struct rfcomm_connection_data *conn_data = bthost->rfcomm_conn_data;
-	uint8_t type = RFCOMM_GET_TYPE(ua_hdr->control);
+	uint8_t type;
 	uint8_t buf[14];
 	struct rfcomm_hdr *hdr;
 	struct rfcomm_mcc *mcc;
 	struct rfcomm_pn *pn_cmd;
 
+	if (len < sizeof(*ua_hdr))
+		return;
+
+	channel = RFCOMM_GET_CHANNEL(ua_hdr->address);
+	type = RFCOMM_GET_TYPE(ua_hdr->control);
+
 	if (channel && conn_data && conn_data->channel == channel) {
 		if (conn_data->cb)
 			conn_data->cb(conn->handle, l2conn->scid,
-- 
1.8.3.1

