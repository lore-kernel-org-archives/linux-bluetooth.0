Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9619994F
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324793; cv=pass; b=Uou1VcjIRdlAOq08uQOGtWc9WqEy/obH00Y7wh/272GMLmicXB9vSQR6X2mZ4czH4hm4zTRoVUNNm0cRUH7VZib3Xgx+es18eZWy6lU6aDfAT49CLw8yl2JYgJNaw7Mje2Djl+r2VIC8BhwgnNUvBKo1xL/y7zgzSWO8onO4D88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324793; c=relaxed/simple;
	bh=LJBc+l8ozORYv4z30HGBbF6YCUUGkk5qJZbaXmMzogQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdMgvW1Qen4vV+jSGnnxFropytYYwjmI4Q5uvPIKGsMTpfKmChreo5RLBmAw5nS2RclFoeG1VjoUTmHP3nAsNr68cbFDAlYX5igdAmKStZmj8d1fyU5x1ltfE6ObORaCvU1CnzQNX8AS0R82tH7gvEjmTlB46dBgfBt8Yv31fyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=k0yjURQt; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="k0yjURQt"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Xf10f63rGz49PyG;
	Wed, 30 Oct 2024 23:46:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730324787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGW83tDdV0P81Sw8qD7kMIsZqIrBaGdYF53SSXXYcyI=;
	b=k0yjURQtl8lUDskATxlgBHHd5Q9gqiWcYyD+8Pts3Jo6+/ZdXHHUts1QvjWap75SCcSMCw
	dxvENXOSadyh1oXwwt4ahM8rVSTj7Cc8QVcDR7eagyD8oqMfk0NSg0p2DVZrWUB+GYDP/5
	8SwdV4jW/ss+1fYJ+uaPhHeR0kTAt0r15mDiagDF6sFAQNYcjyNFAv7u2hHBR0qdQg2YmR
	hZMt1em/NyqcIFqLorWSa/lDV8Rx7F+eKXFAsenPpx3bS/NkfTh+MPoSyIClaTACdKjiY6
	0BIaVeKvP1HNigmlHnfMKZNvz4BUs/qP+aP7yALOc58tjBLa0Kra8heNTcd0iQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1730324787; a=rsa-sha256;
	cv=none;
	b=U+eD0PzZgHdTEBq++IDk+5cb856Stxip+vtVymZKjuvzpwh7v1Iyctf7xPsJVkw8poqtHi
	9+jEWow3XLKNODcYSExf+nt2ic0ns8WC2AdV1tBikO+JiOGstsW4+C+pMheGZUHVGZ95Sv
	tHwPiarmTiS0NTKHRxMl37wAvcZCAgm42dBC8i6vR8eBuwqjQg1TAvCIDbIr5azo7LMULL
	aU5z9ZHYwdTsxhB+4EtuKGGQG13vVyf1kS1hcZnIqHr3uEk9YAxcODIsajLEZRHZ+ZuGVC
	AjKxeTwLKnJ/hQaOlWONmg1QedU/DlSl2rQWPKZd1O2X7f5h1ds/2kDNTs8I8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1730324787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGW83tDdV0P81Sw8qD7kMIsZqIrBaGdYF53SSXXYcyI=;
	b=LAEKqWHxLRjxx47ixZGwDsZe74yJPgvtiF0QuA0tH5Ue0TFl5KkFTjlsURi5DvKjzRYjMr
	kcyKMCEAGSQQ36PrrlCTSimfMbETN2WnbjAcE1kmoUe7kI2KV3zZo1mFqCjxeG7lQzVoQC
	JfXqclLfY/YI0mvF30KUtiqm+SPgd13/c800agDGaQ+2o1j6M4PQ0U461tbOrcEVfYP6BN
	zn4vjSJnGNPh1P6AUWMKEwCMydT0WxFVPB0xwAAf8zjK+baWWppQUU9020WUZrKRMoW9ED
	T5TT/69WYy2eZNNu1Wbef9gn4YCQpSdw8XmTcar5JrKTUffa1HRIYlzzMrhfLw==
Message-ID: <5e5ab20671f3b6260ddc7e8aafe3971dd1c9fc9f.camel@iki.fi>
Subject: Re: [PATCH BlueZ] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 30 Oct 2024 23:46:24 +0200
In-Reply-To: <CABBYNZK_TgFHAWa7p_ph_DFFTb3N23_oeN6shc42_RwnWf-Ynw@mail.gmail.com>
References: 
	<7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
	 <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com>
	 <4bf0aaa3129f29c84fd78ccfc423a63e4c0a8d90.camel@iki.fi>
	 <CABBYNZK_TgFHAWa7p_ph_DFFTb3N23_oeN6shc42_RwnWf-Ynw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ke, 2024-10-30 kello 16:56 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Oct 28, 2024 at 1:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Hi Luiz,
> >=20
> > ma, 2024-10-28 kello 10:39 -0400, Luiz Augusto von Dentz kirjoitti:
> > > On Sat, Oct 26, 2024 at 6:41=E2=80=AFAM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >=20
> > > > User can cancel transport acquire by calling Release() while Acquir=
e()
> > > > is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CM=
D,
> > > > forcing AVDTP state transition to IDLE, and disconnecting A2DP prof=
ile,
> > > > which is not desired.
> > > >=20
> > > > Fix by instead waiting until START completes and then send SUSPEND.=
 Make
> > > > Release() reply only after the whole sequence completes.
> > >=20
> > > Hmm, but assumes the client is not reconfiguring to another endpoint
> > > or just giving up on the transport since it doesn't intend to use it
> > > anymore, anyway we can't really send anything else other than abort i=
f
> > > we don't want to wait so I think this would be better to be handled b=
y
> >=20
> > I guess you have in mind
> >=20
> >         Acquire(t1)
> >         Release(t1)  # canceling acquire
> >         SetConfiguration(ep2)
> >=20
> > I don't think this works right in current BlueZ master branch either,
> > the Release() results to removing the DBus endpoints & AVDTP
> > disconnect, so nothing to SetConfigure() after abort completes.
> > SetConfiguration() probably fails also if called while Abort_Cfm is
> > pending, since it cannot then close the existing stream.
> >=20
> > I think (but did not test) that with the patch here, it would end up
> > doing START -> CLOSE -> reconfigure, so indeed has to wait for START
> > completion.
>=20
> I guess you are saying that we don't want the stream to transit to
> idle since that would cause the AVDTP session to be disconnected? It
> seems this is the result of session->dc_timeout being set to 0 on
> avdtp_abort, anyway now looking a little more in detail it seems
> clearer that the transport methods shouldn't affect the state machine
> other than for suspend/resume procedures, that said then we need to
> check what happens if those methods are called in quick succession e.g
> Acquire -> Release -> Acquire.

It should be possible to make it work so that SetConfiguration() while
either Acquire() or Release() is pending sends ABORT if needed, but
Acquire()+Release() alone only does OPEN->STREAMING->OPEN.

The code that closes/aborts the existing stream in a2dp:a2dp_reconfig()
may need some tuning, I'll need to test this race condition to make
sure.

> > > the application if it intends to suspend then it should wait acquire
> > > to complete and then release.
> >=20
> > I think it's a bug in BlueZ that calling Release() on transport result
> > to disconnect of A2DP, instead of suspend.
> >=20
> > I have another version of this patch that does send ABORT, but recalls
> > it was due to canceled suspend and reconnects the sink/source when
> > getting to IDLE.
> >=20
> > > > Fix also sending error reply to the canceled Acquire() call, which =
was
> > > > missing previously.
> > > > ---
> > > >=20
> > > > Notes:
> > > >     In theory we could also send ABORT and reconfigure the SEP agai=
n after
> > > >     that. It's more hairy though as with how the code currently wor=
ks, we
> > > >     may need to complete discovery first. This is a corner case any=
way, so
> > > >     just waiting a bit should be easier.
> > > >=20
> > > >  profiles/audio/transport.c | 152 +++++++++++++++++++++++++++------=
----
> > > >  1 file changed, 110 insertions(+), 42 deletions(-)
> > > >=20
> > > > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.=
c
> > > > index 0f7909a94..4d5afe022 100644
> > > > --- a/profiles/audio/transport.c
> > > > +++ b/profiles/audio/transport.c
> > > > @@ -88,6 +88,9 @@ struct a2dp_transport {
> > > >         uint16_t                delay;
> > > >         int8_t                  volume;
> > > >         guint                   watch;
> > > > +       guint                   resume_id;
> > > > +       gboolean                cancel_resume;
> > > > +       guint                   cancel_id;
> > > >  };
> > > >=20
> > > >  struct bap_transport {
> > > > @@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(struct=
 media_transport *transport)
> > > >         return a2dp_sep_get_stream(sep);
> > > >  }
> > > >=20
> > > > +static void a2dp_suspend_complete(struct avdtp *session, int err,
> > > > +                                                       void *user_=
data)
> > > > +{
> > > > +       struct media_owner *owner =3D user_data;
> > > > +       struct media_transport *transport =3D owner->transport;
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->=
endpoint);
> > > > +
> > > > +       /* Release always succeeds */
> > > > +       if (owner->pending) {
> > > > +               owner->pending->id =3D 0;
> > > > +               media_request_reply(owner->pending, 0);
> > > > +               media_owner_remove(owner);
> > > > +       }
> > > > +
> > > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > +       media_transport_remove_owner(transport);
> > > > +}
> > > > +
> > > > +static guint transport_a2dp_suspend(struct media_transport *transp=
ort,
> > > > +                                               struct media_owner =
*owner)
> > > > +{
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > +       struct media_endpoint *endpoint =3D transport->endpoint;
> > > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > > > +
> > > > +       if (a2dp->cancel_resume)
> > > > +               return a2dp->resume_id;
> > > > +
> > > > +       if (owner !=3D NULL)
> > > > +               return a2dp_suspend(a2dp->session, sep, a2dp_suspen=
d_complete,
> > > > +                                                                  =
     owner);
> > > > +
> > > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static gboolean a2dp_cancel_resume_cb(void *user_data)
> > > > +{
> > > > +       struct media_owner *owner =3D user_data;
> > > > +       struct media_transport *transport =3D owner->transport;
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > +
> > > > +       a2dp->cancel_id =3D 0;
> > > > +       a2dp->cancel_resume =3D FALSE;
> > > > +       owner->pending->id =3D transport_a2dp_suspend(transport, ow=
ner);
> > > > +       return FALSE;
> > > > +}
> > > > +
> > > >  static void a2dp_resume_complete(struct avdtp *session, int err,
> > > >                                                         void *user_=
data)
> > > >  {
> > > >         struct media_owner *owner =3D user_data;
> > > >         struct media_request *req =3D owner->pending;
> > > >         struct media_transport *transport =3D owner->transport;
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > >         struct avdtp_stream *stream;
> > > >         int fd;
> > > >         uint16_t imtu, omtu;
> > > >         gboolean ret;
> > > >=20
> > > > +       a2dp->resume_id =3D 0;
> > > >         req->id =3D 0;
> > > >=20
> > > >         if (err)
> > > >                 goto fail;
> > > >=20
> > > > +       if (a2dp->cancel_resume) {
> > > > +               DBG("cancel resume");
> > > > +               a2dp->cancel_id =3D g_idle_add(a2dp_cancel_resume_c=
b, owner);
> > > > +               return;
> > > > +       }
> > > > +
> > > >         stream =3D transport_a2dp_get_stream(transport);
> > > >         if (stream =3D=3D NULL)
> > > >                 goto fail;
> > > > @@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct med=
ia_transport *transport,
> > > >         struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > > >         guint id;
> > > >=20
> > > > +       if (a2dp->resume_id || a2dp->cancel_id)
> > > > +               return -EBUSY;
> > > > +
> > > >         if (a2dp->session =3D=3D NULL) {
> > > >                 a2dp->session =3D a2dp_avdtp_get(transport->device)=
;
> > > >                 if (a2dp->session =3D=3D NULL)
> > > >                         return 0;
> > > >         }
> > > >=20
> > > > -       if (state_in_use(transport->state))
> > > > -               return a2dp_resume(a2dp->session, sep, a2dp_resume_=
complete,
> > > > +       if (state_in_use(transport->state)) {
> > > > +               id =3D a2dp_resume(a2dp->session, sep, a2dp_resume_=
complete,
> > > >                                                                    =
     owner);
> > > > +               a2dp->resume_id =3D id;
> > > > +               return id;
> > > > +       }
> > > >=20
> > > >         if (a2dp_sep_lock(sep, a2dp->session) =3D=3D FALSE)
> > > >                 return 0;
> > > > @@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct med=
ia_transport *transport,
> > > >         if (transport->state =3D=3D TRANSPORT_STATE_IDLE)
> > > >                 transport_set_state(transport, TRANSPORT_STATE_REQU=
ESTING);
> > > >=20
> > > > +       a2dp->resume_id =3D id;
> > > >         return id;
> > > >  }
> > > >=20
> > > > -static void a2dp_suspend_complete(struct avdtp *session, int err,
> > > > -                                                       void *user_=
data)
> > > > -{
> > > > -       struct media_owner *owner =3D user_data;
> > > > -       struct media_transport *transport =3D owner->transport;
> > > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->=
endpoint);
> > > > -
> > > > -       /* Release always succeeds */
> > > > -       if (owner->pending) {
> > > > -               owner->pending->id =3D 0;
> > > > -               media_request_reply(owner->pending, 0);
> > > > -               media_owner_remove(owner);
> > > > -       }
> > > > -
> > > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > -       media_transport_remove_owner(transport);
> > > > -}
> > > > -
> > > > -static guint transport_a2dp_suspend(struct media_transport *transp=
ort,
> > > > -                                               struct media_owner =
*owner)
> > > > -{
> > > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > > -       struct media_endpoint *endpoint =3D transport->endpoint;
> > > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > > > -
> > > > -       if (owner !=3D NULL)
> > > > -               return a2dp_suspend(a2dp->session, sep, a2dp_suspen=
d_complete,
> > > > -                                                                  =
     owner);
> > > > -
> > > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > > -
> > > > -       return 0;
> > > > -}
> > > > -
> > > >  static void transport_a2dp_cancel(struct media_transport *transpor=
t, guint id)
> > > >  {
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > +
> > > > +       if (a2dp->resume_id && a2dp->resume_id =3D=3D id) {
> > > > +               /* a2dp_cancel() results to ABORT->IDLE->disconnect=
. Canceling
> > > > +                * START can be triggered by user via Release(), an=
d it's better
> > > > +                * to not drop the A2DP connection then, so we just=
 suspend
> > > > +                * after resume completes.
> > > > +                */
> > > > +               a2dp->cancel_resume =3D TRUE;
> > > > +               return;
> > > > +       }
> > > > +
> > > >         a2dp_cancel(id);
> > > >  }
> > > >=20
> > > > +static void transport_a2dp_remove_owner(struct media_transport *tr=
ansport,
> > > > +                                       struct media_owner *owner)
> > > > +{
> > > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > > +
> > > > +       /* Clean up callbacks that refer to the owner */
> > > > +
> > > > +       if (a2dp->cancel_id) {
> > > > +               g_source_remove(a2dp->cancel_id);
> > > > +               a2dp->cancel_id =3D 0;
> > > > +       }
> > > > +
> > > > +       if (a2dp->resume_id) {
> > > > +               a2dp_cancel(a2dp->resume_id);
> > > > +               a2dp->resume_id =3D 0;
> > > > +       }
> > > > +
> > > > +       a2dp->cancel_resume =3D FALSE;
> > > > +}
> > > > +
> > > >  static int8_t transport_a2dp_get_volume(struct media_transport *tr=
ansport)
> > > >  {
> > > >         struct a2dp_transport *a2dp =3D transport->data;
> > > > @@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection *c=
onn, DBusMessage *msg,
> > > >=20
> > > >                 member =3D dbus_message_get_member(owner->pending->=
msg);
> > > >                 /* Cancel Acquire request if that exist */
> > > > -               if (g_str_equal(member, "Acquire"))
> > > > +               if (g_str_equal(member, "Acquire")) {
> > > > +                       media_request_reply(owner->pending, ECANCEL=
ED);
> > > >                         media_owner_remove(owner);
> > > > -               else
> > > > +               } else {
> > > >                         return btd_error_in_progress(msg);
> > > > +               }
> > > >         }
> > > >=20
> > > >         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
> > > > @@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct media=
_transport *transport, void *data)
> > > >  }
> > > >=20
> > > >  #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> > > > -       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL,=
 _init, \
> > > > +       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
> > > > +                       transport_a2dp_remove_owner, _init, \
> > > >                         transport_a2dp_resume, transport_a2dp_suspe=
nd, \
> > > >                         transport_a2dp_cancel, NULL, \
> > > >                         transport_a2dp_get_stream, transport_a2dp_g=
et_volume, \
> > > > --
> > > > 2.47.0
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20

