Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Jan 2016 09:36:55 +0100
Message-ID: <CAA+NYvQ7bh1Sq4dG3Xp17g5oq_cgxtDpb7-PqJ1mLyDYWg9a9w@mail.gmail.com>
Subject: [PATCH] Another ACPI ID for bcm43241
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I found another ID for the bcm43241 in my HP Omni10's dsdt. With
attached patch the driver works nicely.

Kind, regards,

J.J.

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5f3de18..11ac590 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -820,6 +820,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
        { "BCM2E3D", 0 },
        { "BCM2E3F", 0 },
        { "BCM2E40", 0 },
+       { "BCM2E54", 0 },
        { "BCM2E64", 0 },
        { "BCM2E65", 0 },
        { "BCM2E67", 0 },
