Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC94315A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931975; cv=none; b=ZdW0W2OzPk/Rap6mGJtnW74HBaVSIh5USE0w+woBMkfOnWVCr5XGPT8I9lAM7OIKMFqDcIts7XoxfkNqi3QluyevcCq4mQ+85e+VVo6GRoQ3+vglSaz2uRuw3H8sqFXeGMR4vnTFQ7+8p+AGNG3zy5tf3uh0aLgXg9EeZhuhKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931975; c=relaxed/simple;
	bh=iPm1w8zGx8QtHUh3uxusQHb/XIOz/KxGzTSL43RuWoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZdTMsT6tFw6vyCNt8ZUN62CnTcOA1KkV2jzF7AeaLuU3vcbTnpKhtMxQ4jHWvmdOV88u3sFIHjT1R5YWz5wVojN7qggXqRKfS1YmE1R1oIcbBIUOiXfduo7hao6QgCTDCMNXgWpmnsvlthNcbvxsdSPEFVnPVMLRFWZwjbV8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuKaNaQg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuKaNaQg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ccc6964c9so1875898e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931972; x=1755536772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPu8tNS+x0TRQXvSO1Z7PRzVxXVYgkS2NNmbFKQirRU=;
        b=TuKaNaQgyS+9/X696ctYQWraxYTN+aFlx8C+f1wxQgLVlkzISP8idK//1Fb6aaX928
         QM+kqAYFR2AM9xG6anjBoaZwciyZUL5sWCURQvLBpdT+PTy+IiZPOUCSXfUjVe7eUxUS
         0hL+hg6Kn3MUP9Y0kuVfVRtJxSCF74QUUOMMbg53Svm7fHeHJh3u6O74vU2RxLPJGOLW
         017MC1gIDiqRHr7J2W2kk6sqlsh/yk/nlJNVkWb6iXr/yjF8Y/1qOziAm4BaOiCk3B7r
         lqATANgoSQeMmrK03+SKh80AextrYLECYsnmdjMR+T0+RwL0zZ2BAXEi9HA7L9SatF+/
         qZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931972; x=1755536772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPu8tNS+x0TRQXvSO1Z7PRzVxXVYgkS2NNmbFKQirRU=;
        b=r+nw0fAzWUPIGUoDoYiHKlSKI0NTMaJJQ5y1zBPNRccAk+Ju53MCmcRihYTiOWIba5
         0FzNRAVdl3MT0Lx/ppcDn13hE3VzB09A7XGEnj2PqwniZs8THGdFOqG1GtCZOVo6i/OQ
         ua+TkNc1EWUerJPUP+bxc3/mkEqT0PZjmxqhEi/36oxuRQ9dOanbaR1h5+vPQXHeQxFS
         ddYCdPFVCb6T7JVJBKK8cPm+tGUaoAaCrd3Z8g/fGhkmqV/AxghD2ogwjia8jmRMd2ae
         bljSZVT1VyDmvuxQbAN/aaI4C7TFmZ04o1LfaNeF22+xsnItwi6t/Zs3Y08LrbqiK1Ua
         Rifw==
X-Gm-Message-State: AOJu0YzbF55RJpc/BCvN3ZpW3GIpTVarCHZq/hSrpdRqZtnB7sB87tVD
	2sYh3WngCE4KIP+ZtYAdraT1HTXW182ghSy6/GYaiQycaIsuAW+ywFarjQS2NqOs8ur2mC8Rr4p
	Cqc4PR5zFGAlwQS3YLzNrIIUaBoXyeJNnlk6h
X-Gm-Gg: ASbGnctPqqbZZopVw16V7ppxQ+SxK3OHZQMFuAs9sTZSoLy2OM4N3ydk1x/r8zV7U3a
	J0dbuW161BrEF3wmf0Uciigxa+mRXfEjiGFYWNdQw9P9S4avVk5YpDbnVGYdeghw17zyaGJDzR1
	QmvmGQgt78jez2C0OaxC2XKSpUABiMXEukiH6Zeq1V4EV0j9BV+uJSHTdFsxWRuplv7M5LpkeJ0
	c+qrw==
X-Google-Smtp-Source: AGHT+IFNA0UKxz26dxJHpY5tBYIyrB59Prv8/b89tn8YFbyKWlcl4+1gaWtmO7wLVO8tEiUU7o+hObXy0Om/MuNTr6c=
X-Received: by 2002:a05:651c:1987:b0:332:2235:911c with SMTP id
 38308e7fff4ca-333d7d29d2fmr929771fa.37.1754931971384; Mon, 11 Aug 2025
 10:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
 <CABBYNZKpYS=55P06PendXTT-VF+hyMqd4n94koXWrtbc9Li14Q@mail.gmail.com> <17eac95c2065b3a21f3d647a3422b3f099cccb46.camel@iki.fi>
In-Reply-To: <17eac95c2065b3a21f3d647a3422b3f099cccb46.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Aug 2025 13:05:58 -0400
X-Gm-Features: Ac12FXy7wThs8V6JmbGw9folSYAUadhZ8v-Zuq78P1_RDVmqogOBxBAw_hshzTY
Message-ID: <CABBYNZ+nAZ2tX=1VbZX96p6ZhFmcdNE80-4Cn3pywYHnfTnyYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: reset local ep states on bap session detach
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Aug 11, 2025 at 12:54=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2025-08-11 kello 10:38 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Aug 10, 2025 at 2:18=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > When detaching BAP session, the session is removed from the global li=
st,
> > > and streams do not go through normal state change cleanup, so local
> > > endpoint states are not cleaned up. This causes problems as ASE may b=
e
> > > in busy state even though there is no stream.
> >
> > Why wouldn't they go through the normal state change cleanup though,
> > the stream shall be set to idle and then affect the endpoint state as
> > well or we do have something preventing that to happen? Or the
> > local_eps are not used as stream->ep for some reason?
>
> What I mean above, is that design in bt_bap_detach() appears to be to
> not call the usual state change callbacks from there.
>
> bap is first removed from sessions list, so bt_bap_ref_safe(bap) =3D=3D
> NULL, so that stream_set_state() only calls ops->detach(), which does
> not change ep state.

Ok, that explains it, bu then perhaps the likes of bap_ucast_detach
shall be cleanup the ep state once it does ep->stream =3D NULL, that
said if it is an unexpected disconnect Id cache the codec
configuration so upon reconnection that should restore the stream
faster, if the stream has been released then it should be in idle
already.

> For remote EPs (iow as BAP Client), we will re-read their state when
> attaching the session next time, so state cleanup on detach is not
> necessary. (We also probably should not in general be updating remote
> EP states ourselves, but leave it to remote via GATT.)
>
> For local EPs, we don't reset state on detach or attach, so they stay
> what they were.

Ok, this is a bug, on disconnect we either should return it to codec
config (cache) or idle (non-cache).

> I think we (as BAP Server) are not supposed to persist the local ASE
> state over session detach, e.g. remote disappears and ATT disconnects,
> and then reconnects later.
>
> We could reset the endpoint state in stream_set_state() if there is no
> session, if that sounds better, instead of doing it in bt_bap_detach()
> like here.
>
> IIUC stream_set_state() is supposed to be called only for streams to
> local endpoints, but not 100% sure if it's so in practice (re:
> broadcast or stream_io_disconnected).
>
> > >
> > > Fix by resetting all ASE to IDLE state after detaching all streams.
> > > ---
> > >  src/shared/bap.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index ed5c322b4..d4beb9818 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -5664,6 +5664,14 @@ static void stream_foreach_detach(void *data, =
void *user_data)
> > >         stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> > >  }
> > >
> > > +static void ep_foreach_detach(void *data, void *user_data)
> > > +{
> > > +       struct bt_bap_endpoint *ep =3D data;
> > > +
> > > +       ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> > > +       ep->old_state =3D BT_ASCS_ASE_STATE_IDLE;
> > > +}
> > > +
> > >  static void bap_req_detach(void *data)
> > >  {
> > >         struct bt_bap_req *req =3D data;
> > > @@ -5696,6 +5704,7 @@ void bt_bap_detach(struct bt_bap *bap)
> > >         bap->att =3D NULL;
> > >
> > >         queue_foreach(bap->streams, stream_foreach_detach, bap);
> > > +       queue_foreach(bap->local_eps, ep_foreach_detach, bap);
> >
> > This sounds more like a workaround though, the stream_foreach_detach
> > should have cleaned up all existing streams and their endpoints, we
> > could perhaps print a message if the ep->state is not idle then it
> > means something is not quite right.
> >
> > >         queue_foreach(bap_cbs, bap_detached, bap);
> > >  }
> > >
> > > --
> > > 2.50.1
> > >
> > >
> >



--=20
Luiz Augusto von Dentz
