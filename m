Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] build: Fix build error if path contains spaces
Date: Thu, 28 Nov 2013 12:10:55 +0100
Message-Id: <1385637056-561-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

janccszy@box:~/bluez test$ make
  GEN      lib/bluetooth/bluetooth.h
ln: target ‘lib/bluetooth/bluetooth.h’ is not a directory
make: *** [lib/bluetooth/bluetooth.h] Error 1
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2bb2eb5..a3924aa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -328,7 +328,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) -f $(abs_top_builddir)/$< $@
+	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
 
 clean-local:
 	$(RM) -r lib/bluetooth
-- 
1.8.3.2

