Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E512DB7BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714757; cv=pass; b=beMkrZOfmmU+JXsiVmbL/v4fGI5jcIRI2V3xWlxyAc6tS9zWYgXmbwWEp0ccrFb9TXXz2U/d9ZEvvyuT0rseDGzlT/Xr+jw3AXgh6WZ+5XdFB3VF1XRzprfInADNu8LZRrAVJd7C89Iag0gGEbnjWp4okbCnWh9EQL17KD5JHGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714757; c=relaxed/simple;
	bh=t745zpafVSC9CipFtOd0sExqtTX1GWRzOT+qj7N9A3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7yuhP+fTFxpnwFzfnAwm7xevPZWMon7pSgaIJBTG0CJ5cTOVjXNonnRfPcaeGdLUMyl2E0j/JrSlsrR/v4B/gd/ygDFz2ivVfkkoaDJXPqdztWt2kDQ25mj3ppM3/+E7lCowKOnyed13tMBVlqbdGK6mPgi3tDXJbG/YfUq3XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOEEHCds; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOEEHCds"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651b4d09141so4585100d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 12:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714754; cv=none;
        d=google.com; s=arc-20240605;
        b=lH2uGobECTUlfL7AmyO0GZD08amWz9pHObsc76RCeNDRUInhxVXFyqw8G919vYWXDX
         d3VRFOAGCjUY1N3OQJdhqtJqrOuy6nG8aFlmYRbmXTKiq2IHalY+0jX50PqDaTrWxh8X
         AFuGTJpdSYm0DmPfMKAwrsD3GIc+pA+yGullQzgcEHOy1d+yC1pKbD8yPSANn0faOqgc
         4jCBAG8RNBWgVOmW7fYV+nu6ab9T7I8dP/jle8P0ehbAb6Y/AclapmnbWPjPDPh99jpq
         VjLIr5gRE08hTDLv8U9l6LG/GHxrXRANLnzeTn5FSTnMpHznR04gwDzLRJHzQmi8KK5N
         JKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SB4b32EgzYazN8qQxkM4O8xX3/Wz78zFPsOUYMoZOBw=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=eciJGXse7D9W4atf+QCuiYm55gFSjj6qlXtvjXhI8uaHDofvUdVlPkiNwcBPiEPKZP
         lSelWDzMv0CSLTuWw3oeVFakxW6icEohgM67Ps0k8W+vslJLq3//wFkC932Y3kdKRSMO
         gVsE2lQeRfmfucDmSRR+7WOOjqVSzDTe07Sbtlvcd79TzUlmaTR1AME6Y7qKPB89XxKC
         VBxq2FINbHvca0ZUu8zsyIBbiWteqM3JZTtGIUfd6/0CWM1VfZ5w9kMlzAXhXi/rqXhn
         1Vzhu3erugPUJwvgmOg95j8zpD69eL09q3+bQlySs1QbWMncAufTJ3TFoKAflD00jksY
         M3Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714754; x=1777319554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB4b32EgzYazN8qQxkM4O8xX3/Wz78zFPsOUYMoZOBw=;
        b=EOEEHCdsbG621Hai4I9S9xbomdd7HNq1beBeK9MHsEEjkV0qR7aALSSfiRuGW/XNSp
         SzLzeTwkinS4KYJyHqDOSuvFXV0WsRWfrtc3c35rYYi3pVASk75giVry+LKdhjlVvw4F
         96KqWD3V6QlkXZRwhNBDxO/icQ0Gkrzdkirm/LWlgEOO61RUHlqEujNFsTpeqoVeJD3E
         zs4oOFrOTwv6tFiOHdsm/e0pPRBPSo96MTWz5uVI883SOUBn8n3L1tVyMp+Hxh24F6YL
         Vhxv/BIDemgCs8BcnH2bmpoK7M7bHJt+3Cgu/r71aomNUj6njRENTyQDjM+kazFqMFmk
         N+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714754; x=1777319554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SB4b32EgzYazN8qQxkM4O8xX3/Wz78zFPsOUYMoZOBw=;
        b=VsLh/tDd89kxxwWNLsUNSQS4n2JCkautgYpoxZgT9T5Y9/4KyKEBTQGcCJpZFultic
         dDMj+4m+MCOIsrgqueCraRfQNgSHdpVkwJ6gzGFBZDXIILO+c2Jq/UXr+EPvtkcdJimr
         mFrj/TYHU1u4OXKFpyWwBwvU+u9eIybV1/aQT6IOAHtRh4t7BD6tvT5BwVaiBJdcldka
         hOeOy6nYX9qH5ZiRR600vxzCSkPgV/0q8Q1CriLWjriLFo1N/h8V6/Zjqk836EfQi0zY
         MpbBLVxAPk+na7h9gAjbWSxp1fTA7RYphCX7Cns2gZBFkwWMpVwjPJcMJ/r+JzHozQE0
         CoCg==
X-Gm-Message-State: AOJu0YwTccbcEN/7kfSqt8Q/nq3AQILeD7Qa8zERmPhPegvPggtyfYMS
	Zk9zWXlSYZfPhzqcSQyhEKO5KSTtSFCWsL7CEL/M1QAe6f+qd8rbUAeNeCZp07LqiyS0JCjL9nu
	svR3BGH8/sjtdllUkGzwkV4eUtgkfXYMpS/+q
X-Gm-Gg: AeBDieu6HA3zqiebg053EDzzrpOP0PR2RIhq5kFw+KWW1O6oVozYPpvTwQYii17PfC/
	owSa4N6NmroEAxPiPbPzft8jVNZpRQNL05ppSVxYdG0cSF/QE0L8Ccd2dxk/uHdUd/OmJqaoXP6
	9tdEaqNEo+TggWoyvGGAtwIsYEfPMHU5ofGJn0DUrX5Ahvh5mEBmn0G0/ydecjxSeWRgcID/meu
	Rk1/9m7SVfSTMyX286O0UaZoet6OV0FX03WIiAAPoSD2gj9pnXvIrbzGQmjN+aV9oQthJbuCiYw
	pN0wg3m8D8geFNI0lHywqIvqodvaDH+ZmlXpmEzI3993UHXem5xxWsDDh/AZ1WYDu7hSP5NqPlR
	VSQ==
X-Received: by 2002:a05:690e:4006:b0:652:f16e:345d with SMTP id
 956f58d0204a3-65311bc3dfamr10710518d50.30.1776714754551; Mon, 20 Apr 2026
 12:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420161345.145089-1-frederic.danis@collabora.com>
In-Reply-To: <20260420161345.145089-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:52:22 -0400
X-Gm-Features: AQROBzDA7VUdiw_8kYWnDONEMthmW8S-brzo7-9LAG2LwsxnOWip0G2Ommo_Ayw
Message-ID: <CABBYNZJzhE5y_YC=vw3-V2HRznnoeSxKkVt+FcFcv4=GnONmSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio: Add ability to force CIS transport Links property
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Apr 20, 2026 at 1:27=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
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
>  profiles/audio/bap.c       | 44 +++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
>  2 files changed, 91 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 375026440..8f1f75240 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -2651,13 +2651,57 @@ static void bap_connect_bcast_io_cb(GIOChannel *c=
han, GError *err,
>         iso_connect_bcast_cb(chan, err, setup->stream);
>  }
>
> +struct connect_io_data {
> +       GIOChannel *chan;
> +       GError *err;
> +       uint8_t cig_id;
> +};
> +
> +static bool find_enabling_stream(const void *data, const void *match_dat=
a)
> +{
> +       const struct bap_setup *setup =3D data;
> +       const struct connect_io_data *d =3D match_data;
> +       uint8_t state;
> +
> +       state =3D bt_bap_stream_get_state(setup->stream);
> +       if (state =3D=3D BT_BAP_STREAM_STATE_ENABLING &&
> +                       setup->qos.ucast.cig_id =3D=3D d->cig_id)
> +               iso_connect_cb(d->chan, d->err, setup->stream);
> +
> +       return false;
> +}
> +
> +static bool find_enabling_ep(const void *data, const void *match_data)
> +{
> +       const struct bap_ep *ep =3D data;
> +
> +       if (ep->setups)
> +               queue_find(ep->setups, find_enabling_stream, match_data);
> +
> +       return false;
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
> +       if (bt_bap_stream_get_state(setup->stream) !=3D
> +                        BT_BAP_STREAM_STATE_ENABLING) {
> +               /* The stream may have manually been unliked for tests an=
d the
> +                * connect event refers to another stream of the CIG.

If this is happening it already means the setup shouldn't be waiting
for a connect IO to begin with. Alternatively, the problem might be
that it will connect regardless because the CIS is bidirectional;
connecting one stream connects both. However, one stream might have
the defer setup marked. Did you check that? And in that case we should
consider it connected, or maybe we should not advance and send the
start operation if it is still deferred.

> +                */
> +               data.chan =3D chan;
> +               data.err =3D err;
> +               data.cig_id =3D setup->qos.ucast.cig_id;
> +               queue_find(setup->ep->data->snks, find_enabling_ep, &data=
);
> +               queue_find(setup->ep->data->srcs, find_enabling_ep, &data=
);
> +               return;
> +       }
> +
>         iso_connect_cb(chan, err, setup->stream);
>  }
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index d9feef768..794c492af 100644
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
> @@ -1417,6 +1419,9 @@ static struct media_transport *find_transport_by_pa=
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
> @@ -1434,6 +1439,16 @@ static void set_links(const GDBusPropertyTable *pr=
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
> @@ -1484,6 +1499,21 @@ static const GDBusPropertyTable transport_bap_uc_p=
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
> @@ -1879,8 +1909,6 @@ static void bap_resume_complete(struct media_transp=
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
> @@ -2535,10 +2563,11 @@ static void *transport_asha_init(struct media_tra=
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
> @@ -2560,26 +2589,28 @@ static void *transport_asha_init(struct media_tra=
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
> @@ -2587,7 +2618,7 @@ static void *transport_asha_init(struct media_trans=
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
> @@ -2642,6 +2673,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>         struct media_transport *transport;
>         const struct media_transport_ops *ops;
>         int fd;
> +       const GDBusPropertyTable *properties;
>
>         transport =3D g_new0(struct media_transport, 1);
>         if (device)
> @@ -2696,9 +2728,14 @@ struct media_transport *media_transport_create(str=
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
