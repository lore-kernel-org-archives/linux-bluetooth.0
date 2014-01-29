Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/8] avctp: Fix wrong error message
Date: Wed, 29 Jan 2014 14:36:05 +0200
Message-Id: <1390998967-24610-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 0a1a457..9f87859 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -933,7 +933,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	ret -= AVCTP_HEADER_LENGTH;
 	if (ret < AVC_HEADER_LENGTH) {
-		error("Too small AVCTP packet");
+		error("Too small AVC packet");
 		goto failed;
 	}
 
-- 
1.8.3.2

