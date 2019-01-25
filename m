Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B78C282C5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 00:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C6A218D9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 00:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZtBxxEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAYAzh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:55:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfAYAzg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jan 2019 19:55:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3451209pgm.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jan 2019 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSPb7Cbr7A2+q4Zr+YYOr1AZJUnYL55acdzIwT0IG1I=;
        b=FZtBxxEtDxY4uGAojcFmmXNQ5ewnGU7dBWNaa4AxoyGgPH54pt+2JXPWlDQkBp6WYG
         hC14/5a12LCG20MUBeidoiwv4KBSIb3s5ZvHiqmZyxBumHqM3P6+Xq8eLfSrkFWWizwC
         YMV2ksb/X98MolH28Ew0hYqsow9+2EVyRx6EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSPb7Cbr7A2+q4Zr+YYOr1AZJUnYL55acdzIwT0IG1I=;
        b=awEc4Z7m5u9V5jqLevGnVRNXvGHSpcOG+zpeVSPZB0qT1uWFGhrjXtK/0ylif69N3n
         HWy8wQZUw2TeWqbehOS9kX6zOHKXYmhc5h/9ThTCrR4Gi0JOWHnOr8pURggdMgxxu0bM
         X5rVEJYPbIduBX+KBd2FNWnLlZvtTSA2x3naFywCx9Yc+R9N5RDSMz7S66SMCbB+4BJL
         Q64uyrkf0azmKQvpFqhfzh6BZAb3vNaajDbYfGiQYH3/KNsoWCV0NweYzkJaGjd6YzTb
         cLmKOXrsvgUW0u5TSyGH8QSNyhBQCXps9znrg4uuJ+v3CcVB93m9371Ex7siBnJwwxl1
         IxXw==
X-Gm-Message-State: AJcUukcW2u3wnvZBA65Paj4QYLKVNVOx3wCnWiVuwSQQU+4gj2FFnBu3
        KNPbBEKoFiiTKKq9f+vRQu1Kkw==
X-Google-Smtp-Source: ALg8bN4uie9HJh63Jax3McaJOhkkjulCrnHdgo0CvptP9g8PEqwnz0ZUNxgMnazQF0jtH+2tu26JPg==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr7676433pgg.347.1548377735713;
        Thu, 24 Jan 2019 16:55:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y6sm35569207pfd.104.2019.01.24.16.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 16:55:34 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:55:34 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 3/3] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
Message-ID: <20190125005534.GC81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124120808.8275-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 24, 2019 at 05:38:08PM +0530, Balakrishna Godavarthi wrote:
> During hci down we observed IBS sleep commands are queued in the Tx
> buffer and hci_uart_write_work is sending data to the chip which is
> not required as the chip is powered off. This patch will disable IBS
> and flush the Tx buffer before we turn off the chip.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes v9:
>   * added lock while disabling the IBS state machine.
> 
> ---
>  drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 6b5bcd44e24c..99ddc35f08c6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -771,16 +771,17 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>  
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
>  	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
>  	}
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -
>  	/* Act according to current state */
>  	switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_AWAKE:
> @@ -1273,6 +1274,18 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> +	struct qca_data *qca = hu->priv;
> +	unsigned long flags;
> +
> +	/* From this point we go into power off state. But serial port is
> +	 * still open, stop queueing the IBS data and flush all the buffered
> +	 * data in skb's.
> +	 */
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	qca_flush(hu);
> +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +
>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);

I was about to add my 'Reviewed-by' tag, but I'm still left with a
doubt. This patch certainly improves the situation by clearing the IBS
bit and flushing the buffered data, however IIUC new data could still
be added to the TX queue after releasing the spinlock:

static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
{
	...

	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
		skb_queue_tail(&qca->txq, skb);

	...
}

To prevent this a boolean/bit like 'shutting_down' or similar would be
needed (I don't think there is something common in the HCI core),
which is set in qca_power_shutdown(). If the bit is set qca_enqueue()
discards the data.

Not sure how important this is, and I don't want to add necessarily
more revisions to this series. If it is preferable to have an empty
queue after shutdown maybe it can be done in a follow up patch.

Thanks

Matthias
