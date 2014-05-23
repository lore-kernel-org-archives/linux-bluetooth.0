Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] gatttool: Allow to build without interactive mode
Date: Fri, 23 May 2014 12:50:08 +0200
Message-Id: <1400842209-4473-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for using gatttool on Android where readline is not
available.
---
 attrib/gatttool.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 8f0913c..f15fe01 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,8 +21,18 @@
  *
  */
 
+#ifdef GATTTOOL_NO_INTERACTIVE
+static inline int interactive(const char *src, const char *dst,
+						const char *dst_type, int psm)
+{
+	g_print("Interactive mode disabled\n");
+	return 0;
+}
+#else
 int interactive(const char *src, const char *dst, const char *dst_type,
 								int psm);
+#endif
+
 GIOChannel *gatt_connect(const char *src, const char *dst,
 			const char *dst_type, const char *sec_level,
 			int psm, int mtu, BtIOConnect connect_cb,
-- 
1.9.1

