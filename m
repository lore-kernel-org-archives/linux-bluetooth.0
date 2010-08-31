Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Solve compilation problem when SBC variable is not active
Date: Tue, 31 Aug 2010 16:50:11 +0200
Message-Id: <1283266211-15798-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <AANLkTinHLGYkji4Eoxu_QReDQCHndB7r319jB-2butVT@mail.gmail.com>
References: <AANLkTinHLGYkji4Eoxu_QReDQCHndB7r319jB-2butVT@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The inclusion of src/attrib-server.c file by default in the daemon
source needs also to compile by default attrib_sources, not only
when SBC is active.
---
 Makefile.am |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 47478c2..5684e99 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -79,9 +79,6 @@ sbc_sbcdec_LDADD = sbc/libsbc.la
 sbc_sbcenc_SOURCES = sbc/sbcenc.c sbc/formats.h
 sbc_sbcenc_LDADD = sbc/libsbc.la
 
-attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
-		attrib/gattrib.h attrib/gattrib.c
-
 if SNDFILE
 noinst_PROGRAMS += sbc/sbctester
 
@@ -90,6 +87,8 @@ sbc_sbctest_CFLAGS = @SNDFILE_CFLAGS@
 endif
 endif
 
+attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
+		attrib/gattrib.h attrib/gattrib.c
 
 if NETLINK
 plugin_LTLIBRARIES += plugins/netlink.la
-- 
1.7.0.4

