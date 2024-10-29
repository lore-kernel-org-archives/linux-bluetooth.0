Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F421DDA2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230750; cv=none; b=rXSpeacE6nndt3ZvDCafqoyrLsiEhA64u+K3+3CIkybfUOLyH5j7cxhtU4ubclN6SdB8MKfEuHLuhFmazyaFW930RdFI8r0JyDUxHAPSv8EAVKWsibQdEmnqbmFj2CzEJX9vjQ8Xdc+ZK+Zn/YriZfrhaNuW40ZlnzJZvuvgwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230750; c=relaxed/simple;
	bh=7fOCqvX8WXyMaW9vPqKu44v65gxdeYI0QuXIi8uDeBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWjgdi020oiShLrOtaqWHbhn81xPUET+2OSCO1CD+GcLsb+9VraK3/dZw2y9HUqCgKMLCWhxhlY4RALHChqO2t0QRKwPZzKghidIKYPNdqizkKKn87NzoEXwUk+zJ58uZZz9I1GzZPcuIsYxEsDSehJFIldoDRohlays/3EC/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrRfFxWA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrRfFxWA"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so52689861fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730230745; x=1730835545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBbFrKFvcyOhi8cDFH/fXl+p9UBsYi92mnRFUM53Iik=;
        b=GrRfFxWARdujIjb6wxDSxU12VYpD2R9+/eNOF5l801dLINB3egQeCjvf4XP7o+GFLe
         s29Gc1ce39kG+VPHXDwwavx1yGhzQsSG0vXqOP03KDifxf/3f05UYE8qw40AKraL5nzj
         P/kH6VAuAbETLEa3RR8t0sCLNkrm3c4KgsQl6W+/3HSC+uJTdY5eKGvbuLW0Xw3RSB4t
         W+mV0Ng3syoZBn9VnwUAoPsBgiBRLSu06ff3bhw5SYAsExpUTiI7Hxey3jdeJjbDTeCF
         xVCr8RR/yU0BPK2zodVXTvN9X9sbh58DrY5TIpnK7wN/2VNgIr2kg7xEFqZ3w7sWEGja
         PVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230745; x=1730835545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBbFrKFvcyOhi8cDFH/fXl+p9UBsYi92mnRFUM53Iik=;
        b=g4ZuJVvBIN4RN4cuWj06XfT/GmVd7kS6Jw942MphsZUzi0AWvjm2XLZWg2YS4RagLA
         itJXHtUbvvUfpuvXxn8Heq9XWIqxBjqbJc8ZmqB4azPyXgAdhY8veVFXGaQLQQNqVc6v
         0wOOaTIhfBW8mTtnnSBW9S7WGSEkvcV1MOuO5644PSalV9al5jlBbU/C9TqVvUdxBz0B
         2Zlu4av9F867M5ah24aXWz2QYb/M8VbAR219jG+YbNwAwFu/yFwxAL5+85COw43RErwk
         da00GPM3L8uNqmxzHQEHefodK7VWorx9/2QF/bkI+nxJ83CB8PmuPKdN/L/74iQ/ooSM
         B/vA==
X-Gm-Message-State: AOJu0Yy9Gn5RAYxzLm1IDDTUJaV7tmkEewcgW8kbaQP58tST/IzmHV+t
	TQeQvvOWMhduQzJiV01BvNxDXL7Bi0s1W/k87IorC+H7+xWoU7FSAFKwze/eO4PLAGXSq2h0S1n
	Y6cYxhGsrJ0ImP9K4XoIT7zZd6Hel8Q==
X-Google-Smtp-Source: AGHT+IEAESCuVXybX97JIKeTB5i1HbdrzN1PwZOdD++bl3MIGfQ4nGZfKEiUz1KHIlwB8Bab5CZ2YhKSfrsuJe+kE7I=
X-Received: by 2002:a2e:b53b:0:b0:2fb:6110:c5d5 with SMTP id
 38308e7fff4ca-2fcbe096067mr46245731fa.43.1730230744867; Tue, 29 Oct 2024
 12:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGFh025H4pK9ddaWoGF4CMwv88OTONjBb3U=Cgsb-DU5ZKo3Xg@mail.gmail.com>
 <20241029190500.578032-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20241029190500.578032-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 15:38:52 -0400
Message-ID: <CABBYNZJyrKnWGcFb9k2YbucPub0hkhG-OH=RWEhdKPJKLVLfpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] transport: Allow to set A2DP transport delay property
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Tue, Oct 29, 2024 at 3:05=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> In order to properly synchronize audio/video playback it is required
> to report audio delay to the A2DP source. This commit allows connected
> media application to update the Delay property of the A2DP transport
> which will inform remote source about the playback delay.
>
> In case when the transport is not acquired, everyone is allowed to set
> the delay. However, when the transport is acquired only the owner can
> modify the delay. This restriction is here to prevent interference
> caused by 3rd party actors.
>
> The functionality was tested by streaming audio between two hosts
> running BlueZ Bluetooth stack.
> ---
>  doc/org.bluez.MediaTransport.rst |   3 +-
>  gdbus/gdbus.h                    |   1 +
>  gdbus/object.c                   |  33 +++++++---
>  profiles/audio/transport.c       | 103 ++++++++++++++++++++++++++++---
>  4 files changed, 124 insertions(+), 16 deletions(-)

Please split the changes of gdbus, doc and transport.

>
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 4838d69d0..78789bc80 100644
> --- a/doc/org.bluez.MediaTransport.rst
> +++ b/doc/org.bluez.MediaTransport.rst
> @@ -119,7 +119,8 @@ uint16 Delay [readwrite, optional]
>  ``````````````````````````````````
>
>         Transport delay in 1/10 of millisecond, this property is only wri=
teable
> -       when the transport was acquired by the sender.
> +       when the transport corresponds to a sink endpoint and it was acqu=
ired by
> +       the sender.
>
>  uint16 Volume [readwrite, optional]
>  ```````````````````````````````````
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index d7be17661..c1b182adb 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -308,6 +308,7 @@ guint g_dbus_add_properties_watch(DBusConnection *con=
nection,
>  gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
>  void g_dbus_remove_all_watches(DBusConnection *connection);
>
> +const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet i=
d);
>  void g_dbus_pending_property_success(GDBusPendingPropertySet id);
>  void g_dbus_pending_property_error_valist(GDBusPendingReply id,
>                         const char *name, const char *format, va_list arg=
s);
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 72d2d46e3..e40c7c5bc 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -430,28 +430,45 @@ static gboolean check_privilege(DBusConnection *con=
n, DBusMessage *msg,
>  static GDBusPendingPropertySet next_pending_property =3D 1;
>  static GSList *pending_property_set;
>
> +static int pending_property_data_compare_id(const void *data,
> +                                               const void *user_data)
> +{
> +       const struct property_data *propdata =3D data;
> +       const GDBusPendingPropertySet *id =3D user_data;
> +       return propdata->id - *id;
> +}
> +
>  static struct property_data *remove_pending_property_data(
>                                                 GDBusPendingPropertySet i=
d)
>  {
>         struct property_data *propdata;
>         GSList *l;
>
> -       for (l =3D pending_property_set; l !=3D NULL; l =3D l->next) {
> -               propdata =3D l->data;
> -               if (propdata->id !=3D id)
> -                       continue;
> -
> -               break;
> -       }
> -
> +       l =3D g_slist_find_custom(pending_property_set, &id,
> +                               pending_property_data_compare_id);
>         if (l =3D=3D NULL)
>                 return NULL;
>
> +       propdata =3D l->data;
>         pending_property_set =3D g_slist_delete_link(pending_property_set=
, l);
>
>         return propdata;
>  }
>
> +const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet i=
d)
> +{
> +       struct property_data *propdata;
> +       GSList *l;
> +
> +       l =3D g_slist_find_custom(pending_property_set, &id,
> +                                       pending_property_data_compare_id)=
;
> +       if (l =3D=3D NULL)
> +               return NULL;
> +
> +       propdata =3D l->data;
> +       return dbus_message_get_sender(propdata->message);
> +}
> +
>  void g_dbus_pending_property_success(GDBusPendingPropertySet id)
>  {
>         struct property_data *propdata;
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 0f7909a94..dad8604eb 100644
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
> @@ -873,7 +904,7 @@ static gboolean delay_reporting_exists(const GDBusPro=
pertyTable *property,
>         return avdtp_stream_has_delay_reporting(stream);
>  }
>
> -static gboolean get_delay_reporting(const GDBusPropertyTable *property,
> +static gboolean get_delay_report(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
>         struct media_transport *transport =3D data;
> @@ -884,6 +915,61 @@ static gboolean get_delay_reporting(const GDBusPrope=
rtyTable *property,
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
> +       struct media_owner *owner =3D transport->owner;
> +       const char *sender;
> +       uint16_t arg;
> +       int err;
> +
> +       if (owner !=3D NULL) {
> +               /* If the transport is acquired, do not allow to modify
> +                * the delay anyone but the owner. */
> +               sender =3D g_dbus_pending_property_get_sender(id);
> +               if (g_strcmp0(owner->name, sender) !=3D 0) {
> +                       g_dbus_pending_property_error(id,
> +                                       ERROR_INTERFACE ".NotAuthorized",
> +                                       "Operation Not Authorized");
> +                       return;
> +               }
> +       }
> +
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
> @@ -1019,7 +1105,7 @@ static const GDBusPropertyTable transport_a2dp_prop=
erties[] =3D {
>         { "Codec", "y", get_codec },
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
> -       { "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists=
 },
> +       { "Delay", "q", get_delay_report, set_delay_report, delay_reporti=
ng_exists },
>         { "Volume", "q", get_volume, set_volume, volume_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> @@ -2170,7 +2256,7 @@ static void *transport_asha_init(struct media_trans=
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
> @@ -2184,16 +2270,17 @@ static void *transport_asha_init(struct media_tra=
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
> @@ -2201,7 +2288,7 @@ static void *transport_asha_init(struct media_trans=
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
> @@ -2219,14 +2306,16 @@ static void *transport_asha_init(struct media_tra=
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
