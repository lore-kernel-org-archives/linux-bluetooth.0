Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove leftover of attrib plugin build
Date: Mon,  2 May 2011 19:23:20 -0300
Message-Id: <1304375000-25686-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9703bf0..afc26f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,7 +385,7 @@ pkgconfigdir = $(libdir)/pkgconfig
 
 pkgconfig_DATA = bluez.pc
 
-DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --enable-attrib
+DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
 
 DISTCLEANFILES = $(pkgconfig_DATA)
 
-- 
1.7.5.rc3

