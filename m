Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 03/62] shared: Add get_le32()
Date: Thu, 20 Mar 2014 11:42:28 -0300
Message-Id: <1395326607-27068-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to avoid possible unaligned memory access when handling
uint32 value using little-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index ef845ae..8caee61 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -106,6 +106,11 @@ static inline uint16_t get_le16(const void *ptr)
 	return le16_to_cpu(get_unaligned((const uint16_t *) ptr));
 }
 
+static inline uint32_t get_le32(const void *ptr)
+{
+	return le32_to_cpu(get_unaligned((const uint32_t *) ptr));
+}
+
 static inline void put_le16(uint16_t val, void *dst)
 {
 	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
-- 
1.8.3.1

