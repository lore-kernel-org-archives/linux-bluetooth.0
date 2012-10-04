Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/2] AVCTP: Remove hand-written function name from log
Date: Thu,  4 Oct 2012 02:14:33 -0300
Message-Id: <1349327674-23672-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Besides being hand-written, it was wrong which leads to confusion with
the AVDTP.
---
 audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index b7b3083..53c28ec 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -392,7 +392,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 
 	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
 	if (dev == NULL) {
-		error("avdtp_set_state(): no matching audio device");
+		error("%s(): No matching audio device", __func__);
 		return;
 	}
 
-- 
1.7.12.2

