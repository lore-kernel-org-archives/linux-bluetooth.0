Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
Date: Thu,  7 Sep 2017 22:25:51 +0200
Message-Id: <20170907202551.26796-2-hdegoede@redhat.com>
In-Reply-To: <20170907202551.26796-1-hdegoede@redhat.com>
References: <20170907202551.26796-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Tested on a GPD win with a BCM4356 PCI-E wifi/bt combo card.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6a662d0161b4..4739acb5b201 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -878,6 +878,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
-- 
2.13.4
