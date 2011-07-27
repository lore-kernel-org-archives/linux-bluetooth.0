Return-Path: <cyrus@holtmann.org>
From: Zheng Wu <wu.zheng@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zheng Wu <wu.zheng@intel.com>
Subject: [PATCH] fixing crash in irmc.c when vcard=0
Date: Wed, 27 Jul 2011 11:05:47 +0800
Message-Id: <1311735947-4835-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If getting the number of vcard is 0 in sync server, obexd will crash.
The reason is that null point is used in query_result of irmc.c.

---
 plugins/irmc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 0fb92be..2ecae21 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -167,6 +167,8 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	else
 		irmc->buffer = g_string_append(irmc->buffer, owner_vcard);
 
+	if (buffer == NULL)
+		goto finish;
 	/* loop around buffer and add X-IRMC-LUID attribs */
 	s = buffer;
 	while ((t = strstr(s, "UID:")) != NULL) {
@@ -189,7 +191,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	}
 	/* add remaining bit of buffer */
 	irmc->buffer = g_string_append(irmc->buffer, s);
-
+finish:
 	obex_object_set_io_flags(irmc, G_IO_IN, 0);
 }
 
-- 
1.7.3.4

