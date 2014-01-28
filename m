Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] avctp: Fix wrong error message
Date: Tue, 28 Jan 2014 15:22:45 +0200
Message-Id: <1390915365-4335-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390915365-4335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390915365-4335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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

