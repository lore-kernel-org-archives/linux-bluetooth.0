Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/8] android/avctp: Fix wrong error message
Date: Wed, 29 Jan 2014 14:36:01 +0200
Message-Id: <1390998967-24610-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avctp.c b/android/avctp.c
index 4ebf2ff..d308ec1 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -827,7 +827,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	ret -= AVCTP_HEADER_LENGTH;
 	if (ret < AVC_HEADER_LENGTH) {
-		error("Too small AVCTP packet");
+		error("Too small AVC packet");
 		goto failed;
 	}
 
-- 
1.8.3.2

