Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC11991DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730325840; cv=pass; b=hI0h4klhvy0DvkBibBgZFqsNqCZtsyRXJTQ/XWKLTS4qkl99zXZX0HmV1p9DIr/F/UQ0syKdJopTjEVagaT7iEh3zG3Pogfa6J3rBRXU0KavIeQr2dIzFygG93ENEk/Ssj5lKWxqmumQQdN0NpavdOa1tuzM6S/P45IiMYsKCZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730325840; c=relaxed/simple;
	bh=IO2H+ANsjQWvGlAshEhPdO5nwArRbUM7j3sVc6qg2QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLMB/CmddwIYePqzYHRc+HFjX+vsR4sXUr+lf4rD2jTwHivb3eYtwaIlmQHytoKLOrLgUdeprBhrYGNzP4nk2mAyQ3JZ7/D1koTKlWcDIIxqwqal2nXUHK1dnUW0dqz9gz6yE+rTTjnf1BDLN05PqGbN0T1asih9r1jP/Idhh+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=vMJT7w94; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="vMJT7w94"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Xf1Np0B7Rz49Q5X;
	Thu, 31 Oct 2024 00:03:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730325834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bzvVDo1oFNAoyuD+UrQvBHzdZ69hPGSsjI8QmDp3G8g=;
	b=vMJT7w94n//krMYsO21uTrlN2YOD/xtYiRiM4/mKmn7GWSlhNc0wgMI4ZgxO+rDIcDBEvl
	geUAZcuTWNmn+ULj91H43X7x9Ki8EgGBASvUW/WJUCTdosTAdPWB4cPSsqFia9MIV1k4fv
	CkGMfnUNycKaGSGepmb7VIBFkXDQHuzN30wbBmYs0mNNE7XHFjD46ZeRUUfIhcBHiUrVoc
	h9VoktMPNkC15r7HDbqVqRQABVZelYcYpbPPEogZckSMC+cifhRDa1iA//RzG2rm6NZ1Ek
	p5zUr30e0NlXY2PPxlcGKWyl/3Q0gCs+LnjrqPCTAOkG4OrZPj3JYuy5KeoxxQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1730325834; a=rsa-sha256;
	cv=none;
	b=l9dCndlZ0P/As+LePNLchQ1q6t2E4QdsV2EP5cLXyCYATfjEpWMDgchK3JIvKGdDxLx+Jt
	2/EE5D0bQdKWaDq/E3CwGBCMTywpiyEszqWIiPyD08sYcCSq8vJV9Ys2aw+DU8mlMZBjCq
	wzw2LxNJ/HOOnvFnFpDYRd8LaRFBFr4DPZNPCKzsvF7Ch79jwtyn9hcUtbQl3hrnxQ/KhN
	mhBKABrMrSRwBgP9/VzACME4+wuaVUEPclTbklAhHk8cO8XJEDwx0yFhQfjcP+Y9tlAXcm
	oJoLISASkNFySbFWefpB8XAJ55MbbFEcPU2gUEShnR3G/avmFXnWkHSDSAcfnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1730325834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bzvVDo1oFNAoyuD+UrQvBHzdZ69hPGSsjI8QmDp3G8g=;
	b=u/+Ue8Ho9YZakMPl+Fr1Iy238ZQvLZL0m+LhjCnsox2sVe1+5G+dQvVNVx5oSYricmu2oh
	RNbOILzBPEyqsYi+cpsnV5AUW+H5nv5TEN85aWGvLmstSSKskijYgYUDVWui2X9AWJdnMM
	8g3XtnrVUr+X6ID8kSE7gfObMd8h81IigxKJJ0TZVlhhBA8FhXe2D/Wx/OO2zSGeYEJrC/
	kNr1oIqMQrtZVBClq3YR4TjfnELcafeWJiIbjKaotG+9ST8N+YGmYq8GPAydT/KxYHRPvP
	9fqGyWdTvl8mi0O7BxqMsGbDFNz2ldfwDINui4AG9JcPNoLxvur/9WTf1kvy8A==
Message-ID: <29fb92f81fed9f8a1f292641fe738dae47f8569d.camel@iki.fi>
Subject: Re: [PATCH BlueZ] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 31 Oct 2024 00:03:52 +0200
In-Reply-To: <5e5ab20671f3b6260ddc7e8aafe3971dd1c9fc9f.camel@iki.fi>
References: 
	<7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
		 <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com>
		 <4bf0aaa3129f29c84fd78ccfc423a63e4c0a8d90.camel@iki.fi>
		 <CABBYNZK_TgFHAWa7p_ph_DFFTb3N23_oeN6shc42_RwnWf-Ynw@mail.gmail.com>
	 <5e5ab20671f3b6260ddc7e8aafe3971dd1c9fc9f.camel@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2024-10-30 kello 23:46 +0200, Pauli Virtanen kirjoitti:
> Hi Luiz,
>=20
> ke, 2024-10-30 kello 16:56 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >=20
> > On Mon, Oct 28, 2024 at 1:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >=20
> > > Hi Luiz,
> > >=20
> > > ma, 2024-10-28 kello 10:39 -0400, Luiz Augusto von Dentz kirjoitti:
> > > > On Sat, Oct 26, 2024 at 6:41=E2=80=AFAM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >=20
> > > > > User can cancel transport acquire by calling Release() while Acqu=
ire()
> > > > > is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_=
CMD,
> > > > > forcing AVDTP state transition to IDLE, and disconnecting A2DP pr=
ofile,
> > > > > which is not desired.
> > > > >=20
> > > > > Fix by instead waiting until START completes and then send SUSPEN=
D. Make
> > > > > Release() reply only after the whole sequence completes.
> > > >=20
> > > > Hmm, but assumes the client is not reconfiguring to another endpoin=
t
> > > > or just giving up on the transport since it doesn't intend to use i=
t
> > > > anymore, anyway we can't really send anything else other than abort=
 if
> > > > we don't want to wait so I think this would be better to be handled=
 by
> > >=20
> > > I guess you have in mind
> > >=20
> > >         Acquire(t1)
> > >         Release(t1)  # canceling acquire
> > >         SetConfiguration(ep2)
> > >=20
> > > I don't think this works right in current BlueZ master branch either,
> > > the Release() results to removing the DBus endpoints & AVDTP
> > > disconnect, so nothing to SetConfigure() after abort completes.
> > > SetConfiguration() probably fails also if called while Abort_Cfm is
> > > pending, since it cannot then close the existing stream.
> > >=20
> > > I think (but did not test) that with the patch here, it would end up
> > > doing START -> CLOSE -> reconfigure, so indeed has to wait for START
> > > completion.
> >=20
> > I guess you are saying that we don't want the stream to transit to
> > idle since that would cause the AVDTP session to be disconnected? It
> > seems this is the result of session->dc_timeout being set to 0 on
> > avdtp_abort, anyway now looking a little more in detail it seems
> > clearer that the transport methods shouldn't affect the state machine
> > other than for suspend/resume procedures, that said then we need to
> > check what happens if those methods are called in quick succession e.g
> > Acquire -> Release -> Acquire.
>=20
> It should be possible to make it work so that SetConfiguration() while
> either Acquire() or Release() is pending sends ABORT if needed, but
> Acquire()+Release() alone only does OPEN->STREAMING->OPEN.
>=20
> The code that closes/aborts the existing stream in a2dp:a2dp_reconfig()
> may need some tuning, I'll need to test this race condition to make
> sure.

For the rapid Acquire() / Release() / Acquire() the intended behavior
probably is:

- while Acquire() call pending:

  Release() makes the pending Acquire() return error, and suspends
  after pending resume completes

  Acquire() returns error

- while Release() call pending:

  Release() returns error

  Acquire() makes the pending Release() return error, and resumes
  after pending suspend completes

so they just control the target state, and the state machine emits
START/SUSPEND as needed to reach the target.

(In this patch pending Release() was supposed to block Acquire() but
maybe we want it to instead work symmetrically like above.)

>=20
> > > > the application if it intends to suspend then it should wait acquir=
e
> > > > to complete and then release.
> > >=20
> > > I think it's a bug in BlueZ that calling Release() on transport resul=
t
> > > to disconnect of A2DP, instead of suspend.
> > >=20
> > > I have another version of this patch that does send ABORT, but recall=
s
> > > it was due to canceled suspend and reconnects the sink/source when
> > > getting to IDLE.
> > >=20
> > > > > Fix also sending error reply to the canceled Acquire() call, whic=
h was
> > > > > missing previously.
> > > > > ---
> > > > >=20
> > > > > Notes:
> > > > >     In theory we could also send ABORT and reconfigure the SEP ag=
ain after
> > > > >     that. It's more hairy though as with how the code currently w=
orks, we
> > > > >     may need to complete discovery first. This is a corner case a=
nyway, so
> > > > >     just waiting a bit should be easier.
> > > > >=20
> > > > >  profiles/audio/transport.c | 152 +++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 110 insertions(+), 42 deletions(-)
> > > > >=20
> > > > > diff --git a/profiles/audio/transport.c b/profiles/audio/transpor=
t.c
> > > > > index 0f7909a94..4d5afe022 100644
> > > > > --- a/profiles/audio/transport.c
> > > > > +++ b/profiles/audio/transport.c
> > > > > @@ -88,6 +88,9 @@ struct a2dp_transport {
> > > > >         uint16_t                delay;
> > > > >         int8_t                  volume;
> > > > >         guint                   watch;
> > > > > +       guint                   resume_id;
> > > > > +       gboolean                cancel_resume;
> > > > > +       guint                   cancel_id;
> > > > >  };
> > > > >=20
> > > > >  struct bap_transport {
> > > > > @@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(stru=
ct media_transport *transport)
> > > > >         return a2dp_sep_get_stream(sep);
> > > > >  }
> > > > >=20
> > > > > +static void a2dp_suspend_complete(struct avdtp *session, int err=
,
> > > > > +                                                       void *use=
r_data)
> > > > > +{
> > > > > +       struct media_owner *owner =3D user_data;
> > > > > +       struct media_transport *transport =3D owner->transport;
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport=
->endpoint);
> > > > > +
> > > > > +       /* Release always succeeds */
> > > > > +       if (owner->pending) {
> > > > > +               owner->pending->id =3D 0;
> > > > > +               media_request_reply(owner->pending, 0);
> > > > > +               media_owner_remove(owner);
> > > > > +       }
> > > > > +
> > > > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > > +       media_transport_remove_owner(transport);
> > > > > +}
> > > > > +
> > > > > +static guint transport_a2dp_suspend(struct media_transport *tran=
sport,
> > > > > +                                               struct media_owne=
r *owner)
> > > > > +{
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > > +       struct media_endpoint *endpoint =3D transport->endpoint;
> > > > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint)=
;
> > > > > +
> > > > > +       if (a2dp->cancel_resume)
> > > > > +               return a2dp->resume_id;
> > > > > +
> > > > > +       if (owner !=3D NULL)
> > > > > +               return a2dp_suspend(a2dp->session, sep, a2dp_susp=
end_complete,
> > > > > +                                                                =
       owner);
> > > > > +
> > > > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static gboolean a2dp_cancel_resume_cb(void *user_data)
> > > > > +{
> > > > > +       struct media_owner *owner =3D user_data;
> > > > > +       struct media_transport *transport =3D owner->transport;
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > > +
> > > > > +       a2dp->cancel_id =3D 0;
> > > > > +       a2dp->cancel_resume =3D FALSE;
> > > > > +       owner->pending->id =3D transport_a2dp_suspend(transport, =
owner);
> > > > > +       return FALSE;
> > > > > +}
> > > > > +
> > > > >  static void a2dp_resume_complete(struct avdtp *session, int err,
> > > > >                                                         void *use=
r_data)
> > > > >  {
> > > > >         struct media_owner *owner =3D user_data;
> > > > >         struct media_request *req =3D owner->pending;
> > > > >         struct media_transport *transport =3D owner->transport;
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > >         struct avdtp_stream *stream;
> > > > >         int fd;
> > > > >         uint16_t imtu, omtu;
> > > > >         gboolean ret;
> > > > >=20
> > > > > +       a2dp->resume_id =3D 0;
> > > > >         req->id =3D 0;
> > > > >=20
> > > > >         if (err)
> > > > >                 goto fail;
> > > > >=20
> > > > > +       if (a2dp->cancel_resume) {
> > > > > +               DBG("cancel resume");
> > > > > +               a2dp->cancel_id =3D g_idle_add(a2dp_cancel_resume=
_cb, owner);
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > >         stream =3D transport_a2dp_get_stream(transport);
> > > > >         if (stream =3D=3D NULL)
> > > > >                 goto fail;
> > > > > @@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct m=
edia_transport *transport,
> > > > >         struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint)=
;
> > > > >         guint id;
> > > > >=20
> > > > > +       if (a2dp->resume_id || a2dp->cancel_id)
> > > > > +               return -EBUSY;
> > > > > +
> > > > >         if (a2dp->session =3D=3D NULL) {
> > > > >                 a2dp->session =3D a2dp_avdtp_get(transport->devic=
e);
> > > > >                 if (a2dp->session =3D=3D NULL)
> > > > >                         return 0;
> > > > >         }
> > > > >=20
> > > > > -       if (state_in_use(transport->state))
> > > > > -               return a2dp_resume(a2dp->session, sep, a2dp_resum=
e_complete,
> > > > > +       if (state_in_use(transport->state)) {
> > > > > +               id =3D a2dp_resume(a2dp->session, sep, a2dp_resum=
e_complete,
> > > > >                                                                  =
       owner);
> > > > > +               a2dp->resume_id =3D id;
> > > > > +               return id;
> > > > > +       }
> > > > >=20
> > > > >         if (a2dp_sep_lock(sep, a2dp->session) =3D=3D FALSE)
> > > > >                 return 0;
> > > > > @@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct m=
edia_transport *transport,
> > > > >         if (transport->state =3D=3D TRANSPORT_STATE_IDLE)
> > > > >                 transport_set_state(transport, TRANSPORT_STATE_RE=
QUESTING);
> > > > >=20
> > > > > +       a2dp->resume_id =3D id;
> > > > >         return id;
> > > > >  }
> > > > >=20
> > > > > -static void a2dp_suspend_complete(struct avdtp *session, int err=
,
> > > > > -                                                       void *use=
r_data)
> > > > > -{
> > > > > -       struct media_owner *owner =3D user_data;
> > > > > -       struct media_transport *transport =3D owner->transport;
> > > > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport=
->endpoint);
> > > > > -
> > > > > -       /* Release always succeeds */
> > > > > -       if (owner->pending) {
> > > > > -               owner->pending->id =3D 0;
> > > > > -               media_request_reply(owner->pending, 0);
> > > > > -               media_owner_remove(owner);
> > > > > -       }
> > > > > -
> > > > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > > -       media_transport_remove_owner(transport);
> > > > > -}
> > > > > -
> > > > > -static guint transport_a2dp_suspend(struct media_transport *tran=
sport,
> > > > > -                                               struct media_owne=
r *owner)
> > > > > -{
> > > > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > > > -       struct media_endpoint *endpoint =3D transport->endpoint;
> > > > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint)=
;
> > > > > -
> > > > > -       if (owner !=3D NULL)
> > > > > -               return a2dp_suspend(a2dp->session, sep, a2dp_susp=
end_complete,
> > > > > -                                                                =
       owner);
> > > > > -
> > > > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > > > -
> > > > > -       return 0;
> > > > > -}
> > > > > -
> > > > >  static void transport_a2dp_cancel(struct media_transport *transp=
ort, guint id)
> > > > >  {
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > > +
> > > > > +       if (a2dp->resume_id && a2dp->resume_id =3D=3D id) {
> > > > > +               /* a2dp_cancel() results to ABORT->IDLE->disconne=
ct. Canceling
> > > > > +                * START can be triggered by user via Release(), =
and it's better
> > > > > +                * to not drop the A2DP connection then, so we ju=
st suspend
> > > > > +                * after resume completes.
> > > > > +                */
> > > > > +               a2dp->cancel_resume =3D TRUE;
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > >         a2dp_cancel(id);
> > > > >  }
> > > > >=20
> > > > > +static void transport_a2dp_remove_owner(struct media_transport *=
transport,
> > > > > +                                       struct media_owner *owner=
)
> > > > > +{
> > > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > > +
> > > > > +       /* Clean up callbacks that refer to the owner */
> > > > > +
> > > > > +       if (a2dp->cancel_id) {
> > > > > +               g_source_remove(a2dp->cancel_id);
> > > > > +               a2dp->cancel_id =3D 0;
> > > > > +       }
> > > > > +
> > > > > +       if (a2dp->resume_id) {
> > > > > +               a2dp_cancel(a2dp->resume_id);
> > > > > +               a2dp->resume_id =3D 0;
> > > > > +       }
> > > > > +
> > > > > +       a2dp->cancel_resume =3D FALSE;
> > > > > +}
> > > > > +
> > > > >  static int8_t transport_a2dp_get_volume(struct media_transport *=
transport)
> > > > >  {
> > > > >         struct a2dp_transport *a2dp =3D transport->data;
> > > > > @@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection =
*conn, DBusMessage *msg,
> > > > >=20
> > > > >                 member =3D dbus_message_get_member(owner->pending=
->msg);
> > > > >                 /* Cancel Acquire request if that exist */
> > > > > -               if (g_str_equal(member, "Acquire"))
> > > > > +               if (g_str_equal(member, "Acquire")) {
> > > > > +                       media_request_reply(owner->pending, ECANC=
ELED);
> > > > >                         media_owner_remove(owner);
> > > > > -               else
> > > > > +               } else {
> > > > >                         return btd_error_in_progress(msg);
> > > > > +               }
> > > > >         }
> > > > >=20
> > > > >         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING=
);
> > > > > @@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct med=
ia_transport *transport, void *data)
> > > > >  }
> > > > >=20
> > > > >  #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> > > > > -       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NUL=
L, _init, \
> > > > > +       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
> > > > > +                       transport_a2dp_remove_owner, _init, \
> > > > >                         transport_a2dp_resume, transport_a2dp_sus=
pend, \
> > > > >                         transport_a2dp_cancel, NULL, \
> > > > >                         transport_a2dp_get_stream, transport_a2dp=
_get_volume, \
> > > > > --
> > > > > 2.47.0
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > >=20
> >=20
> >=20
>=20

