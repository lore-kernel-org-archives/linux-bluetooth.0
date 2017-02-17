Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: fix spelling mistake: "Spurrious" -> "Spurious"
Date: Fri, 17 Feb 2017 19:58:10 +0000
Message-Id: <20170217195810.19365-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05c2307..f242dfd 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -335,7 +335,7 @@ static void hci_ibs_tx_idle_timeout(unsigned long arg)
 		/* Fall through */
 
 	default:
-		BT_ERR("Spurrious timeout tx state %d", qca->tx_ibs_state);
+		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
 		break;
 	}
 
@@ -373,7 +373,7 @@ static void hci_ibs_wake_retrans_timeout(unsigned long arg)
 		/* Fall through */
 
 	default:
-		BT_ERR("Spurrious timeout tx state %d", qca->tx_ibs_state);
+		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
 		break;
 	}
 
-- 
2.10.2
