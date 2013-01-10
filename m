Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org, linux-nfc-request@lists.01.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH neard 2/2] build: Do not use deprecated AM_CONFIG_HEADER
Date: Thu, 10 Jan 2013 13:18:14 -0200
Message-Id: <1357831094-13513-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357831094-13513-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357831094-13513-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 59d9a0a..3109192 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(neard, 0.8)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
-- 
1.8.1

