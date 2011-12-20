Return-Path: <cyrus@holtmann.org>
From: DoHyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH obexd] pbap: Fix NULL check rutine
Date: Tue, 20 Dec 2011 16:27:04 +0900
Message-id: <1324366024-19523-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If obj->buffer is NULL, we should exit the function.
Because the crash will be occured in string_read() function.

THe previous statement returns the error when both obj->buffer and obj->aparams is NULL.
---
 plugins/pbap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0f07c46..e642599 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -996,7 +996,7 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count)
 	DBG("buffer %p maxlistcount %d", obj->buffer,
 						pbap->params->maxlistcount);
 
-	if (!obj->buffer && !obj->aparams)
+	if (!obj->buffer || !obj->aparams)
 		return -EAGAIN;
 
 	if (pbap->params->maxlistcount == 0)
-- 
1.7.4.1

