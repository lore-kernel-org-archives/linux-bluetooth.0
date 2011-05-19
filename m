Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix TRACKER_LIBS value in configure.ac
Date: Thu, 19 May 2011 12:10:07 +0300
Message-Id: <1305796207-13094-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes problem with building obexd introduced by commit
6134dcbbb5acfa1b567aebb798597e9f96cf47ce (Add support for tracker-0.10)
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6ca54ed..611c80b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -151,7 +151,7 @@ fi
 if (test "${phonebook_driver}" = "tracker"); then
 	PKG_CHECK_MODULES(TRACKER_09, tracker-sparql-0.9, [
 			TRACKER_CFLAGS=${TRACKER_09_CFLAGS}
-			TRACKER_LIBS=${TRACKER_09_CFLAGS}
+			TRACKER_LIBS=${TRACKER_09_LIBS}
 		], [
 			PKG_CHECK_MODULES(TRACKER_10, tracker-sparql-0.10, [
 					TRACKER_CFLAGS=${TRACKER_10_CFLAGS}
-- 
1.7.0.4

