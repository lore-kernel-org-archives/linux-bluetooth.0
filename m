Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A345C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiGAWmb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiGAWma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 18:42:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1B70E7C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 15:42:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n15so4179652ljg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6UUJJReJ7Mp+E+oNwFBgomzO2qWjXfTMKu5s8CoAsQ=;
        b=ow8I6iWfsdJiuRIjYjUw8W576JSw9Im19+OVkrGX2rGLdOvuoLq50xunux5gVvu2lU
         tRC8or7caqKp7hGWqqrH4/NHPc/BhwLS7Vicbn9MJd5A2PmKasjRsHuxdYgtYPzuuf2n
         Rjt0I0yh1F2rdM2NPpYfOn/U0V83hi6Mncl2cCzuUqC31b/Yx9+e3wv7Y0WXgPRX/K0s
         p8dTVjwEnfQ/F3WwEaRp7Eazwp6iDLxDa1i7jgzhNIku74yHTc7iS7rprEC5ZTr3WOFO
         WHMoeISPADsUk84y0P63qZQFCFVY4qv/NRwLOPWIkEqY9u30JguWx1nNnFhFeB02X1GJ
         ZtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6UUJJReJ7Mp+E+oNwFBgomzO2qWjXfTMKu5s8CoAsQ=;
        b=QDwcaBlSaPtNyjfHhJDw6L5rqUyKvxblIkttzXUobzvXKKkClBgnKUHgZrvQzcfqxo
         +5k7gyUdomQ1Aq0NIx8zwNf63xBrjdN1c8Jv3ikLlb4XrhcdmwSSGLHjkUxTkRf+8FTy
         afIjREWTLizYbK2YmoV8C8OBadriTo8XNIBscS/ZTZJb3aYtlY8nLSxivpthrUbDCOc0
         egFpc3LRrAujQbrZH562K2s0TCDAnTHHThsEC1lRwgBpQ2eS2IBGByQzWJGv73CVIN/R
         qNhoHGGYF/1ds5D1Y1wa5ylyFLL2BNv+FuQwi5WEidy+wqDuIceRx42lnWbDZ2yiwlQT
         7dOg==
X-Gm-Message-State: AJIora8UZzjAohGYaOY7f9ZwKyUchYyhru/UWAccgfu93Pg4eIHO8nBA
        3dum7NqvRYnhrVtWmAcAPgA2+8Ucrf+iRduvpqG5kFUTblE=
X-Google-Smtp-Source: AGRyM1vwTrLkszPdVAx31lahMeBMF6bezck3pc+6j00QHnc8liXFDySV/PB6Ywx5ZOg4u/IeuyoSb/GC5Vq5Lt3565o=
X-Received: by 2002:a2e:a16f:0:b0:25a:7527:95ce with SMTP id
 u15-20020a2ea16f000000b0025a752795cemr9128538ljl.305.1656715346929; Fri, 01
 Jul 2022 15:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220701080601.3010-1-wangyouwan@uniontech.com> <CABBYNZ+wAGTuXHHs4xZQDp1APJfAgxhh1Opoj7cE0kohY2EGmw@mail.gmail.com>
In-Reply-To: <CABBYNZ+wAGTuXHHs4xZQDp1APJfAgxhh1Opoj7cE0kohY2EGmw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Jul 2022 15:42:15 -0700
Message-ID: <CABBYNZ+jAdgKkK5Oy+OY8-Ak06RMt=KL-oj0OODqJS3X8Ai_5Q@mail.gmail.com>
Subject: Re: [PATCH] obexd: fix crashed after cancel the on-going transfer
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 3:28 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Youwan,
>
> On Fri, Jul 1, 2022 at 1:18 AM Youwan Wang <wangyouwan@uniontech.com> wrote:
> >
> > There is a use after released.transfer->req_id different
> > obex->pending_req->id,See the following log,
> > The packages is removd in cancel_complete func
> > are not the same package in req_timeout func,
> > but transfer pointer is released.
> >
> > log:
> > g_obex_cancel_req()
> > transfer->req_id 23 id 22 obex->pending_req(0x55b642c3e100)
> >
> > g_obex_cancel_req()
> > match->data (0x55b642c344a0)
> >
> > g_obex_ref() ref 4
> >
> > cancel_complete()
> > pending req timeout 176 id 22 obex(0x55b642c3e100)
> >
> > transfer_response()
> > obex 0x55b642c36480 transfer(0x55b642c3d000)
> >
> > g_obex_drop_tx_queue()
> >
> > g_obex_unref() obex 0x55b642c36480
> > g_obex_unref() ref 3
> >
> > transfer_free()
> > obex 0x55b642c36480 transfer 0x55b642c3d000
> >
> > g_obex_unref() obex 0x55b642c36480
> > g_obex_unref() ref 2
> >
> > pending_pkt_free()
> > timeout_id 0 pending_pkt (0x55b642c344a0)
> >
> > step:
> > [obex]# connect 28:33:34:1E:96:98
> > Attempting to connect to 28:33:34:1E:96:98
> > [NEW] Session /org/bluez/obex/client/session2 [default]
> > [NEW] ObjectPush /org/bluez/obex/client/session2
> > Connection successful
> > [28:33:34:1E:96:98]# send /home/uos/Desktop/systemd.zip
> > Attempting to send /home/uos/Desktop/systemd.zip
> > [NEW] Transfer /org/bluez/obex/client/session2/transfer2
> > Transfer /org/bluez/obex/client/session2/transfer2
> >         Status: queued
> >         Name: systemd.zip
> >         Size: 33466053
> >         Filename: /home/uos/Desktop/systemd.zip
> >         Session: /org/bluez/obex/client/session2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > [CHG] Transfer /org/bluez/obex/client/session2/transfer2
> > er2 33:34:1E:96:98]# cancel /org/bluez/obex/client/sessi
> > Attempting to cancel transfer /org/bluez/obex/client/s
> > Cancel successful
> >
> > valgrind trace:
> > ==11431== Invalid read of size 4
> > ==11431==    at 0x12B442: transfer_response ()
> > ==11431==    by 0x127764: req_timeout ()
> > ==11431==    by 0x49B8922: ??? ( )
> > ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> > ==11431==    by 0x49B8287: ??? (in )
> > ==11431==    by 0x49B8581: g_main_loop_run ()
> > ==11431==    by 0x121834: main (main.c:322)
> > ==11431==  Address 0x7344fa0 is 16 bytes inside a block of size
> > ==11431==    at 0x48369AB: free ()
> > ==11431==    by 0x12B459: transfer_response ()
> > ==11431==    by 0x127B3D: cancel_complete ()
> > ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> > ==11431==    by 0x49B8287: ??? ()
> > ==11431==    by 0x49B8581: g_main_loop_run ()
> > ==11431==    by 0x121834: main (main.c:322)
> > ==11431==  Block was alloc'd at
> > ==11431==    at 0x4837B65: calloc ()
> > ==11431==    by 0x49BD9D8: g_malloc0 ()
> > ==11431==    by 0x12AB89: transfer_new ()
> > ==11431==    by 0x12B732: g_obex_put_req_pkt ()
> > ==11431==    by 0x12B732: g_obex_put_req_pkt ()
> > ==11431==    by 0x146982: transfer_start_put ()
> > ==11431==    by 0x146982: obc_transfer_start ()
> > ==11431==    by 0x13C5A7: session_process_transfer ()
> > ==11431==    by 0x13D248: session_process_queue ()
> > ==11431==    by 0x13D248: session_process_queue ()
> > ==11431==    by 0x13D2AF: session_process ()
> > ==11431==    by 0x49B7E97: g_main_context_dispatch ()
> > ==11431==    by 0x49B8287: ??? (i)
> > ==11431==    by 0x49B8581: g_main_loop_run ()
> > ==11431==    by 0x121834: main ()
> > ==11431==
> > ==11431== (action on error) vgdb me ...
> > ---
> >  gobex/gobex-transfer.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> > index c94d018b2..a7d6c103a 100644
> > --- a/gobex/gobex-transfer.c
> > +++ b/gobex/gobex-transfer.c
> > @@ -83,15 +83,20 @@ static struct transfer *find_transfer(guint id)
> >
> >  static void transfer_complete(struct transfer *transfer, GError *err)
> >  {
> > -       guint id = transfer->id;
> > +       guint id;
> >
> > -       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
> > +       if (!g_slist_find(transfers, transfer))
> > +               return;
>
> If we have to do a lookup then something is wrong already and the
> transfer_complete shall not called.
>
> > +       transfer->req_id = 0;
> > +       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
> >
> >         if (err) {
> >                 /* No further tx must be performed */
> >                 g_obex_drop_tx_queue(transfer->obex);
> >         }
> >
> > +       id = transfer->id;
> >         transfer->complete_func(transfer->obex, err, transfer->user_data);
> >         /* Check if the complete_func removed the transfer */
> >         if (find_transfer(id) == NULL)
> > @@ -106,9 +111,6 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
> >         struct transfer *transfer = user_data;
> >
> >         g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
> > -
> > -       transfer->req_id = 0;
> > -
> >         /* Intentionally override error */
> >         err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
> >                                                 "Operation was aborted");
> > @@ -184,12 +186,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
> >         struct transfer *transfer = user_data;
> >         GObexPacket *req;
> >         gboolean rspcode, final;
> > -       guint id;
> > -
> > -       g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
> > -
> > -       id = transfer->req_id;
> > -       transfer->req_id = 0;
>
> Don't think this is right, also I'm not sure why you are removing the
> transfer? If the transfer has been freed then there is something
> already quite wrong.
>
> >         if (err != NULL) {
> >                 transfer_complete(transfer, err);
> > @@ -203,6 +199,9 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
> >                 goto failed;
> >         }
> >
> > +       if (!g_slist_find(transfers, transfer))
> > +               return;
> > +
> >         if (transfer->opcode == G_OBEX_OP_GET) {
> >                 handle_get_body(transfer, rsp, &err);
> >                 if (err != NULL)
> > @@ -222,8 +221,6 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
> >                 req = g_obex_packet_new(transfer->opcode, TRUE,
> >                                                         G_OBEX_HDR_INVALID);
> >         } else {
> > -               /* Keep id since request still outstanting */
> > -               transfer->req_id = id;
>
> Not sure why you are removing this line?
>
> >                 return;
> >         }
> >
> > --
> > 2.20.1
> >
> >
> >
>
>
> --

Btw, I suspect there is something wrong with the session itself, as
there is a test for the exact scenario of cancelling a transfer:

# GOBEX_DEBUG=transfer valgrind unit/test-gobex-transfer -d -p
"/gobex/test_stream_put_req_abort"
==851604== Memcheck, a memory error detector
==851604== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==851604== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==851604== Command: unit/test-gobex-transfer -d -p
/gobex/test_stream_put_req_abort
==851604==
# random seed: R02S5f08b6298979742063c1891a8b1c92d6
# Start of gobex tests
# gobex-DEBUG: gobex/gobex-transfer.c:g_obex_put_req() obex 0x58e7ea0
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.488:
gobex/gobex-transfer.c:g_obex_put_req() obex 0x58e7ea0
# gobex-DEBUG: gobex/gobex-transfer.c:g_obex_put_req_pkt() obex 0x58e7ea0
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.517:
gobex/gobex-transfer.c:g_obex_put_req_pkt() obex 0x58e7ea0
# gobex-DEBUG: gobex/gobex-transfer.c:transfer_new() obex 0x58e7ea0 opcode 2
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.518:
gobex/gobex-transfer.c:transfer_new() obex 0x58e7ea0 opcode 2
# gobex-DEBUG: gobex/gobex-transfer.c:g_obex_put_req_pkt() transfer 1
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.522:
gobex/gobex-transfer.c:g_obex_put_req_pkt() transfer 1
# gobex-DEBUG: gobex/gobex-transfer.c:g_obex_cancel_transfer() transfer 1
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.559:
gobex/gobex-transfer.c:g_obex_cancel_transfer() transfer 1
# gobex-DEBUG: gobex/gobex-transfer.c:transfer_response() transfer 1
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.581:
gobex/gobex-transfer.c:transfer_response() transfer 1
# gobex-DEBUG: gobex/gobex-transfer.c:transfer_complete() transfer 1
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.582:
gobex/gobex-transfer.c:transfer_complete() transfer 1
# gobex-DEBUG: gobex/gobex-transfer.c:transfer_free() transfer 1
(unit/test-gobex-transfer:851604): gobex-DEBUG: 15:37:37.584:
gobex/gobex-transfer.c:transfer_free() transfer 1
ok 1 /gobex/test_stream_put_req_abort
# End of gobex tests
1..1
==851604==
==851604== HEAP SUMMARY:
==851604==     in use at exit: 22,307 bytes in 36 blocks
==851604==   total heap usage: 862 allocs, 826 frees, 904,691 bytes allocated
==851604==
==851604== LEAK SUMMARY:
==851604==    definitely lost: 0 bytes in 0 blocks
==851604==    indirectly lost: 0 bytes in 0 blocks
==851604==      possibly lost: 0 bytes in 0 blocks
==851604==    still reachable: 22,307 bytes in 36 blocks
==851604==         suppressed: 0 bytes in 0 blocks
==851604== Rerun with --leak-check=full to see details of leaked memory
==851604==
==851604== For lists of detected and suppressed errors, rerun with: -s
==851604== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

Perhaps in your case it is not responding with:

static guint8 put_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x03 };

Anyway, please add a similar test to mimic the exact response you are getting.


-- 
Luiz Augusto von Dentz
