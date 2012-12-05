Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 3/7] build-sys: Add missing force arg to symlink creation
Date: Wed,  5 Dec 2012 09:22:51 -0200
Message-Id: <1354706575-4718-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

If we don't force the symlink creation the build fails when the link
already exists. This happens if the rule to create the link is triggered
again because the file it points to changed. This is the case when doing
incremental builds and we modified the file.

$ make
$ touch lib/cmtp.h
$ make
  GEN      lib/bluetooth/cmtp.h
ln: failed to create symbolic link ‘lib/bluetooth/cmtp.h’: File exists
make: *** [lib/bluetooth/cmtp.h] Error 1
make: *** Waiting for unfinished jobs....
---
 Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6def418..a2cdb62 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -427,10 +427,10 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
 profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) -f $(abs_top_srcdir)/$< $@
 
 profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
+	$(AM_V_GEN)$(LN_S) -f $(abs_top_builddir)/$< $@
 
 scripts/%.rules:
 	$(AM_V_GEN)cp $(subst 97-,,$@) $@
@@ -439,7 +439,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
+	$(AM_V_GEN)$(LN_S) -f $(abs_top_builddir)/$< $@
 
 clean-local:
 	$(RM) -r lib/bluetooth
-- 
1.8.0.1

