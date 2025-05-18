Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E852F43
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 May 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592167; cv=pass; b=qUI1x2HNmkN8F3tRSH5+inJBkZFCewCDxFuzik/misgrUXyJVxYzE8ynIO6RRzI57f3kdDmwf/1dCruX3aXxWfc8YQdGtoOyk70/GfYTXtV9XNIBg75QYnMWD6ZKMGkmcS3QUEagmSh0DbwclQtq6C4XXQwHgEHcQrtJLxEKhzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592167; c=relaxed/simple;
	bh=yR6kregvoF9+HcvCKzAXJ9Ztx1olz9KawP5Zca7yue8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKrWQlAHKCY0ft0aKU8nN4dzd2NFclWF4foVdqC9Ugg18PDS5G+LQkH0DNzXSJNRcBWSCRSP9HpV//v+sCMhVQ04OCyY7gHOEAZzVcZFkCwxhhzNzSG7n8ZVuDMemw4az/cbbJ+CqmOAcdmpnv4dZD98x82+u6B4tr/46xy4mGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PNNA76ft; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PNNA76ft"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4b0pjT6WYPz49PvX;
	Sun, 18 May 2025 21:09:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1747591742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4aCKFcRRxXnaxNQwITA/4GSBx8b3MWJgjoAwTos85o=;
	b=PNNA76ft/zp28gFWEmv4u6d3Xz2BzwdZaVo9MWaHu0pHnkWaaadF8C725Y/hQVoX6ijpK9
	Gz0heXPtYiQaHYN6H819tAQ1ICEsPIOw89aVu+GD94/HoLeb9jf77tQckYy2rNlUTg00us
	t5XCPsBwKbes2fSqOjosrj7eaf8SVf2QxW2YgTI9oZMr6onuCCVvsIYX4xVo0Dj7SkepHt
	8wHSYJsBOP7xmYBUiN1Ddb0nERFs4E48RzmDAvIN6b96yjjdAZ9C/eZpUVoWiZcyaq952c
	+VrjNbd59lb7zrMQM+Id3CUZSZkhPYMTKNa9Q/PjTnn9E4oxo07C12PKfMkkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1747591742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4aCKFcRRxXnaxNQwITA/4GSBx8b3MWJgjoAwTos85o=;
	b=NHwUCf5gbspDYEH5s32WihvcmYRltqNaw8nWPWhBvNmb2aIOPnaL/ZjV/M+1HGrgtbYG05
	KMdDEhIPDPsFpaKumkgMgOlEUMYPgaTbQKkCEubm12s2XnuUBVn90mFaW3jlhCHWi2K2U0
	J6LISXdoY8or9xK0u8gQDi4RLRItEFw5TBne6DCFwv9bYCLmc6tNM/9oyiDqkjMC+LQEiu
	KsLxH5KVu9vi95x4nGwAY2EgsS9Qzx5bWrsMH4li69VvtXYwO6UwaZrcHcPCKWnfBKuxAS
	99S5ujcusfz0v+P6733voCnET6/Y1WqYbTl/aqFwCG8VIupjeb5G0j+qGVNhRA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1747591742; a=rsa-sha256;
	cv=none;
	b=O+E730Jvb5fzuGi6PoAyqPwHcipueuOH15itqI6OScwWy8o94GDUdQyqrSEPz9+Nnz14JX
	JaqEE7nlldXtYsHsZa3xDQjIY3SR1Kf6C7bXRyJEzop0W8Fs4oabdCouRMI8nkyI9r5JVa
	HaiwavrBHjs+HQwpO6NOVrEfHQPDrZTCDnJu5XDRvVEeE6969bWLMFRz0Aa25UwQGyKyBx
	XVmjkczO5EkKoFRkgn+f8jqkh4VpQ65azk+HUd2XpqDuo2h/VXRcSBruOH8G8DrAuPWIvy
	l5bzq+cyHcwOqqtFS/PUX7NMKb7jMV4aKhzgUvialoIk+tbDgLwglPmhfCYsqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <fe1b59b75ac38ccfa22d85775d63de500acfd98d.camel@iki.fi>
Subject: Re: [RFC PATCH BlueZ v2 04/11] shared/bap: fix ucast client ASE
 usage
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 18 May 2025 21:08:59 +0300
In-Reply-To: <CABBYNZ+C95QEVk3+R__dQrKVoKCgZc8+X25-BCqy9kYvwFk_AQ@mail.gmail.com>
References:
	 	<3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
		 <52645e73ab0c6f12d2a29b17259222417cf81a93.1746374514.git.pav@iki.fi>
		 <CABBYNZ+C95QEVk3+R__dQrKVoKCgZc8+X25-BCqy9kYvwFk_AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2025-05-06 kello 12:56 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, May 4, 2025 at 12:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > The ucast client stream design has issues:
> >=20
> > * Assuming lpac & rpac pair uniquely identifies a stream.  False for
> >   AC6(i) and other multi-stream configs.
> >=20
> > * No way for ASE in Config state be configured with different codec.
> >=20
> > * Assuming ASE enters idle state at end of stream life cycle.  False fo=
r
> >   some devices like Sony headsets, which always cache codec config so
> >   RELEASING -> CONFIG always, never RELEASING -> IDLE, so ASE never go
> >   IDLE again.
> >=20
> > * Assuming Unicast Client upper layer always creates streams for all
> >   non-idle ASEs.  False, as when switching between duplex & sink-only
> >   modes, only some streams shall be used regardless of whether Server i=
s
> >   caching config or not.
>=20
> I think it would make sense to fix these points one by one, or you
> tried that and ended up running into some problems?

Adding the client_active/lock mechanism and using it in stream linking
& ASE selection solves most of those.

Not clear that aside from the close+unlink on release, the rest can be
split to working standalone changes.

> > In practice, these currently prevent reconfiguring ASEs on devices whic=
h
> > cache codec config, and multi-stream configs work only accidentally (an=
d
> > fail if server does Config codec itself, like some devices do).
> >=20
> > Minimally fixed design for Unicast Client streams:
> >=20
> > Streams correspond 1-to-1 to ASEs in non-IDLE state.
> >=20
> > Track explicitly which streams upper level is using:
> >=20
> > - bt_bap_stream_new() always makes new stream with client_active=3Dtrue
> > - bt_bap_stream_discard() releases stream and marks client_active=3Dfal=
se
>=20
> This perhaps could be done differently, perhaps having a lock flag, so
> if the stream is locked it means its configuration cannot be changed.

It could be called bt_bap_stream_lock/unlock() instead.

The "configuration cannot be changed" in this case would mean only that
bt_bap_stream_new() does not reuse that particular stream.

It's not clear eg. blocking upper layer from bt_bap_config_stream() on
locked stream is useful, similarly blocking server-side config updates

> > Streams (ASEs) with no active client may be reused when upper level ask=
s
> > for a new stream.
> >=20
> > Streams with no active client may have their lpac changed.  The
> > need_reconfig state is a bit ugly, but not really avoidable.
>=20
> Do we have a situation where client_active=3Dfalse (lock=3Dfalse) and
> need_reconfig!=3Dtrue? In other words could we just use the
> client_active/lock flag instead of introducing yet another flag?

It occurs if stream is discarded/unlocked, before transition to CONFIG
is made.=C2=A0

The state indicates the configuration in bt_bap_stream (lpac etc.) is
out of sync with the ASE, and upper layer must bt_bap_stream_config().

> > Streams with no active client shall be ignored when constructing
> > bidirectional CIS pairs.
> >=20
> > Streams shall clear transport and detach io on RELEASING. (cf BAP v1.0.=
2
> > =C2=A75.6.6). Also unlink them since QoS is gone at that point.
>=20
> I'd consider fixing this as a separate patch as well.

I'll split this to separate patch.

> > Streams shall have transport only for >=3D QOS state.  (Server streams
> > work differently, which makes sense since upper level cannot acquire
> > them before they are pending.)
>=20
> Sounds good, that said we might want to check if there aren't missing
> tests that would cover such conditions, there is a whole session of
> the BAP testing spec dedicated for streaming configuration (AC-#), if
> will probably need some changes to test-bap to create socketpair to
> emulate CIS since those tests require CIS/BIS in order to pass.

Tests would be good, yes.

I don't see the BAP testing spec contain tests that explicitly do
client reconfiguring. A simple smoketest for Releasing is specified.

I'll do some more manual testing before v3.

> > ---
> >  src/shared/bap.c | 170 +++++++++++++++++++++++++++++++++--------------
> >  src/shared/bap.h |   2 +
> >  2 files changed, 123 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 976e3c0b1..456450d40 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -296,6 +296,8 @@ struct bt_bap_stream {
> >         struct queue *pending_states;
> >         bool no_cache_config;
> >         bool client;
> > +       bool client_active;
> > +       bool need_reconfig;
> >         void *user_data;
> >  };
> >=20
> > @@ -1488,6 +1490,13 @@ static void bap_stream_state_changed(struct bt_b=
ap_stream *stream)
> >                 if (stream->client)
> >                         bt_bap_stream_stop(stream, stream_stop_complete=
, NULL);
> >                 break;
> > +       case BT_ASCS_ASE_STATE_RELEASING:
> > +               if (stream->client) {
> > +                       bap_stream_clear_cfm(stream);
> > +                       bap_stream_io_detach(stream);
> > +                       bt_bap_stream_io_unlink(stream, NULL);
> > +               }
> > +               break;
> >         }
> >  }
> >=20
> > @@ -1898,6 +1907,9 @@ static unsigned int bap_ucast_qos(struct bt_bap_s=
tream *stream,
> >         if (!stream->client)
> >                 return 0;
> >=20
> > +       if (stream->need_reconfig)
> > +               return 0;
> > +
> >         memset(&qos, 0, sizeof(qos));
> >=20
> >         /* TODO: Figure out how to pass these values around */
> > @@ -2300,7 +2312,6 @@ static unsigned int bap_ucast_release(struct bt_b=
ap_stream *stream,
> >         /* If stream does not belong to a client session, clean it up n=
ow */
> >         if (!bap_stream_valid(stream)) {
> >                 stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> > -               stream =3D NULL;
> >                 return 0;
> >         }
> >=20
> > @@ -2583,6 +2594,9 @@ static int bap_ucast_io_link(struct bt_bap_stream=
 *stream,
> >                         stream->ep->dir =3D=3D link->ep->dir)
> >                 return -EINVAL;
> >=20
> > +       if (stream->client && !(stream->client_active && link->client_a=
ctive))
> > +               return -EINVAL;
> > +
> >         if (!stream->links)
> >                 stream->links =3D queue_new();
> >=20
> > @@ -2603,6 +2617,30 @@ static int bap_ucast_io_link(struct bt_bap_strea=
m *stream,
> >         return 0;
> >  }
> >=20
> > +static void stream_unlink_ucast(void *data)
> > +{
> > +       struct bt_bap_stream *link =3D data;
> > +
> > +       DBG(link->bap, "stream %p unlink", link);
> > +
> > +       queue_destroy(link->links, NULL);
> > +       link->links =3D NULL;
> > +}
> > +
> > +static int bap_ucast_io_unlink(struct bt_bap_stream *stream,
> > +                                               struct bt_bap_stream *l=
ink)
> > +{
> > +       if (!stream)
> > +               return -EINVAL;
> > +
> > +       queue_destroy(stream->links, stream_unlink_ucast);
> > +       stream->links =3D NULL;
> > +
> > +       DBG(stream->bap, "stream %p unlink", stream);
> > +       return 0;
> > +
> > +}
> > +
> >  static void stream_link(void *data, void *user_data)
> >  {
> >         struct bt_bap_stream *stream =3D (void *)data;
> > @@ -2708,7 +2746,7 @@ static const struct bt_bap_stream_ops stream_ops[=
] =3D {
> >                         bap_ucast_release, bap_ucast_detach,
> >                         bap_ucast_set_io, bap_ucast_get_io,
> >                         bap_ucast_io_dir, bap_ucast_io_link,
> > -                       NULL),
> > +                       bap_ucast_io_unlink),
> >         STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
> >                         bap_ucast_get_state,
> >                         bap_ucast_config, bap_ucast_qos, bap_ucast_enab=
le,
> > @@ -2718,7 +2756,7 @@ static const struct bt_bap_stream_ops stream_ops[=
] =3D {
> >                         bap_ucast_release, bap_ucast_detach,
> >                         bap_ucast_set_io, bap_ucast_get_io,
> >                         bap_ucast_io_dir, bap_ucast_io_link,
> > -                       NULL),
> > +                       bap_ucast_io_unlink),
> >         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
> >                         bap_bcast_get_state,
> >                         bap_bcast_config, bap_bcast_qos, bap_bcast_sink=
_enable,
> > @@ -5015,6 +5053,8 @@ static void ep_status_config(struct bt_bap *bap, =
struct bt_bap_endpoint *ep,
> >                 ep->stream->cc =3D new0(struct iovec, 1);
> >=20
> >         util_iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
> > +
> > +       ep->stream->need_reconfig =3D false;
> >  }
> >=20
> >  static void bap_stream_config_cfm_cb(struct bt_bap_stream *stream, int=
 err)
> > @@ -5922,43 +5962,6 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *ba=
p, struct bt_bap_pac *pac)
> >         return false;
> >  }
> >=20
> > -static bool find_ep_unused(const void *data, const void *user_data)
> > -{
> > -       const struct bt_bap_endpoint *ep =3D data;
> > -       const struct match_pac *match =3D user_data;
> > -
> > -       if (ep->stream)
> > -               return false;
> > -
> > -       if (match->rpac)
> > -               return ep->dir =3D=3D match->rpac->type;
> > -       else
> > -               return true;
> > -}
> > -
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
> > @@ -6136,6 +6139,48 @@ static struct bt_bap_stream *bap_bcast_stream_ne=
w(struct bt_bap *bap,
> >         return stream;
> >  }
> >=20
> > +static bool find_ep_ucast(const void *data, const void *user_data)
> > +{
> > +       const struct bt_bap_endpoint *ep =3D data;
> > +       const struct match_pac *match =3D user_data;
> > +
> > +       if (ep->stream) {
> > +               if (!ep->stream->client)
> > +                       return false;
> > +               if (ep->stream->client_active)
> > +                       return false;
> > +               if (!queue_isempty(ep->stream->pending_states))
> > +                       return false;
> > +
> > +               switch (ep->stream->state) {
> > +               case BT_BAP_STREAM_STATE_IDLE:
> > +               case BT_BAP_STREAM_STATE_CONFIG:
> > +               case BT_BAP_STREAM_STATE_QOS:
> > +                       break;
> > +               default:
> > +                       return false;
> > +               }
> > +       }
> > +
> > +       if (ep->dir !=3D match->rpac->type)
> > +               return false;
> > +
> > +       switch (match->lpac->type) {
> > +       case BT_BAP_SOURCE:
> > +               if (ep->dir !=3D BT_BAP_SINK)
> > +                       return false;
> > +               break;
> > +       case BT_BAP_SINK:
> > +               if (ep->dir !=3D BT_BAP_SOURCE)
> > +                       return false;
> > +               break;
> > +       default:
> > +               return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
> >                                         struct bt_bap_pac *lpac,
> >                                         struct bt_bap_pac *rpac,
> > @@ -6153,21 +6198,28 @@ static struct bt_bap_stream *bap_ucast_stream_n=
ew(struct bt_bap *bap,
> >         match.lpac =3D lpac;
> >         match.rpac =3D rpac;
> >=20
> > -       /* Check for existing stream */
> > -       ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> > +       /* Get free ASE */
> > +       ep =3D queue_find(bap->remote_eps, find_ep_ucast, &match);
> >         if (!ep) {
> > -               /* Check for unused ASE */
> > -               ep =3D queue_find(bap->remote_eps, find_ep_unused, &mat=
ch);
> > -               if (!ep) {
> > -                       DBG(bap, "Unable to find unused ASE");
> > -                       return NULL;
> > -               }
> > +               DBG(bap, "Unable to find usable ASE");
> > +               return NULL;
> >         }
> >=20
> >         stream =3D ep->stream;
> > -       if (!stream)
> > +       if (stream) {
> > +               /* Replace lpac: the stream generally needs to be recon=
figured
> > +                * after this, otherwise things like codec config not m=
atch.
> > +                */
> > +               bap_stream_clear_cfm(stream);
> > +               stream->lpac =3D lpac;
> > +               util_iov_free(stream->cc, 1);
> > +               stream->cc =3D util_iov_dup(data, 1);
> > +               stream->need_reconfig =3D true;
> > +       } else {
> >                 stream =3D bap_stream_new(bap, ep, lpac, rpac, data, tr=
ue);
> > +       }
> >=20
> > +       stream->client_active =3D true;
> >         return stream;
> >  }
> >=20
> > @@ -6187,6 +6239,26 @@ struct bt_bap_stream *bt_bap_stream_new(struct b=
t_bap *bap,
> >         return bap_bcast_stream_new(bap, lpac, pqos, data);
> >  }
> >=20
> > +void bt_bap_stream_discard(struct bt_bap_stream *stream)
> > +{
> > +       if (!stream || !stream->client)
> > +               return;
> > +
> > +       stream->client_active =3D false;
> > +
> > +       switch (stream->ep->state) {
> > +       case BT_BAP_STREAM_STATE_IDLE:
> > +       case BT_BAP_STREAM_STATE_RELEASING:
> > +               break;
> > +       case BT_BAP_STREAM_STATE_CONFIG:
> > +               if (stream->ep->old_state =3D=3D BT_BAP_STREAM_STATE_RE=
LEASING)
> > +                       break;
> > +               /* Fallthrough */
> > +       default:
> > +               bt_bap_stream_release(stream, NULL, NULL);
> > +       }
> > +}
> > +
> >  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
> >  {
> >         if (!stream)
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index d10581428..5949eb4b1 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -183,6 +183,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_b=
ap *bap,
> >                                         struct bt_bap_qos *pqos,
> >                                         struct iovec *data);
> >=20
> > +void bt_bap_stream_discard(struct bt_bap_stream *stream);
> > +
> >  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)=
;
> >  uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
> >=20
> > --
> > 2.49.0
> >=20
> >=20
>=20
