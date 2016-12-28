Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: fix spelling mistake: "caibration" -> "calibration"
Date: Wed, 28 Dec 2016 21:30:30 +0000
Message-Id: <20161228213030.6981-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in BT_ERR error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btmrvl_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e6a85f0..c38cb5b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -502,7 +502,7 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_LOAD_CONFIG_DATA, data,
 				   BT_CAL_HDR_LEN + len);
 	if (ret)
-		BT_ERR("Failed to download caibration data");
+		BT_ERR("Failed to download calibration data");
 
 	return 0;
 }
-- 
2.10.2
