Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFBC7EE24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjE3RgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjE3RgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 13:36:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93298
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 10:36:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af28303127so51122151fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468160; x=1688060160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EHSHTG3ryobBkOVVlD+DyftTcI7uhZPu2kaKmFGP9U=;
        b=HJ1zgTWZ1DQi5zAY7fMsI6WpmyN9Jh2EsvO7Wm/gSceFdxcHc2mnZur13CNeRVE/wZ
         w8EafMGdztfyCtoC4/hM7jrSuS9dUuYSccTK6nRpNOpBtUOXHdfuQRQ8CgXvXR8LINZU
         29eCSQdaT1h4UKYgWA9ORJU3NWyTO40EHbRQEGcy5DU/lc9fOhs6Ry30o1sZ6hcMyUFw
         fCw4zy2/TWv3M4c6cjAaYyGNLd3bTuxSeJRIXOM42Null8US41k1B+PEIYXaZknqnepj
         CYMzE5NQ9/ap2j/+nZLRjPteegw5LmWRmgY1oIvbZxbcIw2sDJjpYV/88nTXBEQ6V+cI
         HSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468160; x=1688060160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EHSHTG3ryobBkOVVlD+DyftTcI7uhZPu2kaKmFGP9U=;
        b=MG439vxj6UaeWwJD1xRNflJ6YR6Ywjgzk/WMP9TmVIxjpsx/jUmEmWQK3IkJ0jelKo
         HEdEU180rLPtFFP0+pmIlL6RIA8mCvnPX02QkxOwBnkwAMVzbR+j9V+HG7H2H4bodsQj
         2+wMc7jKdyxyJyXqISSJg5gvztJLSS+dnl9T7Db5oeGa319sPCC1vBVHEGZpc4QKUoXN
         Q1eCBlmyf5M6o7D3wcfG4gOS2G78Lbm2jJPwcJnEMuQSuXf4ZtSEGKt4jXbHLOfmRUkg
         1fwpswdcdPKPerrjytS8s7yi8UxL3GuwcoVEkqNFvSZPii0l3w0YVdyunAA8revdSkEJ
         y17A==
X-Gm-Message-State: AC+VfDyR6cOkshJkgMIIvKTh9tRr3eJoE4eLVv0w71qKNXjkM1i9qBj7
        T5cbn9nBUim6d5t5xJNJypuluCm3Oma4IzpLSsz1LwHQ
X-Google-Smtp-Source: ACHHUZ7moP/MUGTSzIQ1hySLnH9t26mTw2frL383wsXNhwUp4HenVe+FgfLJK58ceW8uegPDCEjEWrUBq4MHqvWfnMo=
X-Received: by 2002:a2e:93c7:0:b0:2ac:79df:cb49 with SMTP id
 p7-20020a2e93c7000000b002ac79dfcb49mr1067857ljh.27.1685468159963; Tue, 30 May
 2023 10:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
In-Reply-To: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 May 2023 10:35:47 -0700
Message-ID: <CABBYNZLzc4HYaHnaTjb8nnBw6Xhd+_-qJu+U3W6zL5sQX7rE+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: detach io for source ASEs at QoS
 when disabling
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, May 28, 2023 at 10:47=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> The Client may terminate a CIS when sink is in QOS and source in
> Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
> Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).
> On successful Receiver Stop Ready the Server shall transition the ASE
> back to QoS state (ASCS v1.0 Sec 5.6).
>
> It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
> Stop Ready command if CIS is already disconnected, and then gets stuck
> in disabling state. It works if CIS is disconnected after Receiver Stop
> Ready.
>
> For better compatibility, disconnect CIS only after the source ASE is
> back in the QoS state. This is what we also do with sinks.
>
> Link: https://github.com/bluez/bluez/issues/516
> ---
>  src/shared/bap.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index f194f466f..16a9cec5b 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1115,18 +1115,6 @@ static bool match_stream_io(const void *data, cons=
t void *user_data)
>         return stream->io =3D=3D io;
>  }
>
> -static void stream_stop_disabling(void *data, void *user_data)
> -{
> -       struct bt_bap_stream *stream =3D data;
> -
> -       if (stream->io || stream->ep->state !=3D BT_ASCS_ASE_STATE_DISABL=
ING)
> -               return;
> -
> -       DBG(stream->bap, "stream %p", stream);
> -
> -       bt_bap_stream_stop(stream, NULL, NULL);
> -}
> -
>  static bool bap_stream_io_detach(struct bt_bap_stream *stream)
>  {
>         struct bt_bap_stream *link;
> @@ -1145,9 +1133,6 @@ static bool bap_stream_io_detach(struct bt_bap_stre=
am *stream)
>                 /* Detach link if in QoS state */
>                 if (link->ep->state =3D=3D BT_ASCS_ASE_STATE_QOS)
>                         bap_stream_io_detach(link);
> -       } else {
> -               /* Links without IO on disabling state shall be stopped. =
*/
> -               queue_foreach(stream->links, stream_stop_disabling, NULL)=
;
>         }
>
>         stream_io_unref(io);
> @@ -1218,7 +1203,6 @@ static void bap_stream_state_changed(struct bt_bap_=
stream *stream)
>                 bap_stream_update_io_links(stream);
>                 break;
>         case BT_ASCS_ASE_STATE_DISABLING:
> -               bap_stream_io_detach(stream);
>                 break;
>         case BT_ASCS_ASE_STATE_QOS:
>                 if (stream->io && !stream->io->connecting)
> @@ -1252,8 +1236,8 @@ static void bap_stream_state_changed(struct bt_bap_=
stream *stream)
>                         bt_bap_stream_start(stream, NULL, NULL);
>                 break;
>         case BT_ASCS_ASE_STATE_DISABLING:
> -               if (!bt_bap_stream_get_io(stream))
> -                       bt_bap_stream_stop(stream, NULL, NULL);
> +               /* IO is detached when back in QOS */
> +               bt_bap_stream_stop(stream, NULL, NULL);
>                 break;

Note that doing this way makes our peripheral/server role detach by
itself because it will end up calling stream_stop, so perhaps we need
to add a check if we acting as a client or not, that said if we do it
late don't we risk the server not sending QOS until ISO is dropped? So
perhaps we also need to detect that somehow and drop the ISO socket if
the peripheral stays on DISABLING for too long (e.g. 2 sec) after
stop.

>         }
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
