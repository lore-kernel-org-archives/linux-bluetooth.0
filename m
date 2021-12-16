Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ED3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 07:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhLPHwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 02:52:18 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59569 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231932AbhLPHwR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 02:52:17 -0500
Received: from [192.168.0.3] (ip5f5aecd0.dynamic.kabel-deutschland.de [95.90.236.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1AF5D61E64846;
        Thu, 16 Dec 2021 08:52:15 +0100 (CET)
Message-ID: <904d134a-a672-72a9-dddb-1c48d151e62e@molgen.mpg.de>
Date:   Thu, 16 Dec 2021 08:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy
 ROM device
Content-Language: en-US
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-bluetooth@vger.kernel.org
References: <20211216033453.9806-1-hj.tedd.an@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211216033453.9806-1-hj.tedd.an@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Tedd,


Am 16.12.21 um 04:34 schrieb Tedd Ho-Jeong An:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch fix the broken LED quirk for Intel legacy ROM devices.

fix*es*

Excuse my ignorance, but what are Intel legacy ROM devices? Maybe also 
mention the IDs 0x0a2a and 0x0aa7 in the commit message?

> Legacy device sends the SW RFKILL while shutting down the device (like
> HCI interface down) to turn off the LED by putting the device in assert.
> 
> Once the SW RFKILL is on, it needs the HCI_Reset to exit from the SW
> RFKILL state. This patch checks the quirk and send the HCI_Reset before

send*s*

> sending the HCI_Intel_Read_Version command.

Is that document in some datasheet/specification? If so, please mention it.

Also, in the commit message summary you write “Fix”. If it fixes an old 
commit, please add a Fixes: tag.

> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 13 ++++++-------
>   drivers/bluetooth/btusb.c   | 10 ++++++++--
>   2 files changed, 14 insertions(+), 9 deletions(-)

I have a Dell Latitude E7250 with the 8087:0a2a. How can I test this?

> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 8f9109b40961..0a5aa637bf6f 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   	 * As a workaround, send HCI Reset command first which will reset the
>   	 * number of completed commands and allow normal command processing
>   	 * from now on.
> +	 *
> +	 * For INTEL_BROKEN_LED, these devices have an issue with LED which
> +	 * doesn't go off immediately during shutdown. Set the flag
> +	 * here to send the LED OFF command during shutdown.

Please reflow all lines for the allowed line length limit (doesn’t fits 
on the line above).

>   	 */
> -	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
> +	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
> +				btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
>   		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
>   				     HCI_INIT_TIMEOUT);
>   		if (IS_ERR(skb)) {
> @@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>   					&hdev->quirks);
>   
> -			/* These devices have an issue with LED which doesn't
> -			 * go off immediately during shutdown. Set the flag
> -			 * here to send the LED OFF command during shutdown.
> -			 */
> -			btintel_set_flag(hdev, INTEL_BROKEN_LED);
> -
>   			err = btintel_legacy_rom_setup(hdev, &ver);
>   			break;
>   		case 0x0b:      /* SfP */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d1bd9ee0a6ab..c6a070d5284f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
>   #define BTUSB_WIDEBAND_SPEECH	0x400000
>   #define BTUSB_VALID_LE_STATES   0x800000
>   #define BTUSB_QCA_WCN6855	0x1000000
> +#define BTUSB_INTEL_BROKEN_LED	0x2000000
>   #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>   
>   static const struct usb_device_id btusb_table[] = {
> @@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
>   	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>   	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
>   						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
> -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_LED },
>   	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
> -	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_LED },
>   	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
>   
>   	/* Other Intel Bluetooth devices */
> @@ -3724,6 +3727,9 @@ static int btusb_probe(struct usb_interface *intf,
>   
>   		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
>   			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
> +
> +		if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
> +			btintel_set_flag(hdev, INTEL_BROKEN_LED);
>   	}
>   
>   	if (id->driver_info & BTUSB_MARVELL)
