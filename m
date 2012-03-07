Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] build: Fix libbluetooth dependency
Date: Wed,  7 Mar 2012 13:11:39 +0200
Message-Id: <1331118699-10591-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Building with libbluetooth prior to 4.99 cause an error:

btio/btio.c: In function 'get_key_size':
btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size

Thanks to Bastien Nocera for reporting it.
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 10c561b..f54cce7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -89,8 +89,8 @@ AC_CHECK_LIB(dbus-1, dbus_connection_can_send_type, dummy=yes,
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-PKG_CHECK_MODULES(BLUEZ, bluez, dummy=yes,
-				AC_MSG_ERROR(libbluetooth is required))
+PKG_CHECK_MODULES(BLUEZ, bluez >= 4.99, dummy=yes,
+				AC_MSG_ERROR(libbluetooth 4.99 or latter is required))
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 
-- 
1.7.7.6

