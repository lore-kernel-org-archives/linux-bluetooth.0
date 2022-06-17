Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB44C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiFQW6h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382620AbiFQW6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:58:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C159BBB
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:58:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c2so8979222lfk.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SayFkkcIzYfgBsXA/3aeID8z4Bad9GXKziytId6aGR8=;
        b=eBaD9dyPKUvLerQdzqLSPLb0Z7ffSLk5K8g0TZdiDcCZNO8msukRQANInTnCHtQVD3
         UCIi4cA/pBG327Mg2OqcJj3CxzIEEmu/v/XeuCWZYzx5SpvaOBrnEjKJs+sfgbpZn59g
         mjg0EDM2dc6Dxa4aSIVA+TTu5KSyAwfy6FbO2JiNFEbInz+/3tjtvk7CO76h7MgcVf5A
         64H4eOXMNOKpCrnDvR04Mal64q5N+z02Q1rPtjEE3FIJLhvr75x+nTVj1Z05hcRFR/Gv
         TmBJZOgd65rJ8bdneRQZPVqeGzInmh+jhHCSwM0e1u4WX/t30PRHBj88tWlCRPuDDyvL
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SayFkkcIzYfgBsXA/3aeID8z4Bad9GXKziytId6aGR8=;
        b=iAN3qyQ+4ErMXTS/E0DR5omIaNqPyDSohEYgXE5RojwQpkGj/jj6/DevauC+0Y6aPf
         Z5EIjBkf1Z+iDfXEub0EE4oGldLvIWUOEIiaeVWmO/j0XxqAqqfypaQlPVRgx32Sa5WX
         9HIjR8B0zE4NIE2gq1Rc/zQvFhEB1UdcUE5fmikpvZV7pSc0wqp0mBjYsBsPVQm9tieK
         iUf4h5Eta9OT92niUsPE5TXKNM/5NR1dQbyJNDNXEB8yje1VTwPNKGvHaVl9IvlRmvgy
         JACbkye5+uyI3czECjksqwdBTZIvikDi3x9N+xwC991SkCdvc0ybh6GUrWvuBYgYjVZ5
         gDDg==
X-Gm-Message-State: AJIora+cmYO5VaMgxwo/34d6uMV/3To+Es7pOHxfqlE2bSVQkwAJMxZn
        RlpK8j0GlYLWR6RVmf87Dblgz79ptksRiH5qeEZOMYgJ9XA=
X-Google-Smtp-Source: AGRyM1uUB058A9NoFLSZrlVMzbpFZvKhqyE9S49S0Ii58ANNeo8LqVEQUqf5erXjGYrIP/5oyB0t/Q8vdHCT8dddyZc=
X-Received: by 2002:a05:6512:2204:b0:479:7c21:bff8 with SMTP id
 h4-20020a056512220400b004797c21bff8mr6936853lfu.251.1655506710875; Fri, 17
 Jun 2022 15:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220615124902.17347-1-wangyouwan@uniontech.com>
In-Reply-To: <20220615124902.17347-1-wangyouwan@uniontech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jun 2022 15:58:19 -0700
Message-ID: <CABBYNZK+8KHiDcz8yoMP-g3PFzxFTXXPaUEnECU+wmKtLo3cPA@mail.gmail.com>
Subject: Re: [PATCH] obexd: Fix crash of transfer pointer has being freed
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youwan,

On Wed, Jun 15, 2022 at 5:54 AM Youwan Wang <wangyouwan@uniontech.com> wrote:
>
> PC1 -> PC2 in the process of transferring the file,
> PC2 terminate the reception.
> It is found that PC1 will receive the Rcvd
> Forbiden message.
> transfer_response func is called and go to failed:
> transfer_complete func is called and go to transfer_free
>
> Invalid read of size 8
>     at 0x129C9B: put_get_data (gobex-transfer.c:138)
>     by 0x128675: get_body (gobex-packet.c:397)
>     by 0x128675: g_obex_packet_encode (gobex-packet.c:451)
>     by 0x1264ED: write_data (gobex.c:461)
>     by 0x1264ED: write_data (gobex.c:431)
>     by 0x49B7E97: g_main_context_dispatch ()
>     by 0x49B8287: ??? ()
>     by 0x49B8581: g_main_loop_run ()
>     by 0x120834: main (main.c:322)
>   Address 0x7300028 is 56 bytes inside a block of size 64 free'd
>     at 0x48369AB: free (vg_replace_malloc.c:530)
>     by 0x12A404: transfer_response (gobex-transfer.c:245)
>     by 0x126B02: handle_response (gobex.c:1128)
>     by 0x127087: incoming_data (gobex.c:1373)
>     by 0x49B7E97: g_main_context_dispatch ()
>     by 0x49B8287: ??? ()
>     by 0x49B8581: g_main_loop_run ()
>     by 0x120834: main (main.c:322)
>   Block was alloc'd at
>     at 0x4837B65: calloc (vg_replace_malloc.c:752)
>     by 0x49BD9D8: g_malloc0 ()
>     by 0x129A49: transfer_new (gobex-transfer.c:258)
>     by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:282)
>     by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:271)
>     by 0x145862: transfer_start_put (transfer.c:880)
>     by 0x145862: obc_transfer_start (transfer.c:911)
>     by 0x13B487: session_process_transfer (session.c:836)
>     by 0x13C128: session_process_queue (session.c:887)
>     by 0x13C128: session_process_queue (session.c:872)
>     by 0x13C18F: session_process (session.c:820)
>     by 0x49B7E97: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/)
>     by 0x49B8287: ??? (in /usr/lib/x86_64-linux-gnu/)
>     by 0x49B8581: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/)
>     by 0x120834: main (main.c:322)
> ---
>  gobex/gobex-transfer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c94d018b2..8e97fc73e 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -197,6 +197,14 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
>         }
>
>         rspcode = g_obex_packet_get_operation(rsp, &final);
> +       if (rspcode == G_OBEX_RSP_FORBIDDEN) {
> +               err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
> +                                               g_obex_strerror(rspcode));
> +               g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
> +               g_error_free(err);
> +               return;
> +       }

This is not quite right, in fact the if statement below already treat
such errors, we might be missing something like final:

/* Reset if final so it can no longer be cancelled */
if (final_rsp)
obex->pending_req = NULL;

This would be a problem on the remote implementation which is
indicating that perhaps it is just a temporary failure, anyway then:

id = transfer->req_id;
transfer->req_id = 0;

This resets the req_id so on transfer_free the following code is not run:

if (transfer->req_id > 0)
g_obex_cancel_req(transfer->obex, transfer->req_id, TRUE);

So either we have to restore the transfer->req_id = id or not reset it
to 0, so perhaps something like this works better:

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..8fae65d8d 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -200,6 +200,11 @@ static void transfer_response(GObex *obex, GError
*err, GObexPacket *rsp,
        if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
                err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
                                                g_obex_strerror(rspcode));
+               /* If not marked as final response but transfer_complete gonna
+                * be called restore the req_id so it can be properly cancelled
+                */
+               if (!final)
+                       transport->req_id = id;
                goto failed;
        }

> +
>         if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
>                 err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
>                                                 g_obex_strerror(rspcode));
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
