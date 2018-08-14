Return-Path: <ianwmorrison@gmail.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com
Cc: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] Use default .cfg file name for RTL8723BS devices with id of OBDA8723
Date: Tue, 14 Aug 2018 16:47:42 +1000
Message-Id: <20180814064742.14519-1-ianwmorrison@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

For RTL8723BS devices the current config file name is a composite of
both the config name (rtl8723bs) and a postfix of the device-id.

Given the majority of RTL8723BS devices use a device-id of OBDA8723
this simplifies the config file name to use "rtl8723bs_config.bin"
as a default of for these devices.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..cce422dc1b8d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	bool flow_control;
 	int err;
 
-	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
+	btrtl_dev = strcmp("OBDA8723", h5->id) ?
+		btrtl_initialize(h5->hu->hdev, h5->id) :
+			btrtl_initialize(h5->hu->hdev, NULL);
 	if (IS_ERR(btrtl_dev))
 		return PTR_ERR(btrtl_dev);
 
-- 
2.17.1
