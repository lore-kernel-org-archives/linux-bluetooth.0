Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085E1DF728
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137067; cv=none; b=eBLiuZjXjU349aKRXOHiHa305OsI+mwAxWl1ucH3kEsyc/hcGK1qlN+EzkqMqorjaO4Z2SwPA8qebUvOY/cWzmn0kA0eZAVdSTgUwCvofwBNNLd/ZQyYv2HTBdExpk82r99qE4owVcs3fWavOybpxjmrMylvysshRhS3x6SQUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137067; c=relaxed/simple;
	bh=DTj8bNvg+uhvHdNc3HKliKouadJP4EgKJOuE4hNxRGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofRe4AC8hdHwyo0AasSO5isRdCAzWW1xdDI1WZdaSgtrbEUI7830QUYQuQNCOLLp0q05IpyuF5Twz9MRXEDiyBNb3ZXs/qIoFSZHFFytVeRbRZyDGzpPbmNC6u/z0viePqnCILBYOUDCV0mnl+cTwocByLMZe2OQGa9EUXf+cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUU/APgO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUU/APgO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so50660901fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730137063; x=1730741863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7gmedIDKwx/krD/j/OMWjUbVfwh75Dql4sNeROuHCc=;
        b=TUU/APgOrqB1feh/fijc1KW5/3LrzcUxjWEnN6M81KUc8JA4F2uoU41V1QobE1pouB
         u9i3osyILPxXnjmWMlcsRn0yK/Y84tVjXCOy1rHQNAJaOTc4c3NQ/KhyD+ha4LmQxv14
         PA+9KUcgDXqssfKofUzmpXPYr2r+vKn4RjGevui1Hr3C7JUyb1kCmDcRq8oDYb2MbNyS
         ABpVOU1vVAXT9rMYSlZBmTPMkz7iF89hRJdRK74IX5qy8WJihsaGxaEuYDwFWg7DRZ7t
         H+kQAEUUAZPzH/SL2XDj0g2zLcyq+7t4b3IycW9JUUzhfc5UUAnmpag3spwaQoQP5pLy
         XLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137063; x=1730741863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7gmedIDKwx/krD/j/OMWjUbVfwh75Dql4sNeROuHCc=;
        b=eZzNPMKc0ZKRJ1jhj4zRBXKKg/tIvvxhG54O5GUwTGhxzhb/wgLXaeXazMer4vUyVF
         iQTPhtUft7gTW9OO96tAhHeIPPSmmfq6gTE1Q4+LCn+2sLHcwUzDGeC3pq7GO3Wh4gqa
         ouY9Xii0gGsY0dF5i0DqS0syyP+tvgA7cnRDsm1FHqMOIfEJNr/3ki/dgoedDzijzvsg
         VOVYGLJJhRdFpuV/tfimnz7yqd4+mUYmtr1+E2/EWi8JhkzWSbTkoesGOdsmnC2xgl3G
         nfhrp/SldoEzHqjKP8E4/0Jotrhd0mQY8F/DCwterAN8+4n6guAii+t6FmwzdtHVG34G
         ZFXA==
X-Gm-Message-State: AOJu0YxzU/NwbG41Nbbxzx/CpCtzeTDkEaWU9azhrUUN3ESQ6tQpiss7
	z4TzmzMwqptlTPGg4ezy/CKS0fq8erjDzQejVvdeQHrt20ZfILqhzVmqRxFFy4gANyIYMqbQoZk
	bQZX5/TtJORwybYdzNzrIYyKk2Ak8pQ==
X-Google-Smtp-Source: AGHT+IFsLZDgIyrHbkydaiZQkOa/ojKdB8nPg0J6qUiVuPd9BdW+qsnX3x+NkDfuBqLrHZ7KNd+sNOznwDKv6I3hrnQ=
X-Received: by 2002:a2e:a58f:0:b0:2fb:5a42:da45 with SMTP id
 38308e7fff4ca-2fcda110302mr1097441fa.16.1730137062907; Mon, 28 Oct 2024
 10:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
 <20241025202141.158946-2-daniel.beer@igorinstitute.com> <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>
 <Zx/Ft7upRYfGVD4f@fermat.nev>
In-Reply-To: <Zx/Ft7upRYfGVD4f@fermat.nev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 13:37:30 -0400
Message-ID: <CABBYNZ+=chpkTNhB=P2RM2c2V7Vxe9wUDdrWi-KkqOmc2wmV5Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if
 the stream goes away.
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 28, 2024 at 1:11=E2=80=AFPM Daniel Beer
<daniel.beer@igorinstitute.com> wrote:
>
> On Mon, Oct 28, 2024 at 11:04:20AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Daniel,
> >
> > On Fri, Oct 25, 2024 at 4:30=E2=80=AFPM Daniel Beer
> > <daniel.beer@igorinstitute.com> wrote:
> > >
> > > If the stream goes IDLE while we have an outstanding request, connect=
_id
> > > stays non-zero and is never cleared via a completion callback. As a
> > > consequence, the profile on this device will never be connected
> > > successfully again until BlueZ restarts.
> > > ---
> > >  profiles/audio/source.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/profiles/audio/source.c b/profiles/audio/source.c
> > > index 9fac352c8..db777e86d 100644
> > > --- a/profiles/audio/source.c
> > > +++ b/profiles/audio/source.c
> > > @@ -134,6 +134,11 @@ static void stream_state_changed(struct avdtp_st=
ream *stream,
> > >         case AVDTP_STATE_IDLE:
> > >                 btd_service_disconnecting_complete(source->service, 0=
);
> > >
> > > +               if (source->connect_id > 0) {
> > > +                       a2dp_cancel(source->connect_id);
> > > +                       source->connect_id =3D 0;
> > > +               }
> > > +
> >
> > Is this really happening or is more of a fix based on disconnect_id?
> > If that really is happening then we need to fix the sink as well since
> > it appears to be doing the same, that said connect_id may be set with
> > a2dp_discover which can happen in AVDTP_STATE_IDLE so in theory that
> > can still be ongoing, anyway this code hasn't change in very long time
> > so I wonder if this is sort of workaround to specific model or
> > use-case we haven't tried before?
>
> Hi Luiz,
>
> Yes, it is really happening, and yes, the same problem occurs in sink.c
> (see patch 1/1). We have a client who can reproduce the issue in
> automated testing with Bluetooth A2DP devices, and who has tested the
> fix above.
>
> The symptom we notice is that PulseAudio complains about a timeout
> connecting the A2DP profile, which is never attempted because
> {sink,source}_setup_stream() never appears to do anything. It returns
> immediately on the first line test because connect_id is non-zero and
> stays that way forever.
>
> Immediately before the sink/source code stops working we see a
> communication failure in which the connection is dropped while
> a2dp_discover is ongoing.

Ok, then perhaps it is a good idea to have these applied, that said it
would have been great to have this type of test automation upstream in
the future so we can catch regressions if we ever change this logic
for some reason.

> Cheers,
> Daniel
>
> > >                 if (source->disconnect_id > 0) {
> > >                         a2dp_cancel(source->disconnect_id);
> > >                         source->disconnect_id =3D 0;
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> --
> Daniel Beer
> Director of Firmware Engineering at Igor Institute
> daniel.beer@igorinstitute.com or +64-27-420-8101
> Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312



--=20
Luiz Augusto von Dentz
