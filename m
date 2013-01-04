Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/3] build: Do not use deprecated AM_CONFIG_HEADER
Date: Thu,  3 Jan 2013 23:21:03 -0200
Message-Id: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index cdfc013..e8193ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ AC_INIT(bluez, 5.0)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests silent-rules
 					tar-pax no-dist-gzip dist-xz])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 AC_USE_SYSTEM_EXTENSIONS
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
-- 
1.8.1

