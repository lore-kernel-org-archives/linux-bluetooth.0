Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jul 2009 09:57:10 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] fix UDEV_DATADIR fallback if pkg-config fails
Message-ID: <20090707095710.4ab1e03c@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 acinclude.m4 |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 48728e8..2018169 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -111,9 +111,11 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 	AC_SUBST(CONFIGDIR, "${configdir}")
 	AC_SUBST(STORAGEDIR, "${storagedir}")
 
-	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`/rules.d"
+	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`"
 	if (test -z "${UDEV_DATADIR}"); then
 		UDEV_DATADIR="${sysconfdir}/udev/rules.d"
+	else
+		UDEV_DATADIR="${UDEV_DATADIR}/rules.d"
 	fi
 	AC_SUBST(UDEV_DATADIR)
 ])
-- 
1.6.3.2
