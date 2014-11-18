Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2014 02:51:12 +0400
Message-ID: <CANoib0HW2umPpzzerYNq1fMMnkYxOa78o5X90-K=eNEnTGSO1w@mail.gmail.com>
Subject: [PATCH v2] ath3k: Add support of MCI 13d3:3408 bt device
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
It is AR3011 device according to iProduct == 0.
So btusb should be blacklisted
I submitted a wrong patch before asif  it was an AR3012 device,
but it works both ways. This is the right one.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
are */

---

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index d85ced2..3b53116 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] = {
  { USB_DEVICE(0x0CF3, 0x3002) },
  { USB_DEVICE(0x0CF3, 0xE019) },
  { USB_DEVICE(0x13d3, 0x3304) },
+ { USB_DEVICE(0x13d3, 0x3408) },

  /* Atheros AR9285 Malbec with sflash firmware */
  { USB_DEVICE(0x03F0, 0x311D) },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfc17b..bbf5c1c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[] = {
  { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
  { USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
  { USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
+ { USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_IGNORE },

  /* Atheros AR9285 Malbec with sflash firmware */
  { USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
