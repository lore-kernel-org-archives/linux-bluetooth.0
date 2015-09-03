Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	trivial@kernel.org
Subject: [PATCH] Bluetooth: btintel: fix warning
Date: Thu,  3 Sep 2015 23:08:45 +0200
Message-Id: <1441314525-12080-1-git-send-email-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Fix compilation the following compilation warning, which happens when
CONFIG_BT_INTEL is not set:

  drivers/bluetooth/btintel.h:98:13: warning: ‘btintel_version_info’
  defined but not used [-Wunused-function]
   static void btintel_version_info(struct hci_dev *hdev,
                                    struct intel_version *ver)
               ^

Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: trivial@kernel.org
---


Hi,

This warning can be seen with e.g. ARM imx_v6_v7_defconfig.

Best regards,

V. 


 drivers/bluetooth/btintel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b278d14..a49c8db 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -95,7 +95,8 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
-static void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+static inline void btintel_version_info(struct hci_dev *hdev,
+					struct intel_version *ver)
 {
 }
 
-- 
2.5.0
