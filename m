Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Fix dead statement
Date: Tue, 12 Oct 2010 11:08:10 +0300
Message-Id: <1286870891-5862-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
References: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Cannot reach dead statement "(*os->driver->close)(object);"
---
 src/obex.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 8d12f8f..41ba558 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -882,7 +882,7 @@ int obex_get_stream_start(struct obex_session *os, const char *filename)
 								&size, &err);
 	if (object == NULL) {
 		error("open(%s): %s (%d)", filename, strerror(-err), -err);
-		goto fail;
+		return err;
 	}
 
 	os->object = object;
@@ -893,12 +893,6 @@ int obex_get_stream_start(struct obex_session *os, const char *filename)
 		os->buf = g_malloc0(os->tx_mtu);
 
 	return 0;
-
-fail:
-	if (object)
-		os->driver->close(object);
-
-	return err;
 }
 
 int obex_put_stream_start(struct obex_session *os, const char *filename)
-- 
1.7.1

