Return-Path: <swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
Date: Tue, 26 Jun 2018 10:06:54 -0700
Message-Id: <20180626170654.96831-1-swboyd@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These three lines make up what msleep() already does, i.e. setting the
task to uninterruptible, sleeping for so many jiffies, and then
schedule() already puts the task state back to TASK_RUNNING when it
returns. Make things clearer by just calling msleep() instead.

Cc: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 51790dd02afb..ef2b00bdf06d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -908,9 +908,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	 * controller will come back after they receive this HCI command
 	 * then host can communicate with new baudrate to controller
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
-	set_current_state(TASK_RUNNING);
+	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
 
 	return 0;
 }
-- 
Sent by a computer through tubes
