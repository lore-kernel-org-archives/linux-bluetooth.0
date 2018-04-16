Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit Pundir <amit.pundir@linaro.org>
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: dragonboard@lists.96boards.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader
Date: Mon, 16 Apr 2018 12:10:24 +0530
Message-Id: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AOSP use userspace firmware loader to load firmwares, which will
return -EAGAIN in case qca/rampatch_00440302.bin is not found.
Since there is no rampatch for dragonboard820c QCA controller
revision, just make it work as is.

CC: Loic Poulain <loic.poulain@linaro.org>
CC: Nicolas Dechesne <nicolas.dechesne@linaro.org>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..330e9b29e145 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -935,6 +935,12 @@ static int qca_setup(struct hci_uart *hu)
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
+	} else if (ret == -EAGAIN) {
+		/*
+		 * Userspace firmware loader will return -EAGAIN in case no
+		 * patch/nvm-config is found, so run with original fw/config.
+		 */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */
-- 
2.7.4

