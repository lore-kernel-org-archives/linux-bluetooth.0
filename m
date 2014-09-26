Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/hal: Add simple helpers for unaligned memory access
Date: Fri, 26 Sep 2014 15:42:16 +0200
Message-Id: <1411738938-29524-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
References: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In HALs we usually don't operate on unaligned memory. Only exception
are PCM stereo<->mono mixing scenarios in sco and audio HALs.
---
 android/hal-utils.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/hal-utils.h b/android/hal-utils.h
index a2ae0f4..ee0320c 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -15,6 +15,8 @@
  *
  */
 
+#include <endian.h>
+
 #include <hardware/bluetooth.h>
 
 #define PLATFORM_VER(a,b,c) ((a << 16) | ( b << 8) | (c))
@@ -132,3 +134,21 @@ DECINTMAP(bt_bond_state_t);
 DECINTMAP(bt_ssp_variant_t);
 DECINTMAP(bt_property_type_t);
 DECINTMAP(bt_cb_thread_evt);
+
+static inline uint16_t get_le16(const void *src)
+{
+	const struct __attribute__((packed)) {
+		uint16_t le16;
+	} *p = src;
+
+	return le16toh(p->le16);
+}
+
+static inline void put_le16(uint16_t val, void *dst)
+{
+	struct __attribute__((packed)) {
+		uint16_t le16;
+	} *p = dst;
+
+	p->le16 = htole16(val);
+}
-- 
1.9.1

