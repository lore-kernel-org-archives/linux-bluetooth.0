Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] bluetooth: retry reset for devices that fail
Date: Thu, 15 Jul 2010 14:23:23 +0200
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007151423.23245.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

=46rom af61f0663f095599003290b13ad6fadee1d4fb25 Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver@neukum.org>
Date: Tue, 6 Jul 2010 08:08:42 +0200
Subject: [PATCH] bluetooth: retry reset for devices that fail

Some devices fail to reset properly at the first attempt to reset
them under unknown circumstances. Failures can be identified by
an invalid btaddr. Retry in those cases.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
=2D--
 net/bluetooth/hci_core.c |   48 ++++++++++++++++++++++++++----------------=
=2D--
 1 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f768de..c47f73d 100644
=2D-- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -180,11 +180,17 @@ static void hci_reset_req(struct hci_dev *hdev, unsig=
ned long opt)
 	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 }
=20
+static int verify_valid_bdaddr(struct hci_dev *hdev)
+{
+	return !bacmp(&hdev->bdaddr, BDADDR_ANY);
+}
+
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 {
 	struct sk_buff *skb;
 	__le16 param;
 	__u8 flt_type;
+	int retries =3D 4;
=20
 	BT_DBG("%s %ld", hdev->name, opt);
=20
@@ -202,33 +208,35 @@ static void hci_init_req(struct hci_dev *hdev, unsign=
ed long opt)
=20
 	/* Mandatory initialization */
=20
=2D	/* Reset */
=2D	if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks))
=2D			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
+	do {
+		/* Reset */
+		if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks))
+				hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
=20
=2D	/* Read Local Supported Features */
=2D	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+		/* Read Local Supported Features */
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
=20
=2D	/* Read Local Version */
=2D	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+		/* Read Local Version */
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
=20
=2D	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
=2D	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
+		/* Read Buffer Size (ACL mtu, max pkt, etc.) */
+		hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
=20
 #if 0
=2D	/* Host buffer size */
=2D	{
=2D		struct hci_cp_host_buffer_size cp;
=2D		cp.acl_mtu =3D cpu_to_le16(HCI_MAX_ACL_SIZE);
=2D		cp.sco_mtu =3D HCI_MAX_SCO_SIZE;
=2D		cp.acl_max_pkt =3D cpu_to_le16(0xffff);
=2D		cp.sco_max_pkt =3D cpu_to_le16(0xffff);
=2D		hci_send_cmd(hdev, HCI_OP_HOST_BUFFER_SIZE, sizeof(cp), &cp);
=2D	}
+		/* Host buffer size */
+		{
+			struct hci_cp_host_buffer_size cp;
+			cp.acl_mtu =3D cpu_to_le16(HCI_MAX_ACL_SIZE);
+			cp.sco_mtu =3D HCI_MAX_SCO_SIZE;
+			cp.acl_max_pkt =3D cpu_to_le16(0xffff);
+			cp.sco_max_pkt =3D cpu_to_le16(0xffff);
+			hci_send_cmd(hdev, HCI_OP_HOST_BUFFER_SIZE, sizeof(cp), &cp);
+		}
 #endif
=20
=2D	/* Read BD Address */
=2D	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+		/* Read BD Address */
+		hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+	} while(!verify_valid_bdaddr(hdev) && retries--);
=20
 	/* Read Class of Device */
 	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
=2D-=20
1.7.1
