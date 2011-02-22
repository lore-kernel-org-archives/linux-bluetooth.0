Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5 v2] Remove redundante check for server when checking for usb
Date: Tue, 22 Feb 2011 16:53:29 +0200
Message-Id: <1298386409-19519-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is a check for this already on Makefile.am
---
 configure.ac |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a17d0ca..9194843 100644
--- a/configure.ac
+++ b/configure.ac
@@ -155,8 +155,7 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--enable-usb],
 				[enable usb plugin]), [
 	enable_usb=${enableval}
 ])
-AM_CONDITIONAL(USB, test "${enable_usb}" = "yes" &&
-				test "${enable_server}" != "no")
+AM_CONDITIONAL(USB, test "${enable_usb}" = "yes")
 
 AC_ARG_ENABLE(pcsuite, AC_HELP_STRING([--enable-pcsuite],
 				[enable Nokia PcSuite plugin]), [
-- 
1.7.1

