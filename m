Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v4 03/20] shared: Add put_le32()
Date: Fri, 14 Mar 2014 10:13:03 -0300
Message-Id: <1394802800-8424-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to put uint32 values to the given pointer using
little-endian representation.
---
 src/shared/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index e0a61c6..cc2dbcd 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -95,3 +95,8 @@ static inline void put_le16(uint16_t val, void *dst)
 {
 	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
 }
+
+static inline void put_le32(uint32_t val, void *dst)
+{
+	put_unaligned(cpu_to_le32(val), (uint32_t *) dst);
+}
-- 
1.8.3.1

