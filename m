Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Check for UDEV before setting rulesdir/rules_DATA
Date: Wed, 19 Dec 2012 08:56:44 -0400
Message-Id: <1355921804-12533-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this check, UDEV_DIR will be empty and an empty "/rules.d"
directory is created on DESTDIR.
---
 Makefile.am |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index a482b54..c10c1fa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -174,6 +174,7 @@ test_scripts =
 include Makefile.tools
 include Makefile.obexd
 
+if UDEV
 rulesdir = @UDEV_DIR@/rules.d
 
 udev_files =
@@ -187,6 +188,7 @@ EXTRA_DIST += tools/hid2hci.rules
 rules_DATA = $(foreach file,$(udev_files), tools/97-$(notdir $(file)))
 
 CLEANFILES += $(rules_DATA)
+endif
 
 if TEST
 testdir = $(pkglibdir)/test
-- 
1.7.9.5

