Return-Path: <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sre@kernel.org, Marcel Holtmann <marcel@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Subject: PATCH: Nokia HCI driver minor issues
Message-ID: <c9907efa-aff0-fa9e-7cdf-868e02203d95@mnementh.co.uk>
Date: Fri, 7 Jul 2017 23:03:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

I've collected a couple of patches together over the last week, they
might be of use.

I'm not entirely certain the 2nd one is the *correct* fix, as I could
only test my (very similar) driver I've based off this one, but it WFM.

--Ian


-------------------------------------------------------------------
>From 3e5182a84717acd5eadd645294a008bcf27201a0 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Tue, 4 Jul 2017 15:01:46 +0100
Subject: [PATCH 1/3] Bluetooth: Nokia HCIUART driver should depend on H4

	The Nokia H4+ driver causes a build error if BT_HCIUART_H4
is not configured. Make it depend on this symbol.


Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 737d93ef27c5..adcd093b7bb3 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -96,6 +96,7 @@ config BT_HCIUART_NOKIA
 	tristate "UART Nokia H4+ protocol support"
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
+	depends on BT_HCIUART_H4
 	depends on PM
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
-- 
2.11.0

>From d3f45ffce99e85e73a7777c6cc39e61ee6971094 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Fri, 7 Jul 2017 22:55:18 +0100
Subject: [PATCH 2/3] bluetooth: Nokia: prevent crash on module removal.

	Unsure if this is correct, but the same code in my brcm serdev
	driver crashes if not done in this sequence.
---
 drivers/bluetooth/hci_nokia.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index a7d687d8d456..728dab3c03f6 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -770,10 +770,12 @@ static void nokia_bluetooth_serdev_remove(struct
serdev_device *serdev)
 	struct hci_uart *hu = &btdev->hu;
 	struct hci_dev *hdev = hu->hdev;

-	cancel_work_sync(&hu->write_work);

 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
+
+	cancel_work_sync(&hu->write_work);
+
 	hu->proto->close(hu);

 	pm_runtime_disable(&btdev->serdev->dev);
-- 
2.11.0

>From 806ac777fae2e800e79a2e04e84e3fb998b61ff3 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Fri, 7 Jul 2017 22:57:49 +0100
Subject: [PATCH 3/3] bluetooth: Nokia: remove duplicate call to
 pm_runtime_disable()

	pm_runtime_disable() is called in the _close() handler.

Since we call the _close() handler on remove, there is no need to
call pm_runtime_disable() a second time.


Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_nokia.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 728dab3c03f6..3aac150eac97 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -777,8 +777,6 @@ static void nokia_bluetooth_serdev_remove(struct
serdev_device *serdev)
 	cancel_work_sync(&hu->write_work);

 	hu->proto->close(hu);
-
-	pm_runtime_disable(&btdev->serdev->dev);
 }

 static int nokia_bluetooth_runtime_suspend(struct device *dev)
-- 
2.11.0
