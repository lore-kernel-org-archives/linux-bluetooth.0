Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] emulator/bthost: Check length of received RFCOMM DM frames
Date: Tue, 11 Feb 2014 11:51:00 +0100
Message-Id: <1392115862-19752-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ignore too short received RFCOMM DM frames.
---
 emulator/bthost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2cd79bc..33a0544 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1669,9 +1669,14 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
 				uint16_t len)
 {
 	const struct rfcomm_cmd *hdr = data;
-	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+	uint8_t channel;
 	struct rfcomm_connection_data *conn_data = bthost->rfcomm_conn_data;
 
+	if (len < sizeof(*hdr))
+		return;
+
+	channel = RFCOMM_GET_CHANNEL(hdr->address);
+
 	if (conn_data && conn_data->channel == channel) {
 		if (conn_data->cb)
 			conn_data->cb(conn->handle, l2conn->scid,
-- 
1.8.3.1

