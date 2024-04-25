Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87F14B08C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058594; cv=none; b=n7HZzTLZ89mgfc9cO6gWh15wdi3MM79BRDScJOTIzSS8jx1j8aq/FzYqoRII+YmO9zfxlQV8Wf9iOXkvZOObZujWkCZNZ45T2VA5F3MLJbjY7lnGs9FAIg5F4AYA1C3xG+O4B53aE99GOYkguWBct3SjxCVJ9JRLkN6M0MwFXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058594; c=relaxed/simple;
	bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJyaml1ni2Eq32kpygKo0sSca9cGGGzVee7mSixfvAvGIBmHr+A60wqIBCEF+ISoZRBxm/ue10mMKqGf3erG9Ha6ny/35lEdK8XMxXtT0iyzQoWP3/kHQseuspwiEeq2tnWHQM+aNDzSiMkzdlZr9ytDVep2ZKPxP9uNfvSiqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUue0AZn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUue0AZn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43a317135a5so9244551cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714058589; x=1714663389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=mUue0AZnE5ty6DERUkqssfyVsxShep+2qc0Pd6+0HUBtR1cBgRvCNiD9HBCOxrEVnq
         9e5vaC8oLgprfoc+0HgVrJ8Ul7OvVLC288jUPlV5MAzrQjdFqZSfZz0birXYRC62Pe3k
         +aJXOSNuZ8J7HEryfBSyVcLmEvBEAVRNDcLXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058589; x=1714663389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=EYBiZNyPjigxOVOS9Bcx8Wdmlwo2+r0M6q3uNcrGTZr56/1J5vxgGCzYw07Tmr7nmc
         uA5lhr0KqCl02vmO/BmfAzxpM9eqQF0/zgi7rMWYnQOoXkS1jwBQDPUevs/073ptYdBO
         IAghWRUsXrvhHgygNfVJEndwK+JLbdli5UNzdR4tp6YUT9IFNyNDeckOlTNmkKTCIM6m
         VsFNb3CWRZKztEkhR72Cx9tnN73N2KUYBFT58SewMrdtKjbtvZX7XLOcjqNOwXs7T2En
         VSszG571lGha9BmHxBGHh7xt3ALj1FDbjbTPL+8bhu3q+1zHs3y0HsJVURNAouksRPn/
         f7sw==
X-Forwarded-Encrypted: i=1; AJvYcCU8oo8LxUGsCKfaDhenjok/0aYZZhDOxNmTDsH0VGfjW8SOQItXVfFGooauzCwHl0DWUe5Tp0KJO29BKC5ytRDfoByAlhfzBWNCuNm18zMD
X-Gm-Message-State: AOJu0YwPTbvFD5Ne0fTMlZsdLkLQN7pGhZzz0SfOJ+aI01hsGCvHoSim
	9zp46puKVbOk6sqsDfwNk/PIAP89GLJP9hIivPlnAIOaKZHuBrVXJIAs7k0zFHHqougvHddSFh4
	=
X-Google-Smtp-Source: AGHT+IHdFOLfNqgLda/4EHgtNqFFZOaLh+9nzAkeeRJuRpLtP6015IFEGF06jAmRiBbh86obI8E3Jg==
X-Received: by 2002:ac8:7d89:0:b0:439:ec1e:327d with SMTP id c9-20020ac87d89000000b00439ec1e327dmr90016qtd.10.1714058589079;
        Thu, 25 Apr 2024 08:23:09 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id ke15-20020a05622a288f00b00434f50f5d82sm7075115qtb.14.2024.04.25.08.23.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:23:08 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-436ed871225so320701cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 08:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcXN+4ZB2hAdvDRUW+I1yt2JdvLIfUQqvvBHC1kpqS60uZc5FWmk1qhiYXFsjO57mxratwpwurWspU3ErvBVZHgFPtZo2FYEv+4b7sGiu/
X-Received: by 2002:a05:622a:5097:b0:43a:381f:6b11 with SMTP id
 fp23-20020a05622a509700b0043a381f6b11mr264680qtb.19.1714058587159; Thu, 25
 Apr 2024 08:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
In-Reply-To: <ZioW9IDT7B4sas4l@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 23:22:50 +0800
X-Gmail-Original-Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 4:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> > > I assume all Trogdor boards use the same controller, WCN3991 IIUC, bu=
t
> > > if you're worried about there being devices out there using a differe=
nt
> > > address we could possibly also use the new
> > > "qcom,local-bd-address-broken" DT property as an indicator to set the
> > > bdaddr quirk.
> >
> > They all should use the same controller, but I'm just worried because
> > I don't personally know anything about how this address gets
> > programmed nor if there is any guarantee from Qualcomm that it'll be
> > consistent. There are a whole pile of boards in the field, so unless
> > we have some certainty that they all have the same address it feels
> > risky.
>
> Hopefully Janaki and Qualcomm will provide some answers soon.
>
> And otherwise we have another fall back in that we can use the
> "qcom,local-bd-address-broken" property for Trogdor.

Quick question. I haven't spent lots of time digging into the
Bluetooth subsystem, but it seems like if the device tree property is
there it should take precedence anyway, shouldn't it? In other words:
if we think there is built-in storage for the MAC address but we also
see a device tree property then we need to decide which of the two we
are going to use. Are there any instances where there's a bogus DT
property and we want the built-in storage to override it?

-Doug
