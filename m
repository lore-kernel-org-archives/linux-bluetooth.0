Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 08/62] shared: Add put_be16()
Date: Thu, 20 Mar 2014 11:42:33 -0300
Message-Id: <1395326607-27068-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to avoid possible unaligned memory access when handling
uint16 value using big-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 9e4d0c0..0d0b45f 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -136,6 +136,11 @@ static inline void put_le16(uint16_t val, void *dst)
 	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
 }
 
+static inline void put_be16(uint16_t val, const void *ptr)
+{
+	put_unaligned(cpu_to_be16(val), (uint16_t *) ptr);
+}
+
 static inline void put_le32(uint32_t val, void *dst)
 {
 	put_unaligned(cpu_to_le32(val), (uint32_t *) dst);
-- 
1.8.3.1

