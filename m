Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F7BC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiFNNVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFNNVv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 09:21:51 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20F3BF84
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 06:21:49 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb46.dynamic.kabel-deutschland.de [95.90.235.70])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5443661EA192D;
        Tue, 14 Jun 2022 15:21:46 +0200 (CEST)
Message-ID: <698fa316-4328-765b-80f4-b5cee03bcdde@molgen.mpg.de>
Date:   Tue, 14 Jun 2022 15:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] obexd: Fix transfer has been free in
 transfer_abort_response
Content-Language: en-US
To:     wangyouwan@uniontech.com
References: <20220614131549.22054-1-wangyouwan@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220614131549.22054-1-wangyouwan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Wang,


Thank you for your patch.

Am 14.06.22 um 15:15 schrieb wangyouwan:

Can you please configure your full name in git?

     git config --global user.name "Wang …"

> Breakpoint 7, transfer_new (obex=0x5555555f5b50, opcode=2 '\002',
> complete_func=0x555555590c40 <xfer_complete>, user_data=0x5555555f7000)
> at gobex/gobex-transfer.c:254
> 254     gobex/gobex-transfer.c:
> (gdb) c
> Continuing.

[…]

In addition to the GDB traces, can you please add a sentence, what is 
going on, and how to reproduce (test setup) that the transfer 
(`find_transfer(id)`) is NULL?

[…]
> ---
>   gobex/gobex-transfer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..48b1f6962 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -92,7 +92,9 @@ static void transfer_complete(struct transfer *transfer, GError *err)
>   		g_obex_drop_tx_queue(transfer->obex);
>   	}
>   
> -	transfer->complete_func(transfer->obex, err, transfer->user_data);
> +	if (find_transfer(id) != NULL)
> +		transfer->complete_func(transfer->obex, err, transfer->user_data);
> +
>   	/* Check if the complete_func removed the transfer */
>   	if (find_transfer(id) == NULL)
>   		return;


Kind regards,

Paul
