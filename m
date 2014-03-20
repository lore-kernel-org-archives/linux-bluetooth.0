Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 06/62] shared: Add get_be32()
Date: Thu, 20 Mar 2014 11:42:31 -0300
Message-Id: <1395326607-27068-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to avoid possible unaligned memory access when handling
uint32 value using big-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index e315f84..251ea2a 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -116,6 +116,11 @@ static inline uint32_t get_le32(const void *ptr)
 	return le32_to_cpu(get_unaligned((const uint32_t *) ptr));
 }
 
+static inline uint32_t get_be32(const void *ptr)
+{
+	return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
+}
+
 static inline uint64_t get_le64(const void *ptr)
 {
 	return le64_to_cpu(get_unaligned((const uint64_t *) ptr));
-- 
1.8.3.1

