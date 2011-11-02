Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/8 v2] filesystem: remove unnecessary includes
Date: Wed,  2 Nov 2011 15:57:55 +0200
Message-Id: <1320242275-2424-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As a mimetype driver only plugin filesystem should not depend on
service.h nor obex.h
---
Add description

 plugins/filesystem.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 4106c80..12ca209 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -48,9 +48,7 @@
 #include "obexd.h"
 #include "plugin.h"
 #include "log.h"
-#include "obex.h"
 #include "mimetype.h"
-#include "service.h"
 #include "filesystem.h"
 
 #define EOL_CHARS "\n"
@@ -79,7 +77,9 @@
 			" modified=\"%s\" mem-type=\"DEV\"" \
 			" created=\"%s\"/>" EOL_CHARS
 
-static const uint8_t FTP_TARGET[TARGET_SIZE] = {
+#define FTP_TARGET_SIZE 16
+
+static const uint8_t FTP_TARGET[FTP_TARGET_SIZE] = {
 			0xF9, 0xEC, 0x7B, 0xC4,  0x95, 0x3C, 0x11, 0xD2,
 			0x98, 0x4E, 0x52, 0x54,  0x00, 0xDC, 0x9E, 0x09  };
 
@@ -669,7 +669,7 @@ static struct obex_mime_type_driver file = {
 
 static struct obex_mime_type_driver capability = {
 	.target = FTP_TARGET,
-	.target_size = TARGET_SIZE,
+	.target_size = FTP_TARGET_SIZE,
 	.mimetype = "x-obex/capability",
 	.open = capability_open,
 	.close = capability_close,
@@ -678,7 +678,7 @@ static struct obex_mime_type_driver capability = {
 
 static struct obex_mime_type_driver folder = {
 	.target = FTP_TARGET,
-	.target_size = TARGET_SIZE,
+	.target_size = FTP_TARGET_SIZE,
 	.mimetype = "x-obex/folder-listing",
 	.open = folder_open,
 	.close = string_free,
@@ -687,7 +687,7 @@ static struct obex_mime_type_driver folder = {
 
 static struct obex_mime_type_driver pcsuite = {
 	.target = FTP_TARGET,
-	.target_size = TARGET_SIZE,
+	.target_size = FTP_TARGET_SIZE,
 	.who = PCSUITE_WHO,
 	.who_size = PCSUITE_WHO_SIZE,
 	.mimetype = "x-obex/folder-listing",
-- 
1.7.6.4

