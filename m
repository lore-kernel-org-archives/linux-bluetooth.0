Return-Path: <cyrus@holtmann.org>
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH] Support libtool-2
Date: Sun, 13 Nov 2011 12:03:40 +0200
Message-Id: <1321178620-17297-1-git-send-email-alon.barlev@gmail.com>
In-Reply-To: <1321177515-2908-1-git-send-email-alon.barlev@gmail.com>
References: <1321177515-2908-1-git-send-email-alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove now obsolete AC_DISABLE_STATIC in favor of
LT_INIT([disable-static])
---
 configure.ac |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c1397f0..2157489 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,8 +30,14 @@ PKG_CHECK_MODULES([CHECK], [check >= 0.9.4])
 m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 
-AC_DISABLE_STATIC
-ifdef([LT_INIT],[LT_INIT], [AC_PROG_LIBTOOL])
+ifdef(
+	[LT_INIT],
+	[LT_INIT([disable-static])],
+	[
+		AC_PROG_LIBTOOL
+		AC_DISABLE_STATIC
+	]
+)
 
 AC_FUNC_PPOLL
 
-- 
1.7.3.4

