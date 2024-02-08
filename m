Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785857A731
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397979; cv=none; b=kxRVy0xCHFBBRLtGf7ylbmKf+RmdLidxF0sFAMMRHLWDfVErw29QMVilBFdFicZqOei2uTa551Mk933PBcSU+bMZZo9rtRCW7iiv6zoZZhNnPYfKA312ORIEw/z90kfagnqwmrF37YrxZVK9hnaOLqdxwoaYSkJbX72R8D0OdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397979; c=relaxed/simple;
	bh=ppHg/BpTt4ZOtApvV1u5k0XrqdbVO0pQCphe+O4yKuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czeo2L3ZoJ5IOA3n4zt2f/9tQZnq82P24lpQvi7JLDS+SDdY3qUJkcvIoc06tWMdUvxNbORYufg5sT1KNzJMxrpPDcyjAy8N9aqbeeZkZMGjF2CKLK9ukxVTS4DOzylQdkQ5spTINc7eMkawPTT9vVgj+Vhncct384tQVg/l7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AllE+Bhx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AllE+Bhx"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so14840401fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Feb 2024 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707397974; x=1708002774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I39Sf4yDvgljjx8Tn7j/4Gqq3UUnurp049mOu/n3cG8=;
        b=AllE+BhxFW13y0LccHsdMoMsQdXZ8vxwgbwYra1EGXQKfh80hS6zHmE8DHq7urmEq8
         mFaV5b6M3/sO5jlLM5BWmbb0lqAnbtPdNOfFDKBhtXKQUQdGjsz/j49mM4djRaaLiK8G
         V+1/CL7GAxEPgrBP7mJZ1eiOXtFqQ9Kxp0gqXGxq/rpT+o5v8xD7YBFtzI4iS5uRdqHW
         5FENksg0D4EJ73Eu8Sjl53ZZSJD+3Rh7biHMHCKYI2DCc6Gi3NYKBZj4NERVf51KIFxe
         J5qS7QPr0Le5KyUHNUUEZ2uajAMJ7a3iA4oKv8fSc+5Pm1nVj5ZQOY1X141ZYpRJ2cgB
         uLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707397974; x=1708002774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I39Sf4yDvgljjx8Tn7j/4Gqq3UUnurp049mOu/n3cG8=;
        b=UdlURND/PAvpyc2GWCfbMvzf8JrVHnJWCORPzbdCXEGiilK3ofwcFip/eTLjlj8tmV
         /DkyhnGO/6s50JrSHmy0YMYOr64FBWJ8HMoq102r9aG1E+99MqqTaP9YJjS+k2X2RaZT
         AA+x5USpnvxoZdK3x7Z746x2scbNA/9i/cLpUut5vs9QC4w2A/yQEDNdYcJlrPwmLgnp
         pSm1XUfmdiDgH5Lw+euBfokojl11uOUt3k9tGY2PxrEvCzku0XIXj2IbbKYougMc0ENx
         ChSjrLD9c2CU80j2bxZxKt3AD28NjeAhhwGNWZ1IffWSc9aOQCw6LnisL2aceX5bjNpK
         K9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaFDv2dgOTxCVEY1O9JKW5SZuronH6Fqmg/StWt37TQ51bTgqaLW5ivVm/B7XJAtLyyudBz2KrCJodHqvjA7olSTyeUwenw3+Samzj8hF5
X-Gm-Message-State: AOJu0YyMWXlbYujCsxORtciYNTqzj2sy1jBLqmEEl+7ukSEgeOs1EzMA
	hcXVwiqakbRrwv9qukMN44dtfFeYEi0UZlYy8Pys6fKmNDXATW2H1HSdot1u1rBRFTHCTvw5cZJ
	bCxNqUEIfI6a84Zy8DwbTsHGUI9kwTiEI
X-Google-Smtp-Source: AGHT+IFwnFLY7J84bzBRWfCZmf17cZH3KyfgyNHjmYpESxFJXSJMG4+idLuPLi8IHCpgxhKmiKi4uksyTskf1YBy7Lc=
X-Received: by 2002:a2e:7c07:0:b0:2cf:425b:59ee with SMTP id
 x7-20020a2e7c07000000b002cf425b59eemr5727656ljc.24.1707397974126; Thu, 08 Feb
 2024 05:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJ9VQL+bvx1=0EaPV0WJS_jLnP=3-gwTLr3rvqhSbN9iA@mail.gmail.com>
 <20240208112549.7432-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240208112549.7432-1-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Feb 2024 08:12:40 -0500
Message-ID: <CABBYNZKztn9c6aVZBTWmegry+-yyaAR4rZussvznxpvXdqnKbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broadcast source discovered
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Thu, Feb 8, 2024 at 6:25=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Wednesday, February 7, 2024 4:42 PM
> > To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> > Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > Subject: [EXT] Re: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broad=
cast
> > source discovered
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > Hi Andrei,
> >
> > On Wed, Feb 7, 2024 at 7:23 AM Andrei Istodorescu
> > <andrei.istodorescu@nxp.com> wrote:
> > >
> > > After discovering a BAP Broadcast Source do a short PA sync first to
> > > learn the BASE. After discovering the BASE check how many BISes are
> > > matching the sink capabilities and create endpoints for them. Allow
> > > user to configure one endpoint using "SetConfiguration" causing BIG
> > > synchronization to the corresponding BIS; also this results in
> > > creating a stream and the corresponding transport.
> > > ---
> > >  profiles/audio/bap.c | 324
> > > +++++++++++++++----------------------------
> > >  1 file changed, 110 insertions(+), 214 deletions(-)
> > >
> > > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c index
> > > 88c93127bea0..8646eae2ed20 100644
> > > --- a/profiles/audio/bap.c
> > > +++ b/profiles/audio/bap.c
> > > @@ -105,6 +105,44 @@ struct bap_data {
> > >         void *user_data;
> > >  };
> > >
> > > +/* Structure holding the parameters for periodic train and BIG
> > > + * synchronization
> > > + */
> > > +static struct bt_iso_qos bap_sink_sync_parameters =3D {
> > > +       .bcast =3D {
> > > +               .big                    =3D BT_ISO_QOS_BIG_UNSET,
> > > +               .bis                    =3D BT_ISO_QOS_BIS_UNSET,
> > > +               /* HCI_LE_Periodic_Advertising_Create_Sync */
> > > +               .options                =3D 0x00,
> > > +               .skip                   =3D 0x0000,
> > > +               .sync_timeout   =3D 0x4000,
> > > +               .sync_cte_type  =3D 0x00,
> > > +               /* HCI_LE_BIG_Create_Sync */
> > > +               .encryption             =3D 0x00,
> > > +               .bcode                  =3D {0x00},
> > > +               .mse                    =3D 0x00,
> > > +               .timeout                =3D 0x4000,
> > > +               /* to remove from kernel check */
> > > +               .sync_factor    =3D 0x07,
> > > +               .packing                =3D 0x00,
> > > +               .framing                =3D 0x00,
> > > +               .in =3D {
> > > +                       .interval       =3D 10000,
> > > +                       .latency        =3D 10,
> > > +                       .sdu            =3D 40,
> > > +                       .phy            =3D 0x02,
> > > +                       .rtn            =3D 2,
> > > +               },
> > > +               .out =3D {
> > > +                       .interval       =3D 10000,
> > > +                       .latency        =3D 10,
> > > +                       .sdu            =3D 40,
> > > +                       .phy            =3D 0x02,
> > > +                       .rtn            =3D 2,
> > > +               }
> > > +       }
> > > +};
> >
> > This cannot be global, it needs to be stored on a per device basis so i=
t doesn't
> > get overwritten.
>
> I will submit an update for this.
>
> >
> > >  static struct queue *sessions;
> > >
> > >  static bool bap_data_set_user_data(struct bap_data *data, void
> > > *user_data) @@ -422,113 +460,6 @@ static int
> > parse_array(DBusMessageIter *iter, struct iovec *iov)
> > >         return 0;
> > >  }
> > >
> > > -static bool parse_base(void *data, size_t len, util_debug_func_t fun=
c,
> > > -               uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *=
numBis,
> > > -               struct bt_bap_codec *codec, struct iovec **caps,
> > > -               struct iovec **meta)
> > > -{
> > > -       struct iovec iov =3D {
> > > -               .iov_base =3D data,
> > > -               .iov_len =3D len,
> > > -       };
> > > -
> > > -       uint8_t capsLen, metaLen;
> > > -       struct iovec cc;
> > > -       struct iovec metadata;
> > > -
> > > -       if (presDelay) {
> > > -               if (!util_iov_pull_le24(&iov, presDelay))
> > > -                       return false;
> > > -               util_debug(func, NULL, "PresentationDelay %d", *presD=
elay);
> > > -       }
> > > -
> > > -       if (numSubgroups) {
> > > -               if (!util_iov_pull_u8(&iov, numSubgroups))
> > > -                       return false;
> > > -               util_debug(func, NULL, "NumSubgroups %d", *numSubgrou=
ps);
> > > -       }
> > > -
> > > -       if (numBis) {
> > > -               if (!util_iov_pull_u8(&iov, numBis))
> > > -                       return false;
> > > -               util_debug(func, NULL, "NumBis %d", *numBis);
> > > -       }
> > > -
> > > -       if (codec) {
> > > -               codec =3D util_iov_pull_mem(&iov, sizeof(*codec));
> > > -               if (!codec)
> > > -                       return false;
> > > -               util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%=
2.2x",
> > > -                               "Codec", codec->id, codec->cid, codec=
->vid);
> > > -       }
> > > -
> > > -       if (!util_iov_pull_u8(&iov, &capsLen))
> > > -               return false;
> > > -       util_debug(func, NULL, "CC Len %d", capsLen);
> > > -
> > > -       if (!capsLen)
> > > -               return false;
> > > -
> > > -       cc.iov_len =3D capsLen;
> > > -       cc.iov_base =3D util_iov_pull_mem(&iov, capsLen);
> > > -       if (!cc.iov_base)
> > > -               return false;
> > > -
> > > -       if (caps) {
> > > -               if (*caps)
> > > -                       util_iov_free(*caps, 1);
> > > -
> > > -               *caps =3D util_iov_dup(&cc, 1);
> > > -       }
> > > -
> > > -       for (int i =3D 0; capsLen > 1; i++) {
> > > -               struct bt_ltv *ltv =3D util_iov_pull_mem(&cc, sizeof(=
*ltv));
> > > -               uint8_t *caps;
> > > -
> > > -               if (!ltv) {
> > > -                       util_debug(func, NULL, "Unable to parse %s",
> > > -                                                               "Capa=
bilities");
> > > -                       return false;
> > > -               }
> > > -
> > > -               util_debug(func, NULL, "%s #%u: len %u type %u",
> > > -                                       "CC", i, ltv->len, ltv->type)=
;
> > > -
> > > -               caps =3D util_iov_pull_mem(&cc, ltv->len - 1);
> > > -               if (!caps) {
> > > -                       util_debug(func, NULL, "Unable to parse %s",
> > > -                                                               "CC")=
;
> > > -                       return false;
> > > -               }
> > > -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> > > -
> > > -               capsLen -=3D (ltv->len + 1);
> > > -       }
> > > -
> > > -       if (!util_iov_pull_u8(&iov, &metaLen))
> > > -               return false;
> > > -       util_debug(func, NULL, "Metadata Len %d", metaLen);
> > > -
> > > -       if (!metaLen)
> > > -               return false;
> > > -
> > > -       metadata.iov_len =3D metaLen;
> > > -       metadata.iov_base =3D util_iov_pull_mem(&iov, metaLen);
> > > -       if (!metadata.iov_base)
> > > -               return false;
> > > -
> > > -       if (meta) {
> > > -               if (*meta)
> > > -                       util_iov_free(*meta, 1);
> > > -
> > > -               *meta =3D util_iov_dup(&metadata, 1);
> > > -       }
> > > -
> > > -       util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
> > > -
> > > -       return true;
> > > -}
> > > -
> > >  static int parse_io_qos(const char *key, int var, DBusMessageIter *i=
ter,
> > >                                 struct bt_bap_io_qos *qos)  { @@
> > > -954,6 +885,17 @@ static DBusMessage
> > *set_configuration(DBusConnection *conn, DBusMessage *msg,
> > >                 return btd_error_invalid_args(msg);
> > >         }
> > >
> > > +       /* For BAP Broadcast Sink, the capabilities and metadata are =
coming
> > > +        * from the source's BIS, which are present in the remote PAC
> > > +        */
> > > +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SINK) {
> > > +               util_iov_free(setup->caps, 1);
> > > +               setup->caps =3D util_iov_dup(bt_bap_pac_get_data(ep->=
rpac), 1);
> > > +               util_iov_free(setup->metadata, 1);
> > > +               setup->metadata =3D util_iov_dup(
> > > +                               bt_bap_pac_get_metadata(ep->rpac), 1)=
;
> > > +       }
> > > +
> > >         setup->stream =3D bt_bap_stream_new(ep->data->bap, ep->lpac, =
ep-
> > >rpac,
> > >                                                 &setup->qos,
> > > setup->caps);
> > >
> > > @@ -977,95 +919,27 @@ static DBusMessage
> > *set_configuration(DBusConnection *conn, DBusMessage *msg,
> > >                 break;
> > >         case BT_BAP_STREAM_TYPE_BCAST:
> > >                 /* No message sent over the air for broadcast */
> > > -               if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST=
_SINK)
> > > -                       setup->msg =3D dbus_message_ref(msg);
> > > -               else {
> > > +               if (bt_bap_pac_get_type(ep->lpac) =3D=3D
> > > + BT_BAP_BCAST_SOURCE)
> > >                         setup->base =3D bt_bap_stream_get_base(setup-=
>stream);
> > > -                       setup->id =3D 0;
> > >                 }
> > > +               setup->id =3D 0;
> > >
> > >                 if (ep->data->service)
> > >                         service_set_connecting(ep->data->service);
> > >
> > >                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> > > -       }
> > >
> > >         return NULL;
> > >  }
> > >
> > > -static void update_bcast_qos(struct bt_iso_qos *qos,
> > > -                       struct bt_bap_qos *bap_qos)
> > > -{
> > > -       bap_qos->bcast.big =3D qos->bcast.big;
> > > -       bap_qos->bcast.bis =3D qos->bcast.bis;
> > > -       bap_qos->bcast.sync_factor =3D qos->bcast.sync_factor;
> > > -       bap_qos->bcast.packing =3D qos->bcast.packing;
> > > -       bap_qos->bcast.framing =3D qos->bcast.framing;
> > > -       bap_qos->bcast.encryption =3D qos->bcast.encryption;
> > > -       bap_qos->bcast.options =3D qos->bcast.options;
> > > -       bap_qos->bcast.skip =3D qos->bcast.skip;
> > > -       bap_qos->bcast.sync_timeout =3D qos->bcast.sync_timeout;
> > > -       bap_qos->bcast.sync_cte_type =3D qos->bcast.sync_cte_type;
> > > -       bap_qos->bcast.mse =3D qos->bcast.mse;
> > > -       bap_qos->bcast.timeout =3D qos->bcast.timeout;
> > > -       bap_qos->bcast.io_qos.interval =3D qos->bcast.in.interval;
> > > -       bap_qos->bcast.io_qos.latency =3D qos->bcast.in.latency;
> > > -       bap_qos->bcast.io_qos.phy =3D qos->bcast.in.phy;
> > > -       bap_qos->bcast.io_qos.sdu =3D qos->bcast.in.sdu;
> > > -       bap_qos->bcast.io_qos.rtn =3D qos->bcast.in.rtn;
> > > -       if (!bap_qos->bcast.bcode)
> > > -               bap_qos->bcast.bcode =3D new0(struct iovec, 1);
> > > -       util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
> > > -                                               sizeof(qos->bcast.bco=
de));
> > > -}
> > > -
> > >  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void
> > > *user_data)  {
> > >         struct bap_setup *setup =3D user_data;
> > > -       struct bap_ep *ep =3D setup->ep;
> > > -       struct bap_data *data =3D ep->data;
> > > -       struct bt_iso_qos qos;
> > > -       struct bt_iso_base base;
> > > -       char address[18];
> > >         int fd;
> > > -       struct iovec *base_io;
> > > -       uint32_t presDelay;
> > > -       uint8_t numSubgroups;
> > > -       uint8_t numBis;
> > > -       struct bt_bap_codec codec;
> > > -
> > > -       bt_io_get(io, &err,
> > > -                       BT_IO_OPT_DEST, address,
> > > -                       BT_IO_OPT_QOS, &qos,
> > > -                       BT_IO_OPT_BASE, &base,
> > > -                       BT_IO_OPT_INVALID);
> > > -       if (err) {
> > > -               error("%s", err->message);
> > > -               g_error_free(err);
> > > -               goto drop;
> > > -       }
> > >
> > > -       g_io_channel_ref(io);
> > > -       btd_service_connecting_complete(data->service, 0);
> > > -       DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
> > > -                                       address, qos.bcast.big, qos.b=
cast.bis);
> > > -
> > > -       update_bcast_qos(&qos, &setup->qos);
> > > -
> > > -       base_io =3D new0(struct iovec, 1);
> > > -       util_iov_memcpy(base_io, base.base, base.base_len);
> > > -
> > > -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
> > > -                       &presDelay, &numSubgroups, &numBis,
> > > -                       &codec, &setup->caps, &setup->metadata);
> > > -
> > > -       /* Update pac with BASE information */
> > > -       bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
> > > -                                       setup->metadata);
> > > -       setup->id =3D bt_bap_stream_config(setup->stream, &setup->qos=
,
> > > -                                       setup->caps, NULL, NULL);
> > > -
> > > -       bt_bap_stream_set_user_data(setup->stream, ep->path);
> > > +       /* listen channel is not needed anymore */
> > > +       g_io_channel_unref(setup->io);
> > > +       setup->io =3D NULL;
> > >
> > >         fd =3D g_io_channel_unix_get_fd(io);
> > >
> > > @@ -1074,26 +948,43 @@ static void iso_bcast_confirm_cb(GIOChannel
> > *io, GError *err, void *user_data)
> > >                 g_io_channel_set_close_on_unref(io, FALSE);
> > >                 return;
> > >         }
> > > -
> > > -
> > > -       return;
> > > -
> > > -drop:
> > > -       g_io_channel_shutdown(io, TRUE, NULL);
> > > -
> > >  }
> > >
> > >  static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
> > > {
> > >         GError *err =3D NULL;
> > > +       struct bap_data *data =3D user_data;
> > > +       struct bt_iso_base base;
> > > +       struct bt_bap_base base_s;
> > > +       struct bt_iso_qos qos;
> > >
> > > -       if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> > > -                               user_data, NULL, &err, BT_IO_OPT_INVA=
LID)) {
> > > -               error("bt_io_bcast_accept: %s", err->message);
> > > +       btd_service_connecting_complete(data->service, 0);
> > > +
> > > +       bt_io_get(io, &err,
> > > +                       BT_IO_OPT_BASE, &base,
> > > +                       BT_IO_OPT_QOS, &qos,
> > > +                       BT_IO_OPT_INVALID);
> > > +       if (err) {
> > > +               error("%s", err->message);
> > >                 g_error_free(err);
> > >                 g_io_channel_shutdown(io, TRUE, NULL);
> > > +               return;
> > >         }
> > >
> > > +       /* The PA Sync channel becomes the new listen_io.
> > > +        * It will be later used to listen for a BIS io.
> > > +        */
> > > +       g_io_channel_unref(data->listen_io);
> > > +       data->listen_io =3D io;
> > > +       g_io_channel_ref(io);
> > > +
> > > +       /* Analyze received BASE data and create remote media endpoin=
ts for
> > each
> > > +        * matching BIS
> > > +        */
> > > +       base_s.subgroups =3D queue_new();
> > > +       bt_bap_parse_base(data->bap, base.base, base.base_len,
> > bap_debug,
> > > +                       &base_s);
> > > +       queue_foreach(base_s.subgroups, bt_bap_parse_bis, NULL);
> > >  }
> > >
> > >  static bool match_data_bap_data(const void *data, const void
> > > *match_data) @@ -1934,12 +1825,11 @@ static void setup_listen_io(stru=
ct
> > bap_data *data, struct bt_bap_stream *stream,
> > >         data->listen_io =3D io;
> > >  }
> > >
> > > -static void setup_listen_io_broadcast(struct bap_data *data,
> > > +static void setup_accept_io_broadcast(struct bap_data *data,
> > >                                         struct bap_setup *setup,
> > >                                         struct bt_bap_stream *stream,
> > >                                         struct bt_iso_qos *qos)  {
> > > -       GIOChannel *io;
> > >         GError *err =3D NULL;
> > >         struct sockaddr_iso_bc iso_bc_addr;
> > >
> > > @@ -1951,29 +1841,18 @@ static void setup_listen_io_broadcast(struct
> > > bap_data *data,
> > >
> > >         DBG("stream %p", stream);
> > >
> > > -       /* If IO already set skip creating it again */
> > > -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> > > -               return;
> > > -
> > > -       io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL=
, &err,
> > > -                       BT_IO_OPT_SOURCE_BDADDR,
> > > -                       btd_adapter_get_address(data->adapter),
> > > -                       BT_IO_OPT_DEST_BDADDR,
> > > -                       device_get_address(data->device),
> > > -                       BT_IO_OPT_DEST_TYPE,
> > > -                       btd_device_get_bdaddr_type(data->device),
> > > -                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > > -                       BT_IO_OPT_QOS, &qos->bcast,
> > > -                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_=
bis,
> > > -                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> > > -                       BT_IO_OPT_INVALID);
> > > -       if (!io) {
> > > -               error("%s", err->message);
> > > +       if (!bt_io_bcast_accept(data->listen_io,
> > > +                       iso_bcast_confirm_cb,
> > > +                       setup, NULL, &err,
> > > +                       BT_IO_OPT_ISO_BC_NUM_BIS,
> > > +                       iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
> > > +                       iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> > > +               error("bt_io_bcast_accept: %s", err->message);
> > >                 g_error_free(err);
> > >         }
> > > -       setup->io =3D io;
> > > -       data->listen_io =3D io;
> > >
> > > +       setup->io =3D data->listen_io;
> > > +       data->listen_io =3D NULL;
> > >  }
> > >  static void setup_create_ucast_io(struct bap_data *data,
> > >                                         struct bap_setup *setup, @@
> > > -2037,7 +1916,7 @@ done:
> > >         if (bt_bap_pac_get_type(setup->ep->lpac) =3D=3D
> > BT_BAP_BCAST_SOURCE)
> > >                 setup_connect_io_broadcast(data, setup, stream, &iso_=
qos);
> > >         else
> > > -               setup_listen_io_broadcast(data, setup, stream, &iso_q=
os);
> > > +               setup_accept_io_broadcast(data, setup, stream,
> > > + &iso_qos);
> > >  }
> > >
> > >  static void setup_create_io(struct bap_data *data, struct bap_setup
> > > *setup, @@ -2422,6 +2301,7 @@ static int bap_bcast_probe(struct
> > btd_service *service)
> > >         struct btd_gatt_database *database =3D
> > btd_adapter_get_database(adapter);
> > >         struct bap_data *data =3D btd_service_get_user_data(service);
> > >         char addr[18];
> > > +       GError *err =3D NULL;
> > >
> > >         ba2str(device_get_address(device), addr);
> > >
> > > @@ -2465,7 +2345,23 @@ static int bap_bcast_probe(struct btd_service
> > > *service)
> > >
> > >         bt_bap_set_user_data(data->bap, service);
> > >
> > > -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> > > +       DBG("Create PA sync with this source");
> > > +       data->listen_io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb=
, data,
> > > +                       NULL, &err,
> > > +                       BT_IO_OPT_SOURCE_BDADDR,
> > > +                       btd_adapter_get_address(data->adapter),
> > > +                       BT_IO_OPT_DEST_BDADDR,
> > > +                       device_get_address(data->device),
> > > +                       BT_IO_OPT_DEST_TYPE,
> > > +                       btd_device_get_bdaddr_type(data->device),
> > > +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > > +                       BT_IO_OPT_QOS, &bap_sink_sync_parameters,
> > > +                       BT_IO_OPT_INVALID);
> > > +       if (!data->listen_io) {
> > > +               error("%s", err->message);
> > > +               g_error_free(err);
> > > +       }
> >
> > I really doubt this will work in a crowded environment, it seems we wou=
ld be
> > doing several PA Sync in parallel, one for each announcement found, whi=
ch
> > not only would overwrite the QOS but also I don't think controller are =
capable
> > of doing multiple PA Sync like that so we might need to serialize the p=
rocess
> > of doing short lived PA Syncs to enumerate the BASE.
> >
> > Usually we have dealt with the serialization using an idle timer which =
can
> > then check services that need to be resolved, once a service is being
> > resolved then the timer shall be stopped, we restart the time everytime
> > something needs to be resolved.
> >
>
> bap_bcast_probe starts a PA Sync controller procedure for each new Broadc=
ast
> source seen.
> This can take several milliseconds with physical controller and runs in a=
n instant
> with the emulator. The problem that can arrive is that another Broadcast =
source
> gets probed and another bt_io_listen is executed before the previous one =
is
> completed. In this scenario the controller will return an error for no re=
sources
> and the second PA sync will fail, but the one in progress will complete s=
uccessfully.
> Given the timings for this to happen, can I submit a different patch for =
this
> issue, or shall I fix it in this one?

Yes, you can choose to fix it later by adding a TODO comment, that
said I'd fix the QoS being a static global.

> > > +
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
