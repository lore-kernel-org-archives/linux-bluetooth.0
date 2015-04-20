Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Apr 2015 18:51:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>, Daniel Drake <drake@endlessm.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: btusb: off by one in rtl8723b_parse_firmware()
Message-ID: <20150420155135.GB10518@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

The ">" should be ">=" so that we don't read past the end of the array.

Fixes: 9d9a113e3695 ('Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 920f6fb..d21f3b4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1502,7 +1502,7 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 		return -EINVAL;
 	}
 
-	if (project_id > ARRAY_SIZE(project_id_to_lmp_subver)) {
+	if (project_id >= ARRAY_SIZE(project_id_to_lmp_subver)) {
 		BT_ERR("%s: unknown project id %d", hdev->name, project_id);
 		return -EINVAL;
 	}
