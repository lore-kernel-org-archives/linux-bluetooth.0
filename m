Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC61BF2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869637; cv=none; b=OBAbkgXb77GzUH37XAvZqJzHHMhZktRaBcTF8uwO2YqI/vRxuWsxu3/p6umalFqjdulzAoLUJmbEe7PUVOFv+AMumnZiB5YNFTz4UeQrnSOOYm8jPg/2bXRwtyfR64VYUv4zOOcyubpx/l7FbFguhvLulrjNFf9WAjbnHlBtTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869637; c=relaxed/simple;
	bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ila02+a1PRhqdXUrBizjPTekEC41JFLzMRKaodZRm1gBBB/0Hjk+MQm9zusLpSUXaDDQ7TvYRhw8supFsN6jYtHPX4h6S45ZrOag8OETVsZ5eRDOqUKGRbLopaiy0eSsIMt4k1zT/pv/LNmLEsYwjaarBBZ0A366InsEwoMOxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ATTPn10o; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATTPn10o"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690c1747c3cso1018036d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710869634; x=1711474434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=ATTPn10oFMffKo8COwMCkwI4iSVvIiFJ6nFwhIaYRC8Y3oyioRBmPl+MYGsSsaYqBd
         aa9CZ1JKnaiZjVNN+yAxAge66H19Ww+dmreI84LTi27sFyBpdNcw99y1rid9Iu/KdnD2
         LXov1Shr0evoKK6m66BIaTGXCI64HZS34UZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869634; x=1711474434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=nkGOIEnr7qEi5atnEgVczY5y1WWhCJs1VFG+4RTLhhGkH4tLuGW2lg0osseL2RFDPS
         fy6heNwXnEWrBcQteSeBkmD/813eBOMaeKS/JT6uN7zo+XFq4dKq+/tg52AT23jO6/zE
         do99j5txSBDT3PznRohfqnwlbBqD2mfr1871CLSb22Nny9v+A9zMGipaOLvthNTX7STJ
         kITMwgAwKfCm/aF34C+me9yfOV8aW+SwIvckqbslmTjI3TzyqPHO9nwPPEozBwwX8/7M
         xql4wlgvRcTXmBTHU8/dt8gemnVbgUg3BoOFXM7+yDvI6jP7iETmjQ3sgPfD7fqAbrR1
         ZGoA==
X-Forwarded-Encrypted: i=1; AJvYcCUIHpYVYouxKUXEBjKrhz2eTlL/O6efTRszOWpBftQW5hroXX8s/6WPU5qndXC1plFAjyvqG22N6TXnty07M70ItbVMqwRZ4QhszyQ+fkvN
X-Gm-Message-State: AOJu0YxrfkqXNKKxFO8v/B3moEYlVHyjiYxSkRJp03arsc5qcrN9lFzN
	OxtuEP4zSj2z4qZEil3r1ZdwrO4VrhMV0xGp2AVR2vpt/yULyBZYjqA6U9sGRmugnDvz8Elc9JI
	=
X-Google-Smtp-Source: AGHT+IEucvY9SU89P46xZ4Z1TQ7GOm7HOI8TFtlCIqhMpQbKzlnEluZAdJ9Q69ZSUmY3V+jgaLPmcQ==
X-Received: by 2002:a05:6214:19e1:b0:690:ae7b:ccdc with SMTP id q1-20020a05621419e100b00690ae7bccdcmr5271687qvc.25.1710869634491;
        Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id gw15-20020a0562140f0f00b00690c14810c2sm6714765qvb.126.2024.03.19.10.33.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430e1e06e75so37301cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuUv2l/cXj4WNrPtzyZmKd3nNB/rxupIR9oLSYtAIvldOJv4MkWiYFKhzI32ULsgVMYCVEE23RM7eq+Amq+wvWeecKGgOaqiQqZ1bWQx2N
X-Received: by 2002:a05:622a:2293:b0:430:d723:aa66 with SMTP id
 ay19-20020a05622a229300b00430d723aa66mr20279qtb.16.1710869633686; Tue, 19 Mar
 2024 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com> <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
 <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
In-Reply-To: <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:33:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 10:28=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > I guess I have a different opinion on the matter. I often end up
> > cherry-picking stuff to older branches and I generally assume that
> > it's relatively safe to pick the beginning of a series without picking
> > later patches because I assume everyone has a goal of bisectability.
> > This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
> > patch into two patches doesn't help enough with clarity to justify.
>
> I did that in v2 because then the two patches had to be split to
> facilitate backporting as wcn3991 support was added later.
>
> But the big issue here is taking the patches through different trees. If
> Bjorn could ack the DT patch so that everything goes through the
> Bluetooth tree, then I guess I can reorder the DT patch and squash the
> two driver patches.
>
> But waiting several weeks just to make sure that the DT patch hits
> mainline (and the binding patch before that?) before the driver fixes
> can go in just does not seem worth it to me.

Personally, I don't care quite as much about them going through the
same tree. It'd be nice, but I agree with you that it's probably not
worth the hassle (though I wouldn't object if Bjorn wanted to Ack the
dts) and it's fine with me if the patches "meet up" in mainline. In my
case, though, I could imagine following the "Link" tag in the patches
and arriving at the mailing list post. That's where I'd go back and
look to see the order which I should apply the patches safely. ...and
I'd prefer that it shows an order that lets things apply safely.

-Doug
