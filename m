Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: h5: Do not initialize Configuration field
Date: Thu, 10 Dec 2015 17:03:43 +0200
Message-Id: <1449759823-12800-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Initializing Configuration field in H5 Config message to 0x01 gives
wrong impression that the value is used and needed. Later on the whole
field is rewritten with h5_cfg_field().

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 2d1c9f6..0879d64 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -123,7 +123,7 @@ static u8 h5_cfg_field(struct h5 *h5)
 static void h5_timed_event(unsigned long arg)
 {
 	const unsigned char sync_req[] = { 0x01, 0x7e };
-	unsigned char conf_req[] = { 0x03, 0xfc, 0x01 };
+	unsigned char conf_req[3] = { 0x03, 0xfc };
 	struct hci_uart *hu = (struct hci_uart *)arg;
 	struct h5 *h5 = hu->priv;
 	struct sk_buff *skb;
@@ -281,7 +281,7 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 	struct h5 *h5 = hu->priv;
 	const unsigned char sync_req[] = { 0x01, 0x7e };
 	const unsigned char sync_rsp[] = { 0x02, 0x7d };
-	unsigned char conf_req[] = { 0x03, 0xfc, 0x01 };
+	unsigned char conf_req[3] = { 0x03, 0xfc };
 	const unsigned char conf_rsp[] = { 0x04, 0x7b };
 	const unsigned char wakeup_req[] = { 0x05, 0xfa };
 	const unsigned char woken_req[] = { 0x06, 0xf9 };
-- 
2.5.0

