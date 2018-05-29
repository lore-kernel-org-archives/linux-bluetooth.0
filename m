Return-Path: <thierry.escande@linaro.org>
From: Thierry Escande <thierry.escande@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning
Date: Tue, 29 May 2018 18:37:16 +0200
Message-Id: <20180529163716.3886-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following warning during boot:

 do not call blocking ops when !TASK_RUNNING; state=1 set at
 [<(ptrval)>] qca_setup+0x194/0x750 [hci_uart]
 WARNING: CPU: 2 PID: 1878 at kernel/sched/core.c:6135
 __might_sleep+0x7c/0x88

In qca_set_baudrate(), the current task state is set to
TASK_UNINTERRUPTIBLE before going to sleep for 300ms. It was then
restored to TASK_INTERRUPTIBLE. This patch sets the current task state
back to TASK_RUNNING instead.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f05382b5a65d..51790dd02afb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -910,7 +910,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	 */
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_RUNNING);
 
 	return 0;
 }
-- 
2.14.1
