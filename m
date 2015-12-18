Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luka Karinja <luka.karinja@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
To: linux-bluetooth@vger.kernel.org
Message-ID: <567404F4.5080807@gmail.com>
Date: Fri, 18 Dec 2015 14:07:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add BCM2E65 device in acpi_device_id table. Used on Asus T100TAF.

Signed-off-by: Luka Karinja <luka.karinja@gmail.com>
---
  drivers/bluetooth/hci_bcm.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 835bfab..372f7bc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -546,6 +546,7 @@ static const struct hci_uart_proto bcm_proto = {
  #ifdef CONFIG_ACPI
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
+	{ "BCM2E65", 0 },
  	{ "BCM2E67", 0 },
  	{ },
  };
-- 
1.9.1

