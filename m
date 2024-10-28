Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36E1DF728
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137696; cv=pass; b=u7GDv5uoDlmTSn9g9JrUA3OcAigwifCmNbDURZPCFa7Lqca9leqYUX4nyG7sYHP7iV0TdSgaIsnPc/a8z5+DTpIC2TzKyIKT6sd7PF/DjqU+gtQYLqHONTlQRj4xuaVgeQye8Bx2BV0T3PnhFFzCzTMFn5SdMzcWhMtWltuCGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137696; c=relaxed/simple;
	bh=tlwQGXa9KmNzC2X7RzbpnZEGAb9Npjj7VIFhswx9+Do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iu7J446yQc8eIE3dlpQyF/G17rU2EgQinq/M6nj1dbhrziYL1aVspdeo8544ewmjGJnAVLuxoPmyE/4qgiPEZ4t7F1l0z+ssi7oLuQeF+ES8vDGlI1EKBw022a5UUDxjC2PX/snXBAxkFysWogoJW4gv6KGE9l3ucTy07C/SCzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OtIiUz9P; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OtIiUz9P"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4XcgpX4t6Gz49Pv9;
	Mon, 28 Oct 2024 19:48:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730137685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2WP8yGxgRckwZilRh+xlMyBmIJcLJ1xRPLjabZe5I=;
	b=OtIiUz9PC9MxssPIQaPU2zJV5oA+FckNoTC8ptJ2udt62ELSTEn25Q03W3rWNICqIfI+Sx
	jl+/CC9GoBK7M7+08ofZC+ieITh/ENoPj8tyuuD2DiXkmzh3CR9DUwYYzUVt7zY+C87nZK
	tYgmVRBfGNIBbskyihVKxnesz4iFHzsIvk0YgzTfzGwEw9t+o+XgpuqHNifssSJyNea3ls
	RJ5ZNSzu+h8tM3t8TK++lQWnNwGJVx0RCNrz6Ia5phXRxYvsSJMTKn+ZYVfsZ7Cn1BGbg4
	EKOa52FzVo9DZyVN5vptRTTXlRg8AvzLXKtsFVfDTPyCOQUw4R/RHtIMAzDlKg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1730137685; a=rsa-sha256;
	cv=none;
	b=N716wA7aqgOcbZ2nVTBxS9GgnZ4HsmFt9IetdtVNKMsztQoJV92gkHBHA9a5nLTELvuXXc
	R2pPKb5mcqoDX+3BpiRhhEHPC3EUHhUMrqDt3KuvoGyX2Yi+dPuV89iudN2JxIqR9KLKzM
	DTnOLqcsrV0qQgf721sdE7F3IqE/w+QQtivpMDPD8n29I7Cc82JdqUpIkhKXSyuXOvW3fV
	t0TDccseQ7tZDt5tb/EdCdFtXHPCer+aT4FpKHnBmeiEi7LTSydlhgKy15nPjwrfVA8hxj
	SO0pwh991zmPc7dIBwaFC8oQ2+gt3hXfMHPSEZcgYCdkfIl3qq3C6Lz08qbGgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1730137685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2WP8yGxgRckwZilRh+xlMyBmIJcLJ1xRPLjabZe5I=;
	b=TrOoLLzQ7rIhsR1OpnXW76PuxS+6D4TD5+TUnWDwSs+2sEzG47gqicx9aIhk41X5qcc40Q
	P2HJ3qZYYbZ1Mr69QXotgV091CBzRRfkVBXqndTPxsKzPrRYku355tmzAgURSPf/mn+Fxs
	C5DYLiZORXuuYT14c/x7kHktaTRy/zesRIrdWPvWjL//fc1iSdD782Ipk86kf9vGEcJbf2
	JtZOD5mslBjy5g9hfGjprnvVdFHY7dx+lU2ptVCUYJPgoRHOEGKdj/H9iS8nTHTUK/6/nK
	NnITaiwHN76SW0Jk4AHOx3XGB1eL3c/fkLsF6fuoEnkx+SEy3figwixcy38rIg==
Message-ID: <4bf0aaa3129f29c84fd78ccfc423a63e4c0a8d90.camel@iki.fi>
Subject: Re: [PATCH BlueZ] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Oct 2024 19:48:03 +0200
In-Reply-To: <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com>
References: 
	<7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
	 <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com>
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

ma, 2024-10-28 kello 10:39 -0400, Luiz Augusto von Dentz kirjoitti:
> On Sat, Oct 26, 2024 at 6:41=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > User can cancel transport acquire by calling Release() while Acquire()
> > is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
> > forcing AVDTP state transition to IDLE, and disconnecting A2DP profile,
> > which is not desired.
> >=20
> > Fix by instead waiting until START completes and then send SUSPEND. Mak=
e
> > Release() reply only after the whole sequence completes.
>=20
> Hmm, but assumes the client is not reconfiguring to another endpoint
> or just giving up on the transport since it doesn't intend to use it
> anymore, anyway we can't really send anything else other than abort if
> we don't want to wait so I think this would be better to be handled by

I guess you have in mind

	Acquire(t1)
	Release(t1)  # canceling acquire
	SetConfiguration(ep2)

I don't think this works right in current BlueZ master branch either,
the Release() results to removing the DBus endpoints & AVDTP
disconnect, so nothing to SetConfigure() after abort completes.
SetConfiguration()=C2=A0probably fails also if called while Abort_Cfm is
pending, since it cannot then close the existing stream.

I think (but did not test) that with the patch here, it would end up
doing START -> CLOSE -> reconfigure, so indeed has to wait for START
completion.

> the application if it intends to suspend then it should wait acquire
> to complete and then release.

I think it's a bug in BlueZ that calling Release() on transport result
to disconnect of A2DP, instead of suspend.

I have another version of this patch that does send ABORT, but recalls
it was due to canceled suspend and reconnects the sink/source when
getting to IDLE.

> > Fix also sending error reply to the canceled Acquire() call, which was
> > missing previously.
> > ---
> >=20
> > Notes:
> >     In theory we could also send ABORT and reconfigure the SEP again af=
ter
> >     that. It's more hairy though as with how the code currently works, =
we
> >     may need to complete discovery first. This is a corner case anyway,=
 so
> >     just waiting a bit should be easier.
> >=20
> >  profiles/audio/transport.c | 152 +++++++++++++++++++++++++++----------
> >  1 file changed, 110 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > index 0f7909a94..4d5afe022 100644
> > --- a/profiles/audio/transport.c
> > +++ b/profiles/audio/transport.c
> > @@ -88,6 +88,9 @@ struct a2dp_transport {
> >         uint16_t                delay;
> >         int8_t                  volume;
> >         guint                   watch;
> > +       guint                   resume_id;
> > +       gboolean                cancel_resume;
> > +       guint                   cancel_id;
> >  };
> >=20
> >  struct bap_transport {
> > @@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(struct med=
ia_transport *transport)
> >         return a2dp_sep_get_stream(sep);
> >  }
> >=20
> > +static void a2dp_suspend_complete(struct avdtp *session, int err,
> > +                                                       void *user_data=
)
> > +{
> > +       struct media_owner *owner =3D user_data;
> > +       struct media_transport *transport =3D owner->transport;
> > +       struct a2dp_transport *a2dp =3D transport->data;
> > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->endp=
oint);
> > +
> > +       /* Release always succeeds */
> > +       if (owner->pending) {
> > +               owner->pending->id =3D 0;
> > +               media_request_reply(owner->pending, 0);
> > +               media_owner_remove(owner);
> > +       }
> > +
> > +       a2dp_sep_unlock(sep, a2dp->session);
> > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > +       media_transport_remove_owner(transport);
> > +}
> > +
> > +static guint transport_a2dp_suspend(struct media_transport *transport,
> > +                                               struct media_owner *own=
er)
> > +{
> > +       struct a2dp_transport *a2dp =3D transport->data;
> > +       struct media_endpoint *endpoint =3D transport->endpoint;
> > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > +
> > +       if (a2dp->cancel_resume)
> > +               return a2dp->resume_id;
> > +
> > +       if (owner !=3D NULL)
> > +               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_co=
mplete,
> > +                                                                      =
 owner);
> > +
> > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > +       a2dp_sep_unlock(sep, a2dp->session);
> > +
> > +       return 0;
> > +}
> > +
> > +static gboolean a2dp_cancel_resume_cb(void *user_data)
> > +{
> > +       struct media_owner *owner =3D user_data;
> > +       struct media_transport *transport =3D owner->transport;
> > +       struct a2dp_transport *a2dp =3D transport->data;
> > +
> > +       a2dp->cancel_id =3D 0;
> > +       a2dp->cancel_resume =3D FALSE;
> > +       owner->pending->id =3D transport_a2dp_suspend(transport, owner)=
;
> > +       return FALSE;
> > +}
> > +
> >  static void a2dp_resume_complete(struct avdtp *session, int err,
> >                                                         void *user_data=
)
> >  {
> >         struct media_owner *owner =3D user_data;
> >         struct media_request *req =3D owner->pending;
> >         struct media_transport *transport =3D owner->transport;
> > +       struct a2dp_transport *a2dp =3D transport->data;
> >         struct avdtp_stream *stream;
> >         int fd;
> >         uint16_t imtu, omtu;
> >         gboolean ret;
> >=20
> > +       a2dp->resume_id =3D 0;
> >         req->id =3D 0;
> >=20
> >         if (err)
> >                 goto fail;
> >=20
> > +       if (a2dp->cancel_resume) {
> > +               DBG("cancel resume");
> > +               a2dp->cancel_id =3D g_idle_add(a2dp_cancel_resume_cb, o=
wner);
> > +               return;
> > +       }
> > +
> >         stream =3D transport_a2dp_get_stream(transport);
> >         if (stream =3D=3D NULL)
> >                 goto fail;
> > @@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct media_t=
ransport *transport,
> >         struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> >         guint id;
> >=20
> > +       if (a2dp->resume_id || a2dp->cancel_id)
> > +               return -EBUSY;
> > +
> >         if (a2dp->session =3D=3D NULL) {
> >                 a2dp->session =3D a2dp_avdtp_get(transport->device);
> >                 if (a2dp->session =3D=3D NULL)
> >                         return 0;
> >         }
> >=20
> > -       if (state_in_use(transport->state))
> > -               return a2dp_resume(a2dp->session, sep, a2dp_resume_comp=
lete,
> > +       if (state_in_use(transport->state)) {
> > +               id =3D a2dp_resume(a2dp->session, sep, a2dp_resume_comp=
lete,
> >                                                                        =
 owner);
> > +               a2dp->resume_id =3D id;
> > +               return id;
> > +       }
> >=20
> >         if (a2dp_sep_lock(sep, a2dp->session) =3D=3D FALSE)
> >                 return 0;
> > @@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct media_t=
ransport *transport,
> >         if (transport->state =3D=3D TRANSPORT_STATE_IDLE)
> >                 transport_set_state(transport, TRANSPORT_STATE_REQUESTI=
NG);
> >=20
> > +       a2dp->resume_id =3D id;
> >         return id;
> >  }
> >=20
> > -static void a2dp_suspend_complete(struct avdtp *session, int err,
> > -                                                       void *user_data=
)
> > -{
> > -       struct media_owner *owner =3D user_data;
> > -       struct media_transport *transport =3D owner->transport;
> > -       struct a2dp_transport *a2dp =3D transport->data;
> > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->endp=
oint);
> > -
> > -       /* Release always succeeds */
> > -       if (owner->pending) {
> > -               owner->pending->id =3D 0;
> > -               media_request_reply(owner->pending, 0);
> > -               media_owner_remove(owner);
> > -       }
> > -
> > -       a2dp_sep_unlock(sep, a2dp->session);
> > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > -       media_transport_remove_owner(transport);
> > -}
> > -
> > -static guint transport_a2dp_suspend(struct media_transport *transport,
> > -                                               struct media_owner *own=
er)
> > -{
> > -       struct a2dp_transport *a2dp =3D transport->data;
> > -       struct media_endpoint *endpoint =3D transport->endpoint;
> > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > -
> > -       if (owner !=3D NULL)
> > -               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_co=
mplete,
> > -                                                                      =
 owner);
> > -
> > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > -       a2dp_sep_unlock(sep, a2dp->session);
> > -
> > -       return 0;
> > -}
> > -
> >  static void transport_a2dp_cancel(struct media_transport *transport, g=
uint id)
> >  {
> > +       struct a2dp_transport *a2dp =3D transport->data;
> > +
> > +       if (a2dp->resume_id && a2dp->resume_id =3D=3D id) {
> > +               /* a2dp_cancel() results to ABORT->IDLE->disconnect. Ca=
nceling
> > +                * START can be triggered by user via Release(), and it=
's better
> > +                * to not drop the A2DP connection then, so we just sus=
pend
> > +                * after resume completes.
> > +                */
> > +               a2dp->cancel_resume =3D TRUE;
> > +               return;
> > +       }
> > +
> >         a2dp_cancel(id);
> >  }
> >=20
> > +static void transport_a2dp_remove_owner(struct media_transport *transp=
ort,
> > +                                       struct media_owner *owner)
> > +{
> > +       struct a2dp_transport *a2dp =3D transport->data;
> > +
> > +       /* Clean up callbacks that refer to the owner */
> > +
> > +       if (a2dp->cancel_id) {
> > +               g_source_remove(a2dp->cancel_id);
> > +               a2dp->cancel_id =3D 0;
> > +       }
> > +
> > +       if (a2dp->resume_id) {
> > +               a2dp_cancel(a2dp->resume_id);
> > +               a2dp->resume_id =3D 0;
> > +       }
> > +
> > +       a2dp->cancel_resume =3D FALSE;
> > +}
> > +
> >  static int8_t transport_a2dp_get_volume(struct media_transport *transp=
ort)
> >  {
> >         struct a2dp_transport *a2dp =3D transport->data;
> > @@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection *conn,=
 DBusMessage *msg,
> >=20
> >                 member =3D dbus_message_get_member(owner->pending->msg)=
;
> >                 /* Cancel Acquire request if that exist */
> > -               if (g_str_equal(member, "Acquire"))
> > +               if (g_str_equal(member, "Acquire")) {
> > +                       media_request_reply(owner->pending, ECANCELED);
> >                         media_owner_remove(owner);
> > -               else
> > +               } else {
> >                         return btd_error_in_progress(msg);
> > +               }
> >         }
> >=20
> >         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
> > @@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
> >  }
> >=20
> >  #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> > -       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _in=
it, \
> > +       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
> > +                       transport_a2dp_remove_owner, _init, \
> >                         transport_a2dp_resume, transport_a2dp_suspend, =
\
> >                         transport_a2dp_cancel, NULL, \
> >                         transport_a2dp_get_stream, transport_a2dp_get_v=
olume, \
> > --
> > 2.47.0
> >=20
> >=20
>=20
>=20

