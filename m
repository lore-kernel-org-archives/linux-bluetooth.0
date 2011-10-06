Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Fix possible crash when using syncevolution plugin
Date: Thu,  6 Oct 2011 11:46:58 +0300
Message-Id: <1317890818-15669-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Context os need to be set since synce_write uses it, in addiction
check if context is valid in synce_open.
---
 plugins/syncevolution.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index ae13e43..a389783 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -230,6 +230,7 @@ static void *synce_connect(struct obex_session *os, int *err)
 	context->dbus_conn = conn;
 	context->lasterr = -EAGAIN;
 	context->id = obex_get_id(os);
+	context->os = os;
 
 	if (err)
 		*err = 0;
@@ -281,8 +282,10 @@ static void synce_disconnect(struct obex_session *os, void *user_data)
 static void *synce_open(const char *name, int oflag, mode_t mode,
 				void *user_data, size_t *size, int *err)
 {
+	struct synce_context *context = user_data;
+
 	if (err)
-		*err = 0;
+		*err = context ? 0 : -EFAULT;
 
 	return user_data;
 }
-- 
1.7.6.4

