Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032A16D332
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475857; cv=none; b=aC1OAv5cRRHHeldBy+foRgF5j16v/jmF3r4JRNm4sWBwtuvUHx+FKYczrQWJPA4SxS6xI+bNZky6W5lWZnfz+U+UohFezjje+a12YmxpP2vcL+4jrN02lPWD3y7YsN69WdJexf0PbRqpAq3/rVKZxDN2l8JIiXMf1+KHHpXfUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475857; c=relaxed/simple;
	bh=lGbUKA451O4fA8Tr7piXdJvOheNb+7vmJJ/lU50sTmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5XuH01+AFP4GER1TxSrfl1kDmRFbFebJixmKN9ICZlUWt9Dsyt+Es9o/NwbhPc0YIrhM4hPHhqMjEw7zbeVDQlmjUm1ByisLcg7BeU8dMA80HsdyL62Blh8fR0Zdomxx/A2OvX8D9DJwSIwf6kwKV75x70DM64pecoVABSu/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFt2jXRG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFt2jXRG"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f16767830dso44787181fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475854; x=1724080654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGbUKA451O4fA8Tr7piXdJvOheNb+7vmJJ/lU50sTmU=;
        b=XFt2jXRGksobvV9JsT+vj7LYfsQrljiG9i+RX0oAMfs77XXfMb5LvVNKudCc16RxDe
         v+GxP2kerm7Cm4D6nGkQ9hVXzIDMI8TfSmmioR0zsMFeSKLpYoA6Wxkk8CfbS3gVzlFN
         IEPRNdIt2Xo7/N2tM77EsgBqG5Vog/tcUbn27rUbrMQjMNkgQmsb64s5Ch1vpgtZXXC3
         9O0dkThJnMbD+/v6QXtHtN027ZJF9Ez4Ow1QglZMguWD1VrRjuq+UttxacSzzCUxnaXT
         jiHB3wDEZX6JMVM3rLSTcyBNj4E4j8xPQ+MVkv+90BRz4th5a4TMF4DaPayXqKTL7+U0
         cLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475854; x=1724080654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGbUKA451O4fA8Tr7piXdJvOheNb+7vmJJ/lU50sTmU=;
        b=n3aKsPwRvJWpbBbrmV35Bo8NcvIzW5efRwkHz5dxFAOS3YeBoUi4klf0bnDxNAzto8
         nEbyCGKyupSGi3kNWuauoAZkiXvx3M1MUy4XkblNZDIGp2GYTBO7dzizmuOmqW8gm12i
         la2vH753AvT/OYpxbdUOhTwtxSvcLCyGCDR++dVSc2AQP6lUnOUPGJ75i2oP7IMj1dfd
         LwLqQeeP6EGbCFeKRMcHIym4FgBEWnneDP9MoT+D9I48aGbUwFQxs5+btwl0H+BxBrfU
         NicFggKPj288lu/sXk0/ZBQwYLrwALt0yKOCMSVAQmcajzEf4/8NiCBRZg2o/EIttRUt
         /IxA==
X-Forwarded-Encrypted: i=1; AJvYcCWsKKKndW/zHrvNsUqMhkBtYvklROI/WXIsi3OhAt1a1I1LXk9arTPxaaPTtJkttDvbzJESsN0zyZdHgguYlKUhOZJaWQCDJzF0Z4mtb0lJ
X-Gm-Message-State: AOJu0YzbD6HOEJn+W4xk2wfePpI8WpXrWGNTqtQu7t6oPIJSdN+pJY8S
	Wt0Gf1BObrMxkDQnmFyQY2F0Yacs9jYHbFRYJYxLHMXZh0ovPgW4PHTTFKIIZHpRF/Fm+6uBjlY
	8OZB+n2R08Hd6NFl4wzCy+nGvxpE=
X-Google-Smtp-Source: AGHT+IFhtanjPRuKvqXr8ekRv6FwL2VGZAhKKojqmRRdnEy4wcYWgHGCoBhVcHGgh8BFD7Hx0CPlA3EOE5fRaVABpJ0=
X-Received: by 2002:a2e:b8ca:0:b0:2f0:3cff:30ce with SMTP id
 38308e7fff4ca-2f2b70d4ba6mr5258331fa.0.1723475853845; Mon, 12 Aug 2024
 08:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425163120.1059724-1-raul.cheleguini@gmail.com> <20240811210505.3089013-1-uhrmar@gmail.com>
In-Reply-To: <20240811210505.3089013-1-uhrmar@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Aug 2024 11:17:20 -0400
Message-ID: <CABBYNZJgf0HobQqRR8orizGM-adToJaU20_NXfC-+jrc1efyxA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add new quirk for broken extended create
 connection for ATS2851
To: Markus Uhr <uhrmar@gmail.com>
Cc: raul.cheleguini@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Sun, Aug 11, 2024 at 5:05=E2=80=AFPM Markus Uhr <uhrmar@gmail.com> wrote=
:
>
> On Tue, 25 Apr 2023 13:31:20 -0300
> Raul Cheleguini <raul.cheleguini@gmail.com> wrote:
>
> > The controller based on ATS2851 advertises support for the "LE
> > Extended Create Connection" command, but it does not actually
> > implement it. This issue is blocking the pairing process from
> > beginning.
> >
> > To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
> > This will avoid the unsupported command and instead send a regular "LE
> > Create Connection" command.
>
> I'm interested in getting this patch merged. Was this just forgotten, or
> is there still work to be done before it can be merged?

It might need to be resend since it is no longer listed in patchwork.

> Best regards,
> Markus Uhr



--=20
Luiz Augusto von Dentz
