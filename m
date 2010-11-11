Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] string_free is specific to filesystem only
Date: Thu, 11 Nov 2010 22:46:20 +0200
Message-Id: <1289508380-8873-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

string_free is a callback function specific to filesystem plugin only.
It is used by OBEX drivers when closing OBEX object and not API
exposed to other plugins. g_string_free can be used instead of it when
required.
---
 plugins/filesystem.c |    2 +-
 plugins/filesystem.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index bf00ac2..bb758ab 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -474,7 +474,7 @@ static void *pcsuite_open(const char *name, int oflag, mode_t mode,
 	return append_listing(object, name, TRUE, size, err);
 }
 
-int string_free(void *object)
+static int string_free(void *object)
 {
 	GString *string = object;
 
diff --git a/plugins/filesystem.h b/plugins/filesystem.h
index 712653f..9c7ad9a 100644
--- a/plugins/filesystem.h
+++ b/plugins/filesystem.h
@@ -21,5 +21,4 @@
  *
  */
 
-int string_free(void *object);
 ssize_t string_read(void *object, void *buf, size_t count);
-- 
1.7.0.4

