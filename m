Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 9/9] btmgmt: move it to tools
Date: Tue, 10 Jul 2012 11:03:08 -0300
Message-Id: <1341928988-5116-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
References: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 .gitignore                    |    2 +-
 Makefile.tools                |    6 +++---
 mgmt/main.c => tools/btmgmt.c |    0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename mgmt/main.c => tools/btmgmt.c (100%)

diff --git a/.gitignore b/.gitignore
index c7d079e..9a2241f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,7 +86,7 @@ compat/dund
 compat/hidd
 compat/pand
 unit/test-eir
-mgmt/btmgmt
+tools/btmgmt
 monitor/btmon
 emulator/btvirt
 
diff --git a/Makefile.tools b/Makefile.tools
index 70d333b..fccac2d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -50,10 +50,10 @@ tools_ppporc_LDADD = lib/libbluetooth-private.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth-private.la
 
-noinst_PROGRAMS += mgmt/btmgmt monitor/btmon emulator/btvirt
+noinst_PROGRAMS += tools/btmgmt monitor/btmon emulator/btvirt
 
-mgmt_btmgmt_SOURCES = mgmt/main.c src/glib-helper.c
-mgmt_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_btmgmt_SOURCES = tools/btmgmt.c src/glib-helper.c
+tools_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
 monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/mainloop.h monitor/mainloop.c \
diff --git a/mgmt/main.c b/tools/btmgmt.c
similarity index 100%
rename from mgmt/main.c
rename to tools/btmgmt.c
-- 
1.7.10.2

