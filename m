Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?=
	<jerome.debretagne@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?=
	<jerome.debretagne@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add BCM2E55 ACPI ID used in Lenovo ThinkPad Tablet 8
Date: Thu,  3 Mar 2016 01:46:28 +0100
Message-Id: <1456965988-7706-1-git-send-email-jerome.debretagne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lenovo ThinkPad Tablet 8 with BCM43241 rev B5 chipset uses the BCM2E55 ACPI ID for Bluetooth. Add it to the list of supported devices.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index bb4c5a0..d8881dc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -821,6 +821,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E3F", 0 },
 	{ "BCM2E40", 0 },
 	{ "BCM2E54", 0 },
+	{ "BCM2E55", 0 },
 	{ "BCM2E64", 0 },
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
-- 
2.7.0

