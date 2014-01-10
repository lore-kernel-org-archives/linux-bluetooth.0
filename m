Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 11/19] emulator/bthost: Implement recv_disc rfcomm frame in bthost
Date: Fri, 10 Jan 2014 10:18:21 +0100
Message-Id: <1389345509-27206-12-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/bthost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1e2506e..391d6cd 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1379,6 +1379,10 @@ static void rfcomm_disc_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
 {
+	const struct rfcomm_cmd *hdr = data;
+	uint8_t dlci = RFCOMM_GET_DLCI(hdr->address);
+
+	rfcomm_ua_send(bthost, conn, l2conn, 0, dlci);
 }
 
 static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

