Return-Path: <cyrus@holtmann.org>
From: Bart Westgeest <bart@elbrys.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bart Westgeest <bart@elbrys.com>
Subject: [PATCH 1/3] sdp: Inlined single use of function sdp_set_data_type
Date: Mon, 19 Nov 2012 14:04:30 -0500
Message-Id: <1353351872-10628-2-git-send-email-bart@elbrys.com>
In-Reply-To: <1353351872-10628-1-git-send-email-bart@elbrys.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inlining single use of sdp_set_data_type to improve code readability,
since the function was doing more than just setting the data type.
---
 lib/sdp.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 1a5bf01..dba3f59 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -666,18 +666,6 @@ static int sdp_get_data_type(sdp_buf_t *buf, uint8_t dtd)
 	return data_type;
 }
 
-static int sdp_set_data_type(sdp_buf_t *buf, uint8_t dtd)
-{
-	int data_type = 0;
-	uint8_t *p = buf->data + buf->data_size;
-
-	*p = dtd;
-	data_type = sdp_get_data_type(buf, dtd);
-	buf->data_size += data_type;
-
-	return data_type;
-}
-
 void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
 {
 	uint8_t *p = buf->data;
@@ -815,9 +803,13 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	uint128_t u128;
 	uint8_t *seqp = buf->data + buf->data_size;
 
-	pdu_size = sdp_set_data_type(buf, dtd);
+	pdu_size = sdp_get_data_type(buf, dtd);
+	buf->data_size += pdu_size;
+
 	data_size = sdp_get_data_size(buf, d);
 
+	*seqp = dtd;
+
 	switch (dtd) {
 	case SDP_DATA_NIL:
 		break;
-- 
1.7.10.4

