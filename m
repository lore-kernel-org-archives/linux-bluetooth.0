Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F223EA64
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017228; cv=none; b=kUEO1dJNB7O6516byVi6aRaTuOJRQaEVYHYYOJy1uYtN54BHMACcO7gU/qq0dJ/c9xiP8hCya1ZeNs7jVlcFwX9ymJ3FzMla6V483nmKKLSv8bq6cz1nesErEbjMLQiPuI4pWFvAAsH638aEx4Ng9bK1B0Vt7KZSTAX6gGLRHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017228; c=relaxed/simple;
	bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ26Berwy9iwV2sIHtdvWgg7gJakv3iUcFbqI1IdqSeZnlTXGlL9DH/GZQaMt+Mb3ppTfxqA4nL0JbystkxfvIIpnTwAz6PrcGHRPq9UYr8J1/AvzewNajif3OcShjhYee8vEjYJ5XMndDjHWxKcIXIMudkrejscsxBn2IcQJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h9uWMD6g; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h9uWMD6g"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52fc4388a64so1926554e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723017223; x=1723622023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
        b=h9uWMD6gEvL9VFBHXMTgT30wHAi724kV+7WcdiKDv0XwwtFMT/srTumwwpg9JufOfF
         neRV7C1NqFQU6B08MLOmZjpdeHBq9fP6jAQSlyt2pX2h8lfp+81wGw3svjiNNrTUfrW3
         8BtX8RXM5EHiGT0JyCsYK5Ms5JYRo3d0VKvBsDBlCXY6dedtj6AM4QttVlqF+gj7AVVa
         ZR1bPuhvPOPPe+7isMbTYuEZlv8EZjUlGvLfS1qDQlRzs/XiUq/pY53lpRw5ZW3K0+bn
         ed51U4ualsuW1NVLBVaMlvIJtnrjsITMCi8+PvdlAOZFxBy0Nkd+H/KNsfClt84gkkR1
         +K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017223; x=1723622023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
        b=d6U8QjuEXqINd1Q8X+egl0uAqltzKw7VKdpZkrjXDz2kf+vehsXOb+OsePDbsSkyqc
         goIurtvx1Lk/8XJwX8s+2ctbxBbGLDXJjtVow6FpYECrH0+1mUT8eRQuvBOFBDtXpdpm
         VxhsgPDjo8oJq4HosswJgqFgCcNatuJYjBZW8ruAfkb1wuxjX5eOoR9r5iKwC6ZRE6j1
         2X7BMSjdZKcJpdMbbqIuALeKmYfgqjQS71h7/cB9yTNyBXprIvs5PNebsAFL+cY6Ebbl
         TWkDlbowTKogY5jfHP5PndEIqR3F6y238f+gPUTIKLRgFir+lyl3oMECQiyV9ym4jP/c
         CurQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpPkZLFszyGmAHLDhas25+DKu4s/bK8vCJLyHetz1llK7lwD+NSGrRW8XmNbQlBVZsNIY6St8bkuSYL62bzJ+U+nZRNxdMTa97dL+tPwsO
X-Gm-Message-State: AOJu0YxRAoGQoiRPeFSNzYOqGyhlQaFFCxwOM2/WB/byK3EboIYaksu4
	3HHQ4TtZBu+p0lDp6tkOlKwXfPcn72yNIN2n3jaogpZW5j2xcHWQegQIJTsYiSisc/oVStuGMLY
	9s3PXhivwg/3/OtuqgfTqftzcnG1agJw64f7R8Q==
X-Google-Smtp-Source: AGHT+IEMHPUoCGAziZXFqLRYhcE89Hu0RXOGMn5qoswWzoIi01nwD/49Dvb2oq880JBBAmn6aIs0b95/3o35im4sNu4=
X-Received: by 2002:a05:6512:2302:b0:52f:d69e:bb58 with SMTP id
 2adb3069b0e04-530bb39b7d5mr13670284e87.44.1723017223061; Wed, 07 Aug 2024
 00:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org> <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
In-Reply-To: <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 7 Aug 2024 09:53:31 +0200
Message-ID: <CAMRc=MdSH6n=QKwWnT9zNaBito34t+BpCufQDjnAOaeC5iuD+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: Wren Turkal <wt@penguintechs.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:44=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Wed, Jul 31, 2024 at 05:20:50PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Unlike qca_regulator_init(), qca_power_shutdown() may be called for
> > QCA_ROME which does not have qcadev->bt_power assigned. Add a
> > NULL-pointer check before dereferencing the struct qca_power pointer.
> >
> > Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default=
 if available")
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbv=
v4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi,
>
> I just noticed we're still hitting this issue in mainline (saw it on the
> mt8183-juniper platform in KernelCI). I see this commit was merged 6 days=
 ago to
> bluetooth-next, but it seems there wasn't a pull request with this fix ye=
t to
> include it in 6.11. I'm wondering if it's still going to be sent.
>
> Thanks,
> N=C3=ADcolas

The patches are in next so I don't see why they wouldn't be sent upstream.

Moving Luiz and Marcel to To: to make sure they see this message.

Bart
