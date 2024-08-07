Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078723CE;
	Wed,  7 Aug 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043006; cv=none; b=IPH4iFQcOiQ9SqHhFsLxPsdfTM0e6Sq5PcEbHQimaQV0b3L+tP1KG5i6Hgkxm37cCSd+Xk3FyutZcqrxp8By5sRdPNc2JBkznySTGlgPlyOA2QoN+HfwMNdiIdrfK8hcBX+ben8Hn6kdwSbahVg+jtKd3B1p2tWgkZvQ3IVuW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043006; c=relaxed/simple;
	bh=nRMrw4V9Pr41+Lv5ihVF8n+cyXHutqNgOrphUFs46B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzYEqTC7Ctmk90OekPm1TskR7eGboZ6jngEswcuDoxmLsN7fiwZ024BGHIWqeAQTNwp5tnDxTfJoVWXvM8RhvGMn3fxuoFRv2QZF64UYNzwVnH7wle5VzWHfBwthXAO2JUZyNQVE3h1V2HfYuS8OozHOKCv27kb+O8dGVWwPP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceitQJsN; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceitQJsN"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f149845d81so23509611fa.0;
        Wed, 07 Aug 2024 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723043003; x=1723647803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRMrw4V9Pr41+Lv5ihVF8n+cyXHutqNgOrphUFs46B8=;
        b=ceitQJsNoEVsRSGNmaWvfIV3Dic7UF7N2uzAVz88/s5o2vBEcRU1/c0MVrlwoPpnwJ
         FjVIFVFL0eX0NhL6dgqMlnCYbHAHcHojZ1X+7q9nPwmLQuDw9Z7y/hjT5TS0qEurnKC0
         BayQFA21XMOlPG7HKjfHLn1+rk3Ll5BYNkS7bDEdkX7Sbx3DDNgxYGdbL38lsh8Ucy4W
         w0yikD5UbiqAnlTIoPY4MQArNmXFqVyIa5z54HRcLAlnEMw+RWk8F/JgQz6tS2oype6/
         tlVwv/T76XIDtYn0lIvekYpqEm8W+L9W3e638+0LRAP5aP0dqz4iaB4WwpBwxjk0xdtD
         jvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043003; x=1723647803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRMrw4V9Pr41+Lv5ihVF8n+cyXHutqNgOrphUFs46B8=;
        b=nT82RclxLF0iAv/KsUsUcWPrsCN2cZaGYeMhRDIL9SAi1PcIBCWvzhu6QvUsJFVIup
         nGPsLAwImqrkIfEed44qWo/BvSVAEKeqx/S9IE93GtiSg7Qs4rLV6sNkhcSqTR05mZzP
         wUyDJT34LxSkN+mCqUYGmjJ6ZGYAFf1q4pMHftbrW8NC5ItzYb6BDuj8ugJqLy0OpIVv
         hx59wYt6gJiypiuCk3apMBvoPu4KKF+JWKwUetrIw/a9DuC4IxiaMMAMS0PNnaLIEyQZ
         dn0Doc0k0aWz5ySaqxmkNLohyZ8w95Oi/XxyHUegAm5I/zY7jPmbzwn+wiDTlSrgYxph
         I6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY/A4nRuYiWHAlyCrLvDctDWJGXbKKUwsGz4mVTekGHRo48w+i+AkFrCKs/qFw1xHSDBiPqrbHjQX9ETbDNRyWJiYnXle+PwqFXf835M4OA4uboaCk9XdU7C1dgJatZ6MY+gGVnFbGzMo6Ta9l
X-Gm-Message-State: AOJu0Yzuez0qyP33qp77ZOR7SdJWYJ21CvCvIP8NWiGx4gBmDFv2Ql/s
	8jAACA2TzDZ/rZBpmy60dwmjHLVqWEWQIj1HrQC2vswvsxwBalvlp+pwwmBIVX2MY/++2C3UAOE
	3d13MWAUxH8aeFl30YSV4igtfWrA=
X-Google-Smtp-Source: AGHT+IFHVvEQ0ERmGM9Z9oiubHndmesWcONaitsAYkyBKiSKbwUzIkD4KlYucskdiUerAijqBlVinTDKhFuBgTdgOcc=
X-Received: by 2002:a2e:2c11:0:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2f15aa84ec7mr114696851fa.10.1723043002139; Wed, 07 Aug 2024
 08:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org> <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
 <CAMRc=MdSH6n=QKwWnT9zNaBito34t+BpCufQDjnAOaeC5iuD+Q@mail.gmail.com>
In-Reply-To: <CAMRc=MdSH6n=QKwWnT9zNaBito34t+BpCufQDjnAOaeC5iuD+Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Aug 2024 11:03:09 -0400
Message-ID: <CABBYNZ+1XpSDvt41zEYYQ4AraCucOM7FDSVhhkGNsCgr9-hc6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Wren Turkal <wt@penguintechs.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz, Nicolas,

On Wed, Aug 7, 2024 at 3:53=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Wed, Aug 7, 2024 at 12:44=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 05:20:50PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Unlike qca_regulator_init(), qca_power_shutdown() may be called for
> > > QCA_ROME which does not have qcadev->bt_power assigned. Add a
> > > NULL-pointer check before dereferencing the struct qca_power pointer.
> > >
> > > Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the defau=
lt if available")
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfz=
bvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Hi,
> >
> > I just noticed we're still hitting this issue in mainline (saw it on th=
e
> > mt8183-juniper platform in KernelCI). I see this commit was merged 6 da=
ys ago to
> > bluetooth-next, but it seems there wasn't a pull request with this fix =
yet to
> > include it in 6.11. I'm wondering if it's still going to be sent.
> >
> > Thanks,
> > N=C3=ADcolas
>
> The patches are in next so I don't see why they wouldn't be sent upstream=
.
>
> Moving Luiz and Marcel to To: to make sure they see this message.

I was on a business trip last week, will prepare the pull request later tod=
ay.

--=20
Luiz Augusto von Dentz
