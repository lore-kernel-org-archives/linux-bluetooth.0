Return-Path: <cyrus@holtmann.org>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linville@tuxdriver.com,
	linux-bluetooth@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] bluetooth: properly use pr_fmt() on lib.c
Date: Mon, 23 Apr 2012 19:45:06 -0700
Message-Id: <1335235506-32243-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

pr_fmt() is either defined or we redefine it. Typically
drivers define it prior to including printk.h but this
is done under the assumption that no other subsystem
it uses has already defined pr_fmt(). In such cases
pr_fmt() should be undefined and redefined.

Doing this properly shaves down compilation time quite
considerably.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 net/bluetooth/lib.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 5066288..84ff96f 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -24,11 +24,13 @@
 
 /* Bluetooth kernel library. */
 
+#undef pr_fmt
 #define pr_fmt(fmt) "Bluetooth: " fmt
 
 #include <linux/module.h>
 
 #include <linux/kernel.h>
+#include <linux/printk.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <asm/errno.h>
-- 
1.7.10.rc1.22.gf5241
