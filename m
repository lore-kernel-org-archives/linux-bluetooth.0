Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83A161322
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972625; cv=none; b=lQ+xL247CJFEwnBZxH3F41yMmmXZcUPUm8rEmExkSODfvPVS4GRMWgMHFglYnvK5HTWFLCucrgpolvtoChEBvIb27wKNsyD1+wCw2cjTzZK35YfhO4Iht97QrhWe+9jBAe2iiwDGiG9UyMNNp/NJvY5Gq/0RWD9IuxBc82gH/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972625; c=relaxed/simple;
	bh=WrxU+iK2u+Wu8wwi+GibzMLwpaSndL/Suh4PRa2Redw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFFaYGB4oeTjN+1eGpu84xobl32IcqgpLnZqnzsbqEOV21o5/ksra/vAFOApzegu13DrdcxUBZGTBc2gFKwUF9NteSHdUne1nJ/TzZBr58Pr78+Ss8/he9BLltrq35hYDecVG4KPGcZibiIlcs+K4RZD6XEQW0zAO82I/Af/y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a8qYTfmX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a8qYTfmX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2de232989aaso23061961fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713972621; x=1714577421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN0hHEeupGSSgCE7fWY20jL26gsYlFQ3vjjtg0lU+j8=;
        b=a8qYTfmXzFdX9chUZKS0GFutyxQUkwaOQe6UtpXzDk6CDXoDnOJ10Ao5XsA15vL8UE
         JLD2oSv3RkajURDTH6HrMNZPgRIgScZaLyW/4rKMAlIVESjMDJEwEJnb6EUX/c3x4J2W
         eQYqRBmKgC9yZuwhH+EpqU9jNp7G3T7odjIs63yNmtJE+pICNvzScGNR72qbcwiAnWIO
         Uf9JPkYlQmpbNNVshUxP3GqHfaTRIQei5FabfbNqStblqfrLb8AtyZIfTQUCH9HyyMC3
         qCODIre+yssNeKv1mY+LbsvYV11bHg7ExEtATNtEMd74T5uW2vGcPdzys0wv5rPB4nDG
         jvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972621; x=1714577421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN0hHEeupGSSgCE7fWY20jL26gsYlFQ3vjjtg0lU+j8=;
        b=vauWY1qPgFn3znxKSIH5JOSzqTEZKFqFyCctwJTf6Dw8yz5n1rP2bFOu8zkY+TdAlo
         +AZcwjH4ngRliZPBIWph1deJv+wMbfTuE15W5WOI0Nz417jKW2NXjORl5DxaEaR/bOL4
         kXK3EeZJsd9EmjVIzEAs/vqW6MpKyl106xCFKV4XJyTQsD6WYbfKGpReK5m/F5Qxv5EH
         nh4p/yA2qjRnuQmQ4Wu5yYoVGiUJMtcLrZ+1RA/Bguy3KTIDPGdqsEhFP4DKvYhKpGaq
         dOPvhkVqXh5ircehSemb4tKbquj1ktCxzfP9o+ulij7imhSAH3E33SeS0bhQjDwOZj3F
         z3TA==
X-Forwarded-Encrypted: i=1; AJvYcCWvBU7/GNaI8aOTovorSXiDufLsvZCM87HRaolNyX5C19iRB9/e8IWLYGyvGj5r65ng0veSjQkltn5Pdrs1rDJ55o7yhTzbnq9DqIWJMS6z
X-Gm-Message-State: AOJu0Yxq/wo3C/35R5Gy3VOIzgmGkbWua+jIEtC7BI4NCf2Z5n635UGq
	B44oHM0WKmxPha2y5z6q5TkC1QR687ino2Hx4/HiighHWfA+KxNkSer+N1ApukO6ZT9v6ZAXKAn
	PlhBHS/yoC10EfL9UnZslqSIAP9BOMYC+0cePeg==
X-Google-Smtp-Source: AGHT+IGn7KAqu+nR5bhFS2Z9m9gErGRNbgsG77V5JtQm/T9HJ5ODX/t/kTmqfxILFhpnt0Rc/sZLPz6eLDRVfdL0fe8=
X-Received: by 2002:a05:6512:287:b0:516:cd83:a96a with SMTP id
 j7-20020a056512028700b00516cd83a96amr2069705lfp.37.1713972621326; Wed, 24 Apr
 2024 08:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com> <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
In-Reply-To: <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 17:30:10 +0200
Message-ID: <CAMRc=Md6yJ+ZMd7PD6ifQW4me1JLg3m6ZiVAMvbo9QaOH_jmaQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, quic_zijuhu <quic_zijuhu@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wren Turkal <wt@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:24=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicinc.co=
m> wrote:
>
> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
> > On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>
> >>>               qcadev->susclk =3D devm_clk_get_optional(&serdev->dev, =
NULL);
> >>>               if (IS_ERR(qcadev->susclk)) {
> >>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_dev=
ice *serdev)
> >>>               qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev,=
 "enable",
> >>>                                              GPIOD_OUT_LOW);
> >>>               if (IS_ERR(qcadev->bt_en)) {
> >>> -                     dev_warn(&serdev->dev, "failed to acquire enabl=
e gpio\n");
> >>> -                     power_ctrl_enabled =3D false;
> >>> +                     dev_err(&serdev->dev, "failed to acquire enable=
 gpio\n");
> >>> +                     return PTR_ERR(qcadev->bt_en);
> please think about for QCA2066. if it is returned from here.  BT will
> not working at all.  if you don't return here. i will be working fine
> for every BT functionality.
> NAK again by me.
>

Luiz,

This in turn is an example of Zijun making a claim that looks like a
legitimate review but is simply untrue. He's done it several times.
I'm afraid that it may affect your judgment due to the confidence the
claims are made with. As Krzysztof said multiple times: the
device-tree bindings for QCA2066 are very clear: the enable-gpios
property is *required* and so returning an error on failure here is
correct. Even changing gpiod_get_optional() to just gpiod_get() would
be in line with what the contract in the binding document says. Even
if we relaxed the bindings, returning here stil *IS CORRECT* as if the
enable-gpios is not defined, GPIOLIB will return NULL and we will NOT
return.

Bartosz

> >>>               }
> >>>
> >>> +             if (!qcadev->bt_en)
> >>> +                     power_ctrl_enabled =3D false;
> >>
> >> This looks duplicated - you already have such check earlier.
> >>
> >
> > It's under a different switch case!
> >
> > Bartosz
>
