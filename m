Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix setting noinst_LIBRARIES in Makefile.am
Date: Wed, 20 Jul 2011 18:47:49 -0300
Message-Id: <1311198469-28610-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When both audio and sap plugins are enabled, noinst_LIBRARIES is
incorrectly overwritten.
---
NOTE: Actually, I'm not sure if audio/libtelephony.a and sap/libsap.a are being
used at all. Any reason why they are generated? Makefile dependency resolution
perhaps?

 Makefile.am |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 52c49fb..1089406 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,6 +3,8 @@ AM_MAKEFLAGS = --no-print-directory
 
 lib_LTLIBRARIES =
 
+noinst_LIBRARIES =
+
 noinst_LTLIBRARIES =
 
 bin_PROGRAMS =
@@ -143,7 +145,7 @@ builtin_sources += audio/main.c \
 			audio/telephony.h audio/a2dp-codecs.h
 builtin_nodist += audio/telephony.c
 
-noinst_LIBRARIES = audio/libtelephony.a
+noinst_LIBRARIES += audio/libtelephony.a
 
 audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
 				audio/telephony-maemo5.c audio/telephony-ofono.c \
@@ -159,7 +161,7 @@ builtin_sources += sap/main.c \
 
 builtin_nodist += sap/sap.c
 
-noinst_LIBRARIES = sap/libsap.a
+noinst_LIBRARIES += sap/libsap.a
 
 sap_libsap_a_SOURCES = sap/sap.h sap/sap-dummy.c sap/sap-u8500.c
 endif
-- 
1.7.0.4

