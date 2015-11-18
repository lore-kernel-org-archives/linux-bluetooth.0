Return-Path: <mkarthi3@visteon.com>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] net: bluetooth: Clean up hci_core code
Date: Wed, 18 Nov 2015 12:38:41 +0000
Message-ID: <20151118123816.GA3288@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix errors reported by checkpatch.
- ERROR: spaces required around that ':' (ctx:VxW)
- ERROR: open brace '{' following function declarations go on the next line

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 net/bluetooth/hci_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 83a6aac..11bdbe0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -73,7 +73,7 @@ static ssize_t dut_mode_read(struct file *file, char __us=
er *user_buf,
 	struct hci_dev *hdev =3D file->private_data;
 	char buf[3];
=20
-	buf[0] =3D hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y': 'N';
+	buf[0] =3D hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
 	buf[1] =3D '\n';
 	buf[2] =3D '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -133,7 +133,7 @@ static ssize_t vendor_diag_read(struct file *file, char=
 __user *user_buf,
 	struct hci_dev *hdev =3D file->private_data;
 	char buf[3];
=20
-	buf[0] =3D hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y': 'N';
+	buf[0] =3D hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
 	buf[1] =3D '\n';
 	buf[2] =3D '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -2726,7 +2726,8 @@ struct adv_info *hci_find_adv_instance(struct hci_dev=
 *hdev, u8 instance)
 }
=20
 /* This function requires the caller holds hdev->lock */
-struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance) =
{
+struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance)
+{
 	struct adv_info *cur_instance;
=20
 	cur_instance =3D hci_find_adv_instance(hdev, instance);
--=20
1.9.1
