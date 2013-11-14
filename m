Return-Path: <cyrus@holtmann.org>
From: Andre Heider <a.heider@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix out of tree builds
Date: Thu, 14 Nov 2013 18:58:55 +0100
Message-Id: <1384451935-4836-1-git-send-email-a.heider@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't create bogus symlinks when passing an absolute path to --prefix.
---
 Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 69a2805..87448ab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -318,9 +318,9 @@ tools/%.rules:
 
 $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
-lib/bluetooth/%.h: lib/%.h
+lib/bluetooth/%.h: $(abs_top_srcdir)/lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) -f $(abs_top_builddir)/$< $@
+	$(AM_V_GEN)$(LN_S) -f $< $@
 
 clean-local:
 	$(RM) -r lib/bluetooth
-- 
1.8.4.3

