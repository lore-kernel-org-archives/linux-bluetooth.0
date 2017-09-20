Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/4] build: Always define confdir and statedir
Date: Wed, 20 Sep 2017 13:48:16 +0200
Message-Id: <20170920114819.19929-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we will need those paths to lock down on them.
---
 Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 555f301ca..1c38d94e5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -30,14 +30,14 @@ include_HEADERS =
 AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS)
 AM_LDFLAGS = $(MISC_LDFLAGS)
 
+confdir = $(sysconfdir)/bluetooth
+statedir = $(localstatedir)/lib/bluetooth
+
 if DATAFILES
 dbusdir = @DBUS_CONFDIR@/dbus-1/system.d
 dbus_DATA = src/bluetooth.conf
 
-confdir = $(sysconfdir)/bluetooth
 conf_DATA =
-
-statedir = $(localstatedir)/lib/bluetooth
 state_DATA =
 endif
 
-- 
2.14.1

