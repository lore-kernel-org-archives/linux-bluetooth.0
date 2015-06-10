Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v2 4/5] Support the BCM4354 Bluetooth UART device
Date: Wed, 10 Jun 2015 16:05:19 -0400
Message-ID: <1433966720-17482-5-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The ability to run over the BCM4354 while we are awaiting
the Bluetooth UART firmware map file introduction.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 8e2f6b6..1849db2 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -243,6 +243,7 @@ static const struct {
 } bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x610c, "BCM4354_003.001.012.0306.0659"}, /* 003.001.012 */
 	{ }
 };
 
@@ -279,6 +280,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 1:
 	case 3:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
-- 
1.9.1
