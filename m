Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F62475F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931292; cv=pass; b=m5kQ67jNZfV08tKcMHQtIq+WeUWcbrO7YXBISrM3jGKl9bgQMgUyQu0oBU7oZJ5cXrCAougwd730f/L8JYcJLKg6ipWryN4dKq3nilzMePMvOz7LULkFRhdkyJyZATAoQQfUvaWhfbNUU+UIfS+oFQCmvm7CVGX8EPobAurAEXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931292; c=relaxed/simple;
	bh=NpG2u1osShnYA/FenYr2MWZv863wpq3gyrCVBgWuibE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQYC089s52IZvmAvrphFn0GDweLAMn+MK4FamP+9WB2/luG2U/AMfXudEucLz72IQyxOzcH6BHTR9z+macKflTE6PwUH6hE1Vt+SJ3GSq1uQyzhiDWnRyOX0zUYVe/IkUnVcMCdG6pxIhlZFuC91NCdi/Uuv8iY7Qr3lcS2nwKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=H7Fu6FXK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="H7Fu6FXK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c112V5nCNz49Q51;
	Mon, 11 Aug 2025 19:54:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754931282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBmlYxFUVJmvpHA1mvm8N7XVNvZ5X1DdpI6iiO4xzxM=;
	b=H7Fu6FXKKH+HDjffzVfo7CdNnGooGNlOikmb5jJXFe6m1dlbOp6cKLo9ux52I/m8Srszsi
	1R30pCGGJXKsD+dF9xCzu6EbqFq/JGpHe6eCJEFhK8r4z6DEd59By4dz2m1R2Ex8Y+wEDq
	HFVGrPhwFLwAo4U1igHgaJHOVOqFxoMuveJLkey1/1xtXVsxhk7/QYUYiUljPqiT3iopim
	PLcsLD3jq9/8Zaivd17aIMX74Qh8u4mxsO2xG78SD1HzPPBET2Kq4Gv0sc6c4DnbZyUnUV
	0bTNAz7u+0aiHRQmm0uWbi3U5YSqhDkb+rsmK6tcnMQAtUzu18K8UaLUhfJ9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754931282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBmlYxFUVJmvpHA1mvm8N7XVNvZ5X1DdpI6iiO4xzxM=;
	b=wDKt9R/GhXuKrIQk1p5LNrrKmQ1v0U5Qig0upUeN4bMqISjUfK2JuO34MG61AZ7RSfMStd
	VwXeQs2bIroFzbRJDy2oTfn4vhTr4u3fpsDbYpn3T2gsJFeLRcdV3DqVTOSai18x1GaWWS
	BnfRFxijKzDwqQYoGRnNdpU++9gmvMsy7L/bqT0V1BxFlnMqQXGTf4KdMJBd5P1wEcLajq
	k/1k241ft+Xbglmq8j0vYfJWNcZQg+RefR3ObxDOM5qG3ZtPqPTtd1lXXexfkE74oowfnU
	y/s+NIGoE780eAUsEu+YAFO+AL34VKWIFNPbTE3m0BtIiCLLOCe6mdFJT8JX8w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754931282; a=rsa-sha256;
	cv=none;
	b=feJGw8fF57aBwOHFiwQEcOtZrrxJUiJxqbDmsgkfVSSqwfD9dFwV888zHYcXnSyZhRoz0h
	g2g2PCZTPYA+kt0gDbYZ/wkyRMTW34mb6ZSy+r+M8/qKmcU5VYGEiCiIn9aY+C2c+pU/aa
	ONf/M/urF4YkAoqhO5cA3OxSti5laghKE5w9yvlFUlEbWQeOncOtPmmZgcNaL9iGTKqVg1
	RwMFbPiCWomR4zrZ80qJNX5jdYp850Uz8cYKT5hM1nkbA1r0m+mdS4WMhPAbEcHFUSiyUP
	nBBr7Xm2fAYbHCjJB0twp1X79H/fRVKHtmO2aO9NGyivpcy9hKEKG/437K3c5A==
Message-ID: <17eac95c2065b3a21f3d647a3422b3f099cccb46.camel@iki.fi>
Subject: Re: [PATCH BlueZ] shared/bap: reset local ep states on bap session
 detach
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 11 Aug 2025 19:54:42 +0300
In-Reply-To: <CABBYNZKpYS=55P06PendXTT-VF+hyMqd4n94koXWrtbc9Li14Q@mail.gmail.com>
References: 
	<d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
	 <CABBYNZKpYS=55P06PendXTT-VF+hyMqd4n94koXWrtbc9Li14Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-08-11 kello 10:38 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Aug 10, 2025 at 2:18=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > When detaching BAP session, the session is removed from the global list=
,
> > and streams do not go through normal state change cleanup, so local
> > endpoint states are not cleaned up. This causes problems as ASE may be
> > in busy state even though there is no stream.
>=20
> Why wouldn't they go through the normal state change cleanup though,
> the stream shall be set to idle and then affect the endpoint state as
> well or we do have something preventing that to happen? Or the
> local_eps are not used as stream->ep for some reason?

What I mean above, is that=C2=A0design in bt_bap_detach() appears to be to
not call the usual state change callbacks from there.

bap is first removed from sessions list,=C2=A0so bt_bap_ref_safe(bap) =3D=
=3D
NULL, so that stream_set_state() only calls ops->detach(), which does
not change ep state.

For remote EPs (iow as BAP Client), we will re-read their state when
attaching the session next time, so state cleanup on detach is not
necessary. (We also probably should not in general be updating remote
EP states ourselves, but leave it to remote via GATT.)

For local EPs, we don't reset state on detach or attach, so they stay
what they were.

I think we (as BAP Server) are not supposed to persist the local ASE
state=C2=A0over session detach, e.g. remote disappears and ATT disconnects,
and then reconnects later.

We could reset the endpoint state in stream_set_state() if there is no
session, if that sounds better, instead of doing it in bt_bap_detach()
like here.

IIUC stream_set_state() is supposed to be called only for streams to
local endpoints, but not 100% sure if it's so in practice (re:
broadcast or stream_io_disconnected).

> >=20
> > Fix by resetting all ASE to IDLE state after detaching all streams.
> > ---
> >  src/shared/bap.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index ed5c322b4..d4beb9818 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -5664,6 +5664,14 @@ static void stream_foreach_detach(void *data, vo=
id *user_data)
> >         stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> >  }
> >=20
> > +static void ep_foreach_detach(void *data, void *user_data)
> > +{
> > +       struct bt_bap_endpoint *ep =3D data;
> > +
> > +       ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> > +       ep->old_state =3D BT_ASCS_ASE_STATE_IDLE;
> > +}
> > +
> >  static void bap_req_detach(void *data)
> >  {
> >         struct bt_bap_req *req =3D data;
> > @@ -5696,6 +5704,7 @@ void bt_bap_detach(struct bt_bap *bap)
> >         bap->att =3D NULL;
> >=20
> >         queue_foreach(bap->streams, stream_foreach_detach, bap);
> > +       queue_foreach(bap->local_eps, ep_foreach_detach, bap);
>=20
> This sounds more like a workaround though, the stream_foreach_detach
> should have cleaned up all existing streams and their endpoints, we
> could perhaps print a message if the ep->state is not idle then it
> means something is not quite right.
>=20
> >         queue_foreach(bap_cbs, bap_detached, bap);
> >  }
> >=20
> > --
> > 2.50.1
> >=20
> >=20
>=20
