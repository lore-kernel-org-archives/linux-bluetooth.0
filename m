Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A013D633
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264011; cv=none; b=J8MJsT28sRtewxBB3vGrYr5BvJ40dPis7k9fYrxGF32KV7bDWGJoBcLIsxntl5/4uEl9FUtKbhHy+2vnMtdHOVCEqf51gHz9nKvimGGjZbs2L0POi9RmBWcvP7X+s1s+lRXGC48HLHihzJ/EYE+JE9m/fb3AEgQGxWlY80ifPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264011; c=relaxed/simple;
	bh=Ywxh3jHKp2J5C17RLeeKrTvFRG0sWKH4+bmBhjCAW8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2rFzZHXeWzX7Lma5vwEDsffXKJKfbACbgciWczdHYZLyVjHOPfMvtyONePzpI0IDsp4merk/RR6KRF9hRl8nxY30EsuX6La91Sb/k6bB+X5T8TqgVAMENKfqsuMatp3JblsZg2J+psSLjoPXLo/m41ovOj3bR8lDagHgrqBeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeKVUeKg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeKVUeKg"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-644630a8de9so13327767b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719264008; x=1719868808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n29kKcAPtdQUAbyq3kUWwiLbnOH1cX8Yo23m4ifTvmI=;
        b=MeKVUeKg5mZl2+2blD9X1xPBnFbIPXocL8TGphWqM2JwS//iUIdXB0yIkKYu4UAEMk
         ksLA3gwJpwDLVZlVlXEOkXzeco5NzcYvCaS7hrj2UToCNVMJy5dPNpvpk4bRn4o+M20S
         Cw9+RwSBB47USW6Yq00/xHSBgi/NZFirgTOqmlfIX5NB/FXyl3QvSp02vjjIeZm8Rj6u
         Oz6CDEqxRdo4lVC//zXM7kl9V30bHVliQSif+Ktn3n7JJZWa5q7ZHOBU4zbJH5lqliIu
         USIzsLMUjOzsr+0t55wvdz2HfOzokeO3jBQD7RcTggOde2vyg5+huecSWCHfe3rx/6NL
         W8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264008; x=1719868808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n29kKcAPtdQUAbyq3kUWwiLbnOH1cX8Yo23m4ifTvmI=;
        b=aAdSSZAYuKoHs2fHftbnHSLFWxPdS3lCQ8mtJuRqNymJnXH6uAP2ZmQMu6ZrlIZhzP
         ++kOs0y+idvdjcnaXJHfIxXaffZHgrLPMtRQwUYxni8kACMJjV1e0GOaYeY1tmLCnpak
         FFZjS4EW89xb0hdE3hVJPBEQ+9vuy0UnVGs7Bt6cL2wjD8/4CR5LmNic8E+pXgaq9I1T
         Y5hjuqJU6PvmNTmGrdVL/VUg6lR7rY4UJMnDGhyEjcN1owi94Lkcy5AnuRkrd5/9WEvg
         rPc9xLLSNpPp4fZXdnJUkijl1s/ec+vB2FJ7g7iWQQcrHPPEQc1pyLGUrsdSxBovys+p
         7iww==
X-Forwarded-Encrypted: i=1; AJvYcCWYzg330KWjEFuHHetx1QPyleNbMi7xM14rCyBZjofuxvJOCstTpZsk4X8ifesBDSTprc7c6g6evKfgnLe7x+JTXhG3MtsItGZg1CIRGLy0
X-Gm-Message-State: AOJu0YwRM/s1/WDBPx4Q9kQpUJM2kt7/MdvWmUOBrK62Jfle1DLhRagg
	35mY7w6DJqcmz/lHW9YhDcuK7KsdiuQhM9sjo3aVp2+Wxq2fhSGpBibRUnXpcYM/VsILQflRhWd
	0jHg0eJlozmVQ5cBMv6XB0/pGzW6unO3QsD5E1A==
X-Google-Smtp-Source: AGHT+IGfkE0PbENmDKD6PlrJs150f8byfhtEUip8X0YtUZ/Mio4OSI/c4fOL3gUP49C6cbypdf7Z86ZWf3HHaLi4r5s=
X-Received: by 2002:a81:c905:0:b0:62f:1925:c455 with SMTP id
 00721157ae682-6424a143008mr39277877b3.15.1719264008235; Mon, 24 Jun 2024
 14:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
In-Reply-To: <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 00:19:55 +0300
Message-ID: <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 23:47, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We unnecessarily fallthrough the case for QCA6390 when initializing t=
he
> > > device and hit the condition where - due to the lack of the enable-gp=
io
> > > - we disable power management despite using the power sequencer. We d=
on't
> > > need to look for clocks on this model so it makes more sense to just
> > > register the hci device and break the switch.
> > >
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA=
6390")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
> > the older DT which didn't have pwrseq entries?
> >
>
> Neither of these has clocks that need to be driven by linux. The only
> user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> before so no commitment was ever made.

This might make some laptop users unhappy. But anyway, restarting the
hci0 now gives:

[   24.387344] Bluetooth: hci0: setting up ROME/QCA6390
[   24.387439] qcom_geni_serial 998000.serial: serial engine reports 0
RX bytes in!
[   24.554349] qcom_geni_serial 998000.serial: serial engine reports 0
RX bytes in!
[   24.562056] arm-smmu 15000000.iommu: Unhandled context fault:
fsr=3D0x402, iova=3D0xfffd1080, fsynr=3D0x750013, cbfrsynra=3D0x5a3, cb=3D3
[   26.914225] Bluetooth: hci0: command 0xfc00 tx timeout
[   35.042619] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   35.049721] Bluetooth: hci0: Retry BT power ON:0
[   37.539492] Bluetooth: hci0: command 0xfc00 tx timeout
[   45.539519] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   45.546667] Bluetooth: hci0: Retry BT power ON:1
[   48.035863] Bluetooth: hci0: command 0xfc00 tx timeout
[   56.034783] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   56.041901] Bluetooth: hci0: Retry BT power ON:2
[   58.532174] Bluetooth: hci0: command 0xfc00 tx timeout
[   66.531928] Bluetooth: hci0: Reading QCA version information failed (-11=
0)




--
With best wishes
Dmitry
