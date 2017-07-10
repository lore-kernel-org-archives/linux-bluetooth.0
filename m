Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Olivier Blin <olivier.blin@softathome.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Lo=C3=AFc=20Yhuel?= <loic.yhuel@softathome.com>,
        Olivier Blin <olivier.blin@softathome.com>
Subject: [PATCH BlueZ] Fix out-of-tree build with absolute source path
Date: Mon, 10 Jul 2017 13:59:57 +0200
Message-Id: <20170710115957.15708-1-olivier.blin@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running out-of-tree build using /abs/path/to/bluez/configure, the
generated Makefile uses /abs/path/to/bluez as VPATH.
Using ../configure, VPATH is set to ..

The first case generates incorrect symlinks in the lib/bluetooth
directory inside the build dir, because the rule prepended
abs_top_builddir to the absolute target path.

For example, with sources in "/home/dev/bluez" and a build in
"/home/dev/bluez build", it generates the following incorrect symlink:
    'bluez build/lib/bluetooth/bluetooth.h'
    -> '/home/dev/bluez build//home/dev/bluez/lib/bluetooth.h'

To handle both absolute and relative source dir, use abspath on the
make prerequisite.

Also-by: Loïc Yhuel <loic.yhuel@softathome.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 84e67a42c..237b05d78 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -494,7 +494,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
+	$(AM_V_GEN)$(LN_S) -f "$(abspath $<)" $@
 
 if COVERAGE
 clean-coverage:
-- 
2.13.2

