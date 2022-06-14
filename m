Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37882C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 20:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbiFNUlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiFNUlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 16:41:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96446149
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:41:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w20so15738026lfa.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cngke8nv353WystrjUKeHF7SKETtOBwGYtbPt5+IURo=;
        b=qwkJEeyqloyD4Y1UkZ/WTgiCgIBCX0tmHwSMsuGjSwu9D45WvC3ueAR6k015hALRvL
         ImaSqZeXUJipI9TftjQgvBrEmDsX5IsrwY+TwEUY5/PH93aaXq9PUDB1totOKoUU6vtz
         1SkF4yG2WyF1ow8fHN/RF2hnO9M/b3OJ+nxMK8+XqyqHy1ZZndB6CpYr+qbjjji46gcP
         VoAMw28RpfNT/1IBhTOVFPS1hf3FJOou8gMtFecSkaOkmVwrHCIPLVPYEMQMpHK8k7ub
         M0xUJWYLSL27svfN2qIJrGSYnq66L1z/q6320BHo9BqrKVAKZWZ9KOIPBWbXB+HTE8Kn
         nRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cngke8nv353WystrjUKeHF7SKETtOBwGYtbPt5+IURo=;
        b=skf4TuEPY2EjNTgrzwojkg3OF4ZnrX2AM2x23N8WKrOQCi5VVEAOSXzzSDJELe9iDs
         8PoCjhsbjBkj8nd7TRHUaw64ZXRNBV8Ik+tF5y/4axSmxedd9FAfAIFDLiPFcFqWhvPN
         Khqu5TlCer5Krtoj5+eTCrNMiP/CMCA7mjLk15nbcK3Kersd8dpRYJSJod9JK9PF/DDi
         QKA5+3x/xrPJFfKQOvidJrKuhOJ7Jhu1QHAYyAC8prEoppFMZ+64cH4czRaxWIRKqVF5
         UvLBR6oTuPZn+hQ+g96jJKfS7Wq12idykG4avmQkyhT7Y52JNHeAisBOAiFvEXju+7Bm
         PLdw==
X-Gm-Message-State: AJIora/gIC9ip5LoORXzRmISGLBiKPRlt7v7Z+HmYOuNdsBxEwdUtPNO
        Qf+NbIW0yOyqKpVS46nvb/3x1S0D7WC8hwUNh8v+zBxM
X-Google-Smtp-Source: AGRyM1tyHcuuv1q1KYLXB9MZod5W6t+cqEN9/gZ7dAtUM2cg0TnrC7vVdRp43vA6ryOcBmqKQ7eYD3PEJrz7j6RqFaE=
X-Received: by 2002:a05:6512:e94:b0:478:f6ad:c9d7 with SMTP id
 bi20-20020a0565120e9400b00478f6adc9d7mr4196073lfb.198.1655239261060; Tue, 14
 Jun 2022 13:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220614114914.30497-1-wangyouwan@uniontech.com>
In-Reply-To: <20220614114914.30497-1-wangyouwan@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Jun 2022 13:40:49 -0700
Message-ID: <CABBYNZKcqH=pTCgt=nvjUMUhv8GiBAaXxi2PvHtqA_Zar983Lg@mail.gmail.com>
Subject: Re: [PATCH] obexd: Fix transfer has been free during
 transfer_abort_response func
To:     wangyouwan <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jun 14, 2022 at 4:55 AM wangyouwan <wangyouwan@uniontech.com> wrote:
>
> Breakpoint 7, transfer_new (obex=0x5555555f5b50, opcode=2 '\002',
> complete_func=0x555555590c40 <xfer_complete>, user_data=0x5555555f7000)
> at gobex/gobex-transfer.c:254
> 254     gobex/gobex-transfer.c:
> (gdb) c
> Continuing.
>
> Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6d60)
> at gobex/gobex-transfer.c:99
> 99      in gobex/gobex-transfer.c
> (gdb) c
> Continuing.
>
> Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6d60,
> user_data=0x5555555f7000)
> at obexd/client/transfer.c:659
> 659     obexd/client/transfer.c:
> (gdb) n
> 661     in obexd/client/transfer.c
> (gdb) n
> 663     in obexd/client/transfer.c
> (gdb) p callback->func
> $17 = (transfer_callback_t) 0x5555555885e0 <transfer_complete>
> (gdb) c
> Continuing.
>
> Breakpoint 3, transfer_complete (transfer=0x5555555f7000, err=0x5555555f6d60,
> user_data=0x5555555f48d0) at obexd/client/session.c:964
> 964     obexd/client/session.c:
> (gdb) c
> Continuing.
>
> Breakpoint 5, transfer_free (transfer=0x5555555f5f40) at gobex/gobex-transfer.c:61
> 61      gobex/gobex-transfer.c:
> (gdb) n
> 63      in gobex/gobex-transfer.c
> (gdb) p transfer->id
> $18 = 1
> (gdb) c
> Continuing.
>
> Breakpoint 2, transfer_abort_response (obex=0x5555555f5b50, err=0x0, rsp=0x5555555f0810,
> user_data=0x5555555f5f40) at gobex/gobex-transfer.c:116
> 116     in gobex/gobex-transfer.c
> (gdb) n
> 118     in gobex/gobex-transfer.c
> (gdb) p transfer->id
> $19 = 1432314080
> (gdb) c
> Continuing.
>
> Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6f00) at gobex/gobex-transfer.c:99
> 99      in gobex/gobex-transfer.c
> (gdb) c
> Continuing.
>
> Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6f00, user_data=0x5555555f7000)
> at obexd/client/transfer.c:659
> 659     obexd/client/transfer.c:
> (gdb) n
> 661     in obexd/client/transfer.c
> (gdb) p callback->func
> $20 = (transfer_callback_t) 0x5555555f6420
> (gdb) n
> 663     in obexd/client/transfer.c
> (gdb) n
> 668     in obexd/client/transfer.c
> (gdb) n
> 671     in obexd/client/transfer.c
> (gdb) n
> 672     in obexd/client/transfer.c
> (gdb) n
> 676     in obexd/client/transfer.c
> (gdb) n
> 679     in obexd/client/transfer.c
> (gdb) n
> 680     in obexd/client/transfer.c
> (gdb) n
> 0x00005555555f6420 in ?? ()
> (gdb) n
> Cannot find bounds of current function
> (gdb) c
> Continuing.
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00005555555f6420 in ?? ()
> (gdb)
> ---
>  gobex/gobex-transfer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..48b1f6962 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -92,7 +92,9 @@ static void transfer_complete(struct transfer *transfer, GError *err)
>                 g_obex_drop_tx_queue(transfer->obex);
>         }
>
> -       transfer->complete_func(transfer->obex, err, transfer->user_data);
> +       if (find_transfer(id) != NULL)
> +               transfer->complete_func(transfer->obex, err, transfer->user_data);

I would rather fix the code calling of the transfer_complete rather
than its side effect if transfer has been freed already, also it might
be better to use valgrind to collect the bracktrace since it should be
able to tell us where the transfer pointer is being freed.

>         /* Check if the complete_func removed the transfer */
>         if (find_transfer(id) == NULL)
>                 return;
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
