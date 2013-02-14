Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH sbc] build: Do not use deprecated AM_CONFIG_HEADER
Date: Thu, 14 Feb 2013 12:27:01 -0200
Message-Id: <1360852021-2693-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9d5ebdb..30496ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(sbc, 1.0)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
-- 
1.8.1.3

