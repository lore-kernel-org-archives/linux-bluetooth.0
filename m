Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Fix out-of-tree builds
Date: Fri, 28 Sep 2012 15:43:31 -0400
Message-Id: <1348861411-31555-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit makes a few changes that mostly affect "out-of-tree" builds:

* Fix symlink creation for profiles/sap/sap.c (should use build
  directory, not source tree).
* Remove useless -I$(builddir)/{tools,health} directives (these
  build directories do not contain any headers).
* Add -I$(srcdir)/profiles/sap (necessary because sap.c is a symlink
  into the build directory, and refers to headers in the source tree).

Tested with:

./bootstrap
mkdir build
cd build
../configure [...]
---
 Makefile.am |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c27eb01..257c18a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,10 +405,10 @@ AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
 			-I$(srcdir)/attrib -I$(srcdir)/btio -I$(srcdir)/tools \
-			-I$(builddir)/tools -I$(srcdir)/monitor
+			-I$(srcdir)/monitor
 
-if MCAP
-INCLUDES += -I$(builddir)/health
+if SAPPLUGIN
+INCLUDES += -I$(srcdir)/profiles/sap
 endif
 
 unit_objects =
@@ -447,7 +447,7 @@ audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
-- 
1.7.9.5

