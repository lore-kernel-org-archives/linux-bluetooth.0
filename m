Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031ABC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiGAW2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiGAW2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 18:28:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DAE1FCFB
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 15:28:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a4so6145995lfm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GruWYOBngfLfDfK1U4G6/+LRagw1AuDAR7ngA7eWRQE=;
        b=mayFNLkAzNQsvo4lL7Hbg4kkyHQuQpeO3Cqgp1+5nsETpovfXqQXPhHk1EjYBBy3CV
         tYM7eDOUV7rxzjzuFBaQsfRUVLcKfm69fDljr4wJPrDvre4tPA85lba2C9qEzU3zvNIp
         /zqCX1ULpA4eLtOXwastp29mDpj55bXBe6Fdg0ZgtiCb4nkw/qGgzDGQyNVemnv8vAvt
         KRR9BFy6J3JSMrcz/zBTOtGFaGzKgXn5FwOpNBQYO9ckdoJBTfF0Oqx962gp00sjhuv+
         55qjKwdyCc2UznjO5tkxP14T/gxkx8BRWHPYMKNN8UWy0GszZrsfAL3yU6PHW88VS3EJ
         +qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GruWYOBngfLfDfK1U4G6/+LRagw1AuDAR7ngA7eWRQE=;
        b=UZh/FQqTeiwOM1DTD0dFO658C1fK15wmf33V5lZ6xIRdzEqH5isJs6ggGf2CsVP/9o
         ET0kYcJ77PXKrqAbdwdP4ZSfheG/gw2rYkGcbupc7vC0H67e1aCsImERjEGEYeA+s9JX
         QeA5reMNE+HTHITx9BJGlsxNhn42hcbTqrdUJBydEl/Jrx+Xtf8iLSS0HibO9lQNZQp1
         HoMgTl7ptMzvOsp/Gh6s8OTTxE0id2HEZfGwxl1Kxfmn85iAKgc0cmePRgJ7C+ulX6yW
         eVnEN/TmGoUXYAFEdV0mEikMZXUiKH8v5vEQmck9JRKRub2H9urPAIPaCc7tXPvREzLp
         qRwA==
X-Gm-Message-State: AJIora/iEhKnkKvrMNM3YhnVqr8AHg/8wcnARqAYn4Pl9m95CVxElrRf
        +t0OYyex+sc8lCU+LGkvXXiROIyvKLtqBY8iNW/ed78e
X-Google-Smtp-Source: AGRyM1viSa0VI2seKxHtKMnmPonOqVDvFRmfzx9Fekdl4Vc9Q9Rg9aNuhTl1MiJXoigQFlV23H6BXEzuari2aTBxeM0=
X-Received: by 2002:a05:6512:31d0:b0:47f:92c6:99f1 with SMTP id
 j16-20020a05651231d000b0047f92c699f1mr11174859lfe.198.1656714508637; Fri, 01
 Jul 2022 15:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220701080601.3010-1-wangyouwan@uniontech.com>
In-Reply-To: <20220701080601.3010-1-wangyouwan@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Jul 2022 15:28:17 -0700
Message-ID: <CABBYNZ+wAGTuXHHs4xZQDp1APJfAgxhh1Opoj7cE0kohY2EGmw@mail.gmail.com>
Subject: Re: [PATCH] obexd: fix crashed after cancel the on-going transfer
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youwan,

On Fri, Jul 1, 2022 at 1:18 AM Youwan Wang <wangyouwan@uniontech.com> wrote:
>
> There is a use after released.transfer->req_id different
> obex->pending_req->id,See the following log,
> The packages is removd in cancel_complete func
> are not the same package in req_timeout func,
> but transfer pointer is released.
>
> log:
> g_obex_cancel_req()
> transfer->req_id 23 id 22 obex->pending_req(0x55b642c3e100)
>
> g_obex_cancel_req()
> match->data (0x55b642c344a0)
>
> g_obex_ref() ref 4
>
> cancel_complete()
> pending req timeout 176 id 22 obex(0x55b642c3e100)
>
> transfer_response()
> obex 0x55b642c36480 transfer(0x55b642c3d000)
>
> g_obex_drop_tx_queue()
>
> g_obex_unref() obex 0x55b642c36480
> g_obex_unref() ref 3
>
> transfer_free()
> obex 0x55b642c36480 transfer 0x55b642c3d000
>
> g_obex_unref() obex 0x55b642c36480
> g_obex_unref() ref 2
>
> pending_pkt_free()
> timeout_id 0 pending_pkt (0x55b642c344a0)
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
>  gobex/gobex-transfer.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..a7d6c103a 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -83,15 +83,20 @@ static struct transfer *find_transfer(guint id)
>
>  static void transfer_complete(struct transfer *transfer, GError *err)
>  {
> -       guint id = transfer->id;
> +       guint id;
>
> -       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
> +       if (!g_slist_find(transfers, transfer))
> +               return;

If we have to do a lookup then something is wrong already and the
transfer_complete shall not called.

> +       transfer->req_id = 0;
> +       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
>
>         if (err) {
>                 /* No further tx must be performed */
>                 g_obex_drop_tx_queue(transfer->obex);
>         }
>
> +       id = transfer->id;
>         transfer->complete_func(transfer->obex, err, transfer->user_data);
>         /* Check if the complete_func removed the transfer */
>         if (find_transfer(id) == NULL)
> @@ -106,9 +111,6 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
>         struct transfer *transfer = user_data;
>
>         g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
> -
> -       transfer->req_id = 0;
> -
>         /* Intentionally override error */
>         err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
>                                                 "Operation was aborted");
> @@ -184,12 +186,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
>         struct transfer *transfer = user_data;
>         GObexPacket *req;
>         gboolean rspcode, final;
> -       guint id;
> -
> -       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
> -
> -       id = transfer->req_id;
> -       transfer->req_id = 0;

Don't think this is right, also I'm not sure why you are removing the
transfer? If the transfer has been freed then there is something
already quite wrong.

>         if (err != NULL) {
>                 transfer_complete(transfer, err);
> @@ -203,6 +199,9 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
>                 goto failed;
>         }
>
> +       if (!g_slist_find(transfers, transfer))
> +               return;
> +
>         if (transfer->opcode == G_OBEX_OP_GET) {
>                 handle_get_body(transfer, rsp, &err);
>                 if (err != NULL)
> @@ -222,8 +221,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
>                 req = g_obex_packet_new(transfer->opcode, TRUE,
>                                                         G_OBEX_HDR_INVALID);
>         } else {
> -               /* Keep id since request still outstanting */
> -               transfer->req_id = id;

Not sure why you are removing this line?

>                 return;
>         }
>
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
