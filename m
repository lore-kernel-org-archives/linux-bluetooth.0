Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth:btusb:fix incorrect type in initializer
Date: Tue, 3 Mar 2015 14:01:38 +0000
Message-ID: <E72C4779-837E-45DC-8256-AAA4F01DE182@qca.qualcomm.com>
References: <5355d8dbb7584d488f6d059306d3a1ad@nalasexr02e.na.qualcomm.com>
In-Reply-To: <5355d8dbb7584d488f6d059306d3a1ad@nalasexr02e.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the following sparse warning:

drivers/bluetooth/btusb.c:2677:11: warning: incorrect type in initializer (=
different base types)
drivers/bluetooth/btusb.c:2677:11:    expected restricted __le32 [usertype]=
 rom_version
drivers/bluetooth/btusb.c:2677:11:    got int
drivers/bluetooth/btusb.c:2678:11: warning: incorrect type in initializer (=
different base types)
drivers/bluetooth/btusb.c:2678:11:    expected restricted __le32 [usertype]=
 rom_version
drivers/bluetooth/btusb.c:2678:11:    got int
drivers/bluetooth/btusb.c:2679:11: warning: incorrect type in initializer (=
different base types)
drivers/bluetooth/btusb.c:2679:11:    expected restricted __le32 [usertype]=
 rom_version
drivers/bluetooth/btusb.c:2679:11:    got int
drivers/bluetooth/btusb.c:2680:11: warning: incorrect type in initializer (=
different base types)
drivers/bluetooth/btusb.c:2680:11:    expected restricted __le32 [usertype]=
 rom_version
drivers/bluetooth/btusb.c:2680:11:    got int
drivers/bluetooth/btusb.c:2681:11: warning: incorrect type in initializer (=
different base types)
drivers/bluetooth/btusb.c:2681:11:    expected restricted __le32 [usertype]=
 rom_version
drivers/bluetooth/btusb.c:2681:11:    got int
drivers/bluetooth/btusb.c:2805:17: warning: restricted __le16 degrades to i=
nteger
drivers/bluetooth/btusb.c:2805:37: warning: restricted __le32 degrades to i=
nteger
drivers/bluetooth/btusb.c:2806:17: warning: restricted __le16 degrades to i=
nteger
drivers/bluetooth/btusb.c:2806:39: warning: restricted __le32 degrades to i=
nteger

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0833054..f65cd44 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2674,11 +2674,11 @@ struct qca_device_info {
 };
=20
 static const struct qca_device_info qca_devices_table[] =3D {
-	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
-	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
-	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
-	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
-	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
+	{ cpu_to_le32(0x00000100), 20, 4, 10 }, /* Rome 1.0 */
+	{ cpu_to_le32(0x00000101), 20, 4, 10 }, /* Rome 1.1 */
+	{ cpu_to_le32(0x00000201), 28, 4, 18 }, /* Rome 2.1 */
+	{ cpu_to_le32(0x00000300), 28, 4, 18 }, /* Rome 3.0 */
+	{ cpu_to_le32(0x00000302), 28, 4, 18 }, /* Rome 3.2 */
 };
=20
 static int btusb_qca_send_vendor_req(struct hci_dev *hdev, u8 request,
@@ -2802,8 +2802,8 @@ static int btusb_setup_qca_load_rampatch(struct hci_d=
ev *hdev,
 		le16_to_cpu(rver->patch_version), le32_to_cpu(ver->rom_version),
 		le32_to_cpu(ver->patch_version));
=20
-	if (rver->rom_version !=3D ver->rom_version ||
-	    rver->patch_version <=3D ver->patch_version) {
+	if (le16_to_cpu(rver->rom_version) !=3D le32_to_cpu(ver->rom_version) ||
+	    le16_to_cpu(rver->patch_version) < le32_to_cpu(ver->patch_version)) {
 		BT_ERR("%s: rampatch file version did not match with firmware",
 		       hdev->name);
 		err =3D -EINVAL;
--=20
1.8.1.5
