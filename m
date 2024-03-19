Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAB25777
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868362; cv=none; b=A2Rc0De2g6aHHMClgZ5L50YErxil070/+i0nSwGiqXO8ov4UNnXR+XRjYviRQFsoaL+0YOi20azDGV0LHayMgDpZ8aoI/yiVQcx1l7EUBcHvrvUSArZIMFegYYPD97CO0g5biCitguxnID2QLsgay8Ps4JWFqRqnwCY1vhQHgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868362; c=relaxed/simple;
	bh=jL9kHyMM7c3nVEZ31ALav/nIxEz+OLnT9X61bJOp+Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awGS13j3xINMw6UJiV4ObkZY9qC1az8P8QnXyBevKv9hRcovJxxZzRC7HEmjP6Gc6TOcvol2jVi+vyNqHOll8pCmC8N/KPQbb+nJcn84kuqqWNsYu2AOjlqUTjvS6B1sLK/MZ5liXsKMHAHKdBI4TVi1Se8/xnymZgJ+4sf4HN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UtM4NlH4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtM4NlH4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430c4b1a439so18818011cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710868360; x=1711473160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=UtM4NlH40tDB0MGfKn8aj3+PnB8U0z5b5fFD+nLmtflhi9F8f9lD9mIra2GyQGvgye
         +mg66pAhTsCnDgWSm4FmHpwixoWZs0D8KHFc+MEcW5LdZfFTKNOG7JUnNxHcDQGQOYvz
         mzxh2FFx8UnPQOGD5K2AG/McvTLbCozc6jmR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868360; x=1711473160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=sc5BdTA51jCVO78FmXfTQgbk3QeZ9wsv3gfjHzrVEhjFT1QEjJchnG7HFHZzi4+mrG
         Nra25FBIp6d0JKLRZdYlFTorUAZTB5oe6pSmoyq9+mGnsDufyIZKCEpSrWO5sqKWYJdb
         vtowX6Oyi19lbshSKXBzsq4bshRGtwVvXa3axa19JfWTJCsAXecVNkfOcQXzXG/iQ5Rn
         HHB4X60OrdyNeAk5DBvkZHTdvAQP5fTv3F/p6ii5WQ46ywh+FPNihx65pZ7mmahnVIsw
         Xav8efC0/Yz9MzwaIwsXWXHTPsdnTova2RfLPlWaDKYm+NsYQtw0O9+kVK7iMhUZeJmA
         D0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz7zj5/wJ3VGd6LnfRAaiBeHYvb/f1A7TD4x8fZV6EU8mO5EbIABaJONCyMEP4v7lenF/naDTvaNdAtihAp8YMhN+maPlvPqRyLl1D2nnV
X-Gm-Message-State: AOJu0YxJNQaZO57k5SHk6CemE6kOo6XXjbFyyZRBNOrP7gNwA7KsEdN8
	CmaXqZApJc8x0xJiTvMdw2XTFyJCwr0Fjx0W+kbdidbkTN8ybUhn5QIh9zdwCeQc4+7CMqf8MJc
	=
X-Google-Smtp-Source: AGHT+IF+n71aSmUnBYPpQDDDp7U7TxMvbF6rqJYkouCPswEi2KgJickiALD7MxOUIDH2VfDub/h+BA==
X-Received: by 2002:a05:622a:1047:b0:430:fa9a:de16 with SMTP id f7-20020a05622a104700b00430fa9ade16mr177065qte.4.1710868359883;
        Tue, 19 Mar 2024 10:12:39 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id fg14-20020a05622a580e00b00430bddc75a5sm3995518qtb.23.2024.03.19.10.12.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:12:39 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ee0c326e8so17391cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 10:12:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ60Ush+e0CUH8Z/KzMRLyKkMSSULguD0CA59ccLPatLeWx/vBg58jyyYulls1z/BD41HovNXUjxgm+Bdgk5D9Td+wWp7ejdQdDKbQPQJs
X-Received: by 2002:ac8:590c:0:b0:430:b7d0:59d4 with SMTP id
 12-20020ac8590c000000b00430b7d059d4mr1682qty.19.1710868359392; Tue, 19 Mar
 2024 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
In-Reply-To: <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:12:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 9:38=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
> > >
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetoot=
h
> > > device address in big-endian order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.
> > >
> > > Presumably, this is the case for all non-ROME devices which all use t=
he
> > > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices wh=
ich
> > > use a different command and expect the address in little-endian order=
).
> > >
> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > >
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passin=
g
> > > the address via devicetree in big-endian order.
> > >
> > > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device ad=
dress")
> > > Cc: stable@vger.kernel.org      # 5.1
> > > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/bluetooth/btqca.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Personally, I'd prefer it if you didn't break bisectability with your
> > series. As it is, if someone applies just the first 3 patches they'll
> > end up with broken Bluetooth.
>
> It doesn't break the build, but yes, the device address would be
> reversed for Trogdor machines for two commits and possible break any
> previous pairings. That's hardly something to worry about.
>
> So I consider this to be acceptable for sake of clarity, and especially
> since these patches will be coming in from separate trees anyway.

I guess I have a different opinion on the matter. I often end up
cherry-picking stuff to older branches and I generally assume that
it's relatively safe to pick the beginning of a series without picking
later patches because I assume everyone has a goal of bisectability.
This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
patch into two patches doesn't help enough with clarity to justify.


> > IMO the order should be:
> > 1. Binding (currently patch #1)
> > 2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
> > 3. Bluetooth subsystem patch handling the quirk (currently patch #2)
> > 4. Qualcomm change to fix the endianness and handle the quirk squashed
> > into 1 patch (currently patch #3 + #4)
> >
> > ..and the patch that changes the Qualcomm driver should make it
> > obvious that it depends on the trogdor DT patch in the change
> > description.
> >
> > With patches #3 and #4 combined, feel free to add my Reviewed-by tag
> > as both patches look fine to me.
>
> I don't think it's worth spending more time and effort on this issue
> (which should have been caught and fixed years ago) for this.

Sure, that's your opinion and if the BT folks agree with you then they
are free to land the patches without my Reviewed-by on them. ;-) Mine
is not a strong Nak but I feel strongly enough that I'd prefer not to
have my Reviewed-by added without the re-organization.

-Doug
