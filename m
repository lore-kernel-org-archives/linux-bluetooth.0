Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87323D297
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449382; cv=pass; b=ZW5HSQV1mSFUKJk1VXSpe2YzExL+XQG+WqCU/nPKML1p1OB62r8ZkXxSJ7Q6w5E7gZzXN/O9tJklUYNnDtBVMz9Q/GGvyeQCehUfO+w21q4mwyPxKmBH6kiGznD9q0pZb5rZ63DfeC0No/Vzs1ci37oA0QXjS5DV9C3aZQt/Ooo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449382; c=relaxed/simple;
	bh=smmX/Eo4hvLm+jmRwQ9xYh/y9G6ZTdC7Th5Ssfvk54s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5SnhZ1lZn/Bvox2ZMVg4fiTTBpz3l63AaXDXOcmeBO17y+DtMY+8wfayg3I+OnQf4ltmaXYZEPGR9xoAUtVCSiRpMT03UJvMHirowW4MjRfKVSoWdHJgB/gnIXqLP9XOA0VBywJoY/NIGy+tzC6AMNp0Fo7bA0YBeZrwsKfRMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDtCd2i6; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDtCd2i6"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e8cdafeffso1553964d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 07:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774449380; cv=none;
        d=google.com; s=arc-20240605;
        b=eOAXcafSl4kdLXXzYaRsli12OodSGLkB4nKRHZFrNWxZFwX604KntZ3y11qDKyUHQc
         Jw8Y2rLwhGXU2ceIjNK5s/MKhEUs3Tg4lT7pJAYls0Um4ouejvHKYm0vMWtxWI1panrs
         BX1JtQn9FqJufJvGbO8Dkby047PprMZI5teFQydNI35Wqja7QQ00QMjXjp+o3O/qoBM9
         hHVvxqvFNEubsc7cTgHVmWNb8US6j56RMwgL+tuoUXnWVTZvITP6lRb/shk8at5awGFm
         C+MaY/vpgygSG/tr207tUkIqhlmzfeh3olkHiPeRiIy/Hj8rrreOozBIxZap2zWrWBka
         peXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pGPnYxvq9hnzr2kA9OE2vMDct57Hq1DQLCYAloentrE=;
        fh=equJUd5MLvwVxFGRk+fVo0Iwuh+RM2Hm4ZruNO5GD7w=;
        b=Gao03n10KvfCRVqIPgQT1SlSV+kDZBAuMr6B9PX5jKP539J2h2tvls4OY9VQrwzeu7
         f+mShpnnvJ4pB+jzDbaN+mYQB9pjGehxAxIdRio6B0F+mV5vYYRppth3e9vqMfYg0/Cq
         bF5wrrCSfuJhSSBOk4JGHuMYWfiiMJH+R9Jpct661LZeIiIE4F4rkdriT0w6etvaCsKy
         SnUcvPtofEmB0PULhf/j3EQTQ4zNY613uaxPSxWBDAanHpAkJSBM0q3isKfnzAOgZc8m
         A3+Kwh1OLDGeH2AUgDkb3qBZEN0rVsTFegAiAKkhNS9imEh5BNwXB+SL1FjKzf250+uX
         KSZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774449380; x=1775054180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGPnYxvq9hnzr2kA9OE2vMDct57Hq1DQLCYAloentrE=;
        b=qDtCd2i6iYupLOpEvgfnF+7A93gxhKjlKKHFD5SGcAZNZ0bCRst0wrro52122i2H0x
         Aj2BLDD4TMBWMlV5pYpVIpE3EK18+u1928M7CqhWXleuAZ4hYiv8gmAFV3EzwCdDTbW5
         n4njmoEXZDBWIc4OnkSAIrfIO5RBfk2RwolDS2GIoYqK0ww7cQVU4Z7TM40nq829jJMA
         ylg1kjlINcV3ggK1/ztYPzEOrUwsqHZUBCDR/Q2dvxY5z4bZGT5KcS6kt8A7mFObc8Ml
         pXRidgWbowrkdmLcTEi/angOdkz91jM6FPd/kRe29dMeKHOFTkSbvkWAadg3YjTKpuMC
         ie/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774449380; x=1775054180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGPnYxvq9hnzr2kA9OE2vMDct57Hq1DQLCYAloentrE=;
        b=DN1Jj+fVIrsVY4WH9o36yP+AHQUk6vEWrJ1kzGiRLuyAeWgZLuB8PYmoLe07Nn63my
         EzZLrQoxa8qGcH9arW1Q+2aGT0tLFBmAqPJi7Yq6LDNCwE+nqnZaMPUJaOIZM2TzoRvr
         U27c3550tJrRnMN44dA8+5jF1rA0fjmLCefKhcaBGAbu8SKqa5gGW3xslC9jEf/4HjrJ
         GAFdyWhdKD7XbjWZD+HfDPnx3zuHflqwnkwIIpv8TXFKB7qauntkcfUDcitFYHyDxr7m
         TIvaBH3tIDqg74j7d1KaXAJ1AVhvQIhUN2PuCkBi8ZvDQupYZHDzFFB+fyajLzhCHDN6
         bnqQ==
X-Gm-Message-State: AOJu0YwXGXzyfj9U6Bx7l6UdYD90be1InAZd/hRa3OCHvTOne6FsR171
	VYBouskX9DzwGtt/MNktoBF5l2xtUrtUfOi4ItK+DDEy2oL416ydzNBxFyhy/BsAFaMw2/vw8RC
	ZyoVeJsd8SNN9MXDmfTnf0/s6S7rOqZoODrli
X-Gm-Gg: ATEYQzziI0Z6CX3Onvp6pVXaWMNvNs05dMNtZeFwvDRyOQONmfjD8TLeuYi9zR48aRq
	3dAupAYx+eg1o9O+o4RO0Xwns3f3id5wKcw5ToLRu7nlYm9ib6GrKJ7eoow0+zoo2hBFUsyRpsv
	5gx4dFhnyEEf3VyJHnS7t8JJlrz8yo8ai3eKwZ9Oc9OmXgYNRm25WrJhwHgQyQGNUzRmHI2GEUu
	77NR7e0/BEVQRB6+7dtt1BkrJCqKOFkafROPtH1mM+Wdm2Qc8X61KaqeZqM4BPuYbRHGDa4hWYu
	bw8LkHDd9p/YHAIPlNWrtJ//5RtnwNDk+YCf93yHeDuV5/4QP8Fgm5p1hg60e3f9uqc=
X-Received: by 2002:a05:690e:4251:b0:64c:ec30:9dd8 with SMTP id
 956f58d0204a3-64ed79f0e71mr4491871d50.47.1774449379490; Wed, 25 Mar 2026
 07:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205195742.55530-1-luiz.dentz@gmail.com> <249b111f2618ea16b98201dae672b578d501ec4a.camel@decadent.org.uk>
In-Reply-To: <249b111f2618ea16b98201dae672b578d501ec4a.camel@decadent.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2026 10:36:08 -0400
X-Gm-Features: AaiRm50P69baAwC_Fz4K0rrreH_VlCgA3kJEH07NfbreRGYV93zO_Oj_Q_oKLDg
Message-ID: <CABBYNZLbo-LcFsN-x5LWBuzosg-N9SLt4iyTey0tn9-_Q=4w9g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Wed, Mar 25, 2026 at 8:35=E2=80=AFAM Ben Hutchings <ben@decadent.org.uk>=
 wrote:
>
> On Thu, 2026-02-05 at 14:57 -0500, Luiz Augusto von Dentz wrote:
> [...]
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> [...]
> > +             /* If more than one channel is being configured, the MPS =
field
> > +              * shall be greater than or equal to the current MPS size=
 of
> > +              * each of these channels. If only one channel is being
> > +              * configured, the MPS field may be less than the current=
 MPS
> > +              * of that channel.
> > +              */
> > +             if (chan[i]->remote_mps >=3D mps && i) {
>
> The comment and the actual condition here don't match, so one of them is
> wrong:
>
> 1. This rejects an attempt to set an MPS size equal to the current
> value, but the comment says an equal value is OK.
> 2. This checks whether a second or subsequent channel is being
> configured, but the comment says we should consider the number of
> channels being configured, which would mean num_scid > 1 rather than
> i !=3D 0.

Right, nice catch. Do you want to spin a patch fixing this?

> Ben.
>
> > +                     BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
> > +                            chan[i]->remote_mps, mps);
> > +                     result =3D L2CAP_RECONF_INVALID_MPS;
> > +                     goto respond;
> > +             }
> > +     }
> > +
> > +     /* Commit the new MTU and MPS values after checking they are vali=
d */
> > +     for (i =3D 0; i < num_scid; i++) {
> > +             chan[i]->omtu =3D mtu;
> > +             chan[i]->remote_mps =3D mps;
> >       }
> >
> >  respond:
>
> --
> Ben Hutchings
> Theory and practice are closer in theory than in practice - John Levine



--=20
Luiz Augusto von Dentz
