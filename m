Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jul 2022 18:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiGHSGg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiGHSGf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jul 2022 14:06:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A17C1AB
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jul 2022 11:06:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t19so36940344lfl.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jul 2022 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RWEygXYqWchB5ZdRrUcmVd8ZKx2kYEDzBMC7Ah3j/o=;
        b=kdiLoiaQnK+VNvtbyNG8I6NZBI7waUtqDh8sPLCowS093KRwJ4Ojlj1F2mGyhonDIh
         dzEixoou7DlWArSH39ESjpgeNfPGxQMYr+FC/7Rj3E30Y5869SbYgJvqoa9ynSLCxGN8
         YpB6dw0K1a0U3ntHhOgjP6/us+Bg+h7pl4y2W9C0pjN1Qhw2ErghizhhuDNaJb3rSuqM
         yh2z6n7/PLeV0klk/tVut/y5i/kaXBPPbGy5a2lt79t89bbEe01LaJaf2imOIpMWPJ6r
         CRAlFNr8bEERBo9O6ZmelqYKHmSUrQ5YfMckeVqqFDER0dCxjVVysg5JNE8JUUFWdM9O
         UfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RWEygXYqWchB5ZdRrUcmVd8ZKx2kYEDzBMC7Ah3j/o=;
        b=A6w+f6zvSPnVgoughSh4PKAxR2XGLhs076v+8sUxBHnWlogD7E2D80znbZLGK+pno3
         sqmDtJBFknr2WI/8DBbIK/tHYNXCWBdLRPFsJZWNbgcQe3UNCkvFcOEswb8JI9An1a0L
         4QB7y7Q2ZcW+jgkkH2pIhT1BpfLIjaqZGzhYXaL/SEwGgmQhD6Z3Ps7nNxIHdLd4zqNr
         tJMyaeNK19Y5vfRRMCP2XS8kVwBB9+YJx2yNjNY0orexOxLSQXSsd/ILAzwR61h1Cq0G
         LyOsUvITGeTQFb9wXd9/lGr6Gp4wCbz4Q2VWHuuPh0pZeV8uQ8KsDtw3KkxAlHWDQ/3D
         7UBw==
X-Gm-Message-State: AJIora9xyaLgZ5D+h7ieovJBaPlGRZOT3JT6f42hW9WZWz2jTvNdZmo9
        9rZslK0sQRtXnxxbP6FI54iJm9umobnnPYBG8QKa7+mz46Y=
X-Google-Smtp-Source: AGRyM1u0mXbgwH7PTajSwXgIdS+hvO5qTU9reZ6XT9KUdjyhLHivbATKeBcfWTf8Xhga0folj8n2BrJcJf4BWwdIJg0=
X-Received: by 2002:a05:6512:31d0:b0:47f:92c6:99f1 with SMTP id
 j16-20020a05651231d000b0047f92c699f1mr3328802lfe.198.1657303592768; Fri, 08
 Jul 2022 11:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220708062548.31167-1-wangyouwan@uniontech.com>
In-Reply-To: <20220708062548.31167-1-wangyouwan@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 8 Jul 2022 11:06:21 -0700
Message-ID: <CABBYNZJT8QpA2sWMOxE2pnwuQsRarenWMc5GLbcpROiW7Aqe=A@mail.gmail.com>
Subject: Re: [PATCH] obexd: fix crashed after cancel the on-going transfer
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youwan,

On Thu, Jul 7, 2022 at 11:30 PM Youwan Wang <wangyouwan@uniontech.com> wrote:
>
> Pointer is reused after release.
> After the transfer pointer is released,
> remove the response function in pending_pkg
> to avoid the 'p->rsp_func' is reused
>
> step:
> [obex]# connect 28:33:34:1E:96:98
> Attempting to connect to 28:33:34:1E:96:98
> [NEW] Session /org/bluez/obex/client/session2 [default]
> [NEW] ObjectPush /org/bluez/obex/client/session2
> Connection successful
> [28:33:34:1E:96:98]# send /home/uos/Desktop/systemd.zip
> Attempting to send /home/uos/Desktop/systemd.zip
> [NEW] Transfer /org/bluez/obex/client/session2/transfer2
> Transfer /org/bluez/obex/client/session2/transfer2
>         Status: queued
>         Name: systemd.zip
>         Size: 33466053
>         Filename: /home/uos/Desktop/systemd.zip
>         Session: /org/bluez/obex/client/session2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> er2 33:34:1E:96:98]# cancel /org/bluez/obex/client/sessi
> Attempting to cancel transfer /org/bluez/obex/client/s
> Cancel successful
>
> valgrind trace:
> ==11431== Invalid read of size 4
> ==11431==    at 0x12B442: transfer_response ()
> ==11431==    by 0x127764: req_timeout ()
> ==11431==    by 0x49B8922: ??? ( )
> ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> ==11431==    by 0x49B8287: ??? (in )
> ==11431==    by 0x49B8581: g_main_loop_run ()
> ==11431==    by 0x121834: main (main.c:322)
> ==11431==  Address 0x7344fa0 is 16 bytes inside a block of size
> ==11431==    at 0x48369AB: free ()
> ==11431==    by 0x12B459: transfer_response ()
> ==11431==    by 0x127B3D: cancel_complete ()
> ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> ==11431==    by 0x49B8287: ??? ()
> ==11431==    by 0x49B8581: g_main_loop_run ()
> ==11431==    by 0x121834: main (main.c:322)
> ==11431==  Block was alloc'd at
> ==11431==    at 0x4837B65: calloc ()
> ==11431==    by 0x49BD9D8: g_malloc0 ()
> ==11431==    by 0x12AB89: transfer_new ()
> ==11431==    by 0x12B732: g_obex_put_req_pkt ()
> ==11431==    by 0x12B732: g_obex_put_req_pkt ()
> ==11431==    by 0x146982: transfer_start_put ()
> ==11431==    by 0x146982: obc_transfer_start ()
> ==11431==    by 0x13C5A7: session_process_transfer ()
> ==11431==    by 0x13D248: session_process_queue ()
> ==11431==    by 0x13D248: session_process_queue ()
> ==11431==    by 0x13D2AF: session_process ()
> ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> ==11431==    by 0x49B8287: ??? (i)
> ==11431==    by 0x49B8581: g_main_loop_run ()
> ==11431==    by 0x121834: main ()
> ==11431==
> ==11431== (action on error) vgdb me ...
> ---
>  gobex/gobex-transfer.c | 2 ++
>  gobex/gobex.c          | 6 ++++++
>  gobex/gobex.h          | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..38c23785c 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -64,6 +64,8 @@ static void transfer_free(struct transfer *transfer)
>                 g_obex_remove_request_function(transfer->obex,
>                                                         transfer->abort_id);
>
> +       g_obex_remove_responsefunc(transfer->obex);
> +
>         g_obex_unref(transfer->obex);
>         g_free(transfer);
>  }
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index bc4d52551..54ce484f2 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -533,6 +533,12 @@ void g_obex_drop_tx_queue(GObex *obex)
>                 pending_pkt_free(p);
>  }
>
> +void g_obex_remove_responsefunc(GObex *obex)
> +{
> +       if (obex->pending_req)
> +               obex->pending_req->rsp_func = NULL;
> +}

Can we stop treating the symptom and really fix the cause,
transfer_free does already call g_obex_cancel_req which normally
should take care of removing any timeout handling which seems to be
the cause of the crash here:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gobex/gobex.c#n841

Btw, Ive already pointed out that there are test cases for it and if
we are not capturing the exact scenario you are describing here would
you please add a test case with the exact response that is causing
such a crash:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/unit/test-gobex-transfer.c#n480

>  static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
>                                                                 GError **err)
>  {
> diff --git a/gobex/gobex.h b/gobex/gobex.h
> index f16e4426c..1f7ae513a 100644
> --- a/gobex/gobex.h
> +++ b/gobex/gobex.h
> @@ -51,6 +51,7 @@ void g_obex_suspend(GObex *obex);
>  void g_obex_resume(GObex *obex);
>  gboolean g_obex_srm_active(GObex *obex);
>  void g_obex_drop_tx_queue(GObex *obex);
> +void g_obex_remove_responsefunc(GObex *obex);
>
>  GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
>                                                 gssize rx_mtu, gssize tx_mtu);
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
