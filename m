Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 02/13] Add Bluetooth address type definition
Date: Thu, 28 Apr 2011 19:36:58 -0300
Message-Id: <1304030229-6672-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Values defined to LE(public and random) are defined in the Bluetooth
Core Specification. For basic rate, there isn't address type concept.
The constants introduced by this commit will be used to identify the
remote address type, basically to distinguish LE/BR devices before
to request the L2CAP connection.
---
 lib/bluetooth.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 738e07a..98b8f1c 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -130,6 +130,10 @@ typedef struct {
 #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
 
+#define BDADDR_TYPE_LE_PUBLIC	0x00
+#define BRADDR_TYPE_LE_RANDOM	0x01
+#define BDADDR_TYPE_BR		0xff
+
 /* Copy, swap, convert BD Address */
 static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 {
-- 
1.7.5.rc3

