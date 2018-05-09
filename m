Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/3] build: Disable some warnings from GCC 8
Date: Wed,  9 May 2018 14:11:11 +0200
Message-Id: <20180509121113.4110-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GCC 8 -Wall -Wextra seem to enable additional checks. Those generates
lots of spourious warnings so disable them (at least for time being).
---
 acinclude.m4 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index bc39c6d73..39a6be44a 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -16,6 +16,9 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wall -Werror -Wextra"
 		with_cflags="$with_cflags -Wno-unused-parameter"
 		with_cflags="$with_cflags -Wno-missing-field-initializers"
+		with_cflags="$with_cflags -Wno-format-truncation"
+		with_cflags="$with_cflags -Wno-cast-function-type"
+		with_cflags="$with_cflags -Wno-stringop-truncation"
 		with_cflags="$with_cflags -Wdeclaration-after-statement"
 		with_cflags="$with_cflags -Wmissing-declarations"
 		with_cflags="$with_cflags -Wredundant-decls"
-- 
2.17.0

