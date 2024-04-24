Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F615B98B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966735; cv=none; b=cZCaU7J6Z0RV/BlUpfG7O8x6QAUzYrCnzAWFxvqVpIDI5YkBC0cWZ+hOnWZm+raZwdPEoNadkIssM/bCxxEh4EYdyV5yXwlC+8SNTdH1z1hYvRfraLky1zO7krHdVtlzuAcvfmXOzgCFOrh4/n35Eq0gq46dAMzIeFtuu4hGppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966735; c=relaxed/simple;
	bh=VdzoU7XoFrllSZVKXg5eoQOzir2X+S3Z7WiLGU4rHC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHkTljq37dvBgqPoT/ac3fzgvwLQHwT2kCYUUjAk2RilWYVDUgs3cX06Xx8r3omdXkC2G3putoZUNuew7SfP9Egym3R6eNmZSPhtolDUrgwfU4SDBMIO842GlATy3WA8+7c0IEy9wvY9YIgA25KTF8QnV5AC5XaxbI2D3ETAEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdB73Poo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdB73Poo"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de56d4bb72bso886009276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713966731; x=1714571531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzADXOfIhmd+aXHGQmNMC68KitnsoHs9qk0EvLy4dSo=;
        b=wdB73Poo/o+FbKD65XiDBGYdR5AjcKZ61TBiIodMdhuZpsnVxEdNJ7Dtxdk0k9+L2S
         QW4Spntwd0HZSA73Zra2rzNJiNcMB4aJ1wvB2nftSa9ns/Zt8HpOctg+Lpo5RPUA11Ts
         ySPWiMDUwECDu89XLHps7J/seul7wg4vXmF4eQOAWyTMHwcmsWnrsXnfXYXBJGOynEP+
         Yan+pEfRMFH1XUNhVjMyWC0w74ewfp7V+GE3fkfxQVp1mgq4YGQN4CW6xOVBHabBliPT
         3wqStpUzhB9OjJAFBOBcYHBviXWk36aKGdSKtBle+dj+Al+eboHMzhFhYQ/j1PYSZfvu
         B1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966731; x=1714571531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzADXOfIhmd+aXHGQmNMC68KitnsoHs9qk0EvLy4dSo=;
        b=LfawofnpCpjK2y3fzL2SHJ90jrs8z8DaKcYvkKQhW2+f9cwBF4Yeaj2US8M5EJo0sS
         yJsv6TkXa+n5ZyqK+zHxVksc/f+U9yJ+0Gn8qsZv2lOnLNVLTy9+5MLovBP0H5oRPOkr
         nodaO+SpoGn18tQNujIOvoFYw26uKiGBAUt4ReFz4StD9K38vdIeQz+5egXv3b+xz2rB
         zroPH1HPS8vjv1uXRWFlH71AVLSTDeqBS6rMEPvCwAH6rWuF9szDT+gAdX5Vlvp6geTu
         zt+aBMqrrmDOVLK8XScCSjquJzjUEGrOSqNr6gNajqX3wA7aeAOSsHfSFdRvzhnV0kNI
         jllw==
X-Forwarded-Encrypted: i=1; AJvYcCXjl1tFMmlMnaG/g7w1FidKsxejL0LnOB0+CNa9hgpAx8jqzucr3mZUjq7CXGfIJsD2iA87RKYRiCTtOvHWEVcz1qtX0sf9VdceEEsqOJRd
X-Gm-Message-State: AOJu0YyFcKV1ZzrMOJ6/c5mbX5NAS3oeYrCQF+WBApj3n5BqJwb+ZxDH
	n0fjmmLQkbWNArwRlcs4YO1zF4PbG//durkbIPT5eIVFCvZas+mVIHCiQdS+jMfBAd2riauAbP0
	z+Xrh6xqAZvjKCkxoRD95asWFNuAxa1J/IKKRhQ==
X-Google-Smtp-Source: AGHT+IGJLVldlCF5ArUWeqphR5eku+39uqREoBlWKHhqFaMPw9N8KGWMdE1PsgT0a73JlFV5wLUN/qCb3QDqUr6Y6Gk=
X-Received: by 2002:a25:7903:0:b0:de5:5037:8861 with SMTP id
 u3-20020a257903000000b00de550378861mr2656924ybc.48.1713966731284; Wed, 24 Apr
 2024 06:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org> <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org> <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org> <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
In-Reply-To: <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 15:52:00 +0200
Message-ID: <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, quic_zijuhu <quic_zijuhu@quicinc.com>, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev, 
	kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 15:49, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Wren,
>
> On Wed, Apr 24, 2024 at 1:04=E2=80=AFAM Wren Turkal <wt@penguintechs.org>=
 wrote:
> >
> > On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
> > > On 24/04/2024 06:18, quic_zijuhu wrote:
> > >> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
> > >>> On 24/04/2024 06:07, quic_zijuhu wrote:
> > >>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
> > >>>>> On 24/04/2024 02:46, Zijun Hu wrote:
> > >>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NU=
LL()
> > >>>>>> with gpiod_get_optional()") will cause below serious regression =
issue:
> > >>>>>>
> > >>>>>> BT can't be enabled any more after below steps:
> > >>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
> > >>>>>> if property enable-gpios is not configured within DT|ACPI for QC=
A6390.
> > >>>>>>
> > >>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic fo=
r this
> > >>>>>> case as shown by its below code applet and causes this serious i=
ssue.
> > >>>>>> qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable"=
,
> > >>>>>>                                                 GPIOD_OUT_LOW);
> > >>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> > >>>>>> + if (IS_ERR(qcadev->bt_en)) {
> > >>>>>>          dev_warn(&serdev->dev, "failed to acquire enable gpio\n=
");
> > >>>>>>  power_ctrl_enabled =3D false;
> > >>>>>>    }
> > >>>>>>
> > >>>>>> Fixed by reverting the mentioned commit for QCA6390.
> > >>>>>>
> > >>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NU=
LL() with gpiod_get_optional()")
> > >>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
> > >>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> > >>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc=
-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> > >>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > >>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
> > >>>>>
> > >>>>> No, Bartosz' patch should go.
> > >>>>>
> > >>>> what is Bartosz' patch.
> > >>>
> > >>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
> > >>> mailing lists do you receive that you lost track of them?
> > >>>
> > >> Bartosz' patch have basic serious mistook and logic error and have n=
o
> > >> any help for QCA6390, and it is not suitable regarding DTS usage.
> > >
> > > Really? Why you did not respond with comments then? Considering how
> > > imprecise and vague you are in describing real issues, I have doubts =
in
> > > your judgment here as well.
> >
> > Please slow down here. Zijun's patch works and Bartosz's patch does not=
.
> > I don't think Zijun means any ill intent. I am replying to Bartosz's
> > patch right now.
>
> Ok, that is great feedback, so I might be picking up the Zijun v7 set
> if we don't find any major problems with it.
>

Luiz,

Please consider my alternative[1] also tested by Wren. Zijun's usage
of GPIO API is wrong.

Bart

[1] https://lore.kernel.org/linux-bluetooth/CAMRc=3DMfJ1v3pAB+Wvu1ahJAUvDfk=
3OsN5nieA-EYgTXPwMzqyg@mail.gmail.com/T/#mbf94795476d21df0a24441470ce02def9=
d2970a7
