Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4B3D47C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162563; cv=pass; b=U7XmMnrBbrgS+HpxCiJ59jpHErnXSGI8lloJ+e6VaLlkkczu1DTwXykY2qC50FQFGCmUu12QBHmbGBCc9IjcD7zzO7lh8Nn9cje0XWKFHfRhpEagWc8Ja3IYWE6fAHqbK4xOkVz0Y/vP/qBhvSeirGQnwDRG3rJJIwmbJfFSeUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162563; c=relaxed/simple;
	bh=Ido82lTsBObPiLyE+cnbnYTa5RnXovthshiMl4cqqxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfvLuXxA6dKwlJomwLcA2lCp7QAPxfTTXqh+SfnS633hD/eXqu0UgDrGh8dUNypmTn3Q6asDGg4YUMQU6HSEkoHol8hNhs5PwrFCEcBTlUgxEwP2JgLZQcX3RKS02Ib3max6THdPVf0mCblo/fRYq7Oms9LspO2XfD7gsSKACv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAg1W+YC; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAg1W+YC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e68e4389cso26890931fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776162554; cv=none;
        d=google.com; s=arc-20240605;
        b=fvp7HBdpHq1Uf6gCbezpcrBjxtVNSuUtaUJ7PNaTQNawba0kdEINgjccqgNxEAEFfg
         RRbKCmIdNoj51AF4wvIlJAyNVX2RbaEdwCqXmoprP9bwukF9NWcD16B2oZJ37rVQGYQl
         SVlBUbpkYZbN8HIQkvB4765BDiklcjxHOfBxc4Z7sh0HsnVNfdS+R/s9Cb36KcGARXFJ
         cZ0GE+lndk0NshgjS7q4Ycu6ld2Rlb30ZxSxxc3pC/RPR7kNGLZlOfduasdI+ukTJSgg
         nTo2F3k9qQgDi3T4E1JTqA2fuXqFuvqjNzX5LtLvuG+IV15SAvCCpsuHI/pXrjVjHUhK
         pmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        fh=5KXW+V6qWbiDfg97tGVB6E0AB9yX+y+97tgB5T/k6Uk=;
        b=MvE7rD/EaawaVdVQ4ZoBE3tsx34svVBoEz3G0Feqp1P0G2SG98yw8mmwXbXIPrPEln
         mvzRT6xQHbPHdYNVHLw4m8tufwVChXbkcYxMBpaPm9LAdwZqecj3W/8M1b5vlkC5UPZo
         H5YuSLDnN3q3rbGTVQR0hpBqGTIxJqrU8wzxushtifY+5mQ7b2g3dQuwdkCaeDgtBQq/
         KXHXb35cJNU8IYd6tX1jJagP33vhWieClcd3Sd+4hxOC3izwVpm8BNHUGDa/sANVjDOm
         xRYN0upr0b+TtXiF+nvPmFCCQHCHcAXcr69tgmC0tZK0LTROSG3qGpdevBHVOpR9WYJf
         yGKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776162554; x=1776767354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=CAg1W+YCDWa+7hMyoFTX9wrJnea3anbAiHdxWmpDFPNhe7kCyRPxDRCs4+n9KcUSjl
         w6nzvTJigwS7oM6UFv5A3HKxmii0VyJz1d3VSyhkRHh9KbLCHy+zvkfyRpySbb5xZhZu
         JuL3QYV3wyDOI2wfxl8ehTcAnuZZDMlWKsh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162554; x=1776767354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=QSMh4TJPxXuB7cWC1HEHBXW7kYvOufGBZAkWR37ntNNe7IugXTwW7wEhjyQ0fh4LHv
         wT+uKdY/72OPoAwDwFwOEoKhU8wTrA1/bDE2UWC+Mt2unXnCyoDWroQ2xlLHel3jeR2c
         jW8jt2lcvTPh3DI75D6Wu3TN5haxeYJ55lIY777Wv/FTX42cv2TdxlAib3llCsMmzrQz
         sNeQhJls1i0S1ypOxJyY6Murf/bNIfOXB1cCKfq9nv6rszxuc8izJykTMwoE7E3aqFm8
         xeLoiGuKITYeUdvVPou8rFouzkHHBuO0B7la7E22r3cxUX5+fULRaENZHek0e/d3+3li
         AUEA==
X-Forwarded-Encrypted: i=1; AFNElJ98NC47Dd6/5QMxuq75Z81pCqc9DuRlrPDdB4zYMqhiz7AsGIwtrpSW2+J3Iym+WzkeAFOUqjgfwjOdJteyuFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjmtXfJnG/DBasywucOhGHdDP1fYLEb9aMTS+lTDAaT8ePYed
	vOUtFz1g/DcitfYlsm3ViWRlkFzzPhgnoSnt64WDO+gdoWqRfujk7MiwFXYZRGjg++0DlVDgy85
	YFV0Bqu+dOWojsJMg/tYAdNyzBShKl9/b1Snwjpoh
X-Gm-Gg: AeBDievpyXbLpK8KhmslM+kEhyIMT4KK4sjcr/QWOf3pgan6HduSOq0zz4OotmkfEGP
	Cd8fKaMbaWCwu3XYgyOeoLAsGrZsIHFIexp5b55jk7bJpfZ77CqpUiOx85NXyznS/hr9rvchLOh
	KPZA0qFLVBhSJernaRUoMKqZ2wf90XW01Mm7UQ8Zmmt/p0JOZH+8QlcvqYG7rBwyDAz8LAIZhnS
	33N+EZYWr/lmXaLkoOHwoXvbpiXKzvZ79cz7q8NyUsQHsVmvGejfYbomJrviqJnp4/KAvdgRbFt
	42bPPkBubHFsbI5gKjiHaAo33Q61pH97pCr1R2ueAPA+6kxx
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr4850095e87.29.1776162554447; Tue, 14 Apr 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com> <ad36pIu-0dutL7Nk@ashevche-desk.local>
In-Reply-To: <ad36pIu-0dutL7Nk@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 18:29:02 +0800
X-Gm-Features: AQROBzDHB_HCwto4iaprIWgL7mrQWt62yIrtGAtxckKlX4EUkJwTT3ZqPu-YslU
Message-ID: <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam w=
rote:
>
> ...
>
> > > > > - Given that this connector actually represents two devices, how =
do I
> > > > >   say I want the BT part to be a wakeup source, but not the WiFi =
part?
> > > > >   Does wakeup-source even work at this point?
> > > >
> > > > You can't use the DT property since the devices are not described i=
n DT
> > > > statically. But you can still use the per-device 'wakeup' sysfs kno=
b to enable
> > > > wakeup.
> >
> > I see. I think not being able to specify generic properties for the dev=
ices
> > on the connector is going to be a bit problematic.
>
> This is nature of the open-connectors, especially on the busses that are
> hotpluggable, like PCIe. We never know what is connected there _ahead_.

I believe what you mean by "hotpluggable" is "user replaceable".

> In other words you can't describe in DT something that may not exist.

But this is actually doable with the PCIe slot representation. The
properties are put in the device node for the slot. If no card is
actually inserted in the slot, then no device is created, and the
device node is left as not associated with anything.

It's just that for this new M.2 E-key connector, there aren't separate
nodes for each interface. And the system doesn't associate the device
node with the device, because it's no longer a child node of the
controller or hierarchy, but connected over the OF graph.

Moving over to the E-key connector representation seems like one step
forward and one step backward in descriptive ability. We gain proper
power sequencing, but lose generic properties.

The latter part is solvable, but we likely need child nodes under the
connector for the different interfaces. Properties that make sense for
one type might not make sense for another.


Thanks
ChenYu

P.S. We could also just add child device nodes under the controller to
put the generic properties, but that's splitting the description into
multiple parts. Let's not go there if at all possible.
