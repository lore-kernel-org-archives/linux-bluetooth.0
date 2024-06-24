Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72081BC2A
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262034; cv=none; b=Azd8AGkxYO6UdhgYjbcwyh59DbTTs9e9EkRxU7pHYfgq6xu+lkcAdJ6Vds7/1ozP4UFpFAdM+xJhtFKGKxK/D3XjPyUcsJd7rbK0EYeWruM3MxkoOBMTMNDxT4LK7SoYNLIqkFpYrtMe217BusvHg9y0t26f//CxYlw5jLRCkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262034; c=relaxed/simple;
	bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7jQLJRPr5RsRweNGafhkTCrQTbR3SFD0lOwIWAuKYpXgmVGtprRKcdZTMELpfkT1v3PHh+JQZdbWluYm24Oe4d5ZPPiKtbgyqW5EmNUSGnnNp6e5cy25HEBGM+y44H/xXd/9gKeE7AVyDnM//okfu8AaHc+9BmdEBanmCy8V+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i9d/bZ5t; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i9d/bZ5t"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so2881560e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719262031; x=1719866831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
        b=i9d/bZ5t/SR5m7oQpK6fTjQj4cvmArO8EM6U3TP0LY4cm9pcdvpnz+m4B0ZnJcaYSg
         j/NrmSKGMPSw8jcbgIpSsk3Jyn9NtZTQ4qe33Y6AELi0X6+vlPmHtXB7oWiSUyAt/XyK
         ipB/B6eFtDzKfS5amEXeNUkWZKQC6qJVMRk6NenL4WOD4vcsvdDU/N9yvUT8yEt4ksjd
         v5V3Y0qtnHNoe4dVvaWp3oFRt4rlzTVCHLopeDFVEbPkWVXwIk4esi+GmYsPTFGEMOn5
         AS2OClsFWDSd0xVA/nZZ9XMLxbJ0UQzZCWU4mqQZTJj+mawhg4jnj/BygOGVtPVt2dc1
         yjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262031; x=1719866831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
        b=iM+6HiqfAASwy58+mdUIPCH2Id6pUhsY0lU/tZpMokr70Q51BHoNsBJcOG/6UJZeBv
         xjkvp1KAM/dnlt7jikS2jaQhkG+aQ5ccUs7e8EK4CmJcnoPZ8T/WS0I4Ds1Fd7BSjTyf
         MF8Xyrp9U1FKW+l7OIFV73V9uPXy8sr4xEg9iM/kNVxDmZhN6fhnLvDnuJRX5KjGRP43
         gIHACi8BVW3KndSj/TexK5HPc23P394roRM+20guzxqwDVs0ULF0vMyhqaaUqoa6iKhd
         CS9wb9SAs/XiTF8QrB7icbItN1KR8iEq0PBbhj5U+GfVf9lwrXgkE6aJJRj84Dphc2dJ
         tf6A==
X-Forwarded-Encrypted: i=1; AJvYcCUQMycqHFLhBGoLTwNSDIDlBqv9UlBXGT1mPbNsunK5LzfHj1mCZ3aaAbR7qdplX8pjdSoat0/hNMv5nGjqKsXIKYd5JPxlNoGlQkV7eOdW
X-Gm-Message-State: AOJu0Yxqv3LuAKeBQp3jt46R7582uYp07B7tRnVS2lWanVhdrPMCBj9H
	mGhoLJKpZRzVmDTF3noAi2xCouztbzWVH1+uB7ZQrb8lyZDVstI/lc9RTp3MqE/Bv/uMuS0serH
	+LxPn24w+FuhkahSOLEa7CZD4EXSUQDVrrHaglQ==
X-Google-Smtp-Source: AGHT+IHL/+BVaSL1JwC3QdV7+dB7p9nj9FusdDMo3xQgiMwebDA1XqLs7ZH+yWvabVQljOToUMXD4dlenP+acuxj/IA=
X-Received: by 2002:a05:6512:39c8:b0:52c:e4cf:4f31 with SMTP id
 2adb3069b0e04-52ce4cf502dmr3593154e87.49.1719262030535; Mon, 24 Jun 2024
 13:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
In-Reply-To: <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 24 Jun 2024 22:46:59 +0200
Message-ID: <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We unnecessarily fallthrough the case for QCA6390 when initializing the
> > device and hit the condition where - due to the lack of the enable-gpio
> > - we disable power management despite using the power sequencer. We don=
't
> > need to look for clocks on this model so it makes more sense to just
> > register the hci device and break the switch.
> >
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA63=
90")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
> the older DT which didn't have pwrseq entries?
>

Neither of these has clocks that need to be driven by linux. The only
user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
before so no commitment was ever made.

Bart
