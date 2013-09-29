Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Replace BDADDR_LOCAL with BDADDR_NONE
Date: Sun, 29 Sep 2013 01:01:51 -0700
Message-Id: <1380441711-55190-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BDADDR_LOCAL is a relict from userspace and has never been used
within the kernel. So remove that constant and replace it with a new
BDADDR_NONE that is similar to HCI_DEV_NONE with all bits set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index afbc711..5fd5106 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -197,8 +197,8 @@ static inline bool bdaddr_type_is_le(__u8 type)
 	return false;
 }
 
-#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0} })
-#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff} })
+#define BDADDR_ANY  (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
+#define BDADDR_NONE (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
 
 /* Copy, swap, convert BD Address */
 static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
-- 
1.8.3.1

