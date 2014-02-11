Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] emulator/bthost: Check length of received RFCOMM UIH frames
Date: Tue, 11 Feb 2014 11:51:02 +0100
Message-Id: <1392115862-19752-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392115862-19752-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add correct calculation of frame length. If frame is too short, ignore it.
---
 emulator/bthost.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index ab90f4c..8447817 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1760,17 +1760,30 @@ static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
 			struct l2conn *l2conn, const void *data, uint16_t len)
 {
 	const struct rfcomm_mcc *mcc = data;
+	const struct rfcomm_msc *msc;
+	const struct rfcomm_pn *pn;
+
+	if (len < sizeof(*mcc))
+		return;
 
 	switch (RFCOMM_GET_MCC_TYPE(mcc->type)) {
 	case RFCOMM_MSC:
+		if (len - sizeof(*mcc) < sizeof(*msc))
+			break;
+
+		msc = data + sizeof(*mcc);
+
 		rfcomm_msc_recv(bthost, conn, l2conn,
-						RFCOMM_TEST_CR(mcc->type) / 2,
-						data + sizeof(*mcc));
+				RFCOMM_TEST_CR(mcc->type) / 2, msc);
 		break;
 	case RFCOMM_PN:
+		if (len - sizeof(*mcc) < sizeof(*pn))
+			break;
+
+		pn = data + sizeof(*mcc);
+
 		rfcomm_pn_recv(bthost, conn, l2conn,
-					RFCOMM_TEST_CR(mcc->type) / 2,
-					data + sizeof(*mcc));
+				RFCOMM_TEST_CR(mcc->type) / 2, pn);
 		break;
 	default:
 		break;
@@ -1781,18 +1794,27 @@ static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
 {
-	const struct rfcomm_cmd *hdr = data;
+	const struct rfcomm_hdr *hdr = data;
+	uint16_t hdr_len;
 	const void *p;
 
+	if (len < sizeof(*hdr))
+		return;
+
 	if (RFCOMM_GET_DLCI(hdr->address))
 		return;
 
 	if (RFCOMM_TEST_EA(hdr->length))
-		p = data + sizeof(struct rfcomm_hdr);
+		hdr_len = sizeof(*hdr);
 	else
-		p = data + sizeof(struct rfcomm_hdr) + sizeof(uint8_t);
+		hdr_len = sizeof(*hdr) + sizeof(uint8_t);
+
+	if (len - hdr_len < 0)
+		return;
+
+	p = data + hdr_len;
 
-	rfcomm_mcc_recv(bthost, conn, l2conn, p, p - data);
+	rfcomm_mcc_recv(bthost, conn, l2conn, p, len - hdr_len);
 }
 
 static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

