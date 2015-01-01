Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2 2/4] Bluetooth: btmrvl: error path handling in setup  handler
Date: Thu, 1 Jan 2015 00:13:40 -0800
Message-ID: <1420100022-4134-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

If module init command fails, FW might not be in good state.
We will return from setup handler and skip downloading further
commands.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e3f5711..c435b58 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -538,8 +538,11 @@ static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 static int btmrvl_setup(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+	int ret;
 
-	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+	ret = btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.gpio_gap = 0xffff;
 
-- 
1.8.1.4
