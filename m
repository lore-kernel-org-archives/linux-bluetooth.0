Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 05/62] shared: Add get_be16()
Date: Thu, 20 Mar 2014 11:42:30 -0300
Message-Id: <1395326607-27068-6-git-send-email-claudio.takahasi@openbossa.org>
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
index 29f6f6b..e315f84 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -106,6 +106,11 @@ static inline uint16_t get_le16(const void *ptr)
 	return le16_to_cpu(get_unaligned((const uint16_t *) ptr));
 }
 
+static inline uint16_t get_be16(const void *ptr)
+{
+	return be16_to_cpu(get_unaligned((const uint16_t *) ptr));
+}
+
 static inline uint32_t get_le32(const void *ptr)
 {
 	return le32_to_cpu(get_unaligned((const uint32_t *) ptr));
-- 
1.8.3.1

