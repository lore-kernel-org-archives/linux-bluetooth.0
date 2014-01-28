Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] avctp: Use predefined HEADER_LENGTH instead of sizeof
Date: Tue, 28 Jan 2014 15:22:44 +0200
Message-Id: <1390915365-4335-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390915365-4335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390915365-4335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code consistent with using HEADER_LENGTH already defined and used
instead of sizeof(). Remove also ugly type conversion.
---
 profiles/audio/avctp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 570d609..0a1a457 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -924,24 +924,24 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
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

