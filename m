Return-Path: <igiann@hotmail.com>
From: Joan Jani <igiann@hotmail.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "gustavo@padovan.org" <gustavo@padovan.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Joan Jani <igiann@hotmail.com>
Subject: [PATCH] Driver: Bluetooth:btqca.c Fixed a coding style error
Date: Thu, 6 Jul 2017 20:35:32 +0000
Message-ID: <AM5PR10MB1569A2B1E03F1F41A4EC69D7C9D50@AM5PR10MB1569.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed this coding style erro

./drivers/bluetooth/btqca.c:84: ERROR: code indent should use tabs where po=
ssible

Signed-off-by: Joan Jani <igiann@hotmail.com>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 28afd5d..0bbdfce 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -81,7 +81,7 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *=
rome_version)
 	 * and lower 2 bytes from patch will be used.
 	 */
 	*rome_version =3D (le32_to_cpu(ver->soc_id) << 16) |
-		        (le16_to_cpu(ver->rome_ver) & 0x0000ffff);
+			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
=20
 out:
 	kfree_skb(skb);
--=20
2.7.4
