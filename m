Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Remove --enable-mcap from configure command line options
Date: Sat, 18 Sep 2010 09:58:32 +0200
Message-Id: <1284796712-10934-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only plugins are in charge of switch on MCAP if they require
it to work.
---
 acinclude.m4 |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 1df93db..287f07d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -176,7 +176,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	network_enable=yes
 	service_enable=yes
 	health_enable=no
-	mcap_enable=no
 	pnat_enable=no
 	attrib_enable=no
 	tracer_enable=no
@@ -231,10 +230,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		health_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(mcap, AC_HELP_STRING([--enable-mcap], [enable mcap support]), [
-		mcap_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(pnat, AC_HELP_STRING([--enable-pnat], [enable pnat plugin]), [
 		pnat_enable=${enableval}
 	])
@@ -358,7 +353,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
-	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes" || test "${health_enable}" = "yes")
+	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(ATTRIBPLUGIN, test "${attrib_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
-- 
1.7.0.4

