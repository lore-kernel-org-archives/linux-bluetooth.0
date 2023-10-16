Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C4CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjJPRHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjJPRHY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:07:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B151730
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:05:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso33827781fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697475946; x=1698080746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMmQ1XM/tfeoRy7kS7mGhqo9rIvkstFPQCOPcoIFSyU=;
        b=jFppFaHX8gfUxZvEJvm0dbivbMpstab/ugQJckDYKtAS4IfjmNQ2IzxvETknRvufG2
         7yFBGXauHemxW++DOajH67kieupDT63ZNE3I12RQ3tH4xg7eJXeOoHtFDYxjeyrQe7C4
         bPpCeWpupI1AsUvKECiOX1WshnJoDvgGItKjPfZ1zRXfb0wlUeS4rEsGmg1SVaw2xvGl
         KX8mCNVdk89Uprr4Nms17I2OP/EwAIp9hFGRLaIIod1tBNOM3q/7QJEKS3nE+45Eewij
         V6vi1qPbxjOl2Ok1kvrNHHj7Bl4vJZ2UHGlbCq8RXrMBhN/BjAk5mRcziAsSqesfGiEp
         lVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475946; x=1698080746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMmQ1XM/tfeoRy7kS7mGhqo9rIvkstFPQCOPcoIFSyU=;
        b=MD+QruxtbuqU4tzg3LE0YnxmKustbTV0C+R6Jw8KwMh/pQtCRx3yXwBUx2M52w+nLO
         jp6Av+6vN0GQBhUmkeLv9oJes4JH1bCpuDE2QROkXefdYHvcP3F9VFqSNenJoyQoINuw
         Pslkk7qPU1IiR+PVKtMwz+6sF1/NOQ2nRaaZVZXiCpFuYvzoo9+5BQ3INUWWjUpPdAkA
         8Z5n5vtjh9j8h8e4lK2cUYzHvrFP/axUaqMoHMFkQtN4rItWAg16V0sUVE5WlZzDMziW
         f6MUvHIrwH80Vpf2LD4KzGMYryqYa6Rgdw0+B2oKmxoMLE/S28JR3EZzs8DO1N3o8rWa
         pC7g==
X-Gm-Message-State: AOJu0YzedV3zsTbX+0jipcV3MD7871Ptj94XoyvtkQScTfN6aPoIoz5Y
        7jNLEIQv5A123P/xyk/G5joJL9KR/XM2DEecaQg=
X-Google-Smtp-Source: AGHT+IEzuUT3fJSyw5trb5qv9Wap7Ft7cIqUgyDaaKmTI+NJyy6k1BTiLUblLxmxVhsxH+VHR6btYnKA6K8E2DEzRRg=
X-Received: by 2002:a05:651c:a11:b0:2c5:1037:b54d with SMTP id
 k17-20020a05651c0a1100b002c51037b54dmr8590133ljq.31.1697475945569; Mon, 16
 Oct 2023 10:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com> <20231016154900.3094-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20231016154900.3094-3-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Oct 2023 10:04:59 -0700
Message-ID: <CABBYNZ+jgKfE7f7M1K_3WFrTPvfBRewb5u_q5SC8HQtmiRXzDA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] shared/bass: Handle G_IO_HUP on io channels
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Mon, Oct 16, 2023 at 8:49=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds watches to handle closed sockets
>
> ---
>  src/shared/bass.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/bass.h |  2 ++
>  2 files changed, 61 insertions(+)
>
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> index 0ee3187d1..78103d463 100644
> --- a/src/shared/bass.c
> +++ b/src/shared/bass.c
> @@ -655,6 +655,11 @@ static void connect_cb(GIOChannel *io, GError *gerr,
>                 g_io_channel_unref(bcast_src->listen_io);
>                 bcast_src->listen_io =3D NULL;
>
> +               if (bcast_src->listen_io_id > 0) {
> +                       g_source_remove(bcast_src->listen_io_id);
> +                       bcast_src->listen_io_id  =3D 0;
> +               }
> +
>                 /* Close pa sync io */
>                 if (bcast_src->pa_sync_io) {
>                         g_io_channel_shutdown(bcast_src->pa_sync_io,
> @@ -663,6 +668,11 @@ static void connect_cb(GIOChannel *io, GError *gerr,
>                         bcast_src->pa_sync_io =3D NULL;
>                 }
>
> +               if (bcast_src->pa_sync_io_id > 0) {
> +                       g_source_remove(bcast_src->pa_sync_io_id);
> +                       bcast_src->pa_sync_io_id  =3D 0;
> +               }
> +
>                 for (i =3D 0; i < bcast_src->num_subgroups; i++)
>                         bcast_src->subgroup_data[i].bis_sync =3D
>                                 BT_BASS_BIG_SYNC_FAILED_BITMASK;
> @@ -703,6 +713,18 @@ static bool bass_trigger_big_sync(struct bt_bcast_sr=
c *bcast_src)
>         return false;
>  }
>
> +static gboolean pa_sync_io_disconnect_cb(GIOChannel *io, GIOCondition co=
nd,
> +                       gpointer data)
> +{
> +       struct bt_bcast_src *bcast_src =3D data;
> +
> +       DBG(bcast_src->bass, "PA sync io has been disconnected");
> +
> +       bcast_src->pa_sync_io_id =3D 0;
> +       bcast_src->pa_sync_io =3D NULL;
> +
> +       return FALSE;
> +}
>
>  static void confirm_cb(GIOChannel *io, gpointer user_data)
>  {
> @@ -726,6 +748,15 @@ static void confirm_cb(GIOChannel *io, gpointer user=
_data)
>         bcast_src->pa_sync_io =3D io;
>         g_io_channel_ref(bcast_src->pa_sync_io);
>
> +       if (bcast_src->pa_sync_io_id > 0) {
> +               g_source_remove(bcast_src->pa_sync_io_id);
> +               bcast_src->pa_sync_io_id  =3D 0;
> +       }
> +
> +       bcast_src->pa_sync_io_id =3D g_io_add_watch(io, G_IO_ERR | G_IO_H=
UP |
> +                               G_IO_NVAL, (GIOFunc) pa_sync_io_disconnec=
t_cb,
> +                               bcast_src);
> +
>         len =3D sizeof(qos);
>         memset(&qos, 0, len);
>
> @@ -844,6 +875,19 @@ static bool bass_validate_add_src_params(uint8_t *va=
lue, size_t len)
>         return true;
>  }
>
> +static gboolean listen_io_disconnect_cb(GIOChannel *io, GIOCondition con=
d,
> +                       gpointer data)
> +{
> +       struct bt_bcast_src *bcast_src =3D data;
> +
> +       DBG(bcast_src->bass, "Listen io has been disconnected");
> +
> +       bcast_src->listen_io_id =3D 0;
> +       bcast_src->listen_io =3D NULL;
> +
> +       return FALSE;
> +}
> +
>  static void bass_handle_add_src_op(struct bt_bass *bass,
>                                         struct gatt_db_attribute *attrib,
>                                         uint8_t opcode,
> @@ -1023,6 +1067,11 @@ static void bass_handle_add_src_op(struct bt_bass =
*bass,
>                 bcast_src->listen_io =3D io;
>                 g_io_channel_ref(bcast_src->listen_io);
>
> +               bcast_src->listen_io_id =3D g_io_add_watch(io, G_IO_ERR |
> +                                       G_IO_HUP | G_IO_NVAL,
> +                                       (GIOFunc)listen_io_disconnect_cb,
> +                                       bcast_src);

IO handling shall probably be kept outside of shared so we could
emulate it with use of socketpairs and unit test it, see how it was
done for bap.

>                 if (num_bis > 0 && !bcast_src->bises)
>                         bcast_src->bises =3D queue_new();
>         } else {
> @@ -1318,11 +1367,21 @@ static void bass_bcast_src_free(void *data)
>                 g_io_channel_unref(bcast_src->listen_io);
>         }
>
> +       if (bcast_src->listen_io_id > 0) {
> +               g_source_remove(bcast_src->listen_io_id);
> +               bcast_src->listen_io_id  =3D 0;
> +       }
> +
>         if (bcast_src->pa_sync_io) {
>                 g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
>                 g_io_channel_unref(bcast_src->pa_sync_io);
>         }
>
> +       if (bcast_src->pa_sync_io_id > 0) {
> +               g_source_remove(bcast_src->pa_sync_io_id);
> +               bcast_src->pa_sync_io_id  =3D 0;
> +       }
> +
>         queue_destroy(bcast_src->bises, bass_bis_unref);
>
>         free(bcast_src);
> diff --git a/src/shared/bass.h b/src/shared/bass.h
> index c4b5b76ba..bd3fe900b 100644
> --- a/src/shared/bass.h
> +++ b/src/shared/bass.h
> @@ -57,7 +57,9 @@ struct bt_bcast_src {
>         uint8_t num_subgroups;
>         struct bt_bass_subgroup_data *subgroup_data;
>         GIOChannel *listen_io;
> +       guint listen_io_id;
>         GIOChannel *pa_sync_io;
> +       guint pa_sync_io_id;
>         struct queue *bises;
>  };
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
