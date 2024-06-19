Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0517C91
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782549; cv=none; b=YpBx7tyyfsVkc8uEowc9kVxBV1LmQ26njQkfa+QeQWHXSYL+2vh3sc06xgvAJQC05iAyHPH4qY6OuAIOfQe6UwqIDRqFZ1L/w48g3PoDw6scfBvNWb3RYWt24vOs5vkkoVbCeVdWUvcHyUq+JlVO+jAxv88sB/r6SwtDfOEzCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782549; c=relaxed/simple;
	bh=+S5Uv3HO+4mevHlHKh5Y+xeuc2VhQf6TXsTM9rXh0js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjAZc+VnUEARBv94qRiJuxnMHBAmvv9PHqfCbpTYFqxGLX6nlAestAqOJWa8vru2BV07SEpofZaM5vDdfuaBHIdF5tC0/hUvA1uCC0VrHdy7sL9k+0z622IDeE8u21SBbQ+tSVBTjCjrlI86LKQo/xI81bLtwyTvgGPXcJ9GC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MxEF1spK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MxEF1spK"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc0a9cea4so541730e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718782545; x=1719387345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAirk0f0PKTwzOziyA/BSlPSIpqsEtALcS+cg2LXns8=;
        b=MxEF1spKn7wqLKraUNzIKIXdzjGCH44lcL/5kKGAm723HiZD45aIY43SFf+bi1WtDn
         TqnVv4YeVPBMM3mq2TMhK7p8J7Ci749uGax12nigJ1wjv9YTC065zxoFYC+Ql+zGJmxk
         xCYJISE7lBRSzrrwomhJRt7ghW9Kyjmp5O4N8kQAtoe1GQlQ3iShfYR1zRhw7eoFtpBP
         208OywI7jS1WdEU3Ttyd5Qvlm65djZTIX76XqRFezX3//r7ZyhpD6zIMeB0An4uvs1Al
         iuFj8lV75NgJQ564yEU6uuvlwtR1WDWdG4QqmexokdF3qShGfy7+4WeKL54d+KDKh298
         HFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782545; x=1719387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAirk0f0PKTwzOziyA/BSlPSIpqsEtALcS+cg2LXns8=;
        b=E/hi66m4chW70d6gvPvFRqRb5wgtvsBXBTkv8s89RTlFop/sagOIkSrrTwdVP+W+f9
         SJs/pEiXGllqHU95/gaq9Vu9vAjwBjvGM/9aEfiFm41dlFTGyMSbDsIHRRg4OMF21o0g
         unfY1bN9/jiW9sLveqyaHn8aoD/EtcgwCieIXTgxryijHm622uUq3ppyuRg9UMqbTkZo
         grX/2u5G5PZn2ROnTyl9QRDN5ai2OOxYx7/GBHJY81f9b6KYRRDMrDnPPsdytcN+hF84
         EOFbDB/0ZX/ZR4TlowoqODy6wLianh/mlOqb7EYAlDNaqFBweR7yt0kbbBDKsXSADq3x
         /RVA==
X-Forwarded-Encrypted: i=1; AJvYcCWM9Q/WdX4xmQE+SUHCUOZthwkW0WCRMeU5bjJ1LNwauC1/+o9jW3Ka60KB2EGobeBDOj1uwjioWlgvPTql7Pku+ZtNG9ginCfsNd95adoy
X-Gm-Message-State: AOJu0YxiRC+2oRHmg3mfYchpgl0OsOekIvvxQt5jqvIKN1ArqzVeWWhn
	TKYx8AGsKtnS+8EURxhtZ/tWwL1bbBnviBJhP3ueqPCBt8dEZeivtYCyOP/4r5fGF485rmRN33X
	3TfBk1thxJ91CZoPVG/Q8kzanRjauPKBqHeEVgw==
X-Google-Smtp-Source: AGHT+IFSnKagBTz38/KAjI8t4GnDrMsPoKM/8j0e3wn2GQsI00XKi7Y1hebzFZ6x66wwp3aNl7M+IXmjhb/C18jBEp4=
X-Received: by 2002:a05:6512:3b89:b0:52c:80e6:60c7 with SMTP id
 2adb3069b0e04-52cca1bfa80mr623875e87.13.1718782544654; Wed, 19 Jun 2024
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
 <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com> <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
In-Reply-To: <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Jun 2024 09:35:33 +0200
Message-ID: <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Bartosz,
> > > >
> > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > > >
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Hi Marcel, Luiz,
> > > > >
> > > > > Please pull the following power sequencing changes into the Bluet=
ooth tree
> > > > > before applying the hci_qca patches I sent separately.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA76726=
1@bhelgaas/T/
> > > > >
> > > > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6c735=
6688ffa670:
> > > > >
> > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git ta=
gs/pwrseq-initial-for-v6.11
> > > > >
> > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f4286=
9128dd:
> > > > >
> > > > >   power: pwrseq: add a driver for the PMU module on the QCom WCN =
chipsets (2024-06-12 09:20:13 +0200)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Initial implementation of the power sequencing subsystem for linu=
x v6.11
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Bartosz Golaszewski (2):
> > > > >       power: sequencing: implement the pwrseq core
> > > > >       power: pwrseq: add a driver for the PMU module on the QCom =
WCN chipsets
> > > >
> > > > Is this intended to go via bluetooth-next or it is just because it =
is
> > > > a dependency of another set? You could perhaps send another set
> > > > including these changes to avoid having CI failing to compile.
> > > >
> > >
> > > No, the pwrseq stuff is intended to go through its own pwrseq tree
> > > hence the PR. We cannot have these commits in next twice.
> >
> > Not following you here, why can't we have these commits on different
> > next trees? If that is the case how can we apply the bluetooth
> > specific ones without causing build regressions?
> >
>
> We can't have the same commits twice with different hashes in next
> because Stephen Rothwell will yell at us both.
>
> Just pull the tag I provided and then apply the Bluetooth specific
> changes I sent on top of it. When sending to Linus Torvalds/David
> Miller (not sure how your tree gets upstream) mention that you pulled
> in the pwrseq changes in your PR cover letter.
>
> Bart

Gentle ping.

Bart
