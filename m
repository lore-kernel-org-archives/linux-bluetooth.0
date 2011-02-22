Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Fix --enable-usb build
Date: Tue, 22 Feb 2011 11:43:42 +0200
Message-Id: <1298367822-27766-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 602c948..fc63b8c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,7 +156,7 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--enable-usb],
 	enable_usb=${enableval}
 ])
 AM_CONDITIONAL(USB, test "${enable_usb}" = "yes" &&
-				test "${enable_server}" != "no")
+				test "${enable_usb}" != "no")
 
 AC_ARG_ENABLE(pcsuite, AC_HELP_STRING([--enable-pcsuite],
 				[enable Nokia PcSuite plugin]), [
-- 
1.7.1

