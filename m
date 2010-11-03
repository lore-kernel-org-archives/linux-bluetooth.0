Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix folder listing not able to use name header to list sub folders
Date: Wed,  3 Nov 2010 11:56:26 +0200
Message-Id: <1288778186-23418-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 plugins/ftp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 007fe4a..91c77a3 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -171,9 +171,6 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	if (g_strcmp0(type, CAP_TYPE) == 0)
 		return obex_get_stream_start(os, capability);
 
-	if (g_strcmp0(type, LST_TYPE) == 0)
-		return obex_get_stream_start(os, ftp->folder);
-
 	path = g_build_filename(ftp->folder, name, NULL);
 	err = obex_get_stream_start(os, path);
 
-- 
1.7.1

