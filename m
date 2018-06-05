Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH] obexd: use AM_LDFLAGS for linking
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: linux-bluetooth@vger.kernel.org
References: <20171212182717.3429-1-stefan.seyfried@googlemail.com>
Message-ID: <61e22a32-7a04-854c-b4d3-259d49e82cf6@message-id.googlemail.com>
Date: Tue, 5 Jun 2018 09:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171212182717.3429-1-stefan.seyfried@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------ACC4451F55799CB2302AC01D"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------ACC4451F55799CB2302AC01D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Also attached, because Thunderbird is likely to screw this up... :-)

>From b912306ae756eaf75caa1ab7e04e3112fac4a01c Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife+dev@b1-systems.com>
Date: Mon, 11 Dec 2017 22:52:28 +0100
Subject: [PATCH] obexd: use AM_LDFLAGS for linking

without this, --enable-pie does not work for obexd
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc72..86c395305 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -83,7 +83,7 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl

-obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
+obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic

 obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 				@ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

--------------ACC4451F55799CB2302AC01D
Content-Type: text/x-patch;
 name="0001-obexd-use-AM_LDFLAGS-for-linking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-obexd-use-AM_LDFLAGS-for-linking.patch"

>From b912306ae756eaf75caa1ab7e04e3112fac4a01c Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife+dev@b1-systems.com>
Date: Mon, 11 Dec 2017 22:52:28 +0100
Subject: [PATCH] obexd: use AM_LDFLAGS for linking

without this, --enable-pie does not work for obexd
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc72..86c395305 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -83,7 +83,7 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
-obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
+obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
 
 obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 				@ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
-- 
2.15.1


--------------ACC4451F55799CB2302AC01D--
