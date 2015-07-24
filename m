Return-Path: <cyrus@holtmann.org>
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2318/2318] Staging : bluetooth Fix coding style issues
Date: Fri, 24 Jul 2015 23:38:04 +0530
Message-Id: <1437761284-12798-1-git-send-email-shraddha.6596@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a space after the '}' brackets

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/bluetooth/btbcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 1e1a432..cf7c81d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -32,8 +32,8 @@
 
 #define VERSION "0.1"
 
-#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
-#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
+#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00 } })
+#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43 } })
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
-- 
2.1.0
