Return-Path: <prasannakarthik@outlook.com>
From: prasanna karthik <prasannakarthik@outlook.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Prasanna Karthik <pkarthik@outlook.com>
Subject: [PATCH] Bluetooth: btmrvl: cleanup code in return from
 btmrvl_sdio_suspend()
Date: Tue, 28 Mar 2017 19:44:00 +0000
Message-ID: <SG2PR0302MB257551E9937B577EF80ACA15CA320@SG2PR0302MB2575.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Else is not generally useful after a break or return

Signed-off-by: Prasanna Karthik <pkarthik@outlook.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdi=
o.c
index 08e01f0..9a5e2e8 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1637,10 +1637,10 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	if (priv->adapter->hs_state =3D=3D HS_ACTIVATED) {
 		BT_DBG("suspend with MMC_PM_KEEP_POWER");
 		return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
-	} else {
-		BT_DBG("suspend without MMC_PM_KEEP_POWER");
-		return 0;
 	}
+
+	BT_DBG("suspend without MMC_PM_KEEP_POWER");
+	return 0;
 }
=20
 static int btmrvl_sdio_resume(struct device *dev)
--=20
1.9.1
