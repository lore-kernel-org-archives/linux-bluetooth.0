Return-Path: <cyrus@holtmann.org>
From: yegorslists@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 1/2] fix link creation for out-of-source builds
Date: Wed, 28 Dec 2011 10:53:36 +0100
Message-Id: <1325066017-2384-2-git-send-email-yegorslists@googlemail.com>
In-Reply-To: <1325066017-2384-1-git-send-email-yegorslists@googlemail.com>
References: <1325066017-2384-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Yegor Yefremov <yegorslists@googlemail.com>

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5cf287c..9f26b06 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -480,7 +480,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 sap/sap.c: sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
@@ -492,7 +492,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
 clean-local:
 	$(RM) -r lib/bluetooth
-- 
1.7.5.4
