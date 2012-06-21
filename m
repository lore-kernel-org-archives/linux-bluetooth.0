Return-Path: <cyrus@holtmann.org>
Message-ID: <4FE2ED4E.5010503@message-id.googlemail.com>
Date: Thu, 21 Jun 2012 11:45:50 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] build: fix MISC_LDFLAGS typo to fix "--enable-pie"
Content-Type: multipart/mixed;
 boundary="------------070102090308020307000905"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070102090308020307000905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

draconic rules in the openSUSE buildservice found, that executables are
no longer linked with "-pie" and complained about it.

As it turned out, it's a simple typo in acinclude.m4, trivial patch is
attached.

Best regards,

	Stefan
-- 
Stefan Seyfried

"Dispatch war rocket Ajax to bring back his body!"

--------------070102090308020307000905
Content-Type: text/x-patch;
 name="0001-build-fix-MISC_LDFLAGS-typo-to-fix-enable-pie.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-build-fix-MISC_LDFLAGS-typo-to-fix-enable-pie.patch"

>From 74cabe5148e7618544ec25f1385aa48454a0ee60 Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife+obs@b1-systems.com>
Date: Thu, 21 Jun 2012 11:28:47 +0200
Subject: [PATCH] build: fix MISC_LDFLAGS typo to fix "--enable-pie"

---
 acinclude.m4 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 6505ad3..1d6d736 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -360,7 +360,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	fi
 
 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
-	AC_SUBST([MISC_LDLAGS], $misc_ldlags)
+	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
 
 	if (test "${usb_enable}" = "yes" && test "${usb_found}" = "yes"); then
 		AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
-- 
1.7.10.4


--------------070102090308020307000905--
