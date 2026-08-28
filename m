Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB636D9E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935579; cv=pass; b=oQV45dHRHM6XtXzfmM6IHOgJBVXrCCNUo+UO8lnHHHUeX6vGizKh9El5JuFZ2hJlwBAZtIdvCZ/xwW7Ca/JmLk2xJHOstxdl1fQ/FOM7pZ8uXBEtibkWQJgz9FnERDR/CfsCNjni7SwV/Pqzr3hunWtgVn/wQNkQtqKDkLU+98g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935579; c=relaxed/simple;
	bh=O7x0mx1drNffxPRyb+k+1eggUwnV9E3wC1hy7chCpds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEr+CRuHVNBQXn5XnwDxPn10L6Ox4qferXxl+5ZXUQuxKmFjAbeyXCrtc0JA4h/VMqDPJovi2bKI0neq4oFCrxBKNoMZTl+J+Fs0QrDvbw8iXqgJc8QtANrYDdwBdaeJDj6BRQYqEwghhyj5XpEfJg+jr80KA0iHAVpHO4gt/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOHV+bdC; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOHV+bdC"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-857ff9fef54so14531827b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 09:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787935577; cv=none;
        d=google.com; s=arc-20260327;
        b=jyru6LwNghr7yPLbQbiO07B1f1Bly7685yo1pzIfgBLzroQoxM0fwaC2rK67nRPxt5
         7RaHtS/N9Sbz6UVHuMXr91e4AMk79hWkB04i/q26PiBCeVP/QaYbKFoVSZ8qrmisqxFm
         yDQIA/DGP0pLAHQnjc3hySQpcuYyyORhBgm8iiyo3bkdmSAKbABQFeaxr+ygXsJMt5jm
         TD9fiG46rkuxYrDGbvRtTA7Dm4ogpQTnHiccAebdS5/0S0y3nCP1GheZM9NSPx/famgR
         kozMBDbqc8y80WDqkpf+WEhuDeFvuxQ3+xNJdnfqwAPAfjRq4in5BOGE5g3R/tFJ9CsY
         AEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L8Mo668Q3hVDs52vb8xrz6iOJ63EU+NZfS57YDh6lTA=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=Mk10cmd3ovhtHDKp6tKgrLszQmG/GOOxuGgo+SfnaaP/HWIPADRgLAFjC90BPw5cqX
         xUdtGcEHt7MyHA2seURSp14FgJ5LSzCQLSWP0k0FAwwvWyAHPY8CnWG8hSAGIXZi1u//
         HX8+QC/KRueBOmpoTmk6n/DCamiuJJgI7UvH1liclC8TelST3r4Z+igrcDlX4ul1sNEm
         XaZKQyjjqlUuoBc2dkjslfqfoLu7GLUZiI02hrQZyghweN06aedpRswGNdquN9pAhccI
         NiflAijuOMjCjPFlzSDYR0PRryw9RaIxTNuqAC3THGm3K2Yv7M9617PEf+9Rq/o91haH
         X2VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787935577; x=1788540377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8Mo668Q3hVDs52vb8xrz6iOJ63EU+NZfS57YDh6lTA=;
        b=GOHV+bdCaE0HdNxqI/HncPil8SDALsbjdu7sl6AkfjqX/1aqCkrNubtJTbMUN2bhs/
         DuCsX8QZsKzdS5ksFg3c84ZlRoJ6lfj5cctSWiZ4PGuHVeSLyg0qAMwduqY7YHrvw6MO
         cFNkVP7YgfRHCxXmhjekqLr1eqGPVDP9TAmQUw6YmM1qnzPXyFF9Hdq7QrUkhukimCjj
         gnaweaLrxeWmYvvgvxh90DWxKmIVOWoSCtEeXSo1gAHcDADqIwhsssqr17ILHBPtSlCl
         d4NsPcTnS/uNqtoUHA5J5EM9eB50+oQpzYujzBLJJWUUt1/xADrawjnTFDHbREdc4v4G
         0tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935577; x=1788540377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8Mo668Q3hVDs52vb8xrz6iOJ63EU+NZfS57YDh6lTA=;
        b=bRErh48djLGpIixJkjDtHqUDHtTjO4ImwqanQO4GjFCtScUvWyOECIbGBVIp6g3YmC
         wkfmcblLN40zTRlVsq1//llxyEFaU79jF/5A3ZyWe2Qw1roQ0Zsb12SSqJle71ifPeRi
         cJIzWiBDpoZK/r5272lRsh1EnVWrq39AD7qH5CG+CfKIdfyu9QkYDQvxjp2Rx3eUa+/E
         wu47e1c92P/RDCXTyzGGGIZc28KasDWIx0SZ9n9l+F0bZb13uUCzGqOwBiMCfXKZ9qYE
         4nR6peNMKcfsPKijnOlv+DKE41gUtwn4BueFAjmLwWhncXHhzi2wqrbr3Kqh+Ee26gSy
         Ly+Q==
X-Gm-Message-State: AFuF++mBlRhaoG4YxPoyqq7gRBNS2utl+QrBT0qZeGD+tIgceJDjf8/o
	MKNdEjWvvp64Xko4upYP2ZPGB3IDSRG04VxzjWM1hDMPOtP0GavGe4IdgKMcxcQJBKqvLj8f9rJ
	O2WKwW9O4Dkn8VUKXPm8hKzVPnScH0ttvqJDqm/w=
X-Gm-Gg: AYBFou0QcSqvTTd9SjDbYMoLT7E45VOxkJuUauZnKobnZRV4ES9mLp0RuTT9v/+ixFh
	wfeM2zBIeJIfEm/KST0ImDqzgN2qtapGfRKjgVMMJqwG1gOFlRdd9Fu8lNDT1vxCHAyNdfJtTDW
	p7lxGjFVUYiIFh/dnMWV7yixc1URV36k5EAZm/nPHl09+nOStsgo0kORRfQuoumnxr55xyt9x3y
	qbt8S8ZCYq/edMZkzLTgykTp2zBou+LywKU1PWrVAIflrVS1ESyCKKayEscYg40mTQO0FZGYS8X
	YOkXjv1sWs7NnvvZDEG/Yu7AdqviE92lQyeneScceDzbt8gXJ0Deu+JU9csR6qrGqop6Ud2e/+9
	RiUYFyAQnedDp/Xit+TaeeMVj8bjZFTk=
X-Received: by 2002:a05:690c:530e:b0:81e:5a57:b8ad with SMTP id
 00721157ae682-85d6cfc2431mr27107927b3.21.1787935576947; Fri, 28 Aug 2026
 09:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827180149.415744-1-luiz.dentz@gmail.com> <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
 <CABBYNZ+qzL04d0cdKd==wFr_Gtz9gCa3_iNv0B9rE=R8pdpajg@mail.gmail.com> <78402f4521084b3f6d2cce7709cbba751d83836f.camel@iki.fi>
In-Reply-To: <78402f4521084b3f6d2cce7709cbba751d83836f.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Aug 2026 12:46:04 -0400
X-Gm-Features: AcwNN1XYPkEKAkJhkjGzG1hO0siwR3enalv9nB0mcDd5GhOloeq3CyMJvmPB_HQ
Message-ID: <CABBYNZK6R2GfeoJDLxW72BeYNcpEZvS7sdRac+Ka1E+e6idj3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to bind
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Aug 28, 2026 at 12:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> pe, 2026-08-28 kello 09:50 -0400, Luiz Augusto von Dentz kirjoitti:
> > On Thu, Aug 27, 2026 at 7:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > > to, 2026-08-27 kello 14:01 -0400, Luiz Augusto von Dentz kirjoitti:
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > SCO sockets have no PSM or port namespace: binding one simply reser=
ves
> > > > the ability to accept any incoming eSCO/SCO connection on the adapt=
er.
> > > > That is equivalent to listening on a well-known service, which L2CA=
P
> > > > already restricts to CAP_NET_BIND_SERVICE in
> > > > l2cap_validate_bredr_psm()/l2cap_validate_le_psm().
> > >
> > > In current Linux userspace, sound servers that do HFP listen on SCO
> > > sockets, and I think often don't have CAP_NET_BIND_SERVICE.
> > >
> > > Do they continue working with this change?
> >
> > Good question, that said this is a part of security hardening
> > otherwise any process could start listening to an SCO connection, and
> > the sound server would stop working. Btw, does the sound server have
> > any special capability to, let's say, open the sound card device so
> > perhaps we can gate it on sound capability as well.
>
> For ALSA, the sound hardware access is controlled by device file
> permissions in /dev/snd/*  Not sure if that's usable here, or if
> there's some other per-user controlled solution that could be used.

Ok, so you are saying anyone user with file access to /dev/snd/* can
grab the hardware for itself, since pipewire is just a regular user it
just works because it is the first one to open it?

> In most current distros sound server runs with user permissions without
> special capabilities, and don't have CAP_NET_BIND_SERVICE, so I'd
> expect this patch breaks userspace.
>
> Giving this capability to them allows binding to low network ports, so
> it probably makes the hardening issue worse and not better.

You would grant it to a specific set of binaries, probably via a
systemd file. This would block other users, which currently might just
be testing tools like isotest, where you just use sudo instead, or an
AI agent trying to fabricate vulnerabilities.

> The next simplest is probably separate executable with setcap bit set,
> which gives a SCO listen socket for those who can run it based on file
> permissions.

What file permission? Afaik a socket protocol doesn't have file
permissions, or does it? The is no open just bind which is what we are
trying to protect.

> For ISO bluetoothd manages this (so can be gated with DBus/selinux
> policies), and it could make sense for it to be made to work like that
> for SCO too.

Yeah, bluetoothd manages this for ISO and I wish we did this for SCO
too, maybe via Profle interface which I guess PipeWire registers, but
it just for RFCOMM/AT commands, right? Anyway this is too late because
we cannot break support of older versions of pipewire/bluetoothd + new
kernel, so we need a way to determine if SCO usage is allowed or not.

> > > > Apply the same restriction to sco_sock_bind() so unprivileged proce=
sses
> > > > can no longer hijack incoming SCO links.
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/sco.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > index 3d4362a09df4..e4c26551e513 100644
> > > > --- a/net/bluetooth/sco.c
> > > > +++ b/net/bluetooth/sco.c
> > > > @@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock, =
struct sockaddr_unsized *addr,
> > > >
> > > >       BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
> > > >
> > > > +     /* Binding a SCO socket reserves the ability to accept any in=
coming
> > > > +      * eSCO/SCO connection on the adapter, so restrict it in the =
same way
> > > > +      * L2CAP restricts well-known PSMs.
> > > > +      */
> > > > +     if (!capable(CAP_NET_BIND_SERVICE))
> > > > +             return -EACCES;
> > > > +
> > > >       lock_sock(sk);
> > > >
> > > >       if (sk->sk_state !=3D BT_OPEN) {
> > >
> > > --
> > > Pauli Virtanen
> >
> >



--=20
Luiz Augusto von Dentz
