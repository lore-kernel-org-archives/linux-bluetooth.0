Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v1 2/4] build: Require GLib 2.32 or later
Date: Wed, 22 Aug 2012 22:05:52 +0530
Message-id: <1345653354-23720-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we use GLib version less than 2.32 (more precisely < 2.31.2) then
the following build error may occure in a 32 bit.

cc1: warnings being treated as errors
gobex/gobex-apparam.c: In function ‘g_obex_apparam_set_bytes’:
gobex/gobex-apparam.c:176:38: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_uint8’:
gobex/gobex-apparam.c:243:43: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_uint16’:
gobex/gobex-apparam.c:261:43: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_uint32’:
gobex/gobex-apparam.c:282:43: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_uint64’:
gobex/gobex-apparam.c:303:43: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_string’:
gobex/gobex-apparam.c:324:43: error: cast to pointer from integer of
different size
gobex/gobex-apparam.c: In function ‘g_obex_apparam_get_bytes’:
gobex/gobex-apparam.c:342:43: error: cast to pointer from integer of
different size
make[1]: *** [gobex/gobex-apparam.o] Error 1
make: *** [all] Error 2
---

Reference:
GLib tree: Commit: 16292dd753cb63f8ccb2267644aefbd2632dd52c
Author: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date:   Thu Oct 6 11:18:03 2011 -0300
	Fix G*_TO_POINTER casts on 32 bits

	If we don't do the cast to the proper size in 32 bits, things like below
	doesn't work:

	uint8_t u = 20;

	void *p;

	p = GUINT_TO_POINTER(u);

	Signed-off-by: Colin Walters <walters@verbum.org>


Thanks Luiz for giving this reference.

Btb I'm not very sure, is this the best way to solve this problem.

 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c8e61ac..78da420 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,8 +69,8 @@ fi
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.28 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 
-- 
1.7.4.1

