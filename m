Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 7/9] sap: move it to profiles folder
Date: Tue, 10 Jul 2012 10:43:06 -0300
Message-Id: <1341927788-30287-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
References: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                       |   19 ++++++++++---------
 {sap => profiles/sap}/main.c      |    0
 {sap => profiles/sap}/manager.c   |    0
 {sap => profiles/sap}/manager.h   |    0
 {sap => profiles/sap}/sap-dummy.c |    0
 {sap => profiles/sap}/sap-u8500.c |    0
 {sap => profiles/sap}/sap.h       |    0
 {sap => profiles/sap}/server.c    |    0
 {sap => profiles/sap}/server.h    |    0
 9 files changed, 10 insertions(+), 9 deletions(-)
 rename {sap => profiles/sap}/main.c (100%)
 rename {sap => profiles/sap}/manager.c (100%)
 rename {sap => profiles/sap}/manager.h (100%)
 rename {sap => profiles/sap}/sap-dummy.c (100%)
 rename {sap => profiles/sap}/sap-u8500.c (100%)
 rename {sap => profiles/sap}/sap.h (100%)
 rename {sap => profiles/sap}/server.c (100%)
 rename {sap => profiles/sap}/server.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 82b6ffd..b445160 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -165,16 +165,16 @@ endif
 
 if SAPPLUGIN
 builtin_modules += sap
-builtin_sources += sap/main.c \
-			sap/manager.h sap/manager.c \
-			sap/server.h sap/server.c \
-			sap/sap.h
+builtin_sources += profiles/sap/main.c profiles/sap/manager.h \
+			profiles/sap/manager.c profiles/sap/server.h \
+			profiles/sap/server.c profiles/sap/sap.h
 
-builtin_nodist += sap/sap.c
+builtin_nodist += profiles/sap/sap.c
 
-noinst_LIBRARIES += sap/libsap.a
+noinst_LIBRARIES += profiles/sap/libsap.a
 
-sap_libsap_a_SOURCES = sap/sap.h sap/sap-dummy.c sap/sap-u8500.c
+profiles_sap_libsap_a_SOURCES = profiles_sap/sap.h profiles/sap/sap-dummy.c \
+				profiles/sap/sap-u8500.c
 endif
 
 if INPUTPLUGIN
@@ -337,7 +337,8 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			profiles/input/input.conf proximity/proximity.conf \ \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
+			audio/telephony-maemo6.c profiles/sap/sap-dummy.c \
+			profiles/sap/sap-u8500.c
 
 if AUDIOPLUGIN
 if GSTREAMER
@@ -443,7 +444,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 
-sap/sap.c: sap/@SAP_DRIVER@
+profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
 scripts/%.rules:
diff --git a/sap/main.c b/profiles/sap/main.c
similarity index 100%
rename from sap/main.c
rename to profiles/sap/main.c
diff --git a/sap/manager.c b/profiles/sap/manager.c
similarity index 100%
rename from sap/manager.c
rename to profiles/sap/manager.c
diff --git a/sap/manager.h b/profiles/sap/manager.h
similarity index 100%
rename from sap/manager.h
rename to profiles/sap/manager.h
diff --git a/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
similarity index 100%
rename from sap/sap-dummy.c
rename to profiles/sap/sap-dummy.c
diff --git a/sap/sap-u8500.c b/profiles/sap/sap-u8500.c
similarity index 100%
rename from sap/sap-u8500.c
rename to profiles/sap/sap-u8500.c
diff --git a/sap/sap.h b/profiles/sap/sap.h
similarity index 100%
rename from sap/sap.h
rename to profiles/sap/sap.h
diff --git a/sap/server.c b/profiles/sap/server.c
similarity index 100%
rename from sap/server.c
rename to profiles/sap/server.c
diff --git a/sap/server.h b/profiles/sap/server.h
similarity index 100%
rename from sap/server.h
rename to profiles/sap/server.h
-- 
1.7.10.2

