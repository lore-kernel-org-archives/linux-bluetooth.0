Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd] MAP: Correction in coding style
Date: Fri, 06 Jan 2012 15:37:28 +0530
Message-id: <1325844448-9951-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Starting brace for a function should start on the next line.
---
 plugins/messages-tracker.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 8f9b30a..9c60f2c 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -237,7 +237,8 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 	return 0;
 }
 
-static gboolean async_get_folder_listing(void *s) {
+static gboolean async_get_folder_listing(void *s)
+{
 	struct session *session = s;
 	gboolean count = FALSE;
 	int folder_count = 0;
-- 
1.7.0.4

