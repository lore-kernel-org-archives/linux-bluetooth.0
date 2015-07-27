Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btbcm: Fix coding style
Date: Mon, 27 Jul 2015 16:00:38 +0200
Message-Id: <1438005639-3838-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

space required after that close brace '}'
reported by checkpatch.pl

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 9ceb8ac..9d699dd 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -32,8 +32,8 @@
 
 #define VERSION "0.1"
 
-#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
-#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
+#define BDADDR_BCM20702A0 (&(bdaddr_t){ {0x00, 0xa0, 0x02, 0x70, 0x20, 0x00} })
+#define BDADDR_BCM4324B3 (&(bdaddr_t){ {0x00, 0x00, 0x00, 0xb3, 0x24, 0x43} })
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
-- 
1.9.1

