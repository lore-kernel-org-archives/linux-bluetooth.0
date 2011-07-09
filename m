Return-Path: <cyrus@holtmann.org>
From: Tom Rini <tom_rini@mentor.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Makefile.am: Mark local_headers as BUILT_SOURCES
Date: Sat,  9 Jul 2011 08:10:53 -0700
Message-Id: <1310224253-4557-1-git-send-email-tom_rini@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As these files are auto-generated they need to be marked as BUILT_SOURCES
so that we don't run into a build race later on.  lib/bluetooth is removed
by clean-local so this doesn't need to be in CLEAN_FILES

Signed-off-by: Tom Rini <tom_rini@mentor.com>
---
 Makefile.am |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index fab05eb..356b09f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -53,6 +53,8 @@ lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
 		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
 
+BUILT_SOURCES = $(local_headers)
+
 include_HEADERS += $(lib_headers)
 
 lib_LTLIBRARIES += lib/libbluetooth.la
@@ -62,9 +64,6 @@ lib_libbluetooth_la_SOURCES = $(lib_headers) \
 lib_libbluetooth_la_LDFLAGS = -version-info 14:3:11
 lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 
-CLEANFILES += $(local_headers)
-
-
 if SBC
 noinst_LTLIBRARIES += sbc/libsbc.la
 
-- 
1.7.1

