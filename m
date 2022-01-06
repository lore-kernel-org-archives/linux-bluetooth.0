Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA09C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 21:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbiAFVCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:02:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49249 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVCi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 16:02:38 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2AB0FCECDD;
        Thu,  6 Jan 2022 22:02:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211216210958.62129-1-hj.tedd.an@gmail.com>
Date:   Thu, 6 Jan 2022 22:02:36 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5BB42992-5F8E-4AAB-A5C7-66728154D8D1@holtmann.org>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch fixes the broken LED quirk for Intel legacy ROM devices.
> To fix the LED issue that doesn't turn off immediately, the host sends
> the SW RFKILL command while shutting down the interface and it puts the
> devices in an asserted state.
> 
> Once the device is in SW RFKILL state, it can only accept HCI_Reset to
> exit from the SW RFKILL state. This patch checks the quirk and sends the
> HCI_Reset before sending the HCI_Intel_Read_Version command.
> 
> The affected legacy ROM devices are
> - 8087:0a2a
> - 8087:0aa7
> 
> fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 13 ++++++-------
> drivers/bluetooth/btusb.c   | 10 ++++++++--
> 2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e1f96df847b8..75f8d7aceb35 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> 	 * As a workaround, send HCI Reset command first which will reset the
> 	 * number of completed commands and allow normal command processing
> 	 * from now on.
> +	 *
> +	 * For INTEL_BROKEN_LED, these devices have an issue with LED which
> +	 * doesn't go off immediately during shutdown. Set the flag here to send
> +	 * the LED OFF command during shutdown.
> 	 */
> -	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
> +	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
> +				btintel_test_flag(hdev, INTEL_BROKEN_LED)) {

make sure to indent this as this:

	if (btintel_test..(..) ||
	    btintel_test..(..)) {

And rename this into INTEL_BROKEN_SHUTDOWN_LED

> 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
> 				     HCI_INIT_TIMEOUT);
> 		if (IS_ERR(skb)) {
> @@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> 					&hdev->quirks);
> 
> -			/* These devices have an issue with LED which doesn't
> -			 * go off immediately during shutdown. Set the flag
> -			 * here to send the LED OFF command during shutdown.
> -			 */
> -			btintel_set_flag(hdev, INTEL_BROKEN_LED);
> -
> 			err = btintel_legacy_rom_setup(hdev, &ver);
> 			break;
> 		case 0x0b:      /* SfP */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d1bd9ee0a6ab..c6a070d5284f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_WIDEBAND_SPEECH	0x400000
> #define BTUSB_VALID_LE_STATES   0x800000
> #define BTUSB_QCA_WCN6855	0x1000000
> +#define BTUSB_INTEL_BROKEN_LED	0x2000000

Use BTUSB_INTEL_BROKEN_SHUTDOWN_LED here.

> #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
> 
> static const struct usb_device_id btusb_table[] = {
> @@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },

This one needs both. I know it is just going to work, but for simplicity set it both so that WP2 uses this quirk in shutdown as well. So when you remove the set_flag from setup, you fail to run ->shutdown on WP2.

I know the BROKEN_INITIAL_NCMD is now pointless, but lets keep it for documentation sake.

> -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_LED },
> 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
> -	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_LED },
> 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
> 
> 	/* Other Intel Bluetooth devices */
> @@ -3724,6 +3727,9 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
> 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
> +
> +		if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
> +			btintel_set_flag(hdev, INTEL_BROKEN_LED);
> 	}

Regards

Marcel

