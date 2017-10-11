Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Loic Poulain <loic.poulain@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_bcm: fix build error without CONFIG_PM
Date: Wed, 11 Oct 2017 15:46:21 +0200
Message-Id: <20171011134640.3152236-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

This was introduced by the rework adding PM support:

drivers/bluetooth/hci_bcm.c: In function 'bcm_device_exists':
drivers/bluetooth/hci_bcm.c:156:22: error: 'struct bcm_device' has no member named 'hu'
  if (device && device->hu && device->hu->serdev)
                      ^~

The pointer is not available otherwise, so I'm enclosing
all references in an #ifdef here.

Fixes: 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the serdev driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ab1455e63b92..089bd0473451 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -152,9 +152,11 @@ static bool bcm_device_exists(struct bcm_device *device)
 {
 	struct list_head *p;
 
+#ifdef CONFIG_PM
 	/* Devices using serdev always exist */
 	if (device && device->hu && device->hu->serdev)
 		return true;
+#endif
 
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
@@ -965,7 +967,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	bcmdev->dev = &serdev->dev;
+#ifdef CONFIG_PM
 	bcmdev->hu = &bcmdev->serdev_hu;
+#endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
-- 
2.9.0
