Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3313D53F
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707072; cv=none; b=NjmcuvzdhILc1x7wRsfkRc5WIHo9BKffQoHqgTRfEshJj4lgF8pG17Ue+zgBjYqmq/uEZhEh1XmwEzGHnJYXJFtnsMX6FzLOISwkwOOyQH7nT2stR9YZR/W0nwZGQ+qG7FBmtqeoxFDMkZuNEOOF34UJcFD/07ONPa3FwujJS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707072; c=relaxed/simple;
	bh=7ijOdi8bOwSWvOkRElKH74u2Ju/z++6QT43+lP3S1Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4diJ4+p84Ro6nD9wJ7PO0x6ceSwVVSL6RxLtEhKxFNso3sfqoFPpS8ij2WtxLEOfATsjZC0D+0026NSiyvw8mejjy4QelPmme0Ri6gv0K+RpnM0883T+wj5OjdR9adCiQE7deMN6k/JYpNbNMh21mQDHtb+ZDUHNaTqF3KfSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM/JCGRO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM/JCGRO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f409c87b07so55904011fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707068; x=1725311868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuYaPXotbGFHhLBr0my5gI2UlBYNR105IVpHjw8DEK0=;
        b=BM/JCGROF0js1ZrEWPi+6KiCoVV7WustjOc45jIvvoxW1sCMT7gUqjMcTeeSxNMx7h
         3PHee+cBH35MLKRoTcye+5oerTScUVnsHpA62Ngkplc/TCQfAyPqokbh+w8EFEaDgvwb
         SUPLte3SACfbvCuMmSU8I5C7r+0/9U4fqyVGNMpYBv3GyVDaY8v+UJFZVzV3xTBCHipb
         UxIy6pUS2dB4l9GicJ1ryOmLQXhtQr7yUy5nChudnjRyHCag92avXUS1DjAxjPFNm3RN
         N9gIjXfrtrZidEdLalv+BE276GKfLZhaJvln+31ukSy7iy7Y3xrj3O0vQAVuUzIGUXJ6
         FNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707068; x=1725311868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuYaPXotbGFHhLBr0my5gI2UlBYNR105IVpHjw8DEK0=;
        b=kiPbMzB7LrDmpGP59iCr/99u1qSumvnZR3gcFVnHlqMYLauTVe3CniLPRA5RCr2kVk
         hd2T/ATmYayk5i4odP7CQJmDD8CcTlpB7oXjmicBObZdRFoR8U/PhA+enZPMlV7uUogp
         lllnNmC6CrDHCBr5i4pAyEBUeXQk1ZXR/cp69U8WtB/tHgasUjp9FBLx2DMBJdunjEdR
         sKIgq0pUfEjXkiedDe06PZmXoCtKipsBLgDhKnzbOCrVfsBHmCmDuOH7Woja3n6Al8Tp
         VTB6qKFA/u4vE8drGiGh4WtEiMGiwDRHWPKrkcxs4J6rEMzG4boYjnTTKaZSAUK/pvS5
         D4+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrhd1qhr3qtF02BR2jOVQskJT9Ck0P4r78cxJPCPVCbpQaKo8axmvn6ayhNdYOLiaYiYCELPxIEnMZZGmrVsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6VB9AyfsLThOYvTnfrZeIajsCGmkEWQ5n42HCwehzmZcROnP
	Fy3rx5EGi+z4FE6w5+zR5ulVD3Hffxkzf8bQGN4v+WSrE1nkwLvVMwIJ/nwPvMMmG46O9ghfihj
	m+bs+tUTWJRqZwvmCTkQ4d0t78Qg=
X-Google-Smtp-Source: AGHT+IG/Dtsj9Xj3CzNtxbjWM0ACisQ+54avm0LBZZjsDKPDb9itBRy/GI4mu63jlN8ACKLzGaTFSllKl6ThnHiBv9U=
X-Received: by 2002:a2e:b8c2:0:b0:2f3:e5de:7ff1 with SMTP id
 38308e7fff4ca-2f4f4733210mr73362831fa.0.1724707067289; Mon, 26 Aug 2024
 14:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211162718.1183182-1-xiaokeqinhealth@126.com> <170239802565.22444.13565680839471776744.git-patchwork-notify@kernel.org>
In-Reply-To: <170239802565.22444.13565680839471776744.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Aug 2024 17:17:35 -0400
Message-ID: <CABBYNZJ8+t+ooibh1WRpM6YPiFwbbO82WHfv7nFmR1tYnaHv=g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT/SMP: Fix address type when using SMP
 over BREDR/LE
To: patchwork-bot+bluetooth@kernel.org
Cc: Xiao Yao <xiaokeqinhealth@126.com>, linux-bluetooth@vger.kernel.org, 
	xiaoyao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Tue, Dec 12, 2023 at 11:20=E2=80=AFAM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue, 12 Dec 2023 00:27:18 +0800 you wrote:
> > From: Xiao Yao <xiaoyao@rock-chips.com>
> >
> > If two Bluetooth devices both support BR/EDR and BLE, and also
> > support Secure Connections, then they only need to pair once.
> > The LTK generated during the LE pairing process may be converted
> > into a BR/EDR link key for BR/EDR transport, and conversely, a
> > link key generated during the BR/EDR SSP pairing process can be
> > converted into an LTK for LE transport. Hence, the link type of
> > the link key and LTK is not fixed, they can be either an LE LINK
> > or an ACL LINK.
> >
> > [...]
>
> Here is the summary with links:
>   - [v2] Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/=
LE
>     https://git.kernel.org/bluetooth/bluetooth-next/c/d66abc0fbb27
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

So this changes introduced a regression, the
MGMT_OP_LOAD_LONG_TERM_KEYS doesn't accept BR/EDR keys of LTK, besides
I think some combination old_kernel+new_userspace and
new_kerne+old_userspace where also broken in the process.

>
>
>


--=20
Luiz Augusto von Dentz
