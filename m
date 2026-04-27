Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6C3E7173
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312972; cv=pass; b=U8JIDtu+Rhqc5QHO71yV9sAms5fNP84gi+2V5mResB4uLLPlEQzaG/441BM56NcMq2NJgqlskvfu3TeFfetaz5Xu5hFlqiDE1LzA2ppGoZPfR6Vv7Nb4gRca0kXbLDLQAMW+BHZXn4reztkJL5Z5Q5sRgq/DMU0pxt9qdBCBZPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312972; c=relaxed/simple;
	bh=5W8Cobv2qPJEEQQG46dtX8PB4Ig7pWUSqPqJusZbkOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vmm5Xb7ITUCwpVg8DlZiwgsTv3RuYct1ZCyYGoz2xo7dODEsZ+IKdktk3h80XQP9XpqM8BsytWFC7Iw1rZW4nHe0Vr4pQYOzSxqAptJccOkI/RHygKxlMg6jnddaeT7vSbbysqV0+Rhzv11TMc7UhkUHRTnVg+iMGza7Ul3aGSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJx0AfOQ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJx0AfOQ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651b4d09141so13991366d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777312970; cv=none;
        d=google.com; s=arc-20240605;
        b=gMyA9GZSTysfxr80Wc7bVrcb1G/tcgndGv56/d0O5V3zJdPJafAhGp4LwfREgBFJGC
         TmwpO64WkDC6CxX8W0Cu7SdS+5kijugqYbNIxFOt3yJ5ET5Rc3ec8s1TonQCXj2uCg0c
         9ZYGkZ2fAIms7EeLqW+hl5k9glQl9qm9AfnIFXOAzEQNGsGCDtTRRQ6qqN+ud1CP9ACX
         09jCJXokoXn5EUfEWKC9FNwqMQ8znodwAIAPomwmv4q0nBzbW6bdaEvOLHi7AM6Cg+SP
         UCWEELwCOA1EwcnAQotzMeqC4kvfxSkMxL1xkp5cLSMKyiOm0x9zl+ZnPa+e1rFTKHcX
         it9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P19uap96CanbkFxP6QeR73aMto99ZL6XcsR/n61lL6g=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=kHfnCtEIaf35vCudsWW028FegnVEKmBp+Az2l0h56AMUJceSaRGyfGuC7eli6tA/R1
         u6zX5FF6dsRYxDyUJjdQF8jWOs8053ooLNcEEMxP42pKt5hFj5wlPTrcsZJ4FsS30KXJ
         g6LwITDnx6WS4v4JzDe4ZE9C4Ps+hHdtoOb8XGSheLCm1lM4AjdEXSmATCQxfNzEOrTc
         to5WufXeIDruMgsV9J/SClcEoQwOlACsjAPehJw7Ygzo8UGPNyC/kGOzoJcRER8B1LAk
         RDSXMbuWyz1gRM1F08vs0ETUb69E6goVcdFqI1YmOzbMwg5bz+BwFJ35qqqhxAEz7pfn
         T4jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777312970; x=1777917770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P19uap96CanbkFxP6QeR73aMto99ZL6XcsR/n61lL6g=;
        b=qJx0AfOQU9+fdyJfXg1v4rqhLgkEjZhO672k9MEr4b4fd3Vdg/dv8LY9aa5U+JtO4d
         PThtmLaYPXC+RexykTd2Dz/pXFDUyi1rPVBztg2is3DmJLHsrNY2JJz4m9mYLd0JQBi/
         YM6xPhja7GU5zjBlGbXqvHVclr0uKdwO4NMXssI1OEjmpST0q//NMzAnmhGPScu+3q3r
         Xpa57NlRZydbQepqMgGvVYXd0Epv7kXmu9IC2l6xGNJhJeZ78CDnmHcSNcfwzlaFg0JM
         dtBhfVxhPKxI9N8V8SIEiJ/e1/jzPt+VQWSOmzOty0sUb/nUtQOKPkwXEENCJCvnP0EM
         5C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312970; x=1777917770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P19uap96CanbkFxP6QeR73aMto99ZL6XcsR/n61lL6g=;
        b=Yrynz+Gtc0GCY0emNaVTrqxrQZ+S9AzQTJQLIgY8rkrnL0TUhqM85nfpjTdCYYoV84
         Kn9w9e+iwmNSOz2kR537a2g2CObvjUG+1H/sEPtcOCsD5oGENKZ6CbiCSXASQU/hgueJ
         zqe9hTo2XOSyeJgC6KcLHojsDEXqK8G4DP2nk8FLBZUCdLa3uTQeyeMOcXldecqjlkmE
         C9p5TgQHt5tHcxtmb/BmnvXKSL5TETqm3lKM6gYuTjU35toF9o2De+6qAxnt8nrlLafi
         lr4zcNpRm7AxSBDo78JqW9BHia7q9byqXZLmT5Ual7nvvOSA6JRN/UWg6sxlkI9f48Be
         x+lA==
X-Gm-Message-State: AOJu0Ywa2jbvldtJESamhF+2nVQv0hHGwSuu+IPUNsZFR1qKzDRhb/il
	xp8XUkid6BBzxu2g21h996TdUor6YwDsQE3I5qcFoAcY345wEWkYLIolHQ9YQvo2hx/Bb16Pqw+
	mo8HbNRFQfMxbXaqdzVVfIFF7p2drmTvfdw==
X-Gm-Gg: AeBDietabs5bXMycGv/Xfr3eOvi81fNPIeNgYn7T90OLE0FJpfsiXryyJyYaKUpg3Gk
	MuXlVWBjwr26x8fHIGqQUCNQ0a7f813LI7y6e51KhbCQfQ1s7GS+YlauBK4pM/Aq+sS2H404xYV
	LPL4bsyWYVYxur1zVG2LtL3D8WNGjsR9vSdaaHXTYxOXxC8nj+QxzvTGsc6ydrdK0HnrtjsxoBq
	NP9yRKOaKy/ASJ7qXySnrZv6LOh9Wp26SAaYGatXl+2kcCLimhBIze1yZNyJv8Wo6nwDWna1yYy
	Cd3kt7zi0yT7x/kZ+oxRMbDIVWYyZuq3GdUwK7k9fVbO/sCaRcfe8SqNv3wyLCfzaS8/+w4lONj
	EpQ==
X-Received: by 2002:a05:690e:4349:b0:652:fadd:c970 with SMTP id
 956f58d0204a3-65becb7dfb5mr118546d50.28.1777312969447; Mon, 27 Apr 2026
 11:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172056.148115-1-frederic.danis@collabora.com> <20260427172056.148115-2-frederic.danis@collabora.com>
In-Reply-To: <20260427172056.148115-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Apr 2026 14:02:37 -0400
X-Gm-Features: AVHnY4JkG2Gz5YrHf4btVeydJys9T3Gw4ksKbyiEC_NIe0DOVAL2BBDYSGUIi58
Message-ID: <CABBYNZLX+kkp27GZJNittbVhhokKNy9OvJ2=2NoRSy2RJQsjBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio: Add ability to desynchronized linked transport
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Apr 27, 2026 at 1:26=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> If bluetoothd is started in testing mode a new Desynchronized property
> is added, allowing to prevent automatic acquire of linked transport
> objects.
>
> When desynchronized, each transports needs to be acquired separately.
>
> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
> ---
>  profiles/audio/transport.c | 113 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 100 insertions(+), 13 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 5c2a2777e..f8f68737d 100644
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
> @@ -109,11 +110,13 @@ struct bap_transport {
>         guint                   resume_id;
>         struct iovec            *meta;
>         guint                   chan_id;
> +       bool                    desynchronized;

Let's call it 'desync' for short. Also, add a comment stating that
this is only writable when testing is enabled; otherwise, it defaults
to false, meaning the Enable/Acquire operations synchronize
input/output directions that share the same ISO socket CID/CIG.

>  };
>
>  struct media_transport_ops {
>         const char *uuid;
>         const GDBusPropertyTable *properties;
> +       const GDBusPropertyTable *test_properties;
>         void (*set_owner)(struct media_transport *transport,
>                                 struct media_owner *owner);
>         void (*remove_owner)(struct media_transport *transport,
> @@ -351,7 +354,7 @@ static void transport_bap_remove_owner(struct media_t=
ransport *transport,
>  {
>         struct bap_transport *bap =3D transport->data;
>
> -       if (bap && bap->linked)
> +       if (bap && bap->linked && !bap->desynchronized)
>                 queue_foreach(bt_bap_stream_io_get_links(bap->stream),
>                                 linked_transport_remove_owner, owner);
>  }
> @@ -729,7 +732,7 @@ static void transport_bap_set_owner(struct media_tran=
sport *transport,
>  {
>         struct bap_transport *bap =3D transport->data;
>
> -       if (bap && bap->linked)
> +       if (bap && bap->linked && !bap->desynchronized)
>                 queue_foreach(bt_bap_stream_io_get_links(bap->stream),
>                                 linked_transport_set_owner, owner);
>  }
> @@ -1463,6 +1466,60 @@ static void set_links(const GDBusPropertyTable *pr=
operty,
>         g_dbus_pending_property_success(id);
>  }
>
> +static gboolean get_desynchronized(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
> +                                                       &bap->desynchroni=
zed);
> +
> +       return TRUE;
> +}
> +
> +static void transport_desynchronize(void *data, void *user_data)
> +{
> +       struct bt_bap_stream *link =3D data;
> +       bool desynchronized =3D PTR_TO_UINT(user_data);
> +       struct media_transport *transport;
> +       struct bap_transport *bap;
> +
> +       transport =3D find_transport_by_bap_stream(link);
> +       bap =3D transport->data;
> +       bap->desynchronized =3D desynchronized;
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), transport=
->path,
> +                                               MEDIA_TRANSPORT_INTERFACE=
,
> +                                               "Desynchronized");
> +}
> +
> +static void set_desynchronized(const GDBusPropertyTable *property,
> +                       DBusMessageIter *iter, GDBusPendingPropertySet id=
,
> +                       void *data)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_BOOLEAN) =
{
> +               g_dbus_pending_property_error(id,
> +                               ERROR_INTERFACE ".InvalidArguments",
> +                               "Expected BOOLEAN");
> +               return;
> +       }
> +
> +       dbus_message_iter_get_basic(iter, &bap->desynchronized);
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), transport=
->path,
> +                                               MEDIA_TRANSPORT_INTERFACE=
,
> +                                               "Desynchronized");
> +
> +       /* Set desynchronized for all the links */
> +       queue_foreach(bt_bap_stream_io_get_links(bap->stream),
> +                                       transport_desynchronize,
> +                                       UINT_TO_PTR(bap->desynchronized))=
;
> +
> +       g_dbus_pending_property_success(id);
> +}
> +
>  static gboolean qos_ucast_exists(const GDBusPropertyTable *property, voi=
d *data)
>  {
>         struct media_transport *transport =3D data;
> @@ -1486,6 +1543,23 @@ static const GDBusPropertyTable transport_bap_uc_p=
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
> +       { "Links", "ao", get_links, NULL, links_exists },
> +       { "Volume", "q", get_volume, set_volume, volume_exists },
> +       { "Desynchronized", "b", get_desynchronized, set_desynchronized,
> +                                                               links_exi=
sts},
> +       { }
> +};
> +
>  static gboolean get_bcast_qos(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -1920,6 +1994,9 @@ static void transport_bap_update_links_uc(
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), transport=
->path,
>                                                 MEDIA_TRANSPORT_INTERFACE=
,
>                                                 "Links");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), transport=
->path,
> +                                               MEDIA_TRANSPORT_INTERFACE=
,
> +                                               "Desynchronized");
>
>         DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "f=
alse");
>  }
> @@ -2037,8 +2114,9 @@ static guint transport_bap_resume(struct media_tran=
sport *transport,
>                 return bap->resume_id;
>         }
>
> -       id =3D bt_bap_stream_enable(bap->stream, bap->linked, NULL,
> -                                       bap_enable_complete, owner);
> +       id =3D bt_bap_stream_enable(bap->stream,
> +                               bap->desynchronized ? false : bap->linked=
,
> +                               NULL, bap_enable_complete, owner);

I guess this is the main change that makes everything work together.
We do have a single user `bt_bap_stream_enable(stream, false)` in
test-bap but that doesn't seem to match this test case. Perhaps we
should add a test case for it under test-bap, doesn't need to be in
this set though.

>         if (!id)
>                 return 0;
>
> @@ -2161,7 +2239,7 @@ static void transport_bap_set_state(struct media_tr=
ansport *transport,
>  {
>         struct bap_transport *bap =3D transport->data;
>
> -       if (!bap->linked)
> +       if (!bap->linked || bap->desynchronized)
>                 return;
>
>         /* Update links */
> @@ -2540,10 +2618,11 @@ static void *transport_asha_init(struct media_tra=
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
> @@ -2565,26 +2644,28 @@ static void *transport_asha_init(struct media_tra=
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
> @@ -2592,7 +2673,7 @@ static void *transport_asha_init(struct media_trans=
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
> @@ -2647,6 +2728,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>         struct media_transport *transport;
>         const struct media_transport_ops *ops;
>         int fd;
> +       const GDBusPropertyTable *properties;
>
>         transport =3D g_new0(struct media_transport, 1);
>         if (device)
> @@ -2701,9 +2783,14 @@ struct media_transport *media_transport_create(str=
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
