Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB91DB350
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126388; cv=none; b=WbhsG7UlccnyExpUTHGdTTc+xNbVsSPpHY0p3tkgSaJ5mjDJwJLopDttVaTAvaCk0w3eEEGwCGQeVPIiYqdHWZBq4VuV3P+4jsLIYji0yKDk8+W74w6zIMlUcRdJOriiDPua1gK/VgBGXCwou0h3H+3TbZhZJKF7NXno6Ml//OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126388; c=relaxed/simple;
	bh=sXTVUl2Tsr8lBS1i2pwy1VC2OEXLY1gH8dLTzyemvZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NH1R0waJcZDC/fkbSoDY7d1oSfonAC7JNWxTyKc+mJYRHlDnU/Bf5wV6GctXqDnC6u11TIXxj6N4R1bF8F7jiWg9evWkft06XHv5TdK7DqWjuFfht0BIhrIjyEZAa8LNNRgxW5BBOFEVx39B3y6SUSpOjfoeEqsCDl7mZgec3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5KP7rQK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5KP7rQK"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb49510250so42369141fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730126384; x=1730731184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5SRrMVsFSBvcwqy965TNldzo/EWL6mdfeE5aBswCm8=;
        b=O5KP7rQKBOKACuEhdM8lbm6iGXt+4EqHm8SsHExYD6OWePsTXaQbFE5PC0oAunseHx
         QwVpk4Nj6jpp+MKzqMKil54OJEY6EGdLCvnIpZ/mktQO3b2YfUmngE2DImWQBQjWOTKJ
         blzDZJxvP6WZyUwfUtbnM6qRYtjrgySXK418TFqyTk8qKJCXc1wcCWp3sLiGL2Q3O5Nq
         AgJKXpvd7Fn0bHVIsvy//+bWWI3H1uDueFhr2ryfKUpQ5P7VQf31m714Zmn/fqzYLzy8
         bE5B+rFSDiR1G0CW+nSaBxSoJQRQ6Ks+IpXlbcs7FmmOBoL5B5HxJNv2aUbZ4zYsjAN3
         Gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126384; x=1730731184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5SRrMVsFSBvcwqy965TNldzo/EWL6mdfeE5aBswCm8=;
        b=jQkug5b1XwZDLlp33e3SF9eZQBARMGH8yNzMwLoLPcGD0NFloSBwepm/dQhfNhrVtB
         ngh5edGxnWbS2lfYGcTlUm0n/KYJ7MN3xRAMHYr4yw2+r2vZR2reDCNBONEGdVXh6bWA
         wbu3477Dbvq/h9xXWWHSP4am2wRDjXbeZCaHz3jVlxfUvmG1DFy+h+hCvTyj33Yv4UIB
         l7aX/QdUyuaI89VybLTuXcT6zScatzaGUjoZK5Y2oWADq8pUjIKRKpWDoYyuHfoZjyxu
         Wf691zhD+D2zXCNwAC6IRcl/yp6Q9G8BiSRMhpspn5LpdvqORake/dtuh+aoNcd3VFhR
         3JrA==
X-Gm-Message-State: AOJu0YyXKo+XBKXAR/ktrc0v5u/3laZ8U4O0pN10KLCxWO0dSXHzytoy
	K+/pAo1IO9h9cFQX7vmbg+qJxmOKKALTvpuPjActQitHjLH5au1r0KjEEAf1q6sGLwe0sOWMvAM
	4138RijazG2OL2vQIgYS/FrvwAEt9Pg==
X-Google-Smtp-Source: AGHT+IGWo2wOTs+27QedKlm6GkB7icQGI3iRS+BDJqbftpqWOYnmpiN59Yf2q+5ZoOgn84cO6pDQOFyRaq+/pqZzAu4=
X-Received: by 2002:a2e:a552:0:b0:2fb:30d5:669a with SMTP id
 38308e7fff4ca-2fcbddf7346mr40596411fa.0.1730126383342; Mon, 28 Oct 2024
 07:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
In-Reply-To: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 10:39:30 -0400
Message-ID: <CABBYNZJ-c9zWOr4br8TuMhRam4ue+o0s1e-RzfzRvLbq9cXodw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Oct 26, 2024 at 6:41=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> User can cancel transport acquire by calling Release() while Acquire()
> is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
> forcing AVDTP state transition to IDLE, and disconnecting A2DP profile,
> which is not desired.
>
> Fix by instead waiting until START completes and then send SUSPEND. Make
> Release() reply only after the whole sequence completes.

Hmm, but assumes the client is not reconfiguring to another endpoint
or just giving up on the transport since it doesn't intend to use it
anymore, anyway we can't really send anything else other than abort if
we don't want to wait so I think this would be better to be handled by
the application if it intends to suspend then it should wait acquire
to complete and then release.

> Fix also sending error reply to the canceled Acquire() call, which was
> missing previously.
> ---
>
> Notes:
>     In theory we could also send ABORT and reconfigure the SEP again afte=
r
>     that. It's more hairy though as with how the code currently works, we
>     may need to complete discovery first. This is a corner case anyway, s=
o
>     just waiting a bit should be easier.
>
>  profiles/audio/transport.c | 152 +++++++++++++++++++++++++++----------
>  1 file changed, 110 insertions(+), 42 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 0f7909a94..4d5afe022 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -88,6 +88,9 @@ struct a2dp_transport {
>         uint16_t                delay;
>         int8_t                  volume;
>         guint                   watch;
> +       guint                   resume_id;
> +       gboolean                cancel_resume;
> +       guint                   cancel_id;
>  };
>
>  struct bap_transport {
> @@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(struct media=
_transport *transport)
>         return a2dp_sep_get_stream(sep);
>  }
>
> +static void a2dp_suspend_complete(struct avdtp *session, int err,
> +                                                       void *user_data)
> +{
> +       struct media_owner *owner =3D user_data;
> +       struct media_transport *transport =3D owner->transport;
> +       struct a2dp_transport *a2dp =3D transport->data;
> +       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->endpoi=
nt);
> +
> +       /* Release always succeeds */
> +       if (owner->pending) {
> +               owner->pending->id =3D 0;
> +               media_request_reply(owner->pending, 0);
> +               media_owner_remove(owner);
> +       }
> +
> +       a2dp_sep_unlock(sep, a2dp->session);
> +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> +       media_transport_remove_owner(transport);
> +}
> +
> +static guint transport_a2dp_suspend(struct media_transport *transport,
> +                                               struct media_owner *owner=
)
> +{
> +       struct a2dp_transport *a2dp =3D transport->data;
> +       struct media_endpoint *endpoint =3D transport->endpoint;
> +       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> +
> +       if (a2dp->cancel_resume)
> +               return a2dp->resume_id;
> +
> +       if (owner !=3D NULL)
> +               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_comp=
lete,
> +                                                                       o=
wner);
> +
> +       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> +       a2dp_sep_unlock(sep, a2dp->session);
> +
> +       return 0;
> +}
> +
> +static gboolean a2dp_cancel_resume_cb(void *user_data)
> +{
> +       struct media_owner *owner =3D user_data;
> +       struct media_transport *transport =3D owner->transport;
> +       struct a2dp_transport *a2dp =3D transport->data;
> +
> +       a2dp->cancel_id =3D 0;
> +       a2dp->cancel_resume =3D FALSE;
> +       owner->pending->id =3D transport_a2dp_suspend(transport, owner);
> +       return FALSE;
> +}
> +
>  static void a2dp_resume_complete(struct avdtp *session, int err,
>                                                         void *user_data)
>  {
>         struct media_owner *owner =3D user_data;
>         struct media_request *req =3D owner->pending;
>         struct media_transport *transport =3D owner->transport;
> +       struct a2dp_transport *a2dp =3D transport->data;
>         struct avdtp_stream *stream;
>         int fd;
>         uint16_t imtu, omtu;
>         gboolean ret;
>
> +       a2dp->resume_id =3D 0;
>         req->id =3D 0;
>
>         if (err)
>                 goto fail;
>
> +       if (a2dp->cancel_resume) {
> +               DBG("cancel resume");
> +               a2dp->cancel_id =3D g_idle_add(a2dp_cancel_resume_cb, own=
er);
> +               return;
> +       }
> +
>         stream =3D transport_a2dp_get_stream(transport);
>         if (stream =3D=3D NULL)
>                 goto fail;
> @@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct media_tra=
nsport *transport,
>         struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
>         guint id;
>
> +       if (a2dp->resume_id || a2dp->cancel_id)
> +               return -EBUSY;
> +
>         if (a2dp->session =3D=3D NULL) {
>                 a2dp->session =3D a2dp_avdtp_get(transport->device);
>                 if (a2dp->session =3D=3D NULL)
>                         return 0;
>         }
>
> -       if (state_in_use(transport->state))
> -               return a2dp_resume(a2dp->session, sep, a2dp_resume_comple=
te,
> +       if (state_in_use(transport->state)) {
> +               id =3D a2dp_resume(a2dp->session, sep, a2dp_resume_comple=
te,
>                                                                         o=
wner);
> +               a2dp->resume_id =3D id;
> +               return id;
> +       }
>
>         if (a2dp_sep_lock(sep, a2dp->session) =3D=3D FALSE)
>                 return 0;
> @@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct media_tra=
nsport *transport,
>         if (transport->state =3D=3D TRANSPORT_STATE_IDLE)
>                 transport_set_state(transport, TRANSPORT_STATE_REQUESTING=
);
>
> +       a2dp->resume_id =3D id;
>         return id;
>  }
>
> -static void a2dp_suspend_complete(struct avdtp *session, int err,
> -                                                       void *user_data)
> -{
> -       struct media_owner *owner =3D user_data;
> -       struct media_transport *transport =3D owner->transport;
> -       struct a2dp_transport *a2dp =3D transport->data;
> -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->endpoi=
nt);
> -
> -       /* Release always succeeds */
> -       if (owner->pending) {
> -               owner->pending->id =3D 0;
> -               media_request_reply(owner->pending, 0);
> -               media_owner_remove(owner);
> -       }
> -
> -       a2dp_sep_unlock(sep, a2dp->session);
> -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> -       media_transport_remove_owner(transport);
> -}
> -
> -static guint transport_a2dp_suspend(struct media_transport *transport,
> -                                               struct media_owner *owner=
)
> -{
> -       struct a2dp_transport *a2dp =3D transport->data;
> -       struct media_endpoint *endpoint =3D transport->endpoint;
> -       struct a2dp_sep *sep =3D media_endpoint_get_sep(endpoint);
> -
> -       if (owner !=3D NULL)
> -               return a2dp_suspend(a2dp->session, sep, a2dp_suspend_comp=
lete,
> -                                                                       o=
wner);
> -
> -       transport_set_state(transport, TRANSPORT_STATE_IDLE);
> -       a2dp_sep_unlock(sep, a2dp->session);
> -
> -       return 0;
> -}
> -
>  static void transport_a2dp_cancel(struct media_transport *transport, gui=
nt id)
>  {
> +       struct a2dp_transport *a2dp =3D transport->data;
> +
> +       if (a2dp->resume_id && a2dp->resume_id =3D=3D id) {
> +               /* a2dp_cancel() results to ABORT->IDLE->disconnect. Canc=
eling
> +                * START can be triggered by user via Release(), and it's=
 better
> +                * to not drop the A2DP connection then, so we just suspe=
nd
> +                * after resume completes.
> +                */
> +               a2dp->cancel_resume =3D TRUE;
> +               return;
> +       }
> +
>         a2dp_cancel(id);
>  }
>
> +static void transport_a2dp_remove_owner(struct media_transport *transpor=
t,
> +                                       struct media_owner *owner)
> +{
> +       struct a2dp_transport *a2dp =3D transport->data;
> +
> +       /* Clean up callbacks that refer to the owner */
> +
> +       if (a2dp->cancel_id) {
> +               g_source_remove(a2dp->cancel_id);
> +               a2dp->cancel_id =3D 0;
> +       }
> +
> +       if (a2dp->resume_id) {
> +               a2dp_cancel(a2dp->resume_id);
> +               a2dp->resume_id =3D 0;
> +       }
> +
> +       a2dp->cancel_resume =3D FALSE;
> +}
> +
>  static int8_t transport_a2dp_get_volume(struct media_transport *transpor=
t)
>  {
>         struct a2dp_transport *a2dp =3D transport->data;
> @@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection *conn, D=
BusMessage *msg,
>
>                 member =3D dbus_message_get_member(owner->pending->msg);
>                 /* Cancel Acquire request if that exist */
> -               if (g_str_equal(member, "Acquire"))
> +               if (g_str_equal(member, "Acquire")) {
> +                       media_request_reply(owner->pending, ECANCELED);
>                         media_owner_remove(owner);
> -               else
> +               } else {
>                         return btd_error_in_progress(msg);
> +               }
>         }
>
>         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
> @@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>  }
>
>  #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
> -       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init=
, \
> +       TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
> +                       transport_a2dp_remove_owner, _init, \
>                         transport_a2dp_resume, transport_a2dp_suspend, \
>                         transport_a2dp_cancel, NULL, \
>                         transport_a2dp_get_stream, transport_a2dp_get_vol=
ume, \
> --
> 2.47.0
>
>


--=20
Luiz Augusto von Dentz
