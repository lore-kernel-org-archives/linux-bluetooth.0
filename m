Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash while exiting when endpoint has a a2dp stream
Date: Wed, 23 Mar 2011 17:43:33 +0200
Message-Id: <1300895013-32010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

After releasing the endpoint should not be used anymore.
---
 audio/a2dp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 8595350..88c280a 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1517,8 +1517,10 @@ proceed:
 
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
 {
-	if (sep->endpoint)
+	if (sep->endpoint) {
 		media_endpoint_release(sep->endpoint);
+		sep->endpoint = NULL;
+	}
 
 	avdtp_unregister_sep(sep->lsep);
 	g_free(sep);
-- 
1.7.1

