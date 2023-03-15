Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F9C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 18:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCOSVU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCOSVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 14:21:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6996615
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:20:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so2828539lfj.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678904403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmI7FT4zSqrcVeZMvDkZviuuWr+DQPgYNX6xi5BVfNA=;
        b=liIqXor3lSy1WamJpbS/cwsmSGFbPMrnXUmWBbuJVljmPMpqAYiE9D4GWqXC7CO4Tu
         PBJutrNB6RqzAvUfeLMvHKQhvi7P40o8JXs8vIOo784Ba8tNUjabIfJ0yTBsEhEf4eTp
         4DOIUy+JMcRJ1N4MxclFfuLgXDC4LdE6yehK3kUTzw6OqEVvDVOqPE8q8m7KVMMI8uFA
         80i9fxSwZ7HIO1Mzullol+SnWYIJdIbikK7e/FT2MvihRXkEqPweO4uIbjLX/w/+xg8r
         dU+GcL47ewg4tQ/+LPhVVrbUENuEI4KKVs2oyvY8m1zxMj/+bM5DOl3HlfujCLmu4rTG
         HmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmI7FT4zSqrcVeZMvDkZviuuWr+DQPgYNX6xi5BVfNA=;
        b=Kqvzx0sa1kpggOCNUyGy41SisoSoyLJzqMEAenyEojeA0hpbpeIIv/80A2ndTXRi3M
         O31SB6RKgnC89+oHbouSLYs/62XtAzb0GAGIAxoWWUtoIaQ9GV5vLKAlKkZrB6/4uigq
         83gEWxnr/dMXmPicmlZR58BQHafLuZ/VaF45Dj7FlsjFJ0KiIN60iL4dVjODBlA9gGwK
         vk3UkzW4yVRGV8ipTIRvK0a6cj/w7OiZPBCScmcBdDRPiOfm1r7euNsNqJNSeGIj4aJc
         brDpNXVACCunCs7moDO3niUt+EzOm+58ZTIfquKjbCmODs/NQ2YsF/2e5AVLAmTyb3c+
         q+5Q==
X-Gm-Message-State: AO0yUKUM9UmKsE+ol2A90R6jiuIcZ9iIGZZnpTfEqcOnkUestFjoleOM
        qhwEw7NVXCwX5RlbIOmx/hoo1aUntdTZJybvFDCKaSMpJGg=
X-Google-Smtp-Source: AK7set/D+wG1sFD/bM06QPPMwDDOjGsD2ClhX6zogl6V+7phgNCToeev9LbAl35nLxos+92fwChWDNrg2NhS/iGJ4V4=
X-Received: by 2002:ac2:4a9b:0:b0:4dc:807a:d140 with SMTP id
 l27-20020ac24a9b000000b004dc807ad140mr2279142lfp.10.1678904402780; Wed, 15
 Mar 2023 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Mar 2023 11:19:51 -0700
Message-ID: <CABBYNZJeJkR18gAdy9bLW0aCkj9t3eAQ_Vpvz7whnjeaeY+2cw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] transport: add CIG/CIS/PHY properties, don't
 show unset QoS properties
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Mar 15, 2023 at 10:54=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add CIG, CIS, and PHY properties to BAP transport.  The other QoS
> properties are there, and these may also be useful to clients, e.g.  to
> manage CIG/CIS allocation as client.
>
> Hide transport QoS properties when they are not configured.
> ---
>  profiles/audio/transport.c | 67 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 457590746..53bf13175 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -811,6 +811,38 @@ static const GDBusPropertyTable a2dp_properties[] =
=3D {
>         { }
>  };
>
> +static gboolean qos_exists(const GDBusPropertyTable *property, void *dat=
a)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       return bap->qos.phy !=3D 0x00;
> +}
> +
> +static gboolean get_cig(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                                       &bap->qos.cig_id)=
;
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_cis(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                                       &bap->qos.cis_id)=
;
> +
> +       return TRUE;
> +}
> +
>  static gboolean get_interval(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -835,6 +867,17 @@ static gboolean get_framing(const GDBusPropertyTable=
 *property,
>         return TRUE;
>  }
>
> +static gboolean get_phy(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ph=
y);
> +
> +       return TRUE;
> +}
> +
>  static gboolean get_sdu(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -962,12 +1005,15 @@ static const GDBusPropertyTable bap_properties[] =
=3D {
>         { "Codec", "y", get_codec },
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
> -       { "Interval", "u", get_interval },
> -       { "Framing", "b", get_framing },
> -       { "SDU", "q", get_sdu },
> -       { "Retransmissions", "y", get_retransmissions },
> -       { "Latency", "q", get_latency },
> -       { "Delay", "u", get_delay },
> +       { "CIG", "y", get_cig, NULL, qos_exists },
> +       { "CIS", "y", get_cis, NULL, qos_exists },
> +       { "Interval", "u", get_interval, NULL, qos_exists },
> +       { "Framing", "b", get_framing, NULL, qos_exists },
> +       { "PHY", "y", get_phy, NULL, qos_exists },
> +       { "SDU", "q", get_sdu, NULL, qos_exists },
> +       { "Retransmissions", "y", get_retransmissions, NULL, qos_exists }=
,
> +       { "Latency", "q", get_latency, NULL, qos_exists },
> +       { "Delay", "u", get_delay, NULL, qos_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
> @@ -1191,12 +1237,21 @@ static void bap_update_qos(const struct media_tra=
nsport *transport)
>
>         bap->qos =3D *qos;
>
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "CIG");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "CIS");
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                         transport->path, MEDIA_TRANSPORT_INTERFACE,
>                         "Interval");
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                         transport->path, MEDIA_TRANSPORT_INTERFACE,
>                         "Framing");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "PHY");
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                         transport->path, MEDIA_TRANSPORT_INTERFACE,
>                         "SDU");
> --
> 2.39.2

I'm fine adding these but you could also have used BT_ISO_QOS
socketopt to read it directly from the socket in case you want to use
it on pipewire.

--=20
Luiz Augusto von Dentz
