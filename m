Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F081DDC21
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125476; cv=none; b=UDcI+amJjjLyMwrqPKnG2c/diF69Ann/nE0mx7venkCpS96prbb7BFWhm9j2KYKmBLQUJX1ybE3+mNe15/iAzp1DRvxuW1W7AKvi1KNmYeNRYYlNOJiPP9HwWs7bLgVyM44fupTXjwP0/MhmFKw2Sm8KbPcK2wmu2UQ0LmhHzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125476; c=relaxed/simple;
	bh=bXBeY66PrGGkOF/hIu07LpuPvXueBs7w89zuY6XhgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7v4kOsQvsNwShG2CLOqk8nOBw2EYM2EQlzHnHrMdenpNRkMe9RuDu1LJVJQcuqFn5Au8N0spejazG22wXr/OxZPSOvl3/Kq5k/PkKOeoq+zivI5jC7/T+I8Idu1/sgyJROy+u7HzDBRTL34FYh6La797Z8i6JMFAKD67Qm2Ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfqmJaDW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfqmJaDW"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso65181751fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730125471; x=1730730271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCtV0Xmq71cdc2vHDAqYuTLaSZgPSSsRkRdwJOxkMsA=;
        b=ZfqmJaDWs4qF3baIin8+7CLsgxrm5JMfgbKBi7X+N34ECA2tf7nz2HeFEzd09TAgIZ
         G3TUtUbn2xGJEfHo2QO+R7Bo+gFu1ftCvfIbRUprjEs0IZFz1Ip9mUkkDmDiGuKzZMlG
         chFTscsmIxV7NdjvmHUsN7OqhNs5ZV+uIi6HZUJLfysjA3TPdlpm008kc+9VnxRvQLpv
         wORLGmBd50SpkkzrlSWQUeGOUDwgMQE5sGFph3C0BNGqLlsmNuYN1BBj+JiiMVK0pf4Q
         4kmpjOqiPlf/2xWhj9eQq/gzZuIv89BbdF0MCmQ0cNJyZlwakqtjuv73UJguD0Lh3HwK
         CMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125471; x=1730730271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCtV0Xmq71cdc2vHDAqYuTLaSZgPSSsRkRdwJOxkMsA=;
        b=c97twzOWKqyliuOK6yBsechYHtt43vT6QOWnKOi2r+B9H7po9oxxA0Lb3ranF/0/S+
         jcYHaYtdLAtDS/sxAQHd4U7QzHIEH0+OgU/tBDxT8vSpYVLhmQ8Kh6zcuBmXrUGYXLSP
         hm/XyzdCPIQykMSH6CAN6CSnFwvmOJ6NxnD7/fU5HtyvIv1Q/zd2sT+7phcVzIankdxq
         CZuoSYrmA3vKf32BY98R5dYiXodcRR/tp08oao1hbAyKk9WqICxeLAW0+1/y87RqoWXO
         grbXiZ6gkjSEPeG65pmCrPbEla9k+STJ3YSXXEiXiGfKtDVfNMLtSmiK3v+4bbBm1RWU
         nmug==
X-Gm-Message-State: AOJu0YyGQTaIFkJAnTA2MoHEaZU/5XeqUBaEwAI41snRD/IFMZzw/KaG
	tJZla8dYNUuH1nPZPQ3bdC3DQQ22SQja581BoHJIBLp6V/RX2bGKJS+z5UMLpxNExXxK1lEGybG
	M/0wgAqML7VPuiIYkPEsCgqOUVzRQdQ==
X-Google-Smtp-Source: AGHT+IGngu1nzS9B+v2TDM5MunAIkWvPYbDGFIDiezBqt/O36idLNDoZmunqesvCCxCIvcmT5CFNNtamf1SnOHK+z+4=
X-Received: by 2002:a2e:812:0:b0:2fa:fcf0:7c2a with SMTP id
 38308e7fff4ca-2fcbdfc8855mr50983491fa.24.1730125471006; Mon, 28 Oct 2024
 07:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com> <20241026191434.556716-2-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20241026191434.556716-2-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 10:24:18 -0400
Message-ID: <CABBYNZJk9jrmHwAgCR4LH2Y7+M9GWNdgSFqC7K9YtEGVDZ1QTw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] transport: Allow to set A2DP transport delay property
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Sat, Oct 26, 2024 at 3:15=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> In order to properly synchronize audio/video playback it is required to
> report audio delay to the A2DP source. This commit allows connected
> media application to update the Delay property of the A2DP transport
> which will inform remote source about the playback delay.
>
> The functionality was tested by streaming audio between two hosts
> running BlueZ Bluetooth stack.
> ---
>  doc/org.bluez.MediaTransport.rst |  2 +-
>  profiles/audio/transport.c       | 87 +++++++++++++++++++++++++++++---
>  2 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 5da13b3b5..310a69c6f 100644
> --- a/doc/org.bluez.MediaTransport.rst
> +++ b/doc/org.bluez.MediaTransport.rst
> @@ -125,7 +125,7 @@ uint16 Delay [readwrite, optional]
>
>         Transport delay in 1/10 of millisecond.
>         This property is available only if the DelayReporting is true and=
 is
> -       writeable only when the transport was acquired by the sender.
> +       writeable only when the transport corresponds to a sink endpoint.

I don't think we should allow changes to the Delay by any application
since this might introduce problems to the streaming, so Id say this
policy should stay, if you are trying to control this via bluetoothctl
then also acquire the stream via bluetoothctl.

>  uint16 Volume [readwrite, optional]
>  ```````````````````````````````````
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index dd6878427..be34cc899 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -116,6 +116,7 @@ struct media_transport_ops {
>         void *(*get_stream)(struct media_transport *transport);
>         int8_t (*get_volume)(struct media_transport *transport);
>         int (*set_volume)(struct media_transport *transport, int8_t level=
);
> +       int (*set_delay)(struct media_transport *transport, uint16_t dela=
y);
>         void (*update_links)(const struct media_transport *transport);
>         GDestroyNotify destroy;
>  };
> @@ -551,6 +552,36 @@ static int transport_a2dp_snk_set_volume(struct medi=
a_transport *transport,
>         return avrcp_set_volume(transport->device, level, notify);
>  }
>
> +static int transport_a2dp_snk_set_delay(struct media_transport *transpor=
t,
> +                                       uint16_t delay)
> +{
> +       struct a2dp_transport *a2dp =3D transport->data;
> +       struct avdtp_stream *stream;
> +
> +       if (a2dp->delay =3D=3D delay)
> +               return 0;
> +
> +       if (a2dp->session =3D=3D NULL) {
> +               a2dp->session =3D a2dp_avdtp_get(transport->device);
> +               if (a2dp->session =3D=3D NULL)
> +                       return -EIO;
> +       }
> +
> +       stream =3D media_transport_get_stream(transport);
> +       if (stream =3D=3D NULL)
> +               return -EIO;
> +
> +       if (a2dp->watch) {
> +               a2dp->delay =3D delay;
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                               transport->path,
> +                                               MEDIA_TRANSPORT_INTERFACE=
,
> +                                               "Delay");
> +       }
> +
> +       return avdtp_delay_report(a2dp->session, stream, delay);
> +}
> +
>  static void media_owner_exit(DBusConnection *connection, void *user_data=
)
>  {
>         struct media_owner *owner =3D user_data;
> @@ -900,6 +931,47 @@ static gboolean get_delay_report(const GDBusProperty=
Table *property,
>         return TRUE;
>  }
>
> +static int media_transport_set_delay(struct media_transport *transport,
> +                                       uint16_t delay)
> +{
> +       DBG("Transport %s delay %d", transport->path, delay);
> +
> +       if (transport->ops && transport->ops->set_delay)
> +               return transport->ops->set_delay(transport, delay);
> +
> +       return 0;
> +}
> +
> +static void set_delay_report(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, GDBusPendingProper=
tySet id,
> +                               void *data)
> +{
> +       struct media_transport *transport =3D data;
> +       uint16_t arg;
> +       int err;

This really needs to check that sender is the owner of the transport.

> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_UINT16) {
> +               g_dbus_pending_property_error(id,
> +                               ERROR_INTERFACE ".InvalidArguments",
> +                               "Expected UINT16");
> +               return;
> +       }
> +
> +       dbus_message_iter_get_basic(iter, &arg);
> +
> +       err =3D media_transport_set_delay(transport, arg);
> +       if (err) {
> +               error("Unable to set delay: %s (%d)", strerror(-err), err=
);
> +               g_dbus_pending_property_error(id,
> +                                               ERROR_INTERFACE ".Failed"=
,
> +                                               "Internal error %s (%d)",
> +                                               strerror(-err), err);
> +               return;
> +       }
> +
> +       g_dbus_pending_property_success(id);
> +}
> +
>  static gboolean volume_exists(const GDBusPropertyTable *property, void *=
data)
>  {
>         struct media_transport *transport =3D data;
> @@ -1036,7 +1108,7 @@ static const GDBusPropertyTable transport_a2dp_prop=
erties[] =3D {
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
>         { "DelayReporting", "b", get_delay_reporting },
> -       { "Delay", "q", get_delay_report, NULL, delay_reporting_exists },
> +       { "Delay", "q", get_delay_report, set_delay_report, delay_reporti=
ng_exists },
>         { "Volume", "q", get_volume, set_volume, volume_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> @@ -2196,7 +2268,7 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>
>  #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>                       _resume, _suspend, _cancel, _set_state, _get_stream=
, \
> -                     _get_volume, _set_volume, _update_links, _destroy) =
\
> +                     _get_volume, _set_volume, _set_delay, _update_links=
, _destroy) \
>  { \
>         .uuid =3D _uuid, \
>         .properties =3D _props, \
> @@ -2210,16 +2282,17 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>         .get_stream =3D _get_stream, \
>         .get_volume =3D _get_volume, \
>         .set_volume =3D _set_volume, \
> +       .set_delay =3D _set_delay, \
>         .update_links =3D _update_links, \
>         .destroy =3D _destroy \
>  }
>
> -#define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> +#define A2DP_OPS(_uuid, _init, _set_volume, _set_delay, _destroy) \
>         TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init=
, \
>                         transport_a2dp_resume, transport_a2dp_suspend, \
>                         transport_a2dp_cancel, NULL, \
>                         transport_a2dp_get_stream, transport_a2dp_get_vol=
ume, \
> -                       _set_volume, NULL, _destroy)
> +                       _set_volume, _set_delay, NULL, _destroy)
>
>  #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links,=
 \
>                 _set_state) \
> @@ -2227,7 +2300,7 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>                         transport_bap_init, \
>                         transport_bap_resume, transport_bap_suspend, \
>                         transport_bap_cancel, _set_state, \
> -                       transport_bap_get_stream, NULL, NULL, _update_lin=
ks, \
> +                       transport_bap_get_stream, NULL, NULL, NULL, _upda=
te_links, \
>                         transport_bap_destroy)
>
>  #define BAP_UC_OPS(_uuid) \
> @@ -2245,14 +2318,16 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>                         transport_asha_resume, transport_asha_suspend, \
>                         transport_asha_cancel, NULL, NULL, \
>                         transport_asha_get_volume, transport_asha_set_vol=
ume, \
> -                       NULL, NULL)
> +                       NULL, NULL, NULL)
>
>  static const struct media_transport_ops transport_ops[] =3D {
>         A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
>                         transport_a2dp_src_set_volume,
> +                       NULL,
>                         transport_a2dp_src_destroy),
>         A2DP_OPS(A2DP_SINK_UUID, transport_a2dp_snk_init,
>                         transport_a2dp_snk_set_volume,
> +                       transport_a2dp_snk_set_delay,
>                         transport_a2dp_snk_destroy),
>         BAP_UC_OPS(PAC_SOURCE_UUID),
>         BAP_UC_OPS(PAC_SINK_UUID),
> --
> 2.39.5
>
>


--=20
Luiz Augusto von Dentz
