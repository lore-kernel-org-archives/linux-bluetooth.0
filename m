Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03216C86F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972726; cv=none; b=leQSo1V6kzUzAg+uzT7hGX/zzHcf9VGlLyE3DxtsVwxFyrunOcrCRA2DYlobWLP2KYlK8yuSc4h7L7gDwTeQVgrMOMEj90pau9xxF4BfccJAqtQHC3C6Q4WSQA3hD8M//dG1Nw2vLOhPfwmFCaY7oA9VKh1G8/JYsriuRK5NGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972726; c=relaxed/simple;
	bh=NnQoCXBLj0bhOfPX+zxQdzkBqr1tX55NskR0NFv3mGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRt/UpctxmUA9A2KHms9grLXMXeWoBm3y/uazM1KCH6MmjvQmFQXp/cWGVe3KDeaSrpQvcKuTutrVlbTWFGdDPx/9yJvy0/yma+JEV4i3+LZP9rMZUBz+cNthzlA0hUPF1A4p9WZ1GqljFpVZ1mwAzhCX8r9Ixf79f5xZtDdVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svm6e63t; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svm6e63t"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so92495061fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713972722; x=1714577522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnQoCXBLj0bhOfPX+zxQdzkBqr1tX55NskR0NFv3mGU=;
        b=Svm6e63tvZ66X0a6uXGA+qqNFXN1ZoK7iyMMNnlD48fI9mRJoql1TzczVZZ1Plg86f
         1qmbHnQeDCV99Pvbkjc3vIP2sIxlcklEssAMLuwpYXIVSKmM4DCjCiWnOs1E5ZwwveLQ
         6cD2jHqRclwhOH0KUu/CTtl4JowDwNmggTgijVh4dM6HZQM1459OtJVplyi2KZbANiSQ
         NZRruVqO+NLDL5o9+TQa0hjW83qBhPq+O83V9ehisj9yjCROMXySF2bv/p3yUmhqteZ3
         nzYDpcbOa1kv9XpWVOc3ra2xuqYJUApMStIWd2KziSr8Vrwgd+zCpyARZv7p7eO/APhQ
         b/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972722; x=1714577522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnQoCXBLj0bhOfPX+zxQdzkBqr1tX55NskR0NFv3mGU=;
        b=OSb/KQvXBeLf3qDfncQ5cTrGP+5WSti4F3KkGrO96KCWOTcMM0+GwcIT3/KFqxYfS8
         ayvrTSmpfhJWUm59ijo1JKx1DLLqld/FWCqsBecgFgxhn+cw799q4F2T/jNGdAngZ1nY
         uuHDV9GeqyHOvXvX5Yu9dDCFwY1TaJxP5+aPiDwyVaybx0Hb/YdSnVyCE5FIZVyU9rOK
         GcKoNt3pd5CkYHJO/3S02UHktWrIqOIULXvZJon1XnqAliXIlDs0JRt8EIETdUks8TrZ
         fN8s+pkpjWXuVc25L/H9FMX/ZicTfbwS+nFnqp7FSUdplqyzYpNImSSFn06U6gfGBmK+
         oe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCGKL7hkpsV4J6AVYjAPfL+LiKLrjVA61VPvDzF5DP2r002Jzitltso3buz86Q5GibuAkEXF4gpAAzHpD3vt4XG51T40lvuI3lfnvWP0xK
X-Gm-Message-State: AOJu0YyNniBIEj5ibeC6FbD5yUcGbgPVkcSHuoEO+BNXmzJj2Ptx3XYo
	+7s/xkG/8sC77QxxHlzqLhKyOdX+xSVcbOtui38n4Cwvbm2/1tr5qwnVS2L5WYgD8576IcsXOHg
	roVOmBWUQ/CbyN0gc7/CeXP1oYkaOqg==
X-Google-Smtp-Source: AGHT+IHnwHHW5tVswXPkLGEh1/BOU677aQMerwTFfgHTg/f/3mQeQ24592IXgVRWCuQ9qGvGFnpAjB5dwpByYoANZa8=
X-Received: by 2002:a05:651c:1043:b0:2d4:54f2:c409 with SMTP id
 x3-20020a05651c104300b002d454f2c409mr1806901ljm.38.1713972721626; Wed, 24 Apr
 2024 08:32:01 -0700 (PDT)
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
 <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com>
 <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com> <CACMJSev8=gBCw9o-ur87fMMj9K=ZWY-ECzxZjyvERYQ8P=VS7A@mail.gmail.com>
 <CABBYNZ+PvZb6azHoXAbO2czqK2zQnZ1ddcKRb_YX-zGSVfy+KQ@mail.gmail.com>
 <CACMJSeue3kM-G1UvO0REEAJbhU9vOqbeEzy0Qny5udKLB97e8g@mail.gmail.com>
 <2805ad96-6383-45b3-9b68-66578461bb5f@quicinc.com> <CACMJSeuyumcmkO8pYiWk6Gccd7njpke23NdboYrxNZxHx6XjAQ@mail.gmail.com>
 <34091f3a-9711-445d-a369-540bcfc49b29@quicinc.com>
In-Reply-To: <34091f3a-9711-445d-a369-540bcfc49b29@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 11:31:48 -0400
Message-ID: <CABBYNZJ9tex_1E=PW8zwiNyq-nJgms5nHXwvinLRd2XDc_U7Xw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	regressions@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quic_zijuhu,

On Wed, Apr 24, 2024 at 10:46=E2=80=AFAM quic_zijuhu <quic_zijuhu@quicinc.c=
om> wrote:
>
> On 4/24/2024 10:41 PM, Bartosz Golaszewski wrote:
> > On Wed, 24 Apr 2024 at 16:25, quic_zijuhu <quic_zijuhu@quicinc.com> wro=
te:
> >>
> >> On 4/24/2024 10:19 PM, Bartosz Golaszewski wrote:
> >>> On Wed, 24 Apr 2024 at 16:08, Luiz Augusto von Dentz
> >>> <luiz.dentz@gmail.com> wrote:
> >>>>
> >>>> Hi Bartosz,
> >>>>
> >>>> On Wed, Apr 24, 2024 at 10:00=E2=80=AFAM Bartosz Golaszewski
> >>>> <bartosz.golaszewski@linaro.org> wrote:
> >>>>>
> >>>>> On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com>=
 wrote:
> >>>>>>
> >>>>>>>>>
> >>>>>>>>> Please slow down here. Zijun's patch works and Bartosz's patch =
does not.
> >>>>>>>>> I don't think Zijun means any ill intent. I am replying to Bart=
osz's
> >>>>>>>>> patch right now.
> >>>>>>>>
> >>>>>>>> Ok, that is great feedback, so I might be picking up the Zijun v=
7 set
> >>>>>>>> if we don't find any major problems with it.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Luiz,
> >>>>>>>
> >>>>>>> Please consider my alternative[1] also tested by Wren. Zijun's us=
age
> >>>>>>> of GPIO API is wrong.
> >>>>>>>
> >>>>>> why is it wrong ?
> >>>>>>
> >>>>>
> >>>>> I have already told you that at least three times. But whatever, le=
t
> >>>>> me repeat again: gpiod_get_optional() returns NULL if the given GPI=
O
> >>>>> is not assigned to the device in question OR a pointer to a valid G=
PIO
> >>>>> descriptor. Anything else returned by it is an error and the driver
> >>>>> must abort probe().
> >>>>
> >>>> Ok, but there are other fixes on top of it:
> >>>>
> >>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-1961=
9-3-git-send-email-quic_zijuhu@quicinc.com/
> >>>>
> >>>> I guess that could go in but it would really help if you guys could
> >>>> work together so we don't have more competing solutions.
> >>>>
> >>>
> >>> These threads with their 7 patch versions from Zijun within 2 days or
> >>> so have become very chaotic. Let me summarize: there are two
> >>> regressions: one caused by my commit 6845667146a2 ("Bluetooth:
> >>> hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe") and a
> >>> second caused by Krzysztof's commit 272970be3dab ("Bluetooth: hci_qca=
:
> >>> Fix driver shutdown on closed serdev"). The patch I linked here is ho=
w
> >>> I propose to fix my regression only. These fixes don't seem to
> >>> conflict with one another.
> >>>
> >> it is not conflict issue, from my perspective, you fix are wrong.
> >> do you see my patch change log?
> >>
> >>> We (Krzysztof and I) have provided feedback to Zijun but he refused t=
o
> >>> address it and instead kept on resending his patches every couple
> >>> hours. Zijun's patch 1/2 proposed to revert my commit 6845667146a2. I
> >>> disagreed and proposed a way forward by fixing the regression. This
> >>> fix was incorrect as pointed out by Wren, so I submitted v2 which
> >>> works.
> >>>
> >> v2 is not right from my point as i commented with your solution.
> >>
> >> you don't answer my questions commented within your solution.
> >>
> >> what is your question i don't answer?
> >>
> >>> Bartosz
> >>
> >
> > Luiz,
> >
> > This is an example of how Zijun will borrow any attempt at meaningful
> > communication under a heap of incomprehensible emails. Krzysztof has
> > already given up and I think I will stop too now. As the GPIO
> > maintainer I suggest you take my fix for this regression. I can't make
> > you though and I've already wasted way too much time on it. Your call.
> >
> how about GPIO maintainer? it is your change about GPIOs causes serious
> regression issue.
>
> i maybe send many mails. but dos it have any relevant my change's rightne=
ss.

Well you are not making it any better if you are still claiming the
maintainer doesn't know what doing when you should really be thanking
him for looking into this, now perhaps his changes doesn't address a
particular problem you are trying to solve nevertheless it is worth
incorporating his changes in your set and then have yours on top
without reverting his changes? Can you do that or there is something
fundamentally broken with that.

Everyone here probably have their own assignments, so you are getting
sort of _free_ consultancy, so please instead continue disputing what
we are suggesting at least try to incorporate the suggested changes,
we want to have it fixed properly so we don't have to keep receiving
the same changes over and over again which is a waste of everyone's
time, including yours.

--=20
Luiz Augusto von Dentz
