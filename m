Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: btmrvl_drv: Clean up header code
Date: Fri, 11 Sep 2015 13:56:21 +0000
Message-ID: <20150911135614.GA2955@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Unnecessary space before function pointer arguments reported by
checkpatch.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/btmrvl_drv.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.=
h
index 086f0ec..27a9aac 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -95,10 +95,10 @@ struct btmrvl_private {
 	struct btmrvl_device btmrvl_dev;
 	struct btmrvl_adapter *adapter;
 	struct btmrvl_thread main_thread;
-	int (*hw_host_to_card) (struct btmrvl_private *priv,
+	int (*hw_host_to_card)(struct btmrvl_private *priv,
 				u8 *payload, u16 nb);
-	int (*hw_wakeup_firmware) (struct btmrvl_private *priv);
-	int (*hw_process_int_status) (struct btmrvl_private *priv);
+	int (*hw_wakeup_firmware)(struct btmrvl_private *priv);
+	int (*hw_process_int_status)(struct btmrvl_private *priv);
 	void (*firmware_dump)(struct btmrvl_private *priv);
 	spinlock_t driver_lock;		/* spinlock used by driver */
 #ifdef CONFIG_DEBUG_FS
--=20
1.7.0.4
