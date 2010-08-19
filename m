Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] btio: Remove libbluetooth dependence for obexd
Date: Thu, 19 Aug 2010 22:21:16 +0800
Message-Id: <1282227676-15381-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove libbluetooth dependence for obex server daemon. obex-test and
obex-client still require libbluetooth because of sdp related
dependence.
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f77fa27..05755a8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -75,7 +75,7 @@ src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) $(btio_sources) \
 
 src_obexd_LDADD = @DBUS_LIBS@ @GLIB_LIBS@ @GTHREAD_LIBS@ \
 					@EBOOK_LIBS@ @OPENOBEX_LIBS@ \
-					@BLUEZ_LIBS@ @LIBICAL_LIBS@ -ldl
+					@LIBICAL_LIBS@ -ldl
 
 src_obexd_LDFLAGS = -Wl,--export-dynamic
 
-- 
1.7.0.4

