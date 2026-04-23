Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324B34750D
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964124; cv=pass; b=A28E1IZLRgEEi+C/EZYm4yfHO+yKe6JXNzdkKEcy3JC/hMWCFXeZqs+99QFpWok0K558wJBR3PzFLRcNb2F6/8ivJXBU9G4QaIruhvEzt/jExcLZHe9OUwxTMFu3qVTb1DwC8i2PvROp7ThT2ac46yszjYxnlIbPrFHGkLzc+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964124; c=relaxed/simple;
	bh=yqKk1Njb2r1fpuOHLtK+HIerhSz4IRCd0gd4TKf1sxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqW3RTI0ct39lpSgrT7W3SWYY91tS5ut+oAaZLnz1K28PrAX5+ji2qQfmfFRUY9PF6rKkZ0hmXFgTY0KfuNwab/vraBtjjc8Ewq0eLuK72LhJPOyustC1OQwRJUKWwO8geXQIK2b15ybvX4APkVAFwFV32jcJa9BYHb2EAj+PNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr4WKfTF; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr4WKfTF"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501d242e2fso6340524d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776964119; cv=none;
        d=google.com; s=arc-20240605;
        b=OHDfbV61/YXdzXQyPy4cr3Kuk2IidEMSLcC4n3XrfncrfDRXGDy32bnXwIuVwZJh95
         JmHrxAY7QNElC8dHVBRnkvJEYgr5mYPoSdvsIxZ0rgrlj7/uz0TIbLTYEwBL+uKBMMy2
         wUP2ryMUxEOPWXzChEkNt4HINSSfBGmVlLAxu17GI1yp0ngLEMEsT07RSEcGCOXtWqdI
         GiRVbi8FcrJi866xQn+imC3MZOAvRCRLZDXyN4Ikm/Mr46Up5UkG879tbPdaU042Eqdn
         qkw1a77zItyHzla/5+Pk/KTD1/I3NiTLIps8I1hO46peP3xno8tqmd9v3npIgGyeTh43
         Fw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCgcRbz5d1rQXHBkMIhcV7pCI1JDIIFc1ABzb4bjmSU=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=UscWDT5HuO8WySAxwbARwWHYM1pfG7zjd2TrdppoxOVLHPBrHnat37TFwi1fGhFLpf
         ccWmiywk+zLTjJByS6WLgutoTGZNnS8TyIDcIEeEn9pLVOwzy0qSJchwZo+PEQ9vu8ze
         rUcmltZgEFmXSQQFfBkasUqlW091bVAB9W4MqSIz05NtsHaM8seLr+CWNFrHV+5414ck
         +TRvzW/N0YYMTwQt85qy31YlGmqkvHJNgbkbvfzrto8CO9QJZwg3h4Ph1DBPOfz6Dis7
         dHaxz7LX2vCTsEu3UiFp3NZzI9QyDLjgxwaKC0VtBs8+7dBynADTy2zwh2dKamMf3sYY
         oldw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776964119; x=1777568919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCgcRbz5d1rQXHBkMIhcV7pCI1JDIIFc1ABzb4bjmSU=;
        b=Cr4WKfTFOVf35SyhlMAlEm0oWoAFg46iOIFSjJTN5SdYn9EV75fDzkpUGpLsvh1UUC
         GCGFWDs9Guj3mpxKFBlL8TY3Nw68oAWVpUjqLrLPcjb+Xkn0i6qqG5vlY9fl6sR840O5
         CiHE7eqtSj+wcs35Luo5OMhH0Zo+FTZkH58bimit0sUxgIOInxzg5DY5yfb5OscKh7u9
         4499iSu+lh+b/ph2Pu2yZTuiQMyqvlCUiqf5K4LbmnDGYjiWpj1Hd5B4514z1noeUB3x
         D+uQRrtEcgdRWoO4Zr1sDMRcFFnkUXdfvjeZ4YoDDitJFk8GfgG0bwdAULqfj2ZsZX/M
         TMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776964119; x=1777568919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCgcRbz5d1rQXHBkMIhcV7pCI1JDIIFc1ABzb4bjmSU=;
        b=GEV3k2DO5UHAq6d5NwSaeSpm8LPZRlgniVD3zwFMG8olIkiEmk6/zLxdfQBQ+zZ/Ke
         aXa9rpb9KRIJi2imFfSI5USAIhoDYNGbGC1Io6QCN5++tQlvzYBfVzWf1AY93D8OgXXf
         zx/vUA9Y5idlHJmMLEkOwV57Ubh96Sj7PEdXtMwu9Wv7X9qyiGl6xkG1qvLRXN5pcysO
         6EC5UgKTr3WWLZWr3GsfTrGQxRM8W0jBwair2C4qsx4p5dUXndbUUKEeCZlC8EENm84W
         YpH0L7ChisBIQ9HlgT7ePbFlDX9uYyVzhaM/mgs5DzjbGV/VnbPmub64sz5zcXQ54TRl
         YF4g==
X-Gm-Message-State: AOJu0YytrPXo5cNNhnB1me/jQQDHtn+O4AnOAVyzXXOtjnMb3rmSPQlw
	zl6ZzMhlvlnQv5jqd2+nVSxDcqnbsxEO1lYkYaSXV1jSxB2phWXA74P5DcOtV283UiCfi7r5+l3
	XkZI2Bx7flGM2NUSyRC6EvjhC+hgJ8tektlqUDF4=
X-Gm-Gg: AeBDies7DF5JVLemkEh76wpnAeO6fCdfhpFsyCNwQBbLwsyKXrnTiOn26hLJFNm8ylz
	YF5vj7dRq5LHEI+YS2x8+AEJqCmQ7ctjcpj3JoQhG9H3RzsP6z/3j5ssuzy5oDUevudxzwhozeg
	3FIRLmMAk2D16MBRUgC/3i6R/LXN278KUxpZGobJHf9i19rHVDFmu5aLWe6Sq9Os7D9ZEwEWK9b
	4ddc7YCIDcDufLpuE58UCNjyF+gYxhvT5nTDfdj46W7WMW9IbpfbrjOtl7RpzHGPORV8b2r9Rhr
	NI+N14Z6fcCtowgpMKaGidp3x3CZL2TM1kgC35k4yhi+awFlFnL1JRNyiKvUCjhuM3X5c5vk1EF
	IOizj
X-Received: by 2002:a53:ea47:0:b0:650:77f4:64e with SMTP id
 956f58d0204a3-65310a309d3mr19179917d50.50.1776964119104; Thu, 23 Apr 2026
 10:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423075309.493820-1-frederic.danis@collabora.com>
In-Reply-To: <20260423075309.493820-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Apr 2026 13:08:27 -0400
X-Gm-Features: AQROBzBLRy_bUG3su-Uu_t6q26g2Izd6iTQpz1bY0xIsmcrJmhNJphWVWpEy54g
Message-ID: <CABBYNZKiNU88wK+oMT2Q7nKOr7NsngFD4+C35-agcbntJXsJ2g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] audio: Add ability to force CIS transport
 Links property
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Thu, Apr 23, 2026 at 3:53=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> If bluetoothd is started in testing mode the Links property for CIS
> is readwrite and can be used to force transport objects Links.
> This can used to unlink transport objects by sending an empty array.
>
> For unlinked transport objects, each transports needs to be acquired
> separately.
>
> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
> ---
> v1 -> v2:
>   - Add testing mode check in bap_connect_io_cb()
>   - Replace stream state check by checking that the stream is not linked
>     before passing the connect event to all streams belonging to same
>     CIG/CIS.
>
>  profiles/audio/bap.c       | 46 ++++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
>  2 files changed, 95 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 5333267f7..e20456436 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -2655,13 +2655,61 @@ static void bap_connect_bcast_io_cb(GIOChannel *c=
han, GError *err,
>         iso_connect_bcast_cb(chan, err, setup->stream);
>  }
>
> +struct connect_io_data {
> +       GIOChannel *chan;
> +       GError *err;
> +       uint8_t cig_id;
> +       uint8_t cis_id;
> +};
> +
> +static void connect_stream(void *data, void *user_data)
> +{
> +       struct bap_setup *setup =3D data;
> +       struct connect_io_data *d =3D user_data;
> +       uint8_t state;
> +
> +       /* Check stream state to only pass the connect event managed
> +        * by bap_stream_set_io() */
> +       state =3D bt_bap_stream_get_state(setup->stream);
> +       if ((state =3D=3D BT_BAP_STREAM_STATE_ENABLING ||
> +                       state =3D=3D BT_BAP_STREAM_STATE_DISABLING) &&
> +                       setup->qos.ucast.cig_id =3D=3D d->cig_id &&
> +                       setup->qos.ucast.cis_id =3D=3D d->cis_id)
> +               iso_connect_cb(d->chan, d->err, setup->stream);

From the discussion we had Ive assume we wouldn't be checking the
state here, since we don't check on bap_connect_io_cb either.

> +}
> +
> +static void connect_ep(void *data, void *user_data)
> +{
> +       struct bap_ep *ep =3D data;
> +
> +       if (ep->setups)
> +               queue_foreach(ep->setups, connect_stream, user_data);
> +}
> +
>  static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer us=
er_data)
>  {
>         struct bap_setup *setup =3D user_data;
> +       struct connect_io_data data;
>
>         if (!setup->stream)
>                 return;
>
> +       if (queue_isempty(bt_bap_stream_io_get_links(setup->stream)) &&
> +               btd_opts.testing) {
> +               /* The stream may have manually been unliked for PTS test=
s,
> +                * e.g. BAP/UCL/STR/BV-543-C or BAP/UCL/STR/BV-546-C,
> +                * in this case send the connect event to all streams
> +                * belonging to the same CIG/CIS.
> +                */
> +               data.chan =3D chan;
> +               data.err =3D err;
> +               data.cig_id =3D setup->qos.ucast.cig_id;
> +               data.cis_id =3D setup->qos.ucast.cis_id;
> +               queue_foreach(setup->ep->data->snks, connect_ep, &data);
> +               queue_foreach(setup->ep->data->srcs, connect_ep, &data);
> +               return;
> +       }
> +
>         iso_connect_cb(chan, err, setup->stream);
>  }
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 5c2a2777e..b6a5dd1fd 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -37,6 +37,7 @@
>  #include "src/shared/bap.h"
>  #include "src/shared/bass.h"
>  #include "src/shared/io.h"
> +#include "src/btd.h"
>
>  #ifdef HAVE_A2DP
>  #include "avdtp.h"
> @@ -114,6 +115,7 @@ struct bap_transport {
>  struct media_transport_ops {
>         const char *uuid;
>         const GDBusPropertyTable *properties;
> +       const GDBusPropertyTable *test_properties;
>         void (*set_owner)(struct media_transport *transport,
>                                 struct media_owner *owner);
>         void (*remove_owner)(struct media_transport *transport,
> @@ -1419,6 +1421,9 @@ static struct media_transport *find_transport_by_pa=
th(const char *path)
>         return NULL;
>  }
>
> +static void bap_update_links(const struct media_transport *transport);
> +static void transport_unlink(void *data, void *user_data);
> +
>  static void set_links(const GDBusPropertyTable *property,
>                                 DBusMessageIter *iter,
>                                 GDBusPendingPropertySet id, void *user_da=
ta)
> @@ -1436,6 +1441,16 @@ static void set_links(const GDBusPropertyTable *pr=
operty,
>
>         dbus_message_iter_recurse(iter, &array);
>
> +       if (dbus_message_iter_get_arg_type(&array) =3D=3D DBUS_TYPE_INVAL=
ID) {
> +               struct queue *links =3D bt_bap_stream_io_get_links(bap->s=
tream);
> +
> +               /* Unlink stream from all its links */
> +               queue_foreach(links, transport_unlink, bap->stream);
> +
> +               bt_bap_stream_io_unlink(bap->stream, NULL);
> +               bap_update_links(transport);
> +       }
> +
>         while (dbus_message_iter_get_arg_type(&array) =3D=3D
>                                                 DBUS_TYPE_OBJECT_PATH) {
>                 struct media_transport *link;
> @@ -1486,6 +1501,21 @@ static const GDBusPropertyTable transport_bap_uc_p=
roperties[] =3D {
>         { }
>  };
>
> +static const GDBusPropertyTable transport_bap_uc_test_properties[] =3D {
> +       { "Device", "o", get_device },
> +       { "UUID", "s", get_uuid },
> +       { "Codec", "y", get_codec },
> +       { "Configuration", "ay", get_configuration },
> +       { "State", "s", get_state },
> +       { "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
> +       { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
> +       { "Location", "u", get_location },
> +       { "Metadata", "ay", get_metadata, set_metadata },
> +       { "Links", "ao", get_links, set_links, links_exists },
> +       { "Volume", "q", get_volume, set_volume, volume_exists },
> +       { }
> +};
> +
>  static gboolean get_bcast_qos(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -1884,8 +1914,6 @@ static void bap_resume_complete(struct media_transp=
ort *transport)
>         transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
>  }
>
> -static void bap_update_links(const struct media_transport *transport);
> -
>  static bool match_link_transport(const void *data, const void *user_data=
)
>  {
>         const struct bt_bap_stream *stream =3D data;
> @@ -2540,10 +2568,11 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>  #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>                       _resume, _suspend, _cancel, _set_state, _get_stream=
, \
>                       _get_volume, _set_volume, _set_delay, _update_links=
, \
> -                     _destroy) \
> +                     _destroy, _test_props) \
>  { \
>         .uuid =3D _uuid, \
>         .properties =3D _props, \
> +       .test_properties =3D _test_props, \
>         .set_owner =3D _set_owner, \
>         .remove_owner =3D _remove_owner, \
>         .init =3D _init, \
> @@ -2565,26 +2594,28 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>                         transport_a2dp_resume, transport_a2dp_suspend, \
>                         transport_a2dp_cancel, NULL, \
>                         transport_a2dp_get_stream, transport_a2dp_get_vol=
ume, \
> -                       _set_volume, _set_delay, NULL, _destroy)
> +                       _set_volume, _set_delay, NULL, _destroy, NULL)
>
>  #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links,=
 \
> -               _set_state) \
> +               _set_state, _test_props) \
>         TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
>                         transport_bap_init, \
>                         transport_bap_resume, transport_bap_suspend, \
>                         transport_bap_cancel, _set_state, \
>                         transport_bap_get_stream, transport_bap_get_volum=
e, \
>                         transport_bap_set_volume, NULL, \
> -                       _update_links, transport_bap_destroy)
> +                       _update_links, transport_bap_destroy, _test_props=
)
>
>  #define BAP_UC_OPS(_uuid) \
>         BAP_OPS(_uuid, transport_bap_uc_properties, \
>                         transport_bap_set_owner, transport_bap_remove_own=
er, \
> -                       transport_bap_update_links_uc, transport_bap_set_=
state)
> +                       transport_bap_update_links_uc, \
> +                       transport_bap_set_state, \
> +                       transport_bap_uc_test_properties)
>
>  #define BAP_BC_OPS(_uuid) \
>         BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
> -                       transport_bap_update_links_bc, NULL)
> +                       transport_bap_update_links_bc, NULL, NULL)
>
>  #define ASHA_OPS(_uuid) \
>         TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
> @@ -2592,7 +2623,7 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>                         transport_asha_resume, transport_asha_suspend, \
>                         transport_asha_cancel, NULL, NULL, \
>                         transport_asha_get_volume, transport_asha_set_vol=
ume, \
> -                       NULL, NULL, NULL)
> +                       NULL, NULL, NULL, NULL)
>
>  static const struct media_transport_ops transport_ops[] =3D {
>  #ifdef HAVE_A2DP
> @@ -2647,6 +2678,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>         struct media_transport *transport;
>         const struct media_transport_ops *ops;
>         int fd;
> +       const GDBusPropertyTable *properties;
>
>         transport =3D g_new0(struct media_transport, 1);
>         if (device)
> @@ -2701,9 +2733,14 @@ struct media_transport *media_transport_create(str=
uct btd_device *device,
>                         goto fail;
>         }
>
> +       if (btd_opts.testing && ops->test_properties)
> +               properties =3D ops->test_properties;
> +       else
> +               properties =3D ops->properties;
> +
>         if (g_dbus_register_interface(btd_get_dbus_connection(),
>                                 transport->path, MEDIA_TRANSPORT_INTERFAC=
E,
> -                               transport_methods, NULL, ops->properties,
> +                               transport_methods, NULL, properties,
>                                 transport, media_transport_free) =3D=3D F=
ALSE) {
>                 error("Could not register transport %s", transport->path)=
;
>                 goto fail;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
