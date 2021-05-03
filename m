Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E52C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471D36121E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhECH5z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 03:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhECH5y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 03:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0345761185;
        Mon,  3 May 2021 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620028622;
        bh=wwGETSsnGI3oAo8F1vOUJQyF0GNITuB1FrqVVVLgcrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWag9VQ9oDGueJ6ZAGwxW33rrfMIWC4uVOViE4WoxEBtZdXi31MelCxu5Wr3icivV
         nFjro4O9qgadD6dSHiGTrc+1MlzZHJN6sn4SCi/WRLHU710RV/iNd7tgha3emjXA2W
         8wqQuwO14gN+YXQyr/2HNFoOu9OdhS4vIeUYUe7ktyc2oam+Bbn1Mua+uJr3FR/GiX
         U5AgxOXRlznW/HswpR/11uQl9PZ57pDGuBZdRWyDbVZBUG7FsCtYlX3qRd7WVaC4DT
         MfUdKkzKjJxiZ3vLvehW0arIUF742HrXNHN/tpiIkY7HdPLaqEu4YIIQ0eVNkUU6SK
         dfquNJpff0NQg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1ldTS4-0003as-6F; Mon, 03 May 2021 09:57:12 +0200
Date:   Mon, 3 May 2021 09:57:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] bluetooth: fix potential gfp
Message-ID: <YI+s2Hms/56Pvatu@hovoldconsulting.com>
References: <20210501150445.4055-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501150445.4055-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, May 01, 2021 at 06:04:45PM +0300, Pavel Skripkin wrote:
> In qca_power_shutdown() qcadev local variable is
> initialized by hu->serdev.dev private data, but
> hu->serdev can be NULL and there is a check for it.
> 
> Since, qcadev is not used before
> 
> 	if (!hu->serdev)
> 		return;
> 
> we can move its initialization after this "if" to
> prevent gfp.

Good catch. The commit message needs to be improved however.

First, what's a "gfp"? Did you mean GPF?

Second, I'd expect you to try to point to the commit that introduced
this issue (e.g. using a Fixes tag) and CC the person responsible. This
appears to be commit 5559904ccc08 ("Bluetooth: hci_qca: Add QCA Rome
power off support to the qca_power_shutdown()") but you should verify
that.

Third, this looks like it could be triggered by user space so you should
CC stable too so that the fix is backported.

Fourth, your commit summary (Subject) is missing the driver component
(i.e. "hci_qca").

> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index de36af63e182..9589ef6c0c26 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1820,8 +1820,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	unsigned long flags;
>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>  
> -	qcadev = serdev_device_get_drvdata(hu->serdev);
> -
>  	/* From this point we go into power off state. But serial port is
>  	 * still open, stop queueing the IBS data and flush all the buffered
>  	 * data in skb's.
> @@ -1837,6 +1835,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	if (!hu->serdev)
>  		return;
>  
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +
>  	if (qca_is_wcn399x(soc_type)) {
>  		host_set_baudrate(hu, 2400);
>  		qca_send_power_pulse(hu, false);

Johan
