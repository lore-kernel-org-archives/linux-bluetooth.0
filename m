Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Fix make distcheck for input plugin
Date: Mon, 12 Nov 2012 17:03:41 -0400
Message-Id: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

suspend.c is a symlink generated at build time, therefore it should be
created on build directory. Additionally, it is necessary to add
-I$(srcdir)/profiles/input to CPPFLAGS so suspend.h can be found (the
compiler does not follow symlinks prior to resolving #include
directives).
---
 Makefile.am |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d49e8a0..c398e74 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,6 +366,10 @@ if MCAP
 AM_CPPFLAGS += -I$(builddir)/health
 endif
 
+if HOGPLUGIN
+AM_CPPFLAGS += -I$(srcdir)/profiles/input
+endif
+
 unit_objects =
 
 if TEST
@@ -405,7 +409,7 @@ profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
 profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 scripts/%.rules:
 	$(AM_V_GEN)cp $(subst 97-,,$@) $@
-- 
1.7.9.5

