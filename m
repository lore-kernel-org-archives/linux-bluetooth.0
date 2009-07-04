Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Jul 2009 09:50:03 +0200
From: Stefan Seyfried <seife@suse.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix build with "--as-needed"
Message-ID: <20090704095003.24945e77@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch got submitted by an openSUSE contributor, I'm passing it
along so that I have one less patch to carry in my package ;)

>From bbb75fa766fe4d03098884f608b5d5d49757b1d1 Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife@suse.de>
Date: Fri, 3 Jul 2009 23:48:22 +0200
Subject: [PATCH] Fix build with "--as-needed"

---
 test/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 48b528a..e54e88e 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -32,7 +32,7 @@ lmptest_LDADD = @BLUEZ_LIBS@
 
 agent_LDADD = @DBUS_LIBS@
 
-btiotest_LDADD = @GLIB_LIBS@ @BLUEZ_LIBS@ $(top_builddir)/common/libhelper.a
+btiotest_LDADD = $(top_builddir)/common/libhelper.a @GLIB_LIBS@ @BLUEZ_LIBS@
 
 noinst_MANS = bdaddr.8
 
-- 
1.6.3.2
