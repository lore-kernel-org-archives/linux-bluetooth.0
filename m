Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2E15D5B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966835; cv=none; b=oBsm9B/4EB+5zo9QwFDYPQozds78YbkJ7i9BzD6MPs2d2O6mjE3zqNhK2OdB46RGyk9brTlVzs97Q7XQ56FEyMtdfDylzRernCgFImaVya8xbZAbZKhEZElQIeIePSjMyMrMpGF/ms57dFZA6WYyvyqSLdQvp3A6g76LZ22y+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966835; c=relaxed/simple;
	bh=fhR4uE4yLyvD+B2f4w/tGJIZJC7P2TcQOXf71qR0Hdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJcqzfCcoIKIci3lstc5HkX0BqT+Yw5FGK5zg5olHRnSDs2+FyLAL7xbG4jeHRYuL0dDYGEtNjGCYPgNQkFTuvM/bDVGLEyyCeAe7eReWL/R+7MDf3I+iv0/TyLq1XdZ+wFkP109BF/2Z8THnJak1t+ZgB2bGm+eEARr/UYPcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DIEvzPxm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIEvzPxm"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de54cb87998so2090377276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713966831; x=1714571631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTF0+jQz4A/5exiMNPE0r/1P9poMBy5VmCr9Kl+mvRg=;
        b=DIEvzPxm4h7EvhTvt7CcorloTm0ogL6LBZsf8CKcZfI07oIEWSkJYc0OemQR4M7UXc
         p1VoAALVPgPBCAmBOUQ7MuJFd4U1UqSpSdGZrye8UxwJFPO2hzjyssS3VYiKd/VWd4CY
         nNAevEU3J9kqpa7pbGp93ebhfNcUNkcAHR8D63Sln8w8PhkAOcq/oURRMVBBuX7ftSBU
         7gzZllSqdqQGmPQOH6/oxTXKPIHNs9j5ubErXmtAL2ob4KYITbEi38OlvYDNAYSTLqyp
         aPvzPYUIts42fOdpGs4X0UkMRmD2XFK6iMgZJOObaD4UiTw5DihrWu6+gRA3DmJ44G6S
         FvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966831; x=1714571631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTF0+jQz4A/5exiMNPE0r/1P9poMBy5VmCr9Kl+mvRg=;
        b=ad+8Hb20lowoy7mc5fzbXQ/rd92ZRrYICHPJb1FPRhllwNy4nG5AF4KZxKsj4I1j9+
         IvlSfGaIjcCT3SLkH1BvNGCvIF+KwheBEg0HBPOMO9FAs7gChTvCRiFVGzVrQ1Ihrkvk
         /4XFnD4jyHAdH/Yr5QRtmTD6VvtUCqCR4kNJo3egE6re249ufHVhenBL8jKUZZ9E1yyP
         1m+OgYH4koo6bB3+xsnmdDk0LyWOfttdWoS4uRSNtgnjWmAA5v/NHR204yaCnMR+MFVp
         8RxdsA/sFJHWh6XNOSDRCo03ngCxoNi7q8lvndrMNTnGhwSwdiiE2Xla90tiqbD6N6n7
         yNyw==
X-Forwarded-Encrypted: i=1; AJvYcCVvBHKX+jsXj8Js2tkYvxP6a9UYhPT6X5tBgwqOT9Ws13mMt0tknnKdYlMSGR+znmF8pNeSGZIMgLGuwN93BUop+VHCjDRspw+a1gTlv104
X-Gm-Message-State: AOJu0Yzy2OpDJodZnxosw3mOfjdpioFXUXmO4C0NTqIGUiJeSeezbMdu
	NcFmOB0RzycoYclsZgIwpvoS2YlaPVrWpcdu0JExVd6TMy7hyfwQch49EC6xyeOguBbZZuhO7ez
	OFG3Pj8C6DMQfbXAY0JslIxFs+jZP27QZv16c9g==
X-Google-Smtp-Source: AGHT+IHCYcGO1WA1gUez2YG161VlC4qW/5CFmZm5gjfXGv7q2yMFfXVWYmGPxxQwq8WnN8pWCyG2oZOjXqJZmZ0BSc4=
X-Received: by 2002:a25:26c8:0:b0:dcb:b072:82d5 with SMTP id
 m191-20020a2526c8000000b00dcbb07282d5mr2468708ybm.64.1713966831536; Wed, 24
 Apr 2024 06:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org> <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org> <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org> <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com> <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
In-Reply-To: <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 15:53:40 +0200
Message-ID: <CACMJSet1wjEive0-Z=0_eiY7umBoSF_VX3QvVgiwqxhTSDZg6g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 15:26, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 6:12 AM, quic_zijuhu wrote:
> > On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
> >> On Wed, Apr 24, 2024 at 2:24=E2=80=AFPM Wren Turkal <wt@penguintechs.o=
rg> wrote:
> >>>>>>
> >>>>>> That's OK, we have the first part right. Let's now see if we can r=
euse
> >>>>>> patch 2/2 from Zijun.
> >>>>>
> >>>>> I'm compiling it right now. Be back soon.
> >>>>>
> >>>>
> >>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
> >>>> right. If I were to guess I'd say we need some mix of both.
> >>>
> >>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
> >>>
> >>> To be specific, I have applied your patch and Zijun's 2/2 only.
> >>>
> >>
> >> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> >> Krzysztof's changes and replaces them with a different if else. This
> >> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> >> Krzysztof handle it.
> >>
> > do you really realize what do you talk about?
> > do you really listen what do @Wren says?
> >
> > he says that my patch 2/2 is right based on several verification result=
s.
>
> she, not he
>
> > BTW, my 2/2 fix don't have anything about DTS usage.
>
> I think the problem with your 2/2 patch is that it removes the
> conditional bailing if the device is shutdown or not open.
>
> Maybe this patch instead?
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2f7ae38d85eb..fcac44ae7898 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev=
)
>                      !test_bit(HCI_RUNNING, &hdev->flags))
>                          return;
>
> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
> &hdev->quirks) ||
> +                   hci_dev_test_flag(hdev, HCI_SETUP))
> +                       return;
> +
>                  serdev_device_write_flush(serdev);
>                  ret =3D serdev_device_write_buf(serdev, ibs_wake_cmd,
>                                                sizeof(ibs_wake_cmd));
>
> > he maybe be a DTS expert but not BT from his present fix history for
> > bluetooth system.
>
>

Did you test it? Does it work? If so, please consider sending it
upstream for review.

You can keep Zijun's authorship but add your own SoB tag at the end
and mention what you did. Something like this:

[Wren: kept Krzysztof's fix]
Signed-off-by: Wren...

Bartosz
