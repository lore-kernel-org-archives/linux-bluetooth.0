Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0608C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A1820748
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDFSIm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:08:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51929 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFSIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:08:42 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CB4F7CECCA;
        Mon,  6 Apr 2020 20:18:14 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] bluetooth:Adding driver and quirk defs for multi-role
 LE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200406143529.209076-1-alainm@chromium.org>
Date:   Mon, 6 Apr 2020 20:08:40 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5835D8B2-C4B6-432F-B985-CA8D9633951A@holtmann.org>
References: <20200406143529.209076-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the relevant driver and quirk to allow drivers to
> report the le_states as being trustworthy.
> 
> This has historically been disabled as controllers did not reliably
> support this. In particular, this will be used to relax this condition
> for controllers that have been well tested and reliable.
> 
> 	/* Most controller will fail if we try to create new connections
> 	 * while we have an existing one in slave role.
> 	 */
> 	if (hdev->conn_hash.le_num_slave > 0)
> 		return NULL;
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c   | 2 +-
> include/net/bluetooth/hci.h | 9 +++++++++
> 2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3bdec42c9612..dd27e28d4601 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -58,7 +58,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_CW6622		0x100000
> #define BTUSB_MEDIATEK		0x200000
> #define BTUSB_WIDEBAND_SPEECH	0x400000
> -
> +#define BTUSB_VALID_LE_STATES   0x800000
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5f60e135aeb6..25c2e5ee81dc 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -214,6 +214,15 @@ enum {
> 	 * This quirk must be set before hci_register_dev is called.
> 	 */
> 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> +
> +	/* When this quirk is set, the controller has validated that
> +	 * LE states reported through the HCI_LE_READ_SUPPORTED_STATES are
> +	 * valid.  This mechanism is necessary as many controllers have
> +	 * been seen has having trouble initiating a connectable
> +	 * advertisement despite the state combination being reported as
> +	 * supported.
> +	 */
> +	HCI_QUIRK_VALID_LE_STATES,
> };

So far so good, but I wait until I see this patch in a broader context that also lifts some of the restrictions and checks the supported LE states.

Regards

Marcel

