Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/8] avctp: Use already calculated avc header
Date: Wed, 29 Jan 2014 14:36:02 +0200
Message-Id: <1390998967-24610-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This removes long (81 characters) line as a side effect.
---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6fd1454..78bf1fd 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -942,7 +942,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	ret -= sizeof(struct avc_header);
 
-	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
+	operands = (uint8_t *) avc + sizeof(struct avc_header);
 	operand_count = ret;
 
 	if (avctp->cr == AVCTP_RESPONSE) {
-- 
1.8.3.2

