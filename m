Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7F36C598
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658815; cv=none; b=TXOsJIg6IZnZgE7m0lRV6TpGEmrz5FSSQwpufo6GEhhETTK6cdP/rsCFVa06zEO48k+WZEMYnTTTqnih6+nWOLltNJyGiv7qY0jNYz8OLaTXrp237BPWmSvhXLiN9o6edUcJQmr9PdxcDzN9zUktpH+yGDWZlRjLOQINQfOkbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658815; c=relaxed/simple;
	bh=dA+X3frohUmiN42sQXCsXtWK/UJo0Tcfbir9/CzOXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZuxON42BLF4ihu9IV09iyWVQKWLODyddCNMYF/+KuFzggi+VNBnE9K8u2H88f4ZJKJsAbGFdeFEbvcLel7klHxDNDlyyIsqcg0H+p43c5TiNVlUbMBPjQreYmemx66eTFcv9I+Dygzn6VLkz/F0eW6Tdzos+Ed6Zx+YtjiJXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B0IPZ+bE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0IPZ+bE"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7291af7190so172266466b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 09:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763658801; x=1764263601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71+jWtBg7d1iYRAZRUfunCs8pFBPFzAnVW06bSqsOgk=;
        b=B0IPZ+bEOJBe9qbZc8/hzmMYp7upSLg7MTHv6CKgsB78eF/SzR7TLR9cw16aRnLSoz
         qUKeI3wBxuE7nQFAOuw8Fr6rffu14Ok2DmYeTNzIIYeTZ/aG/KVFWjlEYFGIL6LTaBRW
         bXnPliLh/rHYdSlv82A0T4Jr2pC49T2QphR3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763658801; x=1764263601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71+jWtBg7d1iYRAZRUfunCs8pFBPFzAnVW06bSqsOgk=;
        b=j1X2vcdnVBWXTSDmQ5k6IVZ2tL1bVlbUq0BiJMgP9BLGdkoe2onhATsSKXXXLfFD3V
         ET1EXs1LD0M7TwFOzgeYSc1FYs3Lo+tkI8HeUfAvWfUOoMiytfLw+PADgWI4jPBvLGXq
         jxy2VvHwSzAiO5PTTrjXblhsjPwqcge6WrFKw+zbi1QHox+EPjmCjWxpW5IrB3H29yzI
         m4TgDuuAv0SqlB1WXaFfzJC2/8xOHb4+u7SxRcgctrHFNXSlHcHedtgRi2RU2iaClbaf
         iAcdfBjMYQXhuqAcLwwFouYeNPru8BvHahCstuMRla7UHFTJvRDkPT/JDqINaYgQupSs
         qThQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxU4sVvceoyBgGFg7ODVc3urStdrTmWDUzlzNhBBuW27Znr2jiOVL+4E4fjEfZiIt1s+v3XOZvTM/GRpWB4Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvVi8/WvPe3UDcMCPj0mVZOdJUEENxVPqefhr+b88KpfKWuup
	Vtbful5SW5WMViCzu9YiajMYsVh+s2Jixt9LskU1FHuqeYqP+K4M5Gg/gMIE0UD24JKANlg9VRn
	1mx2IZccc
X-Gm-Gg: ASbGnctZ+Bzc4pC8411rZjWQJ+hJdreDDjJ6tBlgTQGirSwLDlhpzyfuAjpDHo8sBRt
	JOBkiPINfmdmB2nXIbLbhc9185tjo1/VVtEOpMOtMTHLOWcjsnuu9WyyLA7Eypz3gYzg9xNLQdx
	6qUPWUDEC1c19m8BdQT8styFPk/9q0Bv+YCie1DI/oC597+gR5q8JfsMs7kqR+9zGahy/H+ZFr6
	R3PZhgjh2eZxSFM1DN0GFUjtChi7/aQRgBgoLVgT7RiOVvZ1x724YhvienGWEye9rzo5cjVHIOF
	7MVN7jnjXwNodPkt8R+17042OYacfFb3kYv/xe8Ivsd54MWAkDy97TMdL9rQuYOJljmsZWfK/uk
	Nl8qXOFtq3UZjccpTUMo9KH1aooCliB26u/eDENs23nDnKdmo99J8Aw2Xfh1mY4/Q40nWCbSDYc
	v0K72qdJ3oLpc8hXrTxSLEKgMTEeeCQ1eFCdcWOhh9Y8PQheu9TA==
X-Google-Smtp-Source: AGHT+IFFpOu8p2zO5IKKz4X8+mGr5dLQfKaVj/a3SixblLiOHnfHIVg3ahrbumStFeDsI3+Vaeh45Q==
X-Received: by 2002:a17:906:7314:b0:b43:b7ec:b8a1 with SMTP id a640c23a62f3a-b76587b2aa2mr307710766b.24.1763658800921;
        Thu, 20 Nov 2025 09:13:20 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550512d2sm247983866b.67.2025.11.20.09.13.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 09:13:19 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73161849e1so299559266b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 09:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+d2TH51LZ6IcLFHMSOE58GP+MPVSX5N9gBlhXXTE9O5GYKKJaqPE02SZqfeiTKkG0xNYkFn2Tw1UNYH8c3lo=@vger.kernel.org
X-Received: by 2002:a17:907:84a:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b765869343emr280912466b.4.1763658799257; Thu, 20 Nov 2025
 09:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
 <be1cbae6-f868-4939-a1c1-fd66e2c6b23e@molgen.mpg.de>
In-Reply-To: <be1cbae6-f868-4939-a1c1-fd66e2c6b23e@molgen.mpg.de>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Nov 2025 09:13:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W1D7ksbS-q1c6cHQSxx3=Z5yfC8duiBGh8S01NhLPLUg@mail.gmail.com>
X-Gm-Features: AWmQ_bk3aT3ZuUmLknvARxMmblGOEsNctHWpwZyyDwMRW7H291WIp2zvCdFNcjo
Message-ID: <CAD=FV=W1D7ksbS-q1c6cHQSxx3=Z5yfC8duiBGh8S01NhLPLUg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	incogcyberpunk@proton.me, johan.hedberg@gmail.com, sean.wang@mediatek.com, 
	stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 20, 2025 at 9:04=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index fcc62e2fb641..683ac02e964b 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2751,6 +2751,11 @@ static void btusb_mtk_claim_iso_intf(struct btus=
b_data *data)
> >       if (!btmtk_data)
> >               return;
> >
> > +     if (!btmtk_data->isopkt_intf) {
> > +             bt_dev_err(data->hdev, "Can't claim NULL iso interface");
>
> As an error is printed now,

An error was also printed before commit e9087e828827 ("Bluetooth:
btusb: mediatek: Add locks for usb_driver_claim_interface()") too, it
was just a different error message. Previously the NULL would have
been noticed by usb_driver_claim_interface(), which would have
returned -ENODEV. That error would have been noticed and the message
printed would have been:

Failed to claim iso interface: -19

So that error is merely changed into:

Can't claim NULL iso interface

> what should be done about? Do drivers need
> fixing? Is it broken hardware?

Personally, I have no idea. I was mostly trying to get the regression
fixed and, after looking at the code, I was convinced that this would
get us back to working at least as well as we did before commit
e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()"), plus we'd still have the device_lock()
in place to avoid the problems I noticed earlier. It sounds as if,
even with the error printed, things were working well enough for
IncogCyberpunk.

If someone wants to analyze how / why `btmtk_data->isopkt_intf` would
be NULL in this case and if we should do something better to handle
it, I'd certainly support it!


> > +             return;
> > +     }
> > +
> >       /*
> >        * The function usb_driver_claim_interface() is documented to nee=
d
> >        * locks held if it's not called from a probe routine. The code h=
ere
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks!

-Doug
