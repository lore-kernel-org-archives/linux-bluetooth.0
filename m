Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A59C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C540961528
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 06:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbhI3GxW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 02:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348202AbhI3GxR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 02:53:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07777617E4;
        Thu, 30 Sep 2021 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632984688;
        bh=Hb1Co39zPLbxtxrMbI7Nt3+wtbBdKyHzIMFwjyUn9tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0W7IHG7xlcjunKjtV/xGpwghbFzpMfVXqBg4pxqtNgkhOcB/K6DE0ua8G3/yLnZID
         AE22VNYkqvvVPp6gsbr4V7x5v/F5DD6Z+OpC0Gjy2JJrIsXSyVycgCo+24mBvJONM1
         o30oiMZw+5XfpNt1KW3ejUMa5H/Bdtb25wsjHag8=
Date:   Thu, 30 Sep 2021 08:51:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        regressions@lists.linux.dev, sonnysasaka@chromium.org
Subject: Re: [regression] Bluetooth: Query LE tx power on startup broke
 Bluetooth on MacBookPro16,1
Message-ID: <YVVeaDx20eeeQLSU@kroah.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930063106.19881-1-redecorating@protonmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Sep 30, 2021 at 06:32:57AM +0000, Orlando Chamberlain wrote:
> I've realised that thunderbird has added empty lines between each line in my
> previous email, but here's the same patch I sent before that adds a quirk
> disabling querying LE tx power for affected controllers, but this time
> without the aforementioned extra empty lines (I'm using git send-email now).
> 
> ---
>  drivers/bluetooth/btbcm.c   | 4 ++++
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_core.c    | 3 ++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index e4182acee488..4ecc50d93107 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
>  		return PTR_ERR(skb);
> 
>  	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
> +
> +	if (skb->data[1] == 150)
> +		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> +
>  	kfree_skb(skb);
> 
>  	/* Read Controller Features */
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b80415011dcd..9ce46cb8564d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -246,6 +246,15 @@ enum {
>  	 * HCI after resume.
>  	 */
>  	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> +
> +	/*
> +	 * When this quirk is set, LE tx power is not queried on startup
> +	 * and the min/max tx power values default to HCI_TX_POWER_INVALID.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
>  };
> 
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8a47a3017d61..9a23fe7c8d67 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>  			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
>  		}
> 
> -		if (hdev->commands[38] & 0x80) {
> +		if (hdev->commands[38] & 0x80 &&
> +	    	!test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
>  			/* Read LE Min/Max Tx Power*/
>  			hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
>  				    0, NULL);
> --
> 2.33.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
