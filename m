Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 10/62] shared: Add put_be64()
Date: Thu, 20 Mar 2014 11:42:35 -0300
Message-Id: <1395326607-27068-11-git-send-email-claudio.takahasi@openbossa.org>
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
index baeba91..883b278 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -155,3 +155,8 @@ static inline void put_le64(uint64_t val, const void *ptr)
 {
 	put_unaligned(cpu_to_le64(val), (uint64_t *) ptr);
 }
+
+static inline void put_be64(uint64_t val, const void *ptr)
+{
+	put_unaligned(cpu_to_be64(val), (uint64_t *) ptr);
+}
-- 
1.8.3.1

