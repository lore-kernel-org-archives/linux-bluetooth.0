Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A24C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 17:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356295AbiASRDU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:03:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43105 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356287AbiASRDQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 12:03:16 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id E98EECECDE;
        Wed, 19 Jan 2022 18:03:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH RFC] Bluetooth: btintel: Fix WBS setting for Intel legacy
 ROM products
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220119045119.132191-1-hj.tedd.an@gmail.com>
Date:   Wed, 19 Jan 2022 18:03:14 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <02C27829-DC10-47CF-B5C8-C1CC823ED5CD@holtmann.org>
References: <20220119045119.132191-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> Intel Legacy ROM Products don't support WBS except the SdP(8087:0aa7).
> But StP2(8087:0a2a) and SdP have the same version information, and
> btintel cannot distinguish between StP2 and SdP for WBS support.
> 
> This patch sets the WBS support flag for SdP based on USB idProduct and
> uses it in btintel to configure the WBS.
> 
> This flag is only applicable for Legacy ROM products.
> 
> Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 10 +++++++---
> drivers/bluetooth/btintel.h |  1 +
> drivers/bluetooth/btusb.c   | 12 ++++++++++++
> 3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 1a4f8b227eac..6730c9b2ae33 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2428,10 +2428,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> 
> 			/* Apply the device specific HCI quirks
> 			 *
> -			 * WBS for SdP - SdP and Stp have a same hw_varaint but
> -			 * different fw_variant
> +			 * WBS for SdP - The version information is the same for
> +			 * both StP2 and SdP, so it cannot be used to
> +			 * distinguish between StP2 and SdP. Instead, it uses
> +			 * the flag set by the transport driver(btusb) for
> +			 * the Legacy ROM SKU and sets the quirk for WBS.
> 			 */
> -			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
> +			if (btintel_test_flag(hdev,
> +					      INTEL_ROM_LEGACY_WBS_SUPPORTED))
> 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> 					&hdev->quirks);
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index c9b24e9299e2..efdb3d738abf 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -152,6 +152,7 @@ enum {
> 	INTEL_BROKEN_INITIAL_NCMD,
> 	INTEL_BROKEN_SHUTDOWN_LED,
> 	INTEL_ROM_LEGACY,
> +	INTEL_ROM_LEGACY_WBS_SUPPORTED,
> 
> 	__INTEL_NUM_FLAGS,
> };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c30d131da784..286e2fa1ef44 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3742,6 +3742,18 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 		if (id->driver_info & BTUSB_INTEL_BROKEN_SHUTDOWN_LED)
> 			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
> +
> +		/* Intel's Legacy ROM products don't support WBS except
> +		 * the SdP(8087:0aa7). But the StP2(8087:0a2a) and SdP have the
> +		 * same version information, and btintel can't distinguish
> +		 * between StP2 and SdP for the WBS support.
> +		 * It sets the flag here based on the USB PID to enable the WBS
> +		 * support for legacy ROM products.
> +		 * Note that this flag is only applicable to legacy ROM
> +		 * products.
> +		 */
> +		if (id->idProduct == 0x0aa7)
> +			btintel_set_flag(hdev, INTEL_ROM_LEGACY_WBS_SUPPORTED);
> 	}
> 
> 	if (id->driver_info & BTUSB_MARVELL)

while this is a total mess from a hardware point of view, I prefer our quirking is kinda the same.

One way would be to give the idProduct to btintel.c and remove all quirks from btusb.c. Something like this:

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c9b24e9299e2..4adb21cf5c20 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -158,6 +158,7 @@ enum {
 
 struct btintel_data {
        DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
+       u8 usb_pid;
 };
 
 #define btintel_set_flag(hdev, nr)                                     \
@@ -186,6 +187,12 @@ struct btintel_data {
 #define btintel_wait_on_flag_timeout(hdev, nr, m, to)                  \
                wait_on_bit_timeout(btintel_get_flag(hdev), (nr), m, to)
 
+#define btintel_set_usb_pid(hdev, pid)                                 \
+       do {                                                            \
+               struct btintel_data *intel = hci_get_priv((hdev));      \
+               intel->usb_pid = (pid);                                 \
+       } while (0)
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..9b5348052421 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3737,6 +3737,8 @@ static int btusb_probe(struct usb_interface *intf,
                hdev->send = btusb_send_frame_intel;
                hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
+               btintel_set_usb_pid(hdev, id->idProduct);
+
                if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
                        btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);

Then we need to add a duplicated USB PID table to btintel.c, but everything would be there and all Intel quirks for faulty ROM loader or version information could go to btintel.c.

Or you create a BTUSB_INTEL_NO_WBS_SUPPORT and add it to 0xa2a and 0x07dc like this:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..a898df89585a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855      0x1000000
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED        0x2000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
+#define BTUSB_INTEL_NO_WBS_SUPPORT     0x8000000
 
 static const struct usb_device_id btusb_table[] = {
        /* Generic Bluetooth USB device */
@@ -385,9 +386,11 @@ static const struct usb_device_id blacklist_table[] = {
        { USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
        { USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
        { USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
+                                                    BTUSB_INTEL_NO_WBS_SUPPORT |
                                                     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
                                                     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
        { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+                                                    BTUSB_INTEL_NO_WBS_SUPPORT |
                                                     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
        { USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
        { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
@@ -3737,6 +3740,9 @@ static int btusb_probe(struct usb_interface *intf,
                hdev->send = btusb_send_frame_intel;
                hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
+               if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
+                       btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS);
+
                if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
                        btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 
Frankly, I have no idea what I would favor right now. I do swing a little bit towards the extra btusb.c quirk to keep the btintel.c transport agnostic.

Regards

Marcel

