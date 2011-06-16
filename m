Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Fix build when pcsuite plugin is enabled
Date: Thu, 16 Jun 2011 10:34:59 +0300
Message-Id: <1308209699-3819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit 4ae4f7c4949c6e53cd4c874c9cc533038cd03fb2 breakes the pcsuite
plugin by changing the .read API.
---
 plugins/pcsuite.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index fc60114..125f25a 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -428,17 +428,13 @@ static int backup_close(void *object)
 	return 0;
 }
 
-static ssize_t backup_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+static ssize_t backup_read(void *object, void *buf, size_t count, uint8_t *hi)
 {
 	struct backup_object *obj = object;
 	ssize_t ret = 0;
 
 	*hi = OBEX_HDR_BODY;
 
-	if (flags)
-		*flags = 0;
-
 	if (obj->pending_call) {
 		DBG("cmd = %s, IN WAITING STAGE", obj->cmd);
 		return -EAGAIN;
-- 
1.7.5.4

