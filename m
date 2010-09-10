Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] btio: Add ifndef/endif guard for btio.h
Date: Fri, 10 Sep 2010 10:49:44 +0800
Message-Id: <1284086984-17072-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284086984-17072-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284086984-17072-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid circular inclusion of include file.
---
 btio/btio.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/btio/btio.h b/btio/btio.h
index 81fda8e..d373ed1 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -21,6 +21,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+#ifndef BT_IO_H
+#define BT_IO_H
 
 #include <glib.h>
 
@@ -92,3 +94,4 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 				GDestroyNotify destroy, GError **err,
 				BtIOOption opt1, ...);
 
+#endif
-- 
1.7.0.4

