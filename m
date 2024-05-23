Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20D14B09F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473730; cv=none; b=X8uT0psJqB37nG2RvCNMIaCoU83G+lxNgvi09AcyPcTo+eZicoOoLFf8y9q93aXbdhU8CxcVJ5L1daIRzYkR9WHfAkouuzrnUUAuiThbAavP6cn2hXp+rroU8OGjUOSKqvAY0XPZ8Ifyl7ComlDT7+neOiW9rINvrLcijXfRIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473730; c=relaxed/simple;
	bh=aipzE5GtRGlWYLWYLK+tSGMGIQ8xwpAWT9JjK7f//VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPSUlYQezqkAq3kNq60/B0YuO9fjhtk0nfcP6E95NW788EJRW5sozcxU8BYIFrQ/KiQE8RNQp0dIYMvbKUvH9rSJxgjOsE6WHVcmF9bULTLiOlQw9oLg+yCpH8HeQ4vqnUHo7PzJMCueY0BClkn8SPuDMOZWIjhigACwRliWbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Meb6P8c2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Meb6P8c2"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so78436271fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716473727; x=1717078527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCvsWLI5Wjie2p5MB9xiS3HRVVSzH6zr8ybb90pJ3oA=;
        b=Meb6P8c2G0xb39fVOtCd+NnXJMYSGx/R8I/KknsQN3Apo1OznEKOB8ke9gOGSyBvk9
         hdJuJzqz5KXZgltHq2d7qu7To9tEGNeMsDyx4zXlLO2+tzN1llTkL1oINYNfeg+3vsOG
         6F/6immGrbW4Uy8zqxQLJPawlkBkRnd6lHTiPmj9sTA5IUiyeTPPUZTmrjHGhVZ8wN5Z
         wy8vvONdOeq00ZWGIx/Ui0P3cqW7eAtHnaoxi/5/0wXz/d76UrcKoOV/W4Yvy/JSfttU
         o0djByPdYXjQkIIUgm5kdCzfKpJwNCHb6cW/Bylk7nnAxsqjEXekK+1zUg1G5iOmQMCC
         2Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716473727; x=1717078527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCvsWLI5Wjie2p5MB9xiS3HRVVSzH6zr8ybb90pJ3oA=;
        b=o/oGcfmclvZU49xQIoRxt484I6zCu4wcxjN/2Tn7hFf27KDjI0EIW8ey1I1jQFBFG4
         LqHrbMKaME8sJ+9OY2h4fAivdOjmczNRxRkQttUe6ZfG4ohycjlLdLPUJ144dxDYa61f
         dGNNmzp6Y/HyYww3OhtGP7rA1rpn4y+glQ4JVLeuI9/3sWtBAT1yRtYVB0k/6e6DfbwO
         OGohE96WAqN4aPgVhYoHTBexMHE0nObyINr2HhlqzLrviCkl4yQ5txvCQgVIUcgpoAlW
         99ACFo2OU3+WJpm3wKC2b8qisA8iuCHyWKC+q5OpXbB7U0CnY10MGKtSOaAm2cpaI4MQ
         4lKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZP10aoxMIgCGvBEP7bIyAgTP84mpZwX86Q52vKF6L1nJJIiMWASMVHvEUfm6Ge0qrNwqIR2rPuLJSZN00/62n+UE0t05p8ghXE5QG1D+
X-Gm-Message-State: AOJu0YzVLG1pg9cB/vv+vbrGthmjnA/5gklFto81kT1bf/3LrZX/8iT3
	vZw2zojgeFLBkYfGeyq4FHBK9yRtyz9vS1Ip9EhFQC3/m0f+QbfVua6SNzLc3mWtXLPNain1Yok
	2PvujcXbV7c1zecLogs+m0zSEuQo=
X-Google-Smtp-Source: AGHT+IFVs6vSnhHfNHb7F6BWCDYZBu/lOtuyyLnOeMY6lzpOtleT1IU9T9hWgTBpqqon1ldfrjBi3gqvG3JtcCVorFA=
X-Received: by 2002:a05:651c:49e:b0:2e9:48e6:594a with SMTP id
 38308e7fff4ca-2e9495bab47mr31861061fa.47.1716473726614; Thu, 23 May 2024
 07:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLzSW1VBxZE_f=Qya31OerUxHuwHFOxQJtzNoNt29ia7g@mail.gmail.com>
 <20240523104643.18999-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240523104643.18999-1-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 May 2024 10:15:13 -0400
Message-ID: <CABBYNZKkW_q06o4+KYhGg=HcP_+CHPCUPGDaJ-OUryqCoS-ckg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast Source state machine
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com, 
	linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, May 23, 2024 at 6:46=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Monday, May 20, 2024 7:40 PM
> > To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> > Istodorescu <andrei.istodorescu@nxp.com>; Iulia Tanasescu
> > <iulia.tanasescu@nxp.com>
> > Subject: [EXT] Re: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast S=
ource
> > state machine
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t this
> > email' button
> >
> >
> > Hi Silviu,
> >
> > On Mon, May 20, 2024 at 12:28 PM Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com> wrote:
> > >
> > > Update BAP Broadcast Source state machine states to use BAP define
> > > states  for source Idle, Config, Streaming, and an intermediary state=
 enabling.
> >
> > Not really following, what is an intermediary state? Or do you mean int=
ernal
> > state? And more importantly why would we need an internal state like th=
at?
> >
>
> Hi Luiz we use the ENABLING state to know when a transport linked to a st=
ream
> has been acquired by a process and in the case of a BIG with one BIS stre=
am goes
> in the ENABLING state waiting for the response from the kernel that the B=
IG has
> been created so it can go to the streaming state.
> For the case of a BIG with multiple BISes, the BIG is created when all BI=
Ses
> are acquired. So we use the ENABLING state to  verify that all transports
> attached to that streams form  BIG have been acquired so we can create th=
e BIG.
> If we don=E2=80=99t use this internal state we can use a flag in the stre=
am structure
> to be informed that the transport attached to the stream is in the acquir=
ing
> procedure, but this would not look good, as we will have a flag intercala=
ted
> with the stream state machine.

Fair enough, please add this information as a comment so in the future
we know why we are using enabling for broadcast.

> > > Updated test-bap too.
> > >
> > > ---
> > >  src/shared/bap.c | 39 ++++++++++++++++++++-------------------
> > >  unit/test-bap.c  |  4 ++--
> > >  2 files changed, 22 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c index
> > > 6572ef1d1..639149520 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -1361,14 +1361,6 @@ static void ep_config_cb(struct bt_bap_stream
> > *stream, int err)
> > >         if (err)
> > >                 return;
> > >
> > > -       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_=
BCAST)
> > {
> > > -               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_=
SINK)
> > > -                       stream_set_state(stream, BT_BAP_STREAM_STATE_=
QOS);
> > > -               else if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_B=
CAST_SOURCE)
> > > -                       stream_set_state(stream, BT_BAP_STREAM_STATE_=
CONFIG);
> > > -               return;
> > > -       }
> > > -
> > >         stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);  }
> > >
> > > @@ -1759,6 +1751,15 @@ static unsigned int bap_stream_metadata(struct
> > bt_bap_stream *stream,
> > >         return req->id;
> > >  }
> > >
> > > +static unsigned int bap_bcast_qos(struct bt_bap_stream *stream,
> > > +                                       struct bt_bap_qos *data,
> > > +                                       bt_bap_stream_func_t func,
> > > +                                       void *user_data) {
> > > +       stream->qos =3D *data;
> > > +       return 1;
> > > +}
> > > +
> > >  static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
> > >                                      struct bt_bap_qos *qos, struct i=
ovec *data,
> > >                                      bt_bap_stream_func_t func, void
> > > *user_data) @@ -2071,7 +2072,7 @@ static unsigned int
> > bap_bcast_get_state(struct bt_bap_stream *stream)
> > >         return stream->state;
> > >  }
> > >
> > > -static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
> > > +static unsigned int bap_bcast_sink_enable(struct bt_bap_stream
> > > +*stream,
> > >                                         bool enable_links, struct iov=
ec *data,
> > >                                         bt_bap_stream_func_t func,
> > >                                         void *user_data) @@ -2081,22
> > > +2082,21 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream
> > *stream,
> > >         return 1;
> > >  }
> > >
> > > -static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
> > > +static unsigned int bap_bcast_src_enable(struct bt_bap_stream *strea=
m,
> > > +                                       bool enable_links, struct
> > > +iovec *data,
> > >                                         bt_bap_stream_func_t func,
> > >                                         void *user_data)  {
> > > -       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> > > +       stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
> > >
> > >         return 1;
> > >  }
> > >
> > > -static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *str=
eam,
> > > -                                       bool disable_links,
> > > +static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
> > >                                         bt_bap_stream_func_t func,
> > >                                         void *user_data)
> > >  {
> > > -       bap_stream_io_detach(stream);
> > > -       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > > +       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> > >
> > >         return 1;
> > >  }
> > > @@ -2106,7 +2106,8 @@ static unsigned int bap_bcast_disable(struct
> > bt_bap_stream *stream,
> > >                                         bt_bap_stream_func_t func,
> > >                                         void *user_data)
> > >  {
> > > -       stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
> > > +       bap_stream_io_detach(stream);
> > > +       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > >
> > >         return 1;
> > >  }
> > > @@ -2205,14 +2206,14 @@ static const struct bt_bap_stream_ops
> > stream_ops[] =3D {
> > >                         bap_ucast_release, bap_ucast_detach),
> > >         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
> > >                         bap_bcast_get_state,
> > > -                       bap_bcast_config, NULL, bap_bcast_enable,
> > > -                       bap_bcast_start, bap_bcast_sink_disable, NULL=
,
> > > +                       bap_bcast_config, NULL, bap_bcast_sink_enable=
,
> > > +                       bap_bcast_start, bap_bcast_disable, NULL,
> > >                         bap_bcast_metadata, bap_bcast_sink_get_dir,
> > >                         bap_bcast_get_location,
> > >                         bap_bcast_release, bap_bcast_sink_detach),
> > >         STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
> > >                         bap_bcast_get_state,
> > > -                       bap_bcast_config, NULL, bap_bcast_enable,
> > > +                       bap_bcast_config, bap_bcast_qos, bap_bcast_sr=
c_enable,
> > >                         bap_bcast_start, bap_bcast_disable, NULL,
> > >                         bap_bcast_metadata, bap_bcast_src_get_dir,
> > >                         bap_bcast_get_location,
> > > diff --git a/unit/test-bap.c b/unit/test-bap.c
> > > index 46ee0e4e5..10f9e348c 100644
> > > --- a/unit/test-bap.c
> > > +++ b/unit/test-bap.c
> > > @@ -547,10 +547,10 @@ static void bsrc_state(struct bt_bap_stream
> > *stream, uint8_t old_state,
> > >         struct test_data *data =3D user_data;
> > >
> > >         switch (new_state) {
> > > -       case BT_BAP_STREAM_STATE_QOS:
> > > +       case BT_BAP_STREAM_STATE_CONFIG:
> > >                 bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
> > >                 break;
> > > -       case BT_BAP_STREAM_STATE_CONFIG:
> > > +       case BT_BAP_STREAM_STATE_ENABLING:
> > >                 data->base =3D bt_bap_stream_get_base(stream);
> > >
> > >                 g_assert(data->base);
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>


--=20
Luiz Augusto von Dentz
