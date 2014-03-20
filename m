Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 01/62] shared: Add put_le64()
Date: Thu, 20 Mar 2014 11:42:26 -0300
Message-Id: <1395326607-27068-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to avoid possible unaligned memory access when handling
uint64 value using little-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index f9170bb..a129272 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -110,3 +110,8 @@ static inline void put_le32(uint32_t val, void *dst)
 {
 	put_unaligned(cpu_to_le32(val), (uint32_t *) dst);
 }
+
+static inline void put_le64(uint64_t val, const void *ptr)
+{
+	put_unaligned(cpu_to_le64(val), (uint64_t *) ptr);
+}
-- 
1.8.3.1

