Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF431CA46
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927389; cv=pass; b=ZMIlUnwUvhRP4VUxGi7Ui5q7UizIh29XZjYuzeOIdgmyi/4vjx7ZGOwTPgvAtn6irB/s2izFJYSQ9engvXOBGwoHzcoSFLhzGxvnx3TC9xt5blVWworfTQFaopG0f/4cKRKk63wtAcbf6IufbmwReKR74WEplg+4OFZYQFbFow4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927389; c=relaxed/simple;
	bh=MF0cNsS+gzrfYqEgUa3sor2vlHPatL9VBSV5dHcd4dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1mjqLijtDKiYn/9TstJelsylFKxxx3+r2zvzunEns/yudqP9qFXk/dH8DwKSs7CqEEe4dt6aApnOGtOix3sgx5rfbpMjZ5r9Im9hTy7j9CQNSSAQB2GXL5vBauQB/7evdaNNUya618DyqMcQTKNCB5FSifumpmR6DteLU15vdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJDQEAXU; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJDQEAXU"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c7a6de470so3594715b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927384; cv=none;
        d=google.com; s=arc-20240605;
        b=ekYxSAlRqAOauEmZ7IGSFXuHUfwTLG7oetm7Gh3GP9rEPYWEj660pSh9YVtzNFExbv
         m+3AQgiPVEytKN1XeCTkV4JyGXfj53hcveolQP/REVol4tRQX4GfLTmiS45vj2+DjlWI
         LyS+TzEjKyrWICqGt49T6h+imSdk92OBzAssxNKnak09513igRyhcnjIDKbcmePSgMDF
         TG+W7wKKYZB0jffFFM+TvNz8TokCkw+1Y2JFOPYJz9b3/4AxZIBjE2jU2HU8Jcrh0bnW
         v0AactcFQ+Qz4EGIOyeTgAIohRkx1Kx9Fd3U0PXZcNeqofhtwoCuf1ohpMslZ519AC8m
         g4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjcisqMtxfQTUPupNdBM8mkTWYPmCOSYsbTZEciRKW4=;
        fh=hHqcfPOe4n/baipRxqfNrJpYAO/jua5fe/M55FsZIkE=;
        b=U7bx6fziCgj8mom87GQgMIzHFCg0StAjKN+B2hbwLI+W3BZkzy1XoB8BtMaDPYT0IU
         VrYTv29JlOmjrbhB37s2enLiSrZsVCYyxv4QfyK6Y/hCXQW9sOOlXFvwNlKCo+YhA5m0
         BBH212hhWKdolyBgY9QRoWeMXyHANbgsjoDghqdLtaPKgbCsL5YOpbdp51kGqDLT1C/X
         oTUzPG58gFCIPywo1cLVkZQH5i9UiUsvwzD5vktVt/AWTxBhLlGv8reVqCuxS7wuSWN5
         bvpVlZ+ibknj6CZpQs/poKncQtGfwSCH6axtk0+7nHQpoQp9V4eYWKlmQ5kxJFRHFZa8
         qfRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768927384; x=1769532184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjcisqMtxfQTUPupNdBM8mkTWYPmCOSYsbTZEciRKW4=;
        b=cJDQEAXUB39NwBtr1BWRvEm/irtBY96f5bsjmLifnhr/+6LfOsT67q8I8uu+0v0Nu5
         755FJNk1t2DC0fvq78ROmhPJGhXUubeyzwdtLZHGeJWo0V0jk2oZig1t6gM8AEKykgee
         2KcXJSTPb5w8MM7+jRzefuZGiN58x1aHPzT1JwZnzagv8BrdFzy8YpdZh+v3e6JBCbr6
         Rx98lVGi2uSTz9Y57pmmcUi1FsGmJIHB7UlJwFya5DdfgTurWy2TEtIJgOU2qVJqWHKy
         xa+hFsPVT+VS1QiSlqaNZIf9Ko+swV0XEs2dk44Kyg1x7oNHrcN67yf0Hh80+fnm96D6
         vUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927384; x=1769532184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjcisqMtxfQTUPupNdBM8mkTWYPmCOSYsbTZEciRKW4=;
        b=n/Nftm+8bHl08GmNg5fXOxEfKal9pIyAzJV8l/fkRtg820GwSZv7nEP/C6Ms4xflDM
         jAsncogPR0lhnQu4SCODz5wR6IYvEe8TkMO5aXp0PN/eijPLdVcWvprjwrhMENXfoACN
         dyvsN5AAzyGgLKPEvezOKw+UoEubCxxPqCZ2LiN7HgkEk7hAezS+ql+Uzb2kT5eyBGnx
         qgGYvPOh4b7DFUrBzb2OYmUQwR1JnZPDRlq/5ogzOMawP8aGMVFZHQODbzpAgpplLjl8
         6QMN6fc4J8VMX2AWI7BvnPB2dH9/69AMGhNWSmSs8Blmp0N7/DBufPVcG8GWSULA3B3j
         vQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCVMRlkGJnulDYeK2YQzX/eNSywbRDSe2jYkEBM4YfR7BcqfBtm50dCmV7ScOvUErAlCyjd4BawjMq9tZKNtzsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMBhuIbqTySG0AtBte7kBsgpxD05xNqlAAEBHDNFAE3xUy0wN
	ukv9p0ragbJqZ6YzodLQLvkiMralKop8MMB76ltA0EbQSZTSh2ZzkgvYtn75D4B/jTZ/2y78auh
	EJh9Xk9ADuM3YgKfjRVOF9YEb2CBGFLQ=
X-Gm-Gg: AY/fxX7eRI7ZA7niel/KPTyYMh9Ne2VFT4w2JrclWdyoddd9jAMMbZM2fUti4OvRuv4
	QfEalMAY6j4NQWMuVvWQ3yywS2yktiY4nirRQv5fkUnLBvk9Uehza6pj5XgKlJKHRdFKJbnUss7
	hbQSz5BGnDwhvpAwc9TVN0E9EQcU1mjK+8RhBq/olAk6Ez3X1Iowb5f1yV6bBiksB/ftZH1mJLx
	qT9Lj4M7r9eI9XhcgM567YgGLYnE1nuJyAM8ekvJEltvQHj8jAhpNMxtacE6cfau6r96+EyzClI
	Tf3J6mSCXDWhQc9u2qj7PWp85VWI78Qpd0YKx9b6cJyFQMhckRC8TAqlgw==
X-Received: by 2002:a05:6820:4812:b0:661:1d0c:a5ba with SMTP id
 006d021491bc7-662b01131a7mr653831eaf.71.1768927384405; Tue, 20 Jan 2026
 08:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125803.598552-3-hadess@hadess.net> <202601170322.MZrwlt6M-lkp@intel.com>
 <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <7a5b73b4c56d0bfb8742045a3f530cd3d2d25b53.camel@hadess.net>
In-Reply-To: <7a5b73b4c56d0bfb8742045a3f530cd3d2d25b53.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Jan 2026 11:42:52 -0500
X-Gm-Features: AZwV_QiPC4YlQdDaYc5DJUCQV5xCCx6PzG6kPPubb0H6MzwjCJ9ZmrmihyWFkOg
Message-ID: <CABBYNZL6hAxsnBt=HStvhnZmoTfagzGuJ0sGeqiqhXdpm0DZOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
To: Bastien Nocera <hadess@hadess.net>
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, kernel test robot <lkp@intel.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Jan 19, 2026 at 4:13=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Mon, 2026-01-19 at 07:53 +0000, Neeraj Sanjay Kale wrote:
> > Hi Bastien,
> >
> > Thank you for your patch.
> >
> > Just an FYI, the " #ifdef CONFIG_PM_SLEEP" was added on purpose to
> > resolve such build warning reported by kernel test bot:
> > https://lore.kernel.org/all/20240710123426.935122-1-neeraj.sanjaykale@n=
xp.com/
>
> I didn't see those warnings locally. They should be fixed by using
> __maybe_unused instead otherwise the "it extends the code coverage"
> justification wouldn't really apply anymore.

Yes, I think we should mark the functions that are conditional with
__maybe_unused, actually this might be the case with
btusb_resume/btusb_suspend as well, right?

>
> Cheers
>
> >
> > Thanks,
> > Neeraj
> >
> > > Hi Bastien,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on bluetooth/master] [also build test
> > > WARNING on
> > > linus/master v6.19-rc5] [cannot apply to bluetooth-next/master
> > > next-
> > > 20260116] [If your patch is applied to the wrong git tree, kindly
> > > drop us a
> > > note.
> > > And when submitting patch, we suggest to use '--base' as documented
> > > in
> > > https://git-/
> > > scm.com%2Fdocs%2Fgit-format-
> > > patch%23_base_tree_information&data=3D05%7C02%7Cneeraj.sanjaykale%40n
> > > xp.com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92
> > > cd99c5c301635%7C0%7C0%7C639041898935601715%7CUnknown%7CTWFp
> > > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> > > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DW4jhk2S
> > > VUr77jirvKdK%2FrKuKAVyXSbY9iO2pQ1%2BL7Fs%3D&reserved=3D0]
> > >
> > > url:
> > > https://github/.
> > > com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FBastien-Nocera%2FBluetooth-
> > > btmtksdio-Simplify-dev_pm_ops-usage%2F20260116-
> > > 210400&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a754
> > > 0774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C639041898935632879%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> > > kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUI
> > > j
> > > oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dl2nEr61x%2F00NrtEqmvX2qhJ%2F0d
> > > %2Fc6T%2BI6e5YRiz1TAM%3D&reserved=3D0
> > > base:
> > > https://git.kern/
> > > el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbluetooth%2Fbluetooth.g
> > > i
> > > t&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> > > da08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > > 9041898935651605%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> > > dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> > > 3
> > > D%3D%7C0%7C%7C%7C&sdata=3D%2BKZxHj6EXqJXKC8%2FsiYrPOJczts%2BMEX
> > > ycXixKcxUcf8%3D&reserved=3D0 master
> > > patch link:
> > > https://lore.ke/
> > > rnel.org%2Fr%2F20260116125803.598552-3-
> > > hadess%2540hadess.net&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%
> > > 7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c3
> > > 01635%7C0%7C0%7C639041898935668808%7CUnknown%7CTWFpbGZsb3d8
> > > eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> > > oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Da3gomBec5GENv5B
> > > RsBv%2Butzd11I3QunXE2yAaDg5f4Q%3D&reserved=3D0
> > > patch subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded
> > > CONFIG_PM ifdef
> > > config: x86_64-randconfig-002-20260116
> > > (https://downl/
> > > oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > > lkp%40intel.com%2Fconfig&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> > > %7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c
> > > 301635%7C0%7C0%7C639041898935685518%7CUnknown%7CTWFpbGZsb3d
> > > 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> > > joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhR230cwqc4FucDn
> > > 9TPmv79VLdAd8kHHwc2Q8SdPtHtk%3D&reserved=3D0)
> > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0 reproduce (this is a W=3D1
> > > build):
> > > (https://downl/
> > > oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > > lkp%40intel.com%2Freproduce&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.
> > > com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd9
> > > 9c5c301635%7C0%7C0%7C639041898935702245%7CUnknown%7CTWFpbGZ
> > > sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> > > IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdsZA9O8KQy
> > > QZJK2Fn%2FYtexA8zdrw%2FCcpwnEb7AwhiqU%3D&reserved=3D0)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a
> > > new version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore/
> > > > .kernel.org%2Foe-kbuild-all%2F202601170322.MZrwlt6M-
> > > lkp%40intel.com%2F
> > > >
> > > &data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> > > da08de
> > > >
> > > 5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63904189
> > > 89357202
> > > >
> > > 33%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> > > uMDAwMCI
> > > >
> > > sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> > > ata=3D2
> > > > s046Nm4SrgCfY%2BqPyoYr8tf5xqoBw%2BqDiJ0YQ%2BiAt8%3D&reserved=3D0
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > > > drivers/bluetooth/btnxpuart.c:1964:12: warning:
> > > > > 'nxp_serdev_resume'
> > > > > defined but not used [-Wunused-function]
> > >     1964 | static int nxp_serdev_resume(struct device *dev)
> > >          |            ^~~~~~~~~~~~~~~~~
> > > > > drivers/bluetooth/btnxpuart.c:1950:12: warning:
> > > > > 'nxp_serdev_suspend'
> > > > > defined but not used [-Wunused-function]
> > >     1950 | static int nxp_serdev_suspend(struct device *dev)
> > >          |            ^~~~~~~~~~~~~~~~~~
> > >
> > >
> > > vim +/nxp_serdev_resume +1964 drivers/bluetooth/btnxpuart.c
> > >
> > > 689ca16e5232784 Neeraj Sanjay Kale 2023-03-16  1949
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1950  static int
> > > nxp_serdev_suspend(struct device *dev)
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1951  {
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1952     struct
> > > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1953     struct
> > > ps_data
> > > *psdata =3D &nxpdev->psdata;
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1954
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1955
> > > ps_control(psdata-
> > > > hdev, PS_STATE_SLEEP);
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1956
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1957     if (psdata-
> > > > wakeup_source) {
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1958
> > > enable_irq_wake(psdata->irq_handler);
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1959
> > > enable_irq(psdata->irq_handler);
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1960     }
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1961     return 0;
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1962  }
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1963
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1964  static int
> > > nxp_serdev_resume(struct device *dev)
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1965  {
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1966     struct
> > > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1967     struct
> > > ps_data
> > > *psdata =3D &nxpdev->psdata;
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1968
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1969     if (psdata-
> > > > wakeup_source) {
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1970
> > > disable_irq(psdata->irq_handler);
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1971
> > > disable_irq_wake(psdata->irq_handler);
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1972     }
> > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1973
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1974
> > > ps_control(psdata-
> > > > hdev, PS_STATE_AWAKE);
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1975     return 0;
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1976  }
> > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1977
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github/.
> > > com%2Fintel%2Flkp-
> > > tests%2Fwiki&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f321914
> > > 6a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> > > %7C0%7C639041898935740752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> > > U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> > > sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIqE%2B%2BS2ZXcZb5PFvsvemp
> > > dQffNOiktBLNpxdDx5JJJg%3D&reserved=3D0
> >
>


--=20
Luiz Augusto von Dentz
