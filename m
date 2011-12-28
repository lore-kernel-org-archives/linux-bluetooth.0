Return-Path: <cyrus@holtmann.org>
From: yegorslists@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] fix lib header linking for out-of-source build
Date: Wed, 28 Dec 2011 09:49:15 +0100
Message-Id: <1325062155-1632-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Yegor Yefremov <yegorslists@googlemail.com>

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5cf287c..1389765 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -492,7 +492,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 clean-local:
 	$(RM) -r lib/bluetooth
-- 
1.7.5.4
