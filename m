Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC421C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiCDJw0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCDJw0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 04:52:26 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D3ED5C378
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 01:51:38 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id BCE48CEC82;
        Fri,  4 Mar 2022 10:51:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 3/3] Bluetooth: btusb: Add BTUSB_BROKEN_ENHANCED_SETUP_SCO
 flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220303221709.387865-3-luiz.dentz@gmail.com>
Date:   Fri, 4 Mar 2022 10:51:36 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <90948153-427A-4AB9-A8EF-AC750028578E@holtmann.org>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
 <20220303221709.387865-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds BTUSB_BROKEN_ENHANCED_SETUP_SCO flag which can be used to set
> HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO disabling the use of
> HCI_OP_ENHANCED_SETUP_SYNC_CONN command.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 34d008380fdb..d09a6a712632 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -63,6 +63,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
> #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
> #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
> +#define BTUSB_BROKEN_ENHANCED_SETUP_SCO	BIT(27)
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -3848,6 +3849,9 @@ static int btusb_probe(struct usb_interface *intf,
> 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
> 	}
> 
> +	if (id->driver_info & BTUSB_BROKEN_ENHANCED_SETUP_SCO)
> +		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO, &hdev->quirks);
> +
> 	if (id->driver_info & BTUSB_CSR) {
> 		struct usb_device *udev = data->udev;
> 		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);

I am only adding this if I see the need to do this via USB VID/PID. Most drivers should make the decision on the vendor setup callback. Or FIX their broken firmware.

Regards

Marcel

