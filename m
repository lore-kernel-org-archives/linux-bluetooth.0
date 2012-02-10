Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 01/22] lib: Add functions to deal with unaligned access without conversion
Date: Fri, 10 Feb 2012 18:39:46 -0300
Message-Id: <1328910007-25604-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In various places we need to do access unaligned memory, but we don't
want to do any type of conversions, i.e. the values are already in the
host order.
---
 lib/bluetooth.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1dee6df..e9ced19 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -126,6 +126,46 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
+static inline uint64_t bt_get_h64(void *ptr)
+{
+	return bt_get_unaligned((uint64_t *) ptr);
+}
+
+static inline uint32_t bt_get_h32(void *ptr)
+{
+	return bt_get_unaligned((uint32_t *) ptr);
+}
+
+static inline uint8_t bt_get_h16(void *ptr)
+{
+	return bt_get_unaligned((uint16_t *) ptr);
+}
+
+static inline uint8_t bt_get_h8(void *ptr)
+{
+	return bt_get_unaligned((uint8_t *) ptr);
+}
+
+static inline void bt_put_h64(uint64_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint64_t *) ptr);
+}
+
+static inline void bt_put_h32(uint32_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint32_t *) ptr);
+}
+
+static inline void bt_put_h16(uint16_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint16_t *) ptr);
+}
+
+static inline void bt_put_h8(uint8_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint8_t *) ptr);
+}
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 static inline uint64_t bt_get_le64(void *ptr)
 {
-- 
1.7.8.1

