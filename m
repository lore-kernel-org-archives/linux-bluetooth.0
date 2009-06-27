Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] add CONFIGDIR and STORAGEDIR as AC_SUBST
Date: Sat, 27 Jun 2009 17:01:37 +0200
Message-Id: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 acinclude.m4 |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index eb7cdeb..e8626ff 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -107,6 +107,9 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 				[Directory for the configuration files])
 	AC_DEFINE_UNQUOTED(STORAGEDIR, "${storagedir}",
 				[Directory for the storage files])
+
+	AC_SUBST(CONFIGDIR, "${configdir}")
+	AC_SUBST(STORAGEDIR, "${storagedir}")
 ])
 
 AC_DEFUN([AC_PATH_DBUS], [
-- 
1.6.3.1

