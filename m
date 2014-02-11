Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] emulator/bthost: Check length of received RFCOMM SABM frame
Date: Tue, 11 Feb 2014 11:50:58 +0100
Message-Id: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will check length of received SABM frame. Ignore frame if
it is too short.
---
 emulator/bthost.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 3ff2a36..f92b479 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1578,9 +1578,15 @@ static void rfcomm_sabm_recv(struct bthost *bthost, struct btconn *conn,
 				uint16_t len)
 {
 	const struct rfcomm_cmd *hdr = data;
-	uint8_t dlci = RFCOMM_GET_DLCI(hdr->address);
+	uint8_t dlci;
 	struct rfcomm_conn_cb_data *cb;
-	uint8_t chan = RFCOMM_GET_CHANNEL(hdr->address);
+	uint8_t chan;
+
+	if (len < sizeof(*hdr))
+		return;
+
+	chan = RFCOMM_GET_CHANNEL(hdr->address);
+	dlci = RFCOMM_GET_DLCI(hdr->address);
 
 	cb = bthost_find_rfcomm_cb_by_channel(bthost, chan);
 	if (!dlci || cb) {
-- 
1.8.3.1

