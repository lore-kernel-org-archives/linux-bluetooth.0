Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/2] AVDTP: Remove hand-written function name from log
Date: Thu,  4 Oct 2012 02:14:34 -0300
Message-Id: <1349327674-23672-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349327674-23672-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349327674-23672-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 8836ca1..7db3c02 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -770,7 +770,7 @@ static void avdtp_set_state(struct avdtp *session,
 	avdtp_get_peers(session, &src, &dst);
 	dev = manager_get_device(&src, &dst, FALSE);
 	if (dev == NULL) {
-		error("avdtp_set_state(): no matching audio device");
+		error("%s(): No matching audio device", __func__);
 		return;
 	}
 
-- 
1.7.12.2

