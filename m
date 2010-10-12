Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Fix possible NULL pointer deference
Date: Tue, 12 Oct 2010 11:08:08 +0300
Message-Id: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Variable "os->driver" tracked as NULL.
---
 src/obex.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 92d3b5c..8d12f8f 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -589,7 +589,9 @@ static int obex_read_stream(struct obex_session *os, obex_t *obex,
 	os->buf = g_realloc(os->buf, os->pending + size);
 	memcpy(os->buf + os->pending, buffer, size);
 	os->pending += size;
-	if (os->object == NULL) {
+
+	/* only write if both object and driver are valid */
+	if (os->object == NULL || os->driver == NULL) {
 		DBG("Stored %u bytes into temporary buffer", os->pending);
 		return 0;
 	}
-- 
1.7.1

