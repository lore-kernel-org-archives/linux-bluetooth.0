Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2E1BD9DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321834; cv=none; b=grSx7Ynh99lPEhfepRHvnh4nx8Q36gBGA214yxO9k1g+lDq2eadcmGfy8q3rmPgwzTbA9oj02jYkhkGfojjSLjlBkaQqsDL3vOhOmiWxghJBM4SdnTMrGHN1V6XX1rJS/XgFUlMECOuF+8VV5LMybHMLD6VEEn0jhKthAXDTXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321834; c=relaxed/simple;
	bh=SYwTnEJFz62G1QiCF69vbpjkhZwRxJtitOyms34ngGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLHZKCnj1f2AG/ri5FRIqj+rOpuwKRMIdI8sUPuS7Y77TgP8kLERlHt5+mbU6owoR2uOjQ26n05ZTqcUwSY9fOx3jzHMvlzCfcH/jHi0bYibT7+FsxrvgcdO70Hr7Y3Jk7v+w1rqXtpUiVw0a+/E35tZc45bq+Msr/zVxoMLLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoI1m2OT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoI1m2OT"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso1872441fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321830; x=1730926630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m1G4ubnUNEtnPmmRsxdVrDf8GmGePm1t+dE8/01wMA=;
        b=XoI1m2OT6lWzNeRDemtbWQ61BMXl79KqnOLZ2MfAMZ8tdc/n2R25au1BzNqNgLo/tG
         4BOxm3JUS6GO46XsPjGu0nTwxCZ0wchanu5eDxyGd2MCFRIrmuHM0BNC1cetZZXAo9cn
         Udph4qtx7dIUOwnCMO+6Vsv16DTdtQLlowg3mesybZGX8cu/9+U01y0+iLGvh7J4Zt6F
         GlVwnWOyXgk3uSj6bgd/tezQbt4ON6uVoRN3MGD/5Gh6+jvZJGMdNTdsB0CZ6a9Fi2gJ
         DaxZ4bAWyq7nopn8FmirXRY9XvzkbzqYpsOobaCTbyL8SvzIuPPmjEjeESFyj5Grf5XZ
         XKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321830; x=1730926630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m1G4ubnUNEtnPmmRsxdVrDf8GmGePm1t+dE8/01wMA=;
        b=Yy0rlN7bsgmUrX7u7BuJJptLbxS3z6HfUUj7OM/k9JsD+FRpypDoWalPAPtiyp8q1O
         B+oUts0s2ZiSMyJ+xYaFw3qWENnyPT/eavK4Q6tng9MV66rolQXqYUtCTPyrKawfqVsA
         ABy8M62rnwUWpm7NmZ44DGD3v+HHN0eKsSLPXL9LSGPWcNQxo+uas4cScClHiO2aZvkt
         qjetz2pVYOomoMe+TvC7wuOaf0rfd6AqbQKHZP/N1FtANtWPMgyH43K1v7J9FCb2rC0B
         c2sTytLP72Mu+TwepiND2ALKj+rX/NwDpa7hnVRpUFxXe3wzIHxuOfWkb3NhfSxfgvYW
         DmaQ==
X-Gm-Message-State: AOJu0Yzm4Qe4MFMqiZut0+rGR3rSJjWlke83bnq4ObKvSENRAnIaqGKT
	ruRISv+R5v/qXvet3HtavyGVW7x5947P/myqa5MhwtIRFhyupitQvcsVaH1D9SrSLGX6ffcvczg
	g7oUYJ8nU6HdUCsZujmiEz3cEfu63tw==
X-Google-Smtp-Source: AGHT+IEaG8o4ORVZYvzdRMogGBhXpew41jDMSPV2s9Wi45u/8IVzpJfbxK+aOtO8scThVqqgczoJx2LGWMKBDKcpEMY=
X-Received: by 2002:a2e:bc10:0:b0:2fa:dadf:aad5 with SMTP id
 38308e7fff4ca-2fcbe078c90mr80181811fa.28.1730321829757; Wed, 30 Oct 2024
 13:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
 <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com> <4bf0aaa3129f29c84fd78ccfc423a63e4c0a8d90.camel@iki.fi>
In-Reply-To: <4bf0aaa3129f29c84fd78ccfc423a63e4c0a8d90.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 16:56:57 -0400
Message-ID: <CABBYNZK_TgFHAWa7p_ph_DFFTb3N23_oeN6shc42_RwnWf-Ynw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Oct 28, 2024 at 1:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2024-10-28 kello 10:39 -0400, Luiz Augusto von Dentz kirjoitti:
> > On Sat, Oct 26, 2024 at 6:41=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > User can cancel transport acquire by calling Release() while Acquire(=
)
> > > is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
> > > forcing AVDTP state transition to IDLE, and disconnecting A2DP profil=
e,
> > > which is not desired.
> > >
> > > Fix by instead waiting until START completes and then send SUSPEND. M=
ake
> > > Release() reply only after the whole sequence completes.
> >
> > Hmm, but assumes the client is not reconfiguring to another endpoint
> > or just giving up on the transport since it doesn't intend to use it
> > anymore, anyway we can't really send anything else other than abort if
> > we don't want to wait so I think this would be better to be handled by
>
> I guess you have in mind
>
>         Acquire(t1)
>         Release(t1)  # canceling acquire
>         SetConfiguration(ep2)
>
> I don't think this works right in current BlueZ master branch either,
> the Release() results to removing the DBus endpoints & AVDTP
> disconnect, so nothing to SetConfigure() after abort completes.
> SetConfiguration() probably fails also if called while Abort_Cfm is
> pending, since it cannot then close the existing stream.
>
> I think (but did not test) that with the patch here, it would end up
> doing START -> CLOSE -> reconfigure, so indeed has to wait for START
> completion.

I guess you are saying that we don't want the stream to transit to
idle since that would cause the AVDTP session to be disconnected? It
seems this is the result of session->dc_timeout being set to 0 on
avdtp_abort, anyway now looking a little more in detail it seems
clearer that the transport methods shouldn't affect the state machine
other than for suspend/resume procedures, that said then we need to
check what happens if those methods are called in quick succession e.g
Acquire -> Release -> Acquire.

> > the application if it intends to suspend then it should wait acquire
> > to complete and then release.
>
> I think it's a bug in BlueZ that calling Release() on transport result
> to disconnect of A2DP, instead of suspend.
>
> I have another version of this patch that does send ABORT, but recalls
> it was due to canceled suspend and reconnects the sink/source when
> getting to IDLE.
>
> > > Fix also sending error reply to the canceled Acquire() call, which wa=
s
> > > missing previously.
> > > ---
> > >
> > > Notes:
> > >     In theory we could also send ABORT and reconfigure the SEP again =
after
> > >     that. It's more hairy though as with how the code currently works=
, we
> > >     may need to complete discovery first. This is a corner case anywa=
y, so
> > >     just waiting a bit should be easier.
> > >
> > >  profiles/audio/transport.c | 152 +++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 110 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > > index 0f7909a94..4d5afe022 100644
> > > --- a/profiles/audio/transport.c
> > > +++ b/profiles/audio/transport.c
> > > @@ -88,6 +88,9 @@ struct a2dp_transport {
> > >         uint16_t                delay;
> > >         int8_t                  volume;
> > >         guint                   watch;
> > > +       guint                   resume_id;
> > > +       gboolean                cancel_resume;
> > > +       guint                   cancel_id;
> > >  };
> > >
> > >  struct bap_transport {
> > > @@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(struct m=
edia_transport *transport)
> > >         return a2dp_sep_get_stream(sep);
> > >  }
> > >
> > > +static void a2dp_suspend_complete(struct avdtp *session, int err,
> > > +                                                       void *user_da=
ta)
> > > +{
> > > +       struct media_owner *owner =3D user_data;
> > > +       struct media_transport *transport =3D owner->transport;
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->en=
dpoint);
> > > +
> > > +       /* Release always succeeds */
> > > +       if (owner->pending) {
> > > +               owner->pending->id =3D 0;
> > > +               media_request_reply(owner->pending, 0);
> > > +               media_owner_remove(owner);
> > > +       }
> > > +
> > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > +       media_transport_remove_owner(transport);
> > > +}
> > > +
> > > +static guint transport_a2dp_suspend(struct media_transport *transpor=
t,
> > > +                                               struct media_owner *o=
wner)
> > > +{
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > +       struct media_endpoint *endpoint =3D transport->endpoint;
> > > +       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > > +
> > > +       if (a2dp->cancel_resume)
> > > +               return a2dp->resume_id;
> > > +
> > > +       if (owner !=3D NULL)
> > > +               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_=
complete,
> > > +                                                                    =
   owner);
> > > +
> > > +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > +       a2dp_sep_unlock(sep, a2dp->session);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static gboolean a2dp_cancel_resume_cb(void *user_data)
> > > +{
> > > +       struct media_owner *owner =3D user_data;
> > > +       struct media_transport *transport =3D owner->transport;
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > +
> > > +       a2dp->cancel_id =3D 0;
> > > +       a2dp->cancel_resume =3D FALSE;
> > > +       owner->pending->id =3D transport_a2dp_suspend(transport, owne=
r);
> > > +       return FALSE;
> > > +}
> > > +
> > >  static void a2dp_resume_complete(struct avdtp *session, int err,
> > >                                                         void *user_da=
ta)
> > >  {
> > >         struct media_owner *owner =3D user_data;
> > >         struct media_request *req =3D owner->pending;
> > >         struct media_transport *transport =3D owner->transport;
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > >         struct avdtp_stream *stream;
> > >         int fd;
> > >         uint16_t imtu, omtu;
> > >         gboolean ret;
> > >
> > > +       a2dp->resume_id =3D 0;
> > >         req->id =3D 0;
> > >
> > >         if (err)
> > >                 goto fail;
> > >
> > > +       if (a2dp->cancel_resume) {
> > > +               DBG("cancel resume");
> > > +               a2dp->cancel_id =3D g_idle_add(a2dp_cancel_resume_cb,=
 owner);
> > > +               return;
> > > +       }
> > > +
> > >         stream =3D transport_a2dp_get_stream(transport);
> > >         if (stream =3D=3D NULL)
> > >                 goto fail;
> > > @@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct media=
_transport *transport,
> > >         struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > >         guint id;
> > >
> > > +       if (a2dp->resume_id || a2dp->cancel_id)
> > > +               return -EBUSY;
> > > +
> > >         if (a2dp->session =3D=3D NULL) {
> > >                 a2dp->session =3D a2dp_avdtp_get(transport->device);
> > >                 if (a2dp->session =3D=3D NULL)
> > >                         return 0;
> > >         }
> > >
> > > -       if (state_in_use(transport->state))
> > > -               return a2dp_resume(a2dp->session, sep, a2dp_resume_co=
mplete,
> > > +       if (state_in_use(transport->state)) {
> > > +               id =3D a2dp_resume(a2dp->session, sep, a2dp_resume_co=
mplete,
> > >                                                                      =
   owner);
> > > +               a2dp->resume_id =3D id;
> > > +               return id;
> > > +       }
> > >
> > >         if (a2dp_sep_lock(sep, a2dp->session) =3D=3D FALSE)
> > >                 return 0;
> > > @@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct media=
_transport *transport,
> > >         if (transport->state =3D=3D TRANSPORT_STATE_IDLE)
> > >                 transport_set_state(transport, TRANSPORT_STATE_REQUES=
TING);
> > >
> > > +       a2dp->resume_id =3D id;
> > >         return id;
> > >  }
> > >
> > > -static void a2dp_suspend_complete(struct avdtp *session, int err,
> > > -                                                       void *user_da=
ta)
> > > -{
> > > -       struct media_owner *owner =3D user_data;
> > > -       struct media_transport *transport =3D owner->transport;
> > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->en=
dpoint);
> > > -
> > > -       /* Release always succeeds */
> > > -       if (owner->pending) {
> > > -               owner->pending->id =3D 0;
> > > -               media_request_reply(owner->pending, 0);
> > > -               media_owner_remove(owner);
> > > -       }
> > > -
> > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > -       media_transport_remove_owner(transport);
> > > -}
> > > -
> > > -static guint transport_a2dp_suspend(struct media_transport *transpor=
t,
> > > -                                               struct media_owner *o=
wner)
> > > -{
> > > -       struct a2dp_transport *a2dp =3D transport->data;
> > > -       struct media_endpoint *endpoint =3D transport->endpoint;
> > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> > > -
> > > -       if (owner !=3D NULL)
> > > -               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_=
complete,
> > > -                                                                    =
   owner);
> > > -
> > > -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> > > -       a2dp_sep_unlock(sep, a2dp->session);
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  static void transport_a2dp_cancel(struct media_transport *transport,=
 guint id)
> > >  {
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > +
> > > +       if (a2dp->resume_id && a2dp->resume_id =3D=3D id) {
> > > +               /* a2dp_cancel() results to ABORT->IDLE->disconnect. =
Canceling
> > > +                * START can be triggered by user via Release(), and =
it's better
> > > +                * to not drop the A2DP connection then, so we just s=
uspend
> > > +                * after resume completes.
> > > +                */
> > > +               a2dp->cancel_resume =3D TRUE;
> > > +               return;
> > > +       }
> > > +
> > >         a2dp_cancel(id);
> > >  }
> > >
> > > +static void transport_a2dp_remove_owner(struct media_transport *tran=
sport,
> > > +                                       struct media_owner *owner)
> > > +{
> > > +       struct a2dp_transport *a2dp =3D transport->data;
> > > +
> > > +       /* Clean up callbacks that refer to the owner */
> > > +
> > > +       if (a2dp->cancel_id) {
> > > +               g_source_remove(a2dp->cancel_id);
> > > +               a2dp->cancel_id =3D 0;
> > > +       }
> > > +
> > > +       if (a2dp->resume_id) {
> > > +               a2dp_cancel(a2dp->resume_id);
> > > +               a2dp->resume_id =3D 0;
> > > +       }
> > > +
> > > +       a2dp->cancel_resume =3D FALSE;
> > > +}
> > > +
> > >  static int8_t transport_a2dp_get_volume(struct media_transport *tran=
sport)
> > >  {
> > >         struct a2dp_transport *a2dp =3D transport->data;
> > > @@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection *con=
n, DBusMessage *msg,
> > >
> > >                 member =3D dbus_message_get_member(owner->pending->ms=
g);
> > >                 /* Cancel Acquire request if that exist */
> > > -               if (g_str_equal(member, "Acquire"))
> > > +               if (g_str_equal(member, "Acquire")) {
> > > +                       media_request_reply(owner->pending, ECANCELED=
);
> > >                         media_owner_remove(owner);
> > > -               else
> > > +               } else {
> > >                         return btd_error_in_progress(msg);
> > > +               }
> > >         }
> > >
> > >         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
> > > @@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct media_t=
ransport *transport, void *data)
> > >  }
> > >
> > >  #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> > > -       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _=
init, \
> > > +       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
> > > +                       transport_a2dp_remove_owner, _init, \
> > >                         transport_a2dp_resume, transport_a2dp_suspend=
, \
> > >                         transport_a2dp_cancel, NULL, \
> > >                         transport_a2dp_get_stream, transport_a2dp_get=
_volume, \
> > > --
> > > 2.47.0
> > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
