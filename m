Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54815B0FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133504; cv=none; b=e3r2ZAi2RsTSAjdS2JTJKIZUmNCcttA+YoCSfWjfwbuaY+o3ESETYroW6tA6lKvmsI20gWkK1mqV9+wb2dxhHNYpG2d+Wrk3GynUIOYGX9cSdL0imMWe5ic6p58a/gPHMejd1InzM9xNJxeZDI7V3t/mRJvr9bw8FdSCxnwLmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133504; c=relaxed/simple;
	bh=MPwb+xXkHPKjiTxdShNtfI90y1xNAAbXxXE2t+suJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j766yHXR/hV3frR6r4jS0J93pWRYhYQ6C5FfBt4DLfhsCnTlEEu9l2Gxx/NBXaH4aXuoaF+1AMxzooHlwOVfSW1qqMxjUqRdpjbJofkF+5B//X4u/JVBH2JwZXJlJDoOpcXt7kVu33K9ES5rnx88Hedx+iVAIKDohdu0k/negRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng8gS2h9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng8gS2h9"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2533089f6so69943941fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133500; x=1709738300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFrgTCpyjZKw0/nnc0xb8SIQfr724uYyxgePb2m3aTY=;
        b=ng8gS2h9iqE9o6mBCYrj4MAQvVXfyl2ac/N3VnN7QWvyL/EwKJnpGTbR6fvsDppHPG
         cKE5w9KHZ+UHUX1ffbXNS22fAX7udDErAx2u0PpID/eKLqhF0LFvnsKyNEWWb4Exqwee
         aBHCjTAaRfbOofrW4H+6cZ5+gIK2i+gHYXpkpyxH/zG77t690JEnZZOBPbsay7arDCOD
         qzgSuMR+azE28Kdb/Qix1Y328jZB8e0hNcgyYylhhIc+V6aVL+VXrfKq2Ta95XMcfBQc
         /MahpdlemA5VZQebIdUyygawzQys5V4WDvGcEDjZCvarKBBwjKkepnoB5pCyvWuckUXe
         y+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133500; x=1709738300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFrgTCpyjZKw0/nnc0xb8SIQfr724uYyxgePb2m3aTY=;
        b=apMpjOV+P+fA7twGO5UfI7MCRXG/sHBPoU2kAN1AG2WbpBnVxt8h2Uw6C8RmEENXlO
         /9ohIGHHK3W3C5fNLu4yuH1XWiUmPHQdF+Oici6dEEGPiBYaSF7CvfjQkOJVgk08CtR/
         v0lu5Cf1fkJl5s+L5Rzq36Osg9vbNv9a2RQvE+jxHaxSIE1+434pAsH4aLUMUJ/djAKg
         /V3629HpxGkX9sdCgYSuoelwzIrwXDp5MHaej6xXcH+VP4UV0DRfgmyUstU4FodCKnWC
         /Nl2zUUwSfirvqJM3d7REhcRh2e//vZD32OI1C5uJrKf86eENftytoonr/motxWdcysr
         qh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVJ9VjvKPrHe4Y3K6JQf2ba61caUzLRvLjnfdHRhisxK4Y0t01OYFV+nkWhXFbMtArBh9ppdTXXmX5i+b7i7V5A7/C8GIflkAZoTwiavHC
X-Gm-Message-State: AOJu0Yxt3g9PbntADmXm6pNx9brMMPx0bE3bpSU8myOYGMy0HHdbiK58
	3iaV/w9dOyiVBtzK6xU2XIIg/OiCUjsO79q9i6nciVqMgSlcnDGoCj9nbfKnRix4fY5gFWaUQNk
	MuVKa/Sv/oFcCflFw7rykvnjhrLapif+U
X-Google-Smtp-Source: AGHT+IFBakfPNH8gfn9UAiMJHqIY6BdGV05Q2YtAbHcqKiY8+f/ALjfMsquCankq/44pawKSx1f7hLokdJxnQoFPxeI=
X-Received: by 2002:a2e:99d9:0:b0:2d2:a3b7:da41 with SMTP id
 l25-20020a2e99d9000000b002d2a3b7da41mr3123202ljj.43.1709133500186; Wed, 28
 Feb 2024 07:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+0mMAw4ftbwGE_s49QOQrRZAFGRVEXucxWkv=6YEG+iA@mail.gmail.com>
 <20240228151227.12034-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240228151227.12034-1-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Feb 2024 10:18:07 -0500
Message-ID: <CABBYNZLjqq8QBn48K+jLFhJLoQcehJfcq0_jgYDeb=ou4edGfg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an observed BIS
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Wed, Feb 28, 2024 at 10:12=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Hi Luiz,
>
> I have fixed all the comments excepting one. Please see inline.
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Tuesday, February 27, 2024 4:39 PM
> > To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> > Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > Subject: Re: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an
> > observed BIS
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
> > On Fri, Feb 23, 2024 at 10:34 AM Andrei Istodorescu
> > <andrei.istodorescu@nxp.com> wrote:
> > >
> > > Add API to add a PAC for each observed BIS that is supported by the
> > > local PACS data.
> > > Each BIS observed capabilities LTV is compared to the local
> > > capabilities and when we have a full LTVs match a PAC record is creat=
ed for
> > that BIS.
> > > Also a MediaEndpoint is registered over DBUS and the stream can be
> > > enabled using the SetConfiguration DBUS call.
> > > ---
> > >  src/shared/bap.c | 304
> > > ++++++++++++++++++++++++++++++++++++++++++++---
> > >  src/shared/bap.h |  13 +-
> > >  2 files changed, 302 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c index
> > > f5fc1402701c..853919111835 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -48,6 +48,15 @@
> > >
> > >  #define BAP_PROCESS_TIMEOUT 10
> > >
> > > +#define BAP_FREQ_LTV_TYPE 1
> > > +#define BAP_DURATION_LTV_TYPE 2
> > > +#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3 #define
> > > +BAP_FRAME_LEN_LTV_TYPE 4 #define
> > CODEC_SPECIFIC_CONFIGURATION_MASK (\
> > > +               (1<<BAP_FREQ_LTV_TYPE)|\
> > > +               (1<<BAP_DURATION_LTV_TYPE)|\
> > > +               (1<<BAP_FRAME_LEN_LTV_TYPE))
> > > +
> > >  struct bt_bap_pac_changed {
> > >         unsigned int id;
> > >         bt_bap_pac_func_t added;
> > > @@ -1692,11 +1701,8 @@ static unsigned int bap_bcast_config(struct
> > bt_bap_stream *stream,
> > >                                      bt_bap_stream_func_t func, void
> > > *user_data)  {
> > >         stream->qos =3D *qos;
> > > -       if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
> > > -               if (data)
> > > -                       stream_config(stream, data, NULL);
> > > -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > > -       }
> > > +       stream->lpac->ops->config(stream, stream->cc, &stream->qos,
> > > +                       ep_config_cb, stream->lpac->user_data);
> > >
> > >         return 1;
> > >  }
> > > @@ -3302,6 +3308,13 @@ static void bap_add_broadcast_source(struct
> > > bt_bap_pac *pac)  static void bap_add_broadcast_sink(struct bt_bap_pa=
c
> > > *pac)  {
> > >         queue_push_tail(pac->bdb->broadcast_sinks, pac);
> > > +
> > > +       /* Update local PACS for broadcast sink also, when registerin=
g an
> > > +        * endpoint
> > > +        */
> > > +       pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
> > > +       pacs_add_sink_supported_context(pac->bdb->pacs,
> > > +                       pac->qos.supported_context);
> > >  }
> > >
> > >  static void notify_pac_added(void *data, void *user_data) @@ -3453,6
> > > +3466,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct
> > bt_bap_pac *pac)
> > >         return &pac->qos;
> > >  }
> > >
> > > +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac) {
> > > +       return pac->data;
> > > +}
> > > +
> > > +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac) {
> > > +       return pac->metadata;
> > > +}
> > > +
> > >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)  {
> > >         if (!stream)
> > > @@ -5253,10 +5276,6 @@ bool bt_bap_stream_set_user_data(struct
> > > bt_bap_stream *stream, void *user_data)
> > >
> > >         stream->user_data =3D user_data;
> > >
> > > -       if (bt_bap_stream_get_type(stream) =3D=3D
> > BT_BAP_STREAM_TYPE_BCAST)
> > > -               stream->lpac->ops->config(stream, stream->cc, &stream=
->qos,
> > > -                                       ep_config_cb, stream->lpac->u=
ser_data);
> > > -
> > >         return true;
> > >  }
> > >
> > > @@ -5892,8 +5911,9 @@ static void add_new_subgroup(struct bt_base
> > > *base,
> > >
> > >  struct bt_ltv_match {
> > >         uint8_t l;
> > > -       uint8_t *v;
> > > +       void *data;
> > >         bool found;
> > > +       uint32_t data32;
> > >  };
> > >
> > >  struct bt_ltv_search {
> > > @@ -5912,7 +5932,7 @@ static void match_ltv(size_t i, uint8_t l, uint=
8_t t,
> > uint8_t *v,
> > >         if (ltv_match->l !=3D l)
> > >                 return;
> > >
> > > -       if (!memcmp(v, ltv_match->v, l))
> > > +       if (!memcmp(v, ltv_match->data, l))
> > >                 ltv_match->found =3D true;  }
> > >
> > > @@ -5924,7 +5944,7 @@ static void search_ltv(size_t i, uint8_t l,
> > > uint8_t t, uint8_t *v,
> > >
> > >         ltv_match.found =3D false;
> > >         ltv_match.l =3D l;
> > > -       ltv_match.v =3D v;
> > > +       ltv_match.data =3D v;
> > >
> > >         util_ltv_foreach(ltv_search->iov->iov_base,
> > >                         ltv_search->iov->iov_len, &t, @@ -5965,8
> > > +5985,10 @@ static bool compare_ltv(struct iovec *iov1,  }
> > >
> > >  struct bt_ltv_extract {
> > > -       struct iovec *result;
> > >         struct iovec *src;
> > > +       void *value;
> > > +       uint8_t len;
> > > +       struct iovec *result;
> > >  };
> > >
> > >  static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> > > @@ -5978,7 +6000,7 @@ static void extract_ltv(size_t i, uint8_t l,
> > > uint8_t t, uint8_t *v,
> > >
> > >         ltv_match.found =3D false;
> > >         ltv_match.l =3D l;
> > > -       ltv_match.v =3D v;
> > > +       ltv_match.data =3D v;
> > >
> > >         /* Search each BIS caps ltv in subgroup caps
> > >          * to extract the one that are BIS specific @@ -6111,3
> > > +6133,257 @@ struct iovec *bt_bap_stream_get_base(struct
> > bt_bap_stream
> > > *stream)
> > >
> > >         return base_iov;
> > >  }
> > > +
> > > +static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
> > > +               uint8_t *v, void *user_data) {
> > > +       uint32_t location32;
> > > +
> > > +       if (!v)
> > > +               return;
> > > +
> > > +       memcpy(&location32, v, l);
> > > +       *((uint32_t *)user_data) =3D le32_to_cpu(location32); }
> > > +
> > > +/*
> > > + * This function compares PAC Codec Specific Capabilities, with the
> > > +Codec
> > > + * Specific Configuration LTVs received in the BASE of the BAP
> > > +Source. The
> > > + * result is accumulated in data32 which is a bitmask of types.
> > > + */
> > > +static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8=
_t *v,
> > > +                                       void *user_data) {
> > > +       struct bt_ltv_match *compare_data =3D user_data;
> > > +       uint8_t *bis_v =3D compare_data->data;
> > > +
> > > +       switch (t) {
> > > +       case BAP_FREQ_LTV_TYPE:
> > > +       {
> > > +               uint16_t mask =3D *((uint16_t *)v);
> > > +
> > > +               mask =3D le16_to_cpu(mask);
> > > +               if (mask & (1 << (bis_v[0] - 1)))
> > > +                       compare_data->data32 |=3D 1<<t;
> > > +       }
> > > +       break;
> > > +       case BAP_DURATION_LTV_TYPE:
> > > +               if ((v[0]) & (1 << bis_v[0]))
> > > +                       compare_data->data32 |=3D 1<<t;
> > > +               break;
> > > +       case BAP_FRAME_LEN_LTV_TYPE:
> > > +       {
> > > +               uint16_t min =3D *((uint16_t *)v);
> > > +               uint16_t max =3D *((uint16_t *)(&v[2]));
> > > +               uint16_t frame_len =3D *((uint16_t *)bis_v);
> > > +
> > > +               min =3D le16_to_cpu(min);
> > > +               max =3D le16_to_cpu(max);
> > > +               frame_len =3D le16_to_cpu(frame_len);
> > > +               if ((frame_len >=3D min) &&
> > > +                               (frame_len <=3D max))
> > > +                       compare_data->data32 |=3D 1<<t;
> > > +       }
> >
> > Don't create new scopes inside a switch statement, that makes it hard t=
o
> > follow the code, if you really think that would help have a helper func=
tion to
> > check each field.
> >
> > > +       break;
> > > +       }
> > > +}
> > > +
> > > +static void check_source_ltv(size_t i, uint8_t l, uint8_t t, uint8_t=
 *v,
> > > +                                       void *user_data) {
> > > +       struct bt_ltv_match *local_data =3D user_data;
> > > +       struct iovec *pac_caps =3D local_data->data;
> > > +       struct bt_ltv_match compare_data;
> > > +
> > > +       compare_data.data =3D v;
> > > +
> > > +       /* Search inside local PAC's caps for LTV of type t */
> > > +       util_ltv_foreach(pac_caps->iov_base, pac_caps->iov_len, &t,
> > > +                                       check_pac_caps_ltv,
> > > + &compare_data);
> > > +
> > > +       local_data->data32 |=3D compare_data.data32; }
> > > +
> > > +static void bap_sink_check_level3_ltv(size_t i, uint8_t l, uint8_t t=
,
> > > +               uint8_t *v, void *user_data) {
> > > +       struct bt_ltv_extract *merge_data =3D user_data;
> > > +
> > > +       merge_data->value =3D v;
> > > +       merge_data->len =3D l;
> > > +}
> > > +
> > > +static void bap_push_ltv(struct iovec *output, uint8_t l, uint8_t t,
> > > +void *v) {
> > > +       l++;
> > > +       iov_append(output, 1, &l);
> > > +       iov_append(output, 1, &t);
> > > +       iov_append(output, l - 1, v);
> > > +}
> >
> > Perhaps we should create a helper function to do this sort of thing, ma=
ybe
> > util_ltv_push?
> >
> > > +static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t=
,
> > > +               uint8_t *v, void *user_data) {
> > > +       struct bt_ltv_extract *merge_data =3D user_data;
> > > +
> > > +       merge_data->value =3D NULL;
> > > +       util_ltv_foreach(merge_data->src->iov_base,
> > > +                       merge_data->src->iov_len,
> > > +                       &t,
> > > +                       bap_sink_check_level3_ltv, user_data);
> > > +
> > > +       /* If the LTV at level 2 was found at level 3 add the one fro=
m level 3,
> > > +        * otherwise add the one at level 2
> > > +        */
> > > +       if (merge_data->value)
> > > +               bap_push_ltv(merge_data->result, merge_data->len,
> > > +                               t, merge_data->value);
> > > +       else
> > > +               bap_push_ltv(merge_data->result, l, t, v); }
> > > +
> > > +static void check_local_pac(void *data, void *user_data) {
> > > +       struct bt_ltv_match *compare_data =3D user_data;
> > > +       struct iovec *bis_data =3D (struct iovec *)compare_data->data=
;
> > > +       const struct bt_bap_pac *pac =3D data;
> > > +
> > > +       /* Keep searching for a matching PAC if one wasn't found
> > > +        * in previous PAC element
> > > +        */
> > > +       if (compare_data->found =3D=3D false) {
> > > +               struct bt_ltv_match bis_compare_data =3D {
> > > +                               .data =3D pac->data,
> > > +                               .data32 =3D 0, /* LTVs bitmask result=
 */
> > > +                               .found =3D false
> > > +               };
> > > +
> > > +               /* loop each BIS LTV */
> > > +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_le=
n, NULL,
> > > +                               check_source_ltv, &bis_compare_data);
> > > +
> > > +               /* We have a match if all selected LTVs have a match =
*/
> > > +               if ((bis_compare_data.data32 &
> > > +                       CODEC_SPECIFIC_CONFIGURATION_MASK) =3D=3D
> > > +                       CODEC_SPECIFIC_CONFIGURATION_MASK)
> > > +                       compare_data->found =3D true;
> > > +       }
> > > +}
> > > +
> > > +static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t=
,
> > > +               uint8_t *v, void *user_data) {
> > > +       struct bt_ltv_match *data =3D user_data;
> > > +       uint32_t location32;
> > > +
> > > +       if (!v)
> > > +               return;
> > > +
> > > +       memcpy(&location32, v, l);
> > > +       location32 =3D le32_to_cpu(location32);
> > > +
> > > +       /* If all the bits in the received bitmask are found in
> > > +        * the local bitmask then we have a match
> > > +        */
> > > +       if ((location32 & data->data32) =3D=3D location32)
> > > +               data->found =3D true;
> > > +       else
> > > +               data->found =3D false;
> > > +}
> > > +
> > > +static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec
> > > +*bis_data) {
> > > +       struct bt_ltv_match compare_data =3D {};
> > > +
> > > +       /* Check channel allocation against the PACS location.
> > > +        * If we don't have a location set we can accept any BIS loca=
tion.
> > > +        * If the BIS doesn't have a location set we also accept it
> > > +        */
> > > +       compare_data.found =3D true;
> > > +
> > > +       if (ldb->pacs->sink_loc_value) {
> > > +               uint8_t type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> > > +
> > > +               compare_data.data32 =3D ldb->pacs->sink_loc_value;
> > > +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_le=
n, &type,
> > > +                               bap_sink_match_allocation, &compare_d=
ata);
> > > +       }
> > > +
> > > +       /* Check remaining LTVs against the PACs list */
> > > +       if (compare_data.found) {
> > > +               compare_data.data =3D bis_data;
> > > +               compare_data.found =3D false;
> > > +               queue_foreach(ldb->broadcast_sinks, check_local_pac,
> > > +                               &compare_data);
> > > +       }
> > > +
> > > +       return compare_data.found;
> > > +}
> > > +
> > > +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> > > +               struct bt_bap_codec *codec,
> > > +               struct iovec *l2_caps,
> > > +               struct iovec *l3_caps,
> > > +               struct iovec *meta)
> > > +{
> > > +       struct bt_bap_pac *pac_source_bis;
> > > +       struct bt_bap_endpoint *ep;
> > > +       int err =3D 0;
> > > +       struct bt_bap_pac_qos bis_qos =3D {0};
> > > +       uint8_t type =3D 0;
> > > +       struct bt_ltv_extract merge_data =3D {0};
> > > +
> > > +       merge_data.src =3D l3_caps;
> > > +       merge_data.result =3D new0(struct iovec, 1);
> > > +
> > > +       /* Create a Codec Specific Configuration with LTVs at level 2=
 (subgroup)
> > > +        * overwritten by LTVs at level 3 (BIS)
> > > +        */
> > > +       util_ltv_foreach(l2_caps->iov_base,
> > > +                       l2_caps->iov_len,
> > > +                       NULL,
> > > +                       bap_sink_check_level2_ltv, &merge_data);
> > > +
> > > +       /* Check each BIS Codec Specific Configuration LTVs against o=
ur Codec
> > > +        * Specific Capabilities and if the BIS matches create a PAC =
with it
> > > +        */
> > > +       if (bap_check_bis(bap->ldb, merge_data.result) =3D=3D false)
> > > +               goto cleanup;
> > > +
> > > +       DBG(bap, "Matching BIS %i", bis_index);
> > > +
> > > +       /* Create a QoS structure based on the received BIS informati=
on to
> > > +        * specify the desired channel for this BIS/PAC
> > > +        */
> > > +       type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> > > +       util_ltv_foreach(merge_data.result->iov_base,
> > > +                       merge_data.result->iov_len, &type,
> > > +                       bap_sink_get_allocation, &bis_qos.location);
> >
> > Isn't it better to parse this inline with the use of util_iov_pull_*?
> > If you don't want to change the iovec passed, which shall be made a con=
st if
> > that is intention, then just create a dup and parse it.
> merge_data.result is the concatenated list for Capabilities LTVs. We need=
 to
> extract the value for the Allocation LTV so that we pass it to the stream=
 qos.
> I used util_ltv_foreach to easily access the ltv. Do you see another way?
> Maybe I didn't understand your comment.

My bad, I thought  you were iterating over the same iov but the
merge_data is different, so please disconsider this comment.

>
> >
> > > +       /* Create a remote PAC */
> > > +       pac_source_bis =3D bap_pac_new(bap->rdb, NULL,
> > > +                               BT_BAP_BCAST_SOURCE, codec, &bis_qos,
> > > +                               merge_data.result, meta);
> > > +
> > > +       err =3D asprintf(&pac_source_bis->name, "%d", bis_index);
> > > +
> > > +       if (err < 0) {
> > > +               DBG(bap, "error in asprintf");
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       /* Add remote source endpoint */
> > > +       if (!bap->rdb->broadcast_sources)
> > > +               bap->rdb->broadcast_sources =3D queue_new();
> > > +       queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
> > > +
> > > +       queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis)=
;
> > > +       /* Push remote endpoint with direction sink */
> > > +       ep =3D bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK=
);
> > > +
> > > +       if (ep)
> > > +               queue_push_tail(bap->remote_eps, ep);
> > > +
> > > +cleanup:
> > > +       util_iov_free(merge_data.result, 1); }
> > > diff --git a/src/shared/bap.h b/src/shared/bap.h index
> > > 2c3550921f07..b2826719f84f 100644
> > > --- a/src/shared/bap.h
> > > +++ b/src/shared/bap.h
> > > @@ -4,7 +4,7 @@
> > >   *  BlueZ - Bluetooth protocol stack for Linux
> > >   *
> > >   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> > > - *  Copyright 2023 NXP
> > > + *  Copyright 2023-2024 NXP
> > >   *
> > >   */
> > >
> > > @@ -175,6 +175,10 @@ uint16_t bt_bap_pac_get_context(struct
> > bt_bap_pac
> > > *pac);
> > >
> > >  struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
> > >
> > > +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
> > > +
> > > +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
> >
> > Have these 2 functions above in a separate patch.
> >
> > >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> > >
> > >  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> > > @@ -323,3 +327,10 @@ void bt_bap_update_bcast_source(struct
> > bt_bap_pac
> > > *pac,  bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct
> > > bt_bap_pac *pac);
> > >
> > >  struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
> > > +
> > > +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> > > +               struct bt_bap_codec *codec,
> > > +               struct iovec *l2_caps,
> > > +               struct iovec *l3_caps,
> > > +               struct iovec *meta);
> > > +
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Regards,
> Andrei



--=20
Luiz Augusto von Dentz
