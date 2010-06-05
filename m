Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/3] Remove ifndef barrier from log.h and btio.h
Date: Sat,  5 Jun 2010 01:41:25 -0300
Message-Id: <1275712886-20127-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275712886-20127-1-git-send-email-gustavo@padovan.org>
References: <1275712886-20127-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/btio.h |    3 ---
 src/log.h  |    4 +---
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/src/btio.h b/src/btio.h
index 00d743e..fa6ff69 100644
--- a/src/btio.h
+++ b/src/btio.h
@@ -21,8 +21,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
-#ifndef BT_IO_H
-#define BT_IO_H
 
 #include <glib.h>
 
@@ -93,4 +91,3 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...);
 
-#endif
diff --git a/src/log.h b/src/log.h
index 9af51e7..33168c7 100644
--- a/src/log.h
+++ b/src/log.h
@@ -21,8 +21,7 @@
  *
  */
 
-#ifndef __LOGGING_H
-#define __LOGGING_H
+extern int debug_enabled;
 
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
@@ -57,4 +56,3 @@ struct btd_debug_desc {
                                         __FILE__, __FUNCTION__ , ## arg); \
 } while (0)
 
-#endif /* __LOGGING_H */
-- 
1.7.1

