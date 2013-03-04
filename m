Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] gatttool: fix parameter type/name from le to psm
Date: Mon,  4 Mar 2013 16:42:55 -0400
Message-Id: <1362429775-19101-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The parameter le was changed to psm and its type was modified from
boolean to int, but header was unmodified. That change occurred in commit
0cc24599637ed6666469c68d55f4e42ff722e447.
---
 attrib/gatttool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index a38339b..260480d 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -22,7 +22,7 @@
  */
 
 int interactive(const gchar *src, const gchar *dst, const gchar *dst_type,
-		gboolean le);
+								int psm);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 			const gchar *dst_type, const gchar *sec_level,
 			int psm, int mtu, BtIOConnect connect_cb);
-- 
1.8.1.4

