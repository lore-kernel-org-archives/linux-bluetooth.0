Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] Bluetooth: hci_ldisc: Provide a 'default' switch case
Date: Wed, 25 Apr 2018 19:36:29 -0300
Message-Id: <1524695789-22139-1-git-send-email-festevam@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

When both CONFIG_BT_HCIUART_INTEL and CONFIG_BT_HCIUART_BCM are not
selected, sparse complains like this:

drivers/bluetooth/hci_ldisc.c:437:9: warning: switch with no cases

Fix the sparse warning by proving a default switch case.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/bluetooth/hci_ldisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b6a7170..954213e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -447,6 +447,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		btbcm_check_bdaddr(hdev);
 		break;
 #endif
+	default:
+		break;
 	}
 
 done:
-- 
2.7.4
