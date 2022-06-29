Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD2C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 23:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiF2Xwz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2Xwy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 19:52:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296421E07
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 16:52:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s14so20948317ljs.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5YgBc0z8rjGMoGnLvdiVCt3s1Y/wTBkjGBEBi13cL0=;
        b=B3J0igKRkC5MVzx+RIFVNEDk7EayHiEGtf9v859ZF9+hFU53Qw/IEaBJlJUt3WHfpQ
         NfDSxsDKHIpjhDv0HzmQ1XzBGr3El1GlQee7zEKXi78pqbdhUGM382V/dCXZHX/Mei68
         Azc+xHVOVUc/YCLXCwG+Hp3wdCE/S/lfgPhiMwrLrbaDc2PN3sKQqXsyWSYtEYPcZMWS
         SMfMeOchVnTuW9AV2/gEoJnhBu24N1QKeGCxGiRbgTkL224VQBqItze9xG0lZyoyyxIc
         LV96kyFPf8L8f93TSFxxp+RFiJWTiV+B6B5pW2RcknEsu3rAi1E3BgziFVL0SUe334JE
         zjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5YgBc0z8rjGMoGnLvdiVCt3s1Y/wTBkjGBEBi13cL0=;
        b=vrqiV2FZ74PDmi41J5xPaZ/x+MtTCjBVVppCWJBA06UwUwIrTf5aroWvLQcc9kf+X1
         +/K/sI7sPS4aKKPTBtyb5Nfo0/dYFVOQ+7kJQAQBO0nb5jGvLAn4ngjsTqLpTQ5xETKW
         fF++/++JP8D5SjLK7QP+HkoDIXRXfScfJcukHUuTqHaozyAXLCyM4UVvVqNRG6QvwTMs
         wUHJXPKupDBaokbhGUoKp0XWbcRuAd/e3l/03oTV5Ke9DIZ8WfQHvUvjDQtXeo6jEdoj
         yyAELn16VKDXYn6l3g8JyG7/MjXCqnoLFe37PzeQeJ2pTFa2r7nJIk63Clr/KRkE3GMZ
         rLBQ==
X-Gm-Message-State: AJIora8IVFHj6015yEyDZ45ygU90lFCqXbkDCJ5yuBmYh9BpJb5N6MSC
        7q/Ci6agkGo6qcMAVlyJVnp4X01CO8iX5EVyPRXfOf6H
X-Google-Smtp-Source: AGRyM1saqBSpmsfxkxE0TPvLEDaUdpFHCPSZZ8w1134sLYxmz2xxvpQjcwCQ4afdI/JXWJrtcc6BhshhQC3P02fGW04=
X-Received: by 2002:a2e:9191:0:b0:25a:8858:f60d with SMTP id
 f17-20020a2e9191000000b0025a8858f60dmr3192785ljg.423.1656546771250; Wed, 29
 Jun 2022 16:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220615124902.17347-1-wangyouwan@uniontech.com> <CABBYNZK+8KHiDcz8yoMP-g3PFzxFTXXPaUEnECU+wmKtLo3cPA@mail.gmail.com>
In-Reply-To: <CABBYNZK+8KHiDcz8yoMP-g3PFzxFTXXPaUEnECU+wmKtLo3cPA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Jun 2022 16:52:39 -0700
Message-ID: <CABBYNZ+X2ST_ZZ6dQernrmnAD2rNdF3X_4xY=z4_s8yyRB0+YQ@mail.gmail.com>
Subject: Re: [PATCH] obexd: Fix crash of transfer pointer has being freed
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youwan,

On Fri, Jun 17, 2022 at 3:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Youwan,
>
> On Wed, Jun 15, 2022 at 5:54 AM Youwan Wang <wangyouwan@uniontech.com> wrote:
> >
> > PC1 -> PC2 in the process of transferring the file,
> > PC2 terminate the reception.
> > It is found that PC1 will receive the Rcvd
> > Forbiden message.
> > transfer_response func is called and go to failed:
> > transfer_complete func is called and go to transfer_free
> >
> > Invalid read of size 8
> >     at 0x129C9B: put_get_data (gobex-transfer.c:138)
> >     by 0x128675: get_body (gobex-packet.c:397)
> >     by 0x128675: g_obex_packet_encode (gobex-packet.c:451)
> >     by 0x1264ED: write_data (gobex.c:461)
> >     by 0x1264ED: write_data (gobex.c:431)
> >     by 0x49B7E97: g_main_context_dispatch ()
> >     by 0x49B8287: ??? ()
> >     by 0x49B8581: g_main_loop_run ()
> >     by 0x120834: main (main.c:322)
> >   Address 0x7300028 is 56 bytes inside a block of size 64 free'd
> >     at 0x48369AB: free (vg_replace_malloc.c:530)
> >     by 0x12A404: transfer_response (gobex-transfer.c:245)
> >     by 0x126B02: handle_response (gobex.c:1128)
> >     by 0x127087: incoming_data (gobex.c:1373)
> >     by 0x49B7E97: g_main_context_dispatch ()
> >     by 0x49B8287: ??? ()
> >     by 0x49B8581: g_main_loop_run ()
> >     by 0x120834: main (main.c:322)
> >   Block was alloc'd at
> >     at 0x4837B65: calloc (vg_replace_malloc.c:752)
> >     by 0x49BD9D8: g_malloc0 ()
> >     by 0x129A49: transfer_new (gobex-transfer.c:258)
> >     by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:282)
> >     by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:271)
> >     by 0x145862: transfer_start_put (transfer.c:880)
> >     by 0x145862: obc_transfer_start (transfer.c:911)
> >     by 0x13B487: session_process_transfer (session.c:836)
> >     by 0x13C128: session_process_queue (session.c:887)
> >     by 0x13C128: session_process_queue (session.c:872)
> >     by 0x13C18F: session_process (session.c:820)
> >     by 0x49B7E97: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/)
> >     by 0x49B8287: ??? (in /usr/lib/x86_64-linux-gnu/)
> >     by 0x49B8581: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/)
> >     by 0x120834: main (main.c:322)
> > ---
> >  gobex/gobex-transfer.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> > index c94d018b2..8e97fc73e 100644
> > --- a/gobex/gobex-transfer.c
> > +++ b/gobex/gobex-transfer.c
> > @@ -197,6 +197,14 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
> >         }
> >
> >         rspcode = g_obex_packet_get_operation(rsp, &final);
> > +       if (rspcode == G_OBEX_RSP_FORBIDDEN) {
> > +               err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
> > +                                               g_obex_strerror(rspcode));
> > +               g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
> > +               g_error_free(err);
> > +               return;
> > +       }
>
> This is not quite right, in fact the if statement below already treat
> such errors, we might be missing something like final:
>
> /* Reset if final so it can no longer be cancelled */
> if (final_rsp)
> obex->pending_req = NULL;
>
> This would be a problem on the remote implementation which is
> indicating that perhaps it is just a temporary failure, anyway then:
>
> id = transfer->req_id;
> transfer->req_id = 0;
>
> This resets the req_id so on transfer_free the following code is not run:
>
> if (transfer->req_id > 0)
> g_obex_cancel_req(transfer->obex, transfer->req_id, TRUE);
>
> So either we have to restore the transfer->req_id = id or not reset it
> to 0, so perhaps something like this works better:
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..8fae65d8d 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -200,6 +200,11 @@ static void transfer_response(GObex *obex, GError
> *err, GObexPacket *rsp,
>         if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
>                 err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
>                                                 g_obex_strerror(rspcode));
> +               /* If not marked as final response but transfer_complete gonna
> +                * be called restore the req_id so it can be properly cancelled
> +                */
> +               if (!final)
> +                       transport->req_id = id;
>                 goto failed;
>         }

You haven't responded about this one, I believe there are quite a few
patches of yours that are trying to circumvent this very issue.

> > +
> >         if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
> >                 err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
> >                                                 g_obex_strerror(rspcode));
> > --
> > 2.20.1
> >
> >
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
