Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D16DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 11:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGVL7u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGVL7t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 07:59:49 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2849D1D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 04:59:47 -0700 (PDT)
Received: (qmail 13189 invoked by uid 990); 22 Jul 2022 11:59:45 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <67219c6e-7eef-ee5c-693c-215a4d4c1b3e@eknoes.de>
Date:   Fri, 22 Jul 2022 13:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Bluetooth: virtio_bt: Use skb_put to set length
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20220614145253.132230-1-soenke.huster@eknoes.de>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
In-Reply-To: <20220614145253.132230-1-soenke.huster@eknoes.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-2.93036) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -1.53036
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 22 Jul 2022 13:59:45 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 14.06.22 16:52, Soenke Huster wrote:
> By using skb_put we ensure that skb->tail is set
> correctly. Currently, skb->tail is always zero, which
> leads to errors, such as the following page fault in
> rfcomm_recv_frame:
> 
>     BUG: unable to handle page fault for address: ffffed1021de29ff
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)
> 
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
>  drivers/bluetooth/virtio_bt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 67c21263f9e0..fd281d439505 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *work)
>  	if (!skb)
>  		return;
>  
> -	skb->len = len;
> +	skb_put(skb, len);
>  	virtbt_rx_handle(vbt, skb);
>  
>  	if (virtbt_add_inbuf(vbt) < 0)

Are there any issues with it, or is there another reason why it is not merged yet?
