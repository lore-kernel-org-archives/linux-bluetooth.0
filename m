Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH v3 2/2] Require GLIB v2.46
Date: Tue, 24 Jan 2017 11:03:42 -0800
Message-Id: <1485284622-10210-3-git-send-email-brian.gix@intel.com>
In-Reply-To: <1485284622-10210-1-git-send-email-brian.gix@intel.com>
References: <1485284622-10210-1-git-send-email-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_assert_cmpmem() called from unit test unit/test-midi.c
This function was not introduced until GLIB v2.46
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 91b4955..6d8bf9c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,8 +61,8 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
 
 AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.28 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.46, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.46 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 
-- 
1.9.1

