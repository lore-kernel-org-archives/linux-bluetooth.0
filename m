Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: marcel <marcel@holtmann.org>, albert.o.ho@intel.com
Subject: [RFC 3/3] Bluetooth: Add timeout for Intel specific device initialization
Date: Mon, 10 Sep 2012 15:35:41 -0700
Message-ID: <2047428.SOUXqlU6Wn@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the tiemout for Intel specific device initialization.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb_intel.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb_intel.c b/drivers/bluetooth/btusb_intel.c
index d45ddb9..3657203 100644
--- a/drivers/bluetooth/btusb_intel.c
+++ b/drivers/bluetooth/btusb_intel.c
@@ -30,6 +30,9 @@
 
 #include "btusb.h"
 
+/* patch timeout - 10 seconds */
+#define INTEL_PATCH_TIMEOUT		msecs_to_jiffies(10000)
+
 /* Intel specific HCI cmd opcodes */
 #define INTEL_HCI_MFG_MODE		0xfc11
 #define INTEL_HCI_GET_VER		0xfc05
@@ -71,6 +74,7 @@ struct intel_patch_data {
 	u8			patch_reset;
 
 	struct completion	wait_patch_completion;
+	struct timer_list	patch_timeout;
 
 	char			device_ver[32];
 	const struct firmware	*fw;
@@ -222,6 +226,16 @@ static int intel_prepare_patch_file(struct intel_patch_data *data)
 	return 0;
 }
 
+static void intel_patch_timeout(unsigned long arg)
+{
+	struct intel_patch_data *data = (void *)arg;
+
+	BT_ERR("patch timer expired");
+	data->state = INTEL_PATCH_ERROR;
+
+	complete(&data->wait_patch_completion);
+}
+
 int btusb_intel_init(struct hci_dev *hdev)
 {
 	int ret;
@@ -243,6 +257,10 @@ int btusb_intel_init(struct hci_dev *hdev)
 
 	init_completion(&data->wait_patch_completion);
 
+	setup_timer(&data->patch_timeout, intel_patch_timeout,
+		    (unsigned long) data);
+	mod_timer(&data->patch_timeout, jiffies + INTEL_PATCH_TIMEOUT);
+
 	while (cont) {
 		BT_DBG("patch state: %d", data->state);
 		switch (data->state) {
@@ -324,6 +342,7 @@ skip_wait:
 	}
 
 exit_error:
+	del_timer_sync(&data->patch_timeout);
 	release_firmware(data->fw);
 	kfree(data);
 
-- 
1.7.9.5
