Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v2 03/17] shared: Add put_le16()
Date: Thu, 13 Mar 2014 11:38:39 -0300
Message-Id: <1394721533-6932-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to put uint16 values to the given buffer using little-endian
representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index f614c99..399f678 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -93,6 +93,11 @@ void util_debug(util_debug_func_t function, void *user_data,
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 				util_debug_func_t function, void *user_data);
 
+static inline void put_le16(uint16_t val, void *dst)
+{
+	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
+}
+
 static inline void put_uuid(const bt_uuid_t *src, void *dst)
 {
 	if (src->type == BT_UUID16)
-- 
1.8.3.1

