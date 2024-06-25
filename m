Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B33145B20
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298646; cv=none; b=SBzsXtKBKqmqOfdXcwty2cL1Dgz/GVXYsliuVKQd6tmMSlFoUiPRP1A/SkM1/0vWkGy9/6aOM72rUbpwb4OM0RzCLBQclQr4sdE3YLF1bJcWp5nIDZ+C2DNr51YFJd7Z6jgW6zzXxC7LNAj+sZrvgaxLy5X4MFlFG2yvue5dg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298646; c=relaxed/simple;
	bh=9bwQGGR/wyIdfMAsvGQ9dzDTbZwlGTht+mu4n+QPefg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPRl5FE+8xAWqM4we79CJ0LmryV1Ga2nGlmwy99lPVZ08Oj9r1rMSVGKEBVjQMQ/ws0y/b4aoGxWnlLPWSyq83xpnHRLZBSKssYwgoUylGuhaJEPDJqoPgFTPkUEKgPGDPdx9kzir1xtK6Z8iNDH3ihw0UZ47mfGf92lhSzwlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ppy5c9v3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ppy5c9v3"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63174692a02so47896087b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719298644; x=1719903444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDmIfuJcogCN48ne3+t+LsUj7I8L6ToirSOH5B1KCCI=;
        b=Ppy5c9v3UDf7dNKdkMc5NtogPQkRL5tKCY+76M0n48wyds0x41+35aG5s6QgbjEGwk
         9CA2qdHLx7tEXmwHFORWItwR5boD7bbtuFpXFrBxJs0R3rVUAK208zCpzxNd7HVpKetn
         Mn9gvw5NOuCUDMxyKbBfr0vHIWLB238YTy0Rn2ZcUn9LeO2IVWaCfWYNAUKYMbWfqqx7
         l1jpSgeSQ/ym191DPmz+P5CdcmN6o+dUwljB4YixrVI5QKjebsvPzOD2uwVvlDbs0c0A
         EiX6MqWlSfpxR0pADmnStBVXFm3dEVuhxp0JtOFEkAa9tjyynJ4KuaTOrlo3O7fQMjzi
         Afww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298644; x=1719903444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDmIfuJcogCN48ne3+t+LsUj7I8L6ToirSOH5B1KCCI=;
        b=RDnfnXbODWwr5wY1cx8sosCLl6EovHrhJdLMHgb6BuTozvppwIQMUf3x+rhVbHfSPw
         6Wv36q9P7CKgXx/paTfvMoaFP45noTqyHiaLwEyn3hOhsqGu5Ch1XT4ACoRmM4m5Nzqj
         v04+Pb7TSMG5RFYVWv1UM+2aoLzdi5SqEQYwqUD7zE/4eOIuCgccmmIAaPMKPgf+yMxb
         tdrwdUmEJ574Z/Q2DWfImmwXtO1QT6LEQCohG8FrxbbeEfY7NUbl8TP1ShNrBri8CQrZ
         K0oJ8wzbXVw7CLP2c6aCJJIeHT8Y42kz0cUfrWXO4bjeyMlcJZPytHfR5wwhNVJhvFC8
         UUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0m3GfAFxFD+JMEnLNCFW7uXPWFTIrrDtvx8ZGH2RkLH993mh1QMH83IwcZ0W8/sRUC7M9WOrOA11VcIUEgLdIoU7UuqAMSLpeIN+afYGx
X-Gm-Message-State: AOJu0YzoaOqJIKgvNLhX318Zh9KWsy/fiwD+MpAP/UyuGXEVcudzN3YE
	0LwUpu3K4uUlGaXLvgtMq7X6pPCmjwHka4xd0zYFXHMOvREgamWFWZ7r+h+iDHTsDOy0R9eNfhe
	DJ9Y1MCII07VGrNawptgJ7b1mrV2RicFktXTdLg==
X-Google-Smtp-Source: AGHT+IGripGlc3e99ZcQ7A/cB5i8DPUq0WPOuQjyoddclsAtiju4Lk8yaZqQa5u8RSMpSSF6OCkcO3tGgbtiw1qoIu8=
X-Received: by 2002:a25:a029:0:b0:dfb:812:af06 with SMTP id
 3f1490d57ef6-e0300eef36bmr6622618276.10.1719298644096; Mon, 24 Jun 2024
 23:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com> <CAMRc=MeX6crenUhC1dqp08W+ss5YksUaaemr4PFFM95SHeED2g@mail.gmail.com>
In-Reply-To: <CAMRc=MeX6crenUhC1dqp08W+ss5YksUaaemr4PFFM95SHeED2g@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 09:57:11 +0300
Message-ID: <CAA8EJpr3OPi=EhpfXWghFoF0rgYwuZ8Xw-EzybOzqzftq-GhaA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 09:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, 24 Jun 2024 23:19:55 +0200, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> said:
> > On Mon, 24 Jun 2024 at 23:47, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >>
> >> On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >> >
> >> > On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> >> > >
> >> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> > >
> >> > > We unnecessarily fallthrough the case for QCA6390 when initializin=
g the
> >> > > device and hit the condition where - due to the lack of the enable=
-gpio
> >> > > - we disable power management despite using the power sequencer. W=
e don't
> >> > > need to look for clocks on this model so it makes more sense to ju=
st
> >> > > register the hci device and break the switch.
> >> > >
> >> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> > > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for =
QCA6390")
> >> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org=
>
> >> >
> >> > Is this going to break the QCA6390 as present on M.2 / PCIe cards? O=
r
> >> > the older DT which didn't have pwrseq entries?
> >> >
> >>
> >> Neither of these has clocks that need to be driven by linux. The only
> >> user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> >> before so no commitment was ever made.
> >
> > This might make some laptop users unhappy. But anyway, restarting the
> > hci0 now gives:
> >
> > [   24.387344] Bluetooth: hci0: setting up ROME/QCA6390
> > [   24.387439] qcom_geni_serial 998000.serial: serial engine reports 0
> > RX bytes in!
> > [   24.554349] qcom_geni_serial 998000.serial: serial engine reports 0
> > RX bytes in!
> > [   24.562056] arm-smmu 15000000.iommu: Unhandled context fault:
> > fsr=3D0x402, iova=3D0xfffd1080, fsynr=3D0x750013, cbfrsynra=3D0x5a3, cb=
=3D3
> > [   26.914225] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   35.042619] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   35.049721] Bluetooth: hci0: Retry BT power ON:0
> > [   37.539492] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   45.539519] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   45.546667] Bluetooth: hci0: Retry BT power ON:1
> > [   48.035863] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   56.034783] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   56.041901] Bluetooth: hci0: Retry BT power ON:2
> > [   58.532174] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   66.531928] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> >
> >
>
> How do you reproduce it because it works fine for me:

Hmm, most likely I had a dirty kernel version somewhere. With the
current linux-next it works for me too.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # RB5

Thank you!

--=20
With best wishes
Dmitry
