Return-Path: <cyrus@holtmann.org>
From: Karl Beldan <karl.beldan@gmail.com>
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	Karl Beldan <karl.beldan@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: hci_uart: Fix typo in stats for sco tx
Date: Thu,  7 Oct 2010 21:57:10 +0200
Message-Id: <1286481430-6761-1-git-send-email-karl.beldan@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

s/stat.cmd_tx++/stat.sco_tx++ for HCI_SCODATA_PKT

Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 998833d..74cb6f3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -101,7 +101,7 @@ static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 		break;
 
 	case HCI_SCODATA_PKT:
-		hdev->stat.cmd_tx++;
+		hdev->stat.sco_tx++;
 		break;
 	}
 }
-- 
1.7.1.422.g049e9
