Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v1 1/4] build: BlueZ version 4.100 or later is required
Date: Wed, 22 Aug 2012 22:05:51 +0530
Message-id: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we use the BlueZ version less than 4.100, then the following
compilation error happens.

Error:
======
btio/btio.c: In function ‘l2cap_connect’:
btio/btio.c:301:6: error: ‘struct sockaddr_l2’ has no member named
 ‘l2_bdaddr_type’
btio/btio.c: In function ‘parse_set_opts’:
btio/btio.c:707:19: error: ‘BDADDR_BREDR’ undeclared (first use in
 this function)
btio/btio.c:707:19: note: each undeclared identifier is reported only
 once for each function it appears in
make[1]: *** [btio/btio.o] Error 1
make: *** [all] Error 2
---

 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 69d71b2..c8e61ac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,8 +79,8 @@ PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.4, dummy=yes,
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-PKG_CHECK_MODULES(BLUEZ, bluez >= 4.99, dummy=yes,
-				AC_MSG_ERROR(BlueZ >= 4.99 is required))
+PKG_CHECK_MODULES(BLUEZ, bluez >= 4.100, dummy=yes,
+				AC_MSG_ERROR(BlueZ >= 4.100 is required))
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 
-- 
1.7.4.1

