Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: hci_qca: Avoid setup failure on missing rampatch
Date: Mon,  6 Nov 2017 12:16:56 +0100
Message-Id: <1509967016-24224-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bbd7db7..05ec530 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -932,6 +932,9 @@ static int qca_setup(struct hci_uart *hu)
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret == -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */
-- 
2.7.4
