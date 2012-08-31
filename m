Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 01/15] lib: Add host order unaligned access functions
Date: Fri, 31 Aug 2012 10:36:11 +0200
Message-ID: <1346402185-9487-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change-Id: I3c647249a88b8ca05ef215096e6b9a5609e8eab9
---
 lib/bluetooth.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0fc4508..f0776aa 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -153,6 +153,21 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
+static inline uint64_t bt_get_64(const void *ptr)
+{
+	return bt_get_unaligned((const uint64_t *) ptr);
+}
+
+static inline uint32_t bt_get_32(const void *ptr)
+{
+	return bt_get_unaligned((const uint32_t *) ptr);
+}
+
+static inline uint16_t bt_get_16(const void *ptr)
+{
+	return bt_get_unaligned((const uint16_t *) ptr);
+}
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 static inline uint64_t bt_get_le64(const void *ptr)
 {
-- 
1.7.9.5

