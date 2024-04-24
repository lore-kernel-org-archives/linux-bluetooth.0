Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932615FA76
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970362; cv=none; b=j3WaqCsHRaxaa9P2cZMXeyZToEZ+Lfwzma5N1icrZlhmUWG9iFUuMC+wptcAwkig/sXXJhMX2FGrJ7S2bNkwMis2msPk6nuLGwCETCZaWPm9vxWwBR2pqqkA2BQUjOoHMX6L+tFbU/Gjlp6lxkbfqbGQRYUWdnajjHKa72wla7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970362; c=relaxed/simple;
	bh=wk6urfGs/M3O3sb5eJszZmntrwsXFmVqzMNu2d4frow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhnjxGI/BiOqReO1bNQXQnYQQYX/EGgBdNaGn2mY9cmGXvNhhwc60Dr0YkgBPreJI+rNk9PEqeEXyoGyWuQDvc9q+w/RUtooODXpPGfy5PkITvuOKup4yI+SqJRq9mLG1LaqHV3tLCQ1soyHC20LAbOYpGXO3bC5Iv5oZEknqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCASQPkm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCASQPkm"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61acfd3fd3fso75405117b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713970359; x=1714575159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLcB2GhY/+cPlasvhbE7nJ47bQSzEHeObUtBifAPvFU=;
        b=pCASQPkm1bBYKvdWkYGwGZ9ti6KMfSZsLE0eNsON6NsrdMYXBF4Gdu/IrP+3FFfwOV
         U6f6sT56bVig5Kyaa/COCsDX0xgBEKl3nK1yxI3yAgMMf8t1OM/y7lkx/o6PeYjRYbR+
         OJmn9iyFNBEfeLfeFACiO9gORGvgCa1K2zjDnegT60kgQBSTsBZc58So4hrjttRoggz9
         AO6YuI4sRXVem/0bAfapjjOsMfUI4BViZV2miRiapNLj6+LhwRGC/Jc9gejQphSy0f02
         gIVwBowf8W8xRJMraBpRiPsumJ6o/oF17W8aMY/gPjAGy7ZO3vI+UDSZW2lDvXwpExwE
         4gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970359; x=1714575159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLcB2GhY/+cPlasvhbE7nJ47bQSzEHeObUtBifAPvFU=;
        b=F+NPxD5YOd7IxsQ80TeFR4Gxkh4nAU0qlnElh9OU/ZPA9ybUUhOKGJg7h0wye+MRQp
         VxONFIZHtD/6bm5T39R9HsWWin62cSsE1JoFtOXkTPne7ipbmD8NqHnwlyCu9VeeJNDq
         byH5ydrx4o3v5tGfvZEfUvs9rEeRZ1UUc2ZOkvaZa+OIyLUm71y16k85aUR7oJHXNwUo
         1DUW9LmQVs0eeJQqzcMQwiIomMd8Kgv98UmKtaQcm7xA/n4fCqYZAUxpqpc4zFWJe/b8
         QVTJqplKver+kxt//RhAz3a4l3S032pQi3rihooe8IScnHA+LYKnNo0uMUlKyvFHVNft
         Fuaw==
X-Forwarded-Encrypted: i=1; AJvYcCXygQU2PP/layf0yk/0SQQYU8ZjHGvlXskB17NPlpIUylhzxe0Ex7rlYzQEKmRbmu+oQx7B2x637bNCHizeWThpOWXLOXdE77204d3/kt6G
X-Gm-Message-State: AOJu0YytchofvrOycFGAbuxcvAlapAx+vuEjUYTFhfezBCrp23x3NLBg
	NXzNCFMWpyi99tqvJfBle7eviST+HUPYdI+Vow+R1SGG2sHqScxH0kq4ndaXISHpa0qGSmeScOM
	yFrGnXqNC4ptu7Iviv20enoW417HEXnMzoNrG1g==
X-Google-Smtp-Source: AGHT+IH54wRIUrZM6RC8JRJT0ltlwP+DKNmbmB5RqBiF5ARNVrbx7ouSNK2r3YIofnkI0L1dAtgGzNJSIgy36VVWSF4=
X-Received: by 2002:a25:adc6:0:b0:de4:7831:919 with SMTP id
 d6-20020a25adc6000000b00de478310919mr2699369ybe.38.1713970359182; Wed, 24 Apr
 2024 07:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
In-Reply-To: <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 16:52:28 +0200
Message-ID: <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wren Turkal <wt@penguintechs.org>, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
>
> >               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
> >               if (IS_ERR(qcadev->susclk)) {
> > @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> >                                              GPIOD_OUT_LOW);
> >               if (IS_ERR(qcadev->bt_en)) {
> > -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> > -                     power_ctrl_enabled = false;
> > +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> > +                     return PTR_ERR(qcadev->bt_en);
> >               }
> >
> > +             if (!qcadev->bt_en)
> > +                     power_ctrl_enabled = false;
>
> This looks duplicated - you already have such check earlier.
>

It's under a different switch case!

Bartosz
