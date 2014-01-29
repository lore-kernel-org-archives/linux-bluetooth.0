Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/8] android/avctp: Use predefined HEADER_LENGTH instead of sizeof
Date: Wed, 29 Jan 2014 14:36:00 +0200
Message-Id: <1390998967-24610-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code consistent with using HEADER_LENGTH defined. Remove also type
conversion.
---
 android/avctp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 6f9b33b..4ebf2ff 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -818,24 +818,24 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 	if (ret <= 0)
 		goto failed;
 
-	if ((unsigned int) ret < sizeof(struct avctp_header)) {
+	if (ret < AVCTP_HEADER_LENGTH) {
 		error("Too small AVCTP packet");
 		goto failed;
 	}
 
 	avctp = (struct avctp_header *) buf;
 
-	ret -= sizeof(struct avctp_header);
-	if ((unsigned int) ret < sizeof(struct avc_header)) {
+	ret -= AVCTP_HEADER_LENGTH;
+	if (ret < AVC_HEADER_LENGTH) {
 		error("Too small AVCTP packet");
 		goto failed;
 	}
 
-	avc = (struct avc_header *) (buf + sizeof(struct avctp_header));
+	avc = (struct avc_header *) (buf + AVCTP_HEADER_LENGTH);
 
-	ret -= sizeof(struct avc_header);
+	ret -= AVC_HEADER_LENGTH;
 
-	operands = (uint8_t *) avc + sizeof(struct avc_header);
+	operands = (uint8_t *) avc + AVC_HEADER_LENGTH;
 	operand_count = ret;
 
 	if (avctp->cr == AVCTP_RESPONSE) {
-- 
1.8.3.2

