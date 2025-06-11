Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE317B506
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653170; cv=none; b=rkq9kH8lsJZ3xN3Zw6S11vhLQz5NAtQ/qpVa/K8MjqWnxYla5HT30u+29sDp7YXYJjYGRS7OZzSBTgV4UhRwtWoHIxbN07k4QviMHyq+zuYxYw6GCSEZ8Wp4BYdUodq4fp1EbCZRLF8BdzHXJPb1POXS/syRf7fuctV/WIi7qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653170; c=relaxed/simple;
	bh=i31pg05KyoXO2ePcsZTYj+VBvzqxZxmZKVey9dXyud0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgO0xzFMRzAry0xA/2wiQq4yHZdp17ol6Zvk9/GXAisw41eq1bB6GcUknmM4E2Y1IhLaotfmhLMJFawrut+THPMPWGzEhmUCk3BWenPYbm2tr1rBUTDcNotlTRTWMJp/ZQ4LXsrTTI41Z0IsW1CQCesvDk6yg4FeIkP1iiLkBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5bUDiIb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5bUDiIb"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32a5eb73ad4so55289311fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749653167; x=1750257967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOkBH/j3Z/soBt9RN/t5N+mS7KjNlH1maUYoOcngT5w=;
        b=N5bUDiIbXZjhPDxzuDDKrSm0GOBG4r28NFKP27Ld7YnvJ8DV3C8iiTxZgR7fW9mKUa
         QIrtFR2G+xmd/Z1A7VaT21GS3/3epHmM+/KO9y8yYNMGqFgAHEXqsW59CkaXCU+Hw6Dm
         XJ32DxKDWWSXwVGasV6gdCatfSqyJNi5Vj76xsL1WV0XHb3NaNolOQv6d9ivteelHk4J
         N2i2+HLPFILIGmaNAnOi+J5XtZXiDHZ0Tt6K9+TfFr2CwnMX8hNxR6AN1wANm84blex9
         Exo8frd8dzoaazk/fGAfQ1W68xQA+LgU5LmH0+StcPM0Ocsh3waEcRZ7isKNR+II6R1h
         uPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653167; x=1750257967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOkBH/j3Z/soBt9RN/t5N+mS7KjNlH1maUYoOcngT5w=;
        b=dDku9DRxU1BCp+8p+Ly4GMv0f0bxzC2TOTVDgDyIlV+plBDr+LsoZsj/R81Ks5ZuTQ
         DgzqVLSigrPeR4rxFT4TKjqqYSbY72DXT26LAT9t7ww8UeysPStpKmZe3QONIrfOYL2w
         yD22Wuumo4TXkuNno9+frVMfc3RdM8zMhB7sGGVRro0Rt3A6Stfm8RBYFFebCDR+RqrT
         wFoX0uW7wH4kpipYbAJLKqh+rT1oi2GQknKJMjY/HCnL/Xb3ejleYA4B+l94fXEAEWZ7
         EmMAuTN/V7Dr7YBX8fChMmYrV+pM43l5N8Ct32dlEimBxbASKJlgymVRIbb/UxfDfOAW
         ylZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhnmIPO6jNZg64WwDfTGMy8QhHyME3n2wmxKnD+X0h8AjqgERdOb2Ps4180aQZCvzClxwkw8CYzjIgir3FY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZhrb40Yn/WN+lPVsU/dLeHpCxeugmvF7SauH03gxqhuoCyv0
	l7GLf/aaA8N+XJ8AkRxyxNmFPBHaA3RRe8Y6WpdICaTYmex5v1kQllRU+yv08Mk0AZh+7RTsMur
	G0GqJqrQzPfzYWkIuDOFRynqwyoaNieY=
X-Gm-Gg: ASbGncvnaLqWkeD/hb9d3UL1LYu6hSET/fizSDzwXLTBR+OiXlT5jkHJNECs0uLfNId
	mzaNVmGLGq5MUma6+mKmSRwTsS2QrghUOdHl8O6nIb2Phj0UkSeetTqGXaeX5sfPXBy/tC5in20
	+TY1yivoo74SagPnG9AFZS70KviJayZJe93xw5xOmN7Q==
X-Google-Smtp-Source: AGHT+IGwHwrIAHcEbgF0nmerw1UMnqG130HVZpme7ed9VqJKY+8EHPYKJbl8mbQByJtcqBjzBdkunSOYKTYVUMWe+tY=
X-Received: by 2002:a05:651c:50a:b0:32a:6312:bfc2 with SMTP id
 38308e7fff4ca-32b21eb9283mr11325051fa.38.1749653166811; Wed, 11 Jun 2025
 07:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610140038.696091-1-kiran.k@intel.com> <174965282876.3348581.5179310634948609330.git-patchwork-notify@kernel.org>
In-Reply-To: <174965282876.3348581.5179310634948609330.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Jun 2025 10:45:54 -0400
X-Gm-Features: AX0GCFu17OOYn8HMl85b5PNVNQTHPqZnnVH_8hMT_kkG-zJmjbfnaqMPkPIxc4I
Message-ID: <CABBYNZ+S0orMvq+tTZoXKO2D0-1O1pQMpb-TMUr45xrR3uZTHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Fix potential race
 condition in firmware download
To: patchwork-bot+bluetooth@kernel.org
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	chandrashekar.devegowda@intel.com, aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran, Chandru,

On Wed, Jun 11, 2025 at 10:42=E2=80=AFAM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue, 10 Jun 2025 19:30:37 +0530 you wrote:
> > During firmware download, if an error occurs, interrupts must be
> > disabled, synchronized, and re-enabled before retrying the download.
> > This change ensures proper interrupt handling to prevent race
> > conditions.
> >
> > Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.c=
om>
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [v3,1/2] Bluetooth: btintel_pcie: Fix potential race condition in fir=
mware download
>     https://git.kernel.org/bluetooth/bluetooth-next/c/866fd57640ce
>   - [v3,2/2] Bluetooth: btintel_pcie: Support Function level reset
>     https://git.kernel.org/bluetooth/bluetooth-next/c/ba6b287d9f91

Note that I did add the following changes on top:

https://github.com/bluez/bluetooth-next/commit/bd35cd12d915bc410c721ba28afc=
ada16f0ebd16

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
