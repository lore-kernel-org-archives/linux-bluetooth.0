Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F7326D67
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234891; cv=none; b=Z4YjT5KMKAx6ZzhU0y7OKiw8deQBSsv0MU2tyaDn3Tf//79+6GexIT1zooQqEqxWl9JeG5wwJHqFevm511fmure/VdGBkd4YeNVYqeicfmujxT7EzGp0gyvsLI4ZABAsXji4g0B+FwMg7k3onvjBE5qxtmS1y3/RObeL5kPt/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234891; c=relaxed/simple;
	bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNUKZ9Vm4oTs2zKtUpnPhOCKMsEqVbu3e1YTIH04CEmQKb1b83jrePJ+1AqdwYBEZegkRsvoJWPyurG2/1BgBMrS50sHmw5PpvEf5QXhbdEEhiB7FSznfPn1NYNiVlgJMHABORIvrF76j603piUto3vyyJhPoY5gbOt0uNHk+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WYFUaeHT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WYFUaeHT"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59583505988so825236e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 01:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764234887; x=1764839687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
        b=WYFUaeHTCcZh99fNLyg4ZjCVWMHQInJ4eA1K7+hq/WQJjQDsK/MkEK+wSVvyqeuXla
         KQa1t3ugiAEhdhvw5FvDcYQF8hkf+S9JRACEIlFnj3VNJmxNFmVmloBvRI9XUUrMNNfO
         NmPNMA4MP0Rw/2YFqK6ctPM4s19cMSCQdeQgtQMihpOQsIDy96B/KeuwAEo1tirvPgTB
         pAev8SvLVNCUeU227JfrXqZ9bW0ISv9TY3tN8kx3JZMvbUwnG4hz8CC8GNCYSqsMUPVm
         4p4cqX3cEnv8LNJgZ6I2AGQm235EbNo/jgAtE2WSpViVqhBgk85pcb+xn31/dvq+fQgL
         1yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234887; x=1764839687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
        b=SefySxvdqCSxndX3xlogVzopes4MiD7FMVVaUrK9Jn2EULnU3BEqltMRvMvLSzw57d
         bSf3cSMoYwjbIB6KDlefEuYpKEB2gpfTZ9RJQsUXoIkHJaCzyjBSzLvIhfrz9yZXaBGw
         gnq9e+JJ9Sp7sBJ+mCibUtPOQx/wTeD7KfLiqfHmEwf3SAJetjzuGRW41F+1XrmnEWVR
         ZS/o8fVdBGGThIhrYEU0afD7CIDJq6wAM6rxHMVVgWbw+bVjXc2DhwttKZaiNuqOZn7L
         Iu0otBxCqmM3k/psgk2Nwf0zrO7JysVg3WWf9GK50Mi5w+EBWUADVATlzJhyYZTOksBw
         ODYA==
X-Forwarded-Encrypted: i=1; AJvYcCUhpJygq2p5BpAS44F7ugsI/w6orfKrw5e/evRQSQIBzthPglvs172a+hq0EAZS9WbRCCPvadnP+Bx8QE4ck4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXtZNOjYnkiuONsCTadBbgxm3HlOTVnFNqjseSoZrOSxjfpSa
	J/ve/1mY6j1Pbi9dvCh4ZKV2HkkIvg4ydGB5spf7XN9aE60fIehb+ski8F7HkS1yguvM+M2qLdt
	Y5S26JX/XPh1pMt+EcR2C+vwBrdOk83cS3fiwbUPguQ==
X-Gm-Gg: ASbGncuiQSzYIqRSXM5M+KIr9tG7FP6vMg4heSM3+4NKTKaLhPAK1LnMgR41vsScXEI
	jhH4/XV0HHc6/ImBqcxnXA0synG9pTb+G3LuUEu6ZZGqCypzOrzMfh/M/eWlEwkjSdsEtsAA9vi
	NDABdeaH0oTc03HBycmA8XZwdyO28zxLAUaMb3XRstIoOG9mEpugBYzPRANVmhejgmDsvDhGWSe
	3YDEcw+3JIg3Nt5ymyl6gGOaj1bgqbeLaTvXeSp3FceKpyw8ClP593NznDHF3H4rIli3yVf+0Fk
	/RcNqFXsgvoNXYjkdDNN+HM3lxI=
X-Google-Smtp-Source: AGHT+IEbc2TbO/tYVAauVYSWlsGPpU9aKscxV4CCCOtz2gTp8D6aQtAJcJ71cXNyLsAVeBjOKBJwqCStf35Mbf46OXA=
X-Received: by 2002:a05:6512:8010:20b0:596:9ebf:25a2 with SMTP id
 2adb3069b0e04-5969ebf25d0mr6811454e87.19.1764234887164; Thu, 27 Nov 2025
 01:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-3-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-3-32826de07cc5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Nov 2025 10:14:35 +0100
X-Gm-Features: AWmQ_bkMx1pQI7KIzXZheaED5_3WOsSVYkYxsGF26N74WOl7tj2ktgI1roknym0
Message-ID: <CAMRc=Mc_=F3HiKCVh26RtJ-8vcFWbdRRFS5R8tJa7320W-Tcig@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] serdev: Allow passing the serdev device name to serdev_device_add()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:45=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Instead of always setting the serdev device name from 'struct device' nam=
e,
> allow the callers to pass an optional name and set it as the serdev devic=
e
> name.
>
> This will be used by the future callers passing the serdev device ID as t=
he
> name.
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Instead of modifying the existing callers with an unneeded argument,
I'd suggest adding a new call - serdev_device_add_full() or something
like that - that takes more arguments and make the existing function
wrap it.

Bart
