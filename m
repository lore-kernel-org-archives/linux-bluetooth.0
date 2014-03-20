Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 07/62] shared: Add get_be64()
Date: Thu, 20 Mar 2014 11:42:32 -0300
Message-Id: <1395326607-27068-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to avoid possible unaligned memory access when handling
uint64 value using big-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 251ea2a..9e4d0c0 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -126,6 +126,11 @@ static inline uint64_t get_le64(const void *ptr)
 	return le64_to_cpu(get_unaligned((const uint64_t *) ptr));
 }
 
+static inline uint64_t get_be64(const void *ptr)
+{
+	return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
+}
+
 static inline void put_le16(uint16_t val, void *dst)
 {
 	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
-- 
1.8.3.1

