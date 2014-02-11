Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] emulator/bthost: Check length of received RFCOMM DISC frame
Date: Tue, 11 Feb 2014 11:50:59 +0100
Message-Id: <1392115862-19752-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't access rfcomm_hdr struct and ignore if frame is too short.
---
 emulator/bthost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index f92b479..2cd79bc 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1604,7 +1604,12 @@ static void rfcomm_disc_recv(struct bthost *bthost, struct btconn *conn,
 				uint16_t len)
 {
 	const struct rfcomm_cmd *hdr = data;
-	uint8_t dlci = RFCOMM_GET_DLCI(hdr->address);
+	uint8_t dlci;
+
+	if (len < sizeof(*hdr))
+		return;
+
+	dlci = RFCOMM_GET_DLCI(hdr->address);
 
 	rfcomm_ua_send(bthost, conn, l2conn, 0, dlci);
 }
-- 
1.8.3.1

