Return-Path: <lukas@wunner.de>
Message-Id: <25d6a54bbc801489187e17a14ea2d6da1874e156.1515348092.git.lukas@wunner.de>
In-Reply-To: <cover.1515348092.git.lukas@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 7 Jan 2018 20:16:32 +0100
Subject: [PATCH v3 13/13] Bluetooth: btbcm: Fix sleep mode struct ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org, Sue White <sue.white@lairdtech.com>, Ilya Faenson <ifaenson@broadcom.com>
List-ID: <linux-bluetooth.vger.kernel.org>

According to the documentation for Laird SD40 radio modules (which use
the BCM4329 chipset), the order of the Enable_BREAK_To_Host and
Pulsed_HOST_WAKE parameters in the sleep mode struct is reversed
vis-à-vis our struct declaration.  See page 46 of this PDF:

http://cdn.lairdtech.com/home/brandworld/files/Application%20Note%20-%2040%20Series%20Bluetooth.pdf

The documentation is dated Oct 2015, so fairly recent, making it appear
more likely that the documentation is correct and our code is wrong.
Amend our code to be in congruence with the documentation.

Cc: Sue White <sue.white@lairdtech.com>
Cc: Ilya Faenson <ifaenson@broadcom.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/btbcm.h   | 2 +-
 drivers/bluetooth/hci_bcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d9e6b41658e5..cfe6ad4cc621 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -44,8 +44,8 @@ struct bcm_set_sleep_mode {
 	__u8 tristate_control;
 	__u8 usb_auto_sleep;
 	__u8 usb_resume_timeout;
-	__u8 pulsed_host_wake;
 	__u8 break_to_host;
+	__u8 pulsed_host_wake;
 } __packed;
 
 struct bcm_set_pcm_int_params {
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 81e82ce2da96..7793a9847fdb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -300,8 +300,8 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
 	/* Irrelevant USB flags */
 	.usb_auto_sleep = 0,
 	.usb_resume_timeout = 0,
+	.break_to_host = 0,
 	.pulsed_host_wake = 0,
-	.break_to_host = 0
 };
 
 static int bcm_setup_sleep(struct hci_uart *hu)
-- 
2.15.1
