Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ross Burton <ross.burton@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Makefile.obexd: add missing mkdir in builtin.h generation
Date: Fri, 22 Apr 2016 16:17:55 +0100
Message-Id: <1461338275-5593-1-git-send-email-ross.burton@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In parallel out-of-tree builds it's possible that obexd/src/builtin.h is
generated before the target directory has been implicitly created. Solve this by
creating the directory before writing into it.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 Makefile.obexd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc..c8286f0 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -103,6 +103,7 @@ BUILT_SOURCES += obexd/src/builtin.h
 obexd/src/plugin.$(OBJEXT): obexd/src/builtin.h
 
 obexd/src/builtin.h: obexd/src/genbuiltin $(obexd_builtin_sources)
+	$(AM_V_at)$(MKDIR_P) $(dir $@)
 	$(AM_V_GEN)$(srcdir)/obexd/src/genbuiltin $(obexd_builtin_modules) > $@
 
 CLEANFILES += obexd/src/builtin.h $(builtin_files) obexd/src/obex.service
-- 
2.8.0.rc3

