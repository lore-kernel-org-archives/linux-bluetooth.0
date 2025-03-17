Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F171EB1A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237775; cv=none; b=KxnJqP76lAFot5rf87qFTGb2n6cqfJVqPJGQoSGliPRujJXRowGS9uCYiclvAFW2hjd8AuQAzECNgK7Rxf9mZ4IDh+cHJpp5UR7GcrimFKnQcTaQuvGbKTwB1aBKP8B/EflhYrCuEDL++bUf9H+qePqpa4a0MAEZBVUgOuKDkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237775; c=relaxed/simple;
	bh=Scmnff0CAEgJVbHa4EXuU+UWntPFTMeP+MQVxfsLTqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHipguMklaSMVVpm0DcEUFp9tgRLSG4nuIdJL6sPehLKNXNMlAQI2kLws9YwD/g9TLLyg7SUtv1nK1zpwoorHJ8giaea/Vw3dvokDVxz3vf3lrQFKGcKR0UYgi8PrgFuGdOuBqow82pQYgWEWPwjiCozX9YXPSxhPe7azg8Szm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLPPcwgs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLPPcwgs"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c0517142bso43004111fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237770; x=1742842570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsA1baSW2GG9zJr1UMdA/T8/A/7vhV2MmHPk+RkhP9M=;
        b=MLPPcwgsdZF9ocMRH5SPkrn8iiA6IYk8T8TPMDzAk3KY7ILYGtfmHo4LlXTx3Kb1Nv
         fjouHjz68Q5QznCWkqcWklBfz4E54XoNY8j0IKKpwDJWeiBkOQvNLHiVZ/vujsFT4YPl
         npm92JIn7VEiohG0ICmKAaYqsmqyZIOcmw9p0b35xfhmlNoZy8NZZRLiO7jozGNkyvC4
         WDr5RoQouT6tF8A/mePa8xsLVGERF6n8ukEyosLASX3SrVbrmu+7JOFmD2R/0lScCgV8
         fqoCV/z/EwMtjGwtvIhlWRIR3zoRlZL4dSFXBp6sW20aJ9vaua6O028/2KGmCk460dE2
         YskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237770; x=1742842570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsA1baSW2GG9zJr1UMdA/T8/A/7vhV2MmHPk+RkhP9M=;
        b=snya7kJJYHyfiZXUs2mE/mTZi6rDboqKT0nbYnRCfhKHfG6CUxVhlxZhLXv1TOTqJP
         +CrElrTCRlQoWA1qQ3bFbZzmUi278CbIFfv7GIqLgGPCZp7vvJEGeiQHQDV3scrAOh3U
         S6PslFDrRq1N6c625B4hpf8a6QCgLEhqMettPd5XTYDDkh9VjPIgnQ9tVY51cLs95hPX
         rDgnjpeRezt3YAQeeq6dq+TwCop1Ka3w5XG3P1Ij5JqhC+wViMHpPffjFBJzVRVLttFq
         oHH1zNwyE+7J33P7IVaDlvUGHXUInoizEvEyhnS+FJKMJvYaCo0q4z8RlQFFII3E1j0c
         zN3A==
X-Gm-Message-State: AOJu0Yx5ibAKKOyApX3EP/dvfzFDwJRY656b0ve0d9qM9sdBcD1/PsTi
	bsX77B1suJESgpLMP7sAxniTImIU8zA26LLl/PxqWr3q1QBNQzi04lmWGYExu/1CZShE+CybdeO
	yjwRDd+gLz5qpEuOUCbZ/Fm+++jYa8lzr+nI=
X-Gm-Gg: ASbGncsWjSVGpN2JfUrhWRQV2JIsukVidpIq28PLzc0Sjw79sHr3EzeARFbh+VM4F7i
	A+bQ7TjYhGVu0JxaCq6QzuzybH1+KE5enrWrvSX4W+MVLr6nkLHjsxz+W0A4ielCyYtDvwOvmE1
	QPs35ZtmMxdK7aIXVFVpV9HIMN
X-Google-Smtp-Source: AGHT+IFQ3H2LSNCc+WfWQNfK5+aUg7IMa0rH1gbby+HjOwPaZN6mLjI0asimJmOVOLXZREfnGDpQcV8oJZnuk8cxfZA=
X-Received: by 2002:a2e:a583:0:b0:30b:c6fe:4529 with SMTP id
 38308e7fff4ca-30c4a749065mr75357981fa.8.1742237770053; Mon, 17 Mar 2025
 11:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740844616.git.pav@iki.fi> <5f103220d38f8eb549eb41ac971d1f4cf1e684ba.1740844616.git.pav@iki.fi>
 <718e840dc3a3089f9a8bd24887191617e234c02a.camel@iki.fi>
In-Reply-To: <718e840dc3a3089f9a8bd24887191617e234c02a.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 14:55:57 -0400
X-Gm-Features: AQ5f1Jp62MVLDuVjsfhmddFmDwQEifn36ozsDv3QNwq52kODULAnQC0Es1S70Uo
Message-ID: <CABBYNZK9b5Wkm_cXwsW2ZTqf7E7bEyCjSHe_7OYvaDSa8YoQEg@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 6/9] shared/bap: make sure ucast client stream
 is destroyed after releasing
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 1, 2025 at 11:27=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> la, 2025-03-01 kello 17:57 +0200, Pauli Virtanen kirjoitti:
> > Upper layer as Unicast Client needs to be able to destroy streams when
> > it wants to reconfigure endpoints.
> >
> > This does not currently work right, because of Server issued
> > Releasing->Config (caching) state transitions, which currently cause
> > streams never enter Idle (so they are never destroyed).
> >
> > Fix this by considering Releasing->Config as Releasing->Idle->Config.
> > Also do not make new streams from cached config data as Unicast Client,
> > and leave all stream configuration to upper layer.

Not sure I follow you here, how can we consider it idle even for
cached config data? If we don't keep the stream there won't be a
MediaTransport representing it either so it won't even be possible to
know from the upper layer there is something already configured, so I
really think we should have an option to reconfigure at MediaTransport
layer rather than trying to hide it somehow.

> This change also implies the following, so that reconfiguring multi-ASE
> configurations works right:
>
>     shared/bap: ucast client streams always use a free ASE
>
>     Because upper layer controls Unicast Client streams, bt_bap_stream_ne=
w()
>     should for unicast always allocate an unused ASE.
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 4f44db07a..a85169009 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -5836,29 +5836,6 @@ static bool find_ep_unused(const void *data, const=
 void *user_data)
>                 return true;
>  }
>
> -static bool find_ep_pacs(const void *data, const void *user_data)
> -{
> -       const struct bt_bap_endpoint *ep =3D data;
> -       const struct match_pac *match =3D user_data;
> -
> -       if (!ep->stream)
> -               return false;
> -
> -       if (ep->stream->lpac !=3D match->lpac)
> -               return false;
> -
> -       if (ep->stream->rpac !=3D match->rpac)
> -               return false;
> -
> -       switch (ep->state) {
> -       case BT_BAP_STREAM_STATE_CONFIG:
> -       case BT_BAP_STREAM_STATE_QOS:
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
>  static bool find_ep_source(const void *data, const void *user_data)
>  {
>         const struct bt_bap_endpoint *ep =3D data;
> @@ -6053,15 +6030,11 @@ static struct bt_bap_stream *bap_ucast_stream_new=
(struct bt_bap *bap,
>         match.lpac =3D lpac;
>         match.rpac =3D rpac;
>
> -       /* Check for existing stream */
> -       ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> +       /* Find unused ASE */
> +       ep =3D queue_find(bap->remote_eps, find_ep_unused, &match);

And if there aren't any ASE left then what? I'd go with the design the
spec suggests that stream can be reconfigured for QoS Configuration
state down to Idle, the only hard part is figuring out if a stream
state affects another, etc.

>         if (!ep) {
> -               /* Check for unused ASE */
> -               ep =3D queue_find(bap->remote_eps, find_ep_unused, &match=
);
> -               if (!ep) {
> -                       DBG(bap, "Unable to find unused ASE");
> -                       return NULL;
> -               }
> +               DBG(bap, "Unable to find unused ASE");
> +               return NULL;
>         }
>
>         stream =3D ep->stream;
>
>
>
> > ---
> >  src/shared/bap.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 54c6e8629..4f44db07a 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -1363,6 +1363,31 @@ static void bap_stream_state_changed(struct bt_b=
ap_stream *stream)
> >       struct bt_bap *bap =3D stream->bap;
> >       const struct queue_entry *entry;
> >
> > +     switch (stream->ep->old_state) {
> > +     case BT_ASCS_ASE_STATE_RELEASING:
> > +             /* After Releasing, Server may either transition to Confi=
g or
> > +              * Idle. Our Unicast Client streams shall be considered
> > +              * destroyed after Releasing, so that upper layer can con=
trol
> > +              * stream creation. Make the lifecycle management simpler=
 by
> > +              * making sure the streams are destroyed by always emitti=
ng Idle
> > +              * to upper layer after Releasing, even if the remote ASE=
 did
> > +              * not go through that state.
> > +              */
> > +             if (stream->client &&
> > +                             stream->ep->state !=3D BT_ASCS_ASE_STATE_=
IDLE &&
> > +                             (stream->lpac->type & (BT_BAP_SINK |
> > +                                                     BT_BAP_SOURCE))) =
{
> > +                     struct bt_bap_endpoint *ep =3D stream->ep;
> > +                     uint8_t state =3D ep->state;
> > +
> > +                     ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> > +                     bap_stream_state_changed(stream);
> > +                     ep->state =3D state;
> > +                     return;
> > +             }
> > +             break;
> > +     }
> > +
> >       /* Pre notification updates */
> >       switch (stream->ep->state) {
> >       case BT_ASCS_ASE_STATE_IDLE:
> > @@ -4851,7 +4876,8 @@ static void ep_status_config(struct bt_bap *bap, =
struct bt_bap_endpoint *ep,
> >       }
> >
> >       /* Any previously applied codec configuration may be cached by th=
e
> > -      * server.
> > +      * server. However, all Unicast Client stream creation shall be l=
eft to
> > +      * the upper layer.
> >        */
> >       if (!ep->stream) {
> >               struct match_pac match;
> > @@ -4866,7 +4892,9 @@ static void ep_status_config(struct bt_bap *bap, =
struct bt_bap_endpoint *ep,
> >               if (!match.lpac || !match.rpac)
> >                       return;
> >
> > -             bap_stream_new(bap, ep, match.lpac, match.rpac, NULL, tru=
e);
> > +             if (!(match.lpac->type & (BT_BAP_SINK | BT_BAP_SOURCE)))
> > +                     bap_stream_new(bap, ep, match.lpac, match.rpac,
> > +                                                             NULL, tru=
e);
> >       }
> >
> >       if (!ep->stream)
>
>


--=20
Luiz Augusto von Dentz
