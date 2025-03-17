Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAB1E1E11
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238866; cv=pass; b=PuOfDrQTx9J4XUbM6g1g2J+vFhUxpnvnUCQRdK4bh7PG6YaswnCuUS34giJVal3pPWJtq5pJeE4smbWuS88JCRy/g29c+okl77O9FRm6DxUWE0i5gWMawIwJDC0P2ERhCcE4ei+Z8FAiRfeSrlMmYZuJ5MR58y75DT49qc0n2FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238866; c=relaxed/simple;
	bh=Nd9FRfoX+4Tm629zf7oMlsOW9Z5Z48EQA0Z908VyvzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEz+JjiY/ULAXDIxVl3vm1G8T1y9kAtD2sFUTLKc6ZNbHyjeVzFyKgUHY7n7xLodEfAFcatuAOCyQ5N9Tf7jSH2MMiLljm0/KwzS4lF5RzS6RTozPWIT24lNJSt+ZhA/nOlDLJlpY/vxp4Y21Nwqb2vJ/i5sMiuA8/TUFxiGnZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pmKe+odi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pmKe+odi"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZGl5K4Sw7z49Q4s;
	Mon, 17 Mar 2025 21:14:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742238854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ModkMsTe5/2bng4gztHa4LulhOsaDbCh0dBKGeTQzQ=;
	b=pmKe+odiABrxk30/AJ5ZIu3pc/+MchpXsGu4999imje9Bao91FsTl5KA7yt23FALRrLxgL
	dKOhIy5dEkFUDTM4yla6+9LcmP/boaYnxNk/bqLslA5VngRBcJVc62J5Dkndm7QeU189pS
	gC/aq2gqYPONAtVe1llguEk8eKZUHBlBRAsUHHFnZyyYgv3h/jS+BGBFc1B8LaUIFeBrjp
	Ok0lM54sNhjC9CdR27bMDH+ReGf8I6oSE3yCsHY5CRcogwuEgdDoY91cAj3O+YPlmVgPYr
	8uNNEgC5cpNmWvk3+vroKIBdlKQJKfzj4NjCPKBKe1EXQ18z5Q8hA/6EFiR+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742238854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ModkMsTe5/2bng4gztHa4LulhOsaDbCh0dBKGeTQzQ=;
	b=AF8OF9J2JaHY07sHgXHdsKE1ayVhQFPHFBX07efo2xofaf1g5HnEEdxraSdUa6N+JeC7HC
	3YiQ1WecW1g2QDhzSLif8G3WGyEj+bDjg4yFcI+nGQ/rUEEIKfpRDoWgURGQqtVjkHflIg
	k12+CmLrrudaVk90UO1i6JQ8NeT6S3P73hJjU5T3pHeM8TO7fHJRScmUH7rmFc97XTLdl9
	ncSK4oFM6XZq/0sEcvOpq0JifejdFqa2d4uzRFzhAMFoZXRk/oQMIDqQ2Lo2TsdaPNz/FX
	whkK5x1AkVKhvEAX/yKze05Jh3d+0fpP8u45LHTaOP+QsfTNA5BfU6svEwSgkQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742238854; a=rsa-sha256;
	cv=none;
	b=ahMcixf183BoDCzY6QcpDrthy6q/67WKf8NSvJMyeICmTAqM2Tzpsjfjwn9Ulu6ZpTEl01
	uX41B626J4J0H83uQHL8SqhJwuWfjx7twTRqWz2x6qCa1y8UddVKrxufJ3mS7blpf3HTEJ
	sw9bP1VgSAlIcgvYEwpYoHkEROSuBayZNhLCMAf2uwpzVUD7fLrgdeHDlDrKwWDQxvoLq3
	AaozOti1OQmxfAshj7206596fqh8zWPUn49pPoMGqn5+O2OZsx45ai8cP/hJ2I5a/ebu9n
	qX10ulyxfLi8kKyd0zhQemVFV4fQJ3ttxJZcGGF1tCZs4YLB2w8H4sDMuucy/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <9b9eb57b27f6ff2d1557409a441f24d24791a429.camel@iki.fi>
Subject: Re: [RFC PATCH BlueZ 6/9] shared/bap: make sure ucast client stream
 is destroyed after releasing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Mar 2025 21:14:11 +0200
In-Reply-To: <CABBYNZK9b5Wkm_cXwsW2ZTqf7E7bEyCjSHe_7OYvaDSa8YoQEg@mail.gmail.com>
References: <cover.1740844616.git.pav@iki.fi>
	 <5f103220d38f8eb549eb41ac971d1f4cf1e684ba.1740844616.git.pav@iki.fi>
	 <718e840dc3a3089f9a8bd24887191617e234c02a.camel@iki.fi>
	 <CABBYNZK9b5Wkm_cXwsW2ZTqf7E7bEyCjSHe_7OYvaDSa8YoQEg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-03-17 kello 14:55 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sat, Mar 1, 2025 at 11:27=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > la, 2025-03-01 kello 17:57 +0200, Pauli Virtanen kirjoitti:
> > > Upper layer as Unicast Client needs to be able to destroy streams whe=
n
> > > it wants to reconfigure endpoints.
> > >=20
> > > This does not currently work right, because of Server issued
> > > Releasing->Config (caching) state transitions, which currently cause
> > > streams never enter Idle (so they are never destroyed).
> > >=20
> > > Fix this by considering Releasing->Config as Releasing->Idle->Config.
> > > Also do not make new streams from cached config data as Unicast Clien=
t,
> > > and leave all stream configuration to upper layer.
>=20
> Not sure I follow you here, how can we consider it idle even for
> cached config data?=C2=A0If we don't keep the stream there won't be a
> MediaTransport representing it either so it won't even be possible to
> know from the upper layer there is something already configured, so I
> really think we should have an option to reconfigure at MediaTransport
> layer rather than trying to hide it somehow.

The idea is that in Client role, the upper layer does not care whether
an ASE is configured or idle.=C2=A0It has to (re)configure it before it
wants to use it. The cost of this is that you are sometimes doing some
Config Codec that wouldn't be strictly needed, but it is harmless.

The problem here was that that linking of CIS gets broken by the
configured streams. That said, now I see it might be addressed just by
clearing the stream QoS and linking state when Releasing (QoS is then
invalid anyway so it needs to be cleared).


> > This change also implies the following, so that reconfiguring multi-ASE
> > configurations works right:
> >=20
> >     shared/bap: ucast client streams always use a free ASE
> >=20
> >     Because upper layer controls Unicast Client streams, bt_bap_stream_=
new()
> >     should for unicast always allocate an unused ASE.
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 4f44db07a..a85169009 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -5836,29 +5836,6 @@ static bool find_ep_unused(const void *data, con=
st void *user_data)
> >                 return true;
> >  }
> >=20
> > -static bool find_ep_pacs(const void *data, const void *user_data)
> > -{
> > -       const struct bt_bap_endpoint *ep =3D data;
> > -       const struct match_pac *match =3D user_data;
> > -
> > -       if (!ep->stream)
> > -               return false;
> > -
> > -       if (ep->stream->lpac !=3D match->lpac)
> > -               return false;
> > -
> > -       if (ep->stream->rpac !=3D match->rpac)
> > -               return false;
> > -
> > -       switch (ep->state) {
> > -       case BT_BAP_STREAM_STATE_CONFIG:
> > -       case BT_BAP_STREAM_STATE_QOS:
> > -               return true;
> > -       }
> > -
> > -       return false;
> > -}
> > -
> >  static bool find_ep_source(const void *data, const void *user_data)
> >  {
> >         const struct bt_bap_endpoint *ep =3D data;
> > @@ -6053,15 +6030,11 @@ static struct bt_bap_stream *bap_ucast_stream_n=
ew(struct bt_bap *bap,
> >         match.lpac =3D lpac;
> >         match.rpac =3D rpac;
> >=20
> > -       /* Check for existing stream */
> > -       ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> > +       /* Find unused ASE */
> > +       ep =3D queue_find(bap->remote_eps, find_ep_unused, &match);
>=20
> And if there aren't any ASE left then what? I'd go with the design the
> spec suggests that stream can be reconfigured for QoS Configuration
> state down to Idle, the only hard part is figuring out if a stream
> state affects another, etc.
>=20
> >         if (!ep) {
> > -               /* Check for unused ASE */
> > -               ep =3D queue_find(bap->remote_eps, find_ep_unused, &mat=
ch);
> > -               if (!ep) {
> > -                       DBG(bap, "Unable to find unused ASE");
> > -                       return NULL;
> > -               }
> > +               DBG(bap, "Unable to find unused ASE");
> > +               return NULL;
> >         }
> >=20
> >         stream =3D ep->stream;
> >=20
> >=20
> >=20
> > > ---
> > >  src/shared/bap.c | 32 ++++++++++++++++++++++++++++++--
> > >  1 file changed, 30 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index 54c6e8629..4f44db07a 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -1363,6 +1363,31 @@ static void bap_stream_state_changed(struct bt=
_bap_stream *stream)
> > >       struct bt_bap *bap =3D stream->bap;
> > >       const struct queue_entry *entry;
> > >=20
> > > +     switch (stream->ep->old_state) {
> > > +     case BT_ASCS_ASE_STATE_RELEASING:
> > > +             /* After Releasing, Server may either transition to Con=
fig or
> > > +              * Idle. Our Unicast Client streams shall be considered
> > > +              * destroyed after Releasing, so that upper layer can c=
ontrol
> > > +              * stream creation. Make the lifecycle management simpl=
er by
> > > +              * making sure the streams are destroyed by always emit=
ting Idle
> > > +              * to upper layer after Releasing, even if the remote A=
SE did
> > > +              * not go through that state.
> > > +              */
> > > +             if (stream->client &&
> > > +                             stream->ep->state !=3D BT_ASCS_ASE_STAT=
E_IDLE &&
> > > +                             (stream->lpac->type & (BT_BAP_SINK |
> > > +                                                     BT_BAP_SOURCE))=
) {
> > > +                     struct bt_bap_endpoint *ep =3D stream->ep;
> > > +                     uint8_t state =3D ep->state;
> > > +
> > > +                     ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> > > +                     bap_stream_state_changed(stream);
> > > +                     ep->state =3D state;
> > > +                     return;
> > > +             }
> > > +             break;
> > > +     }
> > > +
> > >       /* Pre notification updates */
> > >       switch (stream->ep->state) {
> > >       case BT_ASCS_ASE_STATE_IDLE:
> > > @@ -4851,7 +4876,8 @@ static void ep_status_config(struct bt_bap *bap=
, struct bt_bap_endpoint *ep,
> > >       }
> > >=20
> > >       /* Any previously applied codec configuration may be cached by =
the
> > > -      * server.
> > > +      * server. However, all Unicast Client stream creation shall be=
 left to
> > > +      * the upper layer.
> > >        */
> > >       if (!ep->stream) {
> > >               struct match_pac match;
> > > @@ -4866,7 +4892,9 @@ static void ep_status_config(struct bt_bap *bap=
, struct bt_bap_endpoint *ep,
> > >               if (!match.lpac || !match.rpac)
> > >                       return;
> > >=20
> > > -             bap_stream_new(bap, ep, match.lpac, match.rpac, NULL, t=
rue);
> > > +             if (!(match.lpac->type & (BT_BAP_SINK | BT_BAP_SOURCE))=
)
> > > +                     bap_stream_new(bap, ep, match.lpac, match.rpac,
> > > +                                                             NULL, t=
rue);
> > >       }
> > >=20
> > >       if (!ep->stream)
> >=20
> >=20
>=20
>=20

--=20
Pauli Virtanen
