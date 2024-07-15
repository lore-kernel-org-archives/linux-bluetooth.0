Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B91DA26
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053063; cv=none; b=uU/498GPnSd4AsrrkxpJwbXgiQEJrg23KNFEyqhZs5hyEBFxQVZ+q6KAdSGjroIQwzLsYuOjFe44vJgVl3JRodoNfiv0kXc+omDolUtwEikCfPoqEkWaQZ2m5uG9GpbjWbNtGy3Z6zypnTNPFJDOUyIRBImQrZbk/tcesDc1v7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053063; c=relaxed/simple;
	bh=p5vkjpUIAN1q0SFRTKNGtBTqWKxR2HbI2p0SsZxwJ3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvwYsBWp05RVb7zg9F1WWRF4if/NtX83F9dYMHRM4QZIUu9Ie6ijG5e1K5ArFGdIB4aHd3f9BmaKXnJUtMqmJTw86yVBkF7t7pNPKFrRoR3qKl37wG4Y4kc8lgXVJFA2Ngceum38mZXdRBiQAltSdaqdXZ6hUMIlsc+ZMdpGq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTOEz8rH; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTOEz8rH"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4538531276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721053059; x=1721657859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OoWtEhbY53+o6LnI0FNJBNw/+pJBxn2lMjzj+KsmgQ=;
        b=tTOEz8rHmSlb1m23dMEt9xqxp+8wBD+Z4JQXbH2YRPN0PlFlMAi9TNhDUei8u79S1p
         tk5xIPYPwV3VBRmZ0s7vtUzl/kWVKtC/t7tXpDJ0Dp2KbCqNeDr+FsAnytQtoeLpz5oV
         fHC4ydlPfXWe/SLVWH/7iF4MnDyjGEPiVuufo3bZttcSNtpQzaczqc7Sg0/jmjEt3MeR
         v1ysUGw6DuozCFbFYnQzBXYFRQMEvQY/sC+7ifRK9Q+wliKtrrgvWri6PmpMibDjqxoC
         n3YFSnBrytZJku2+LD5ElZJSEQSdH5616O89ZimFp+hWQjt7Fmz6hp5QEhl8RSFfPJV7
         BawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053059; x=1721657859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OoWtEhbY53+o6LnI0FNJBNw/+pJBxn2lMjzj+KsmgQ=;
        b=a6PdmGb28CsJdkUb3ycCDeeRykQg0nJsaai+PdLz7s3g4RdPpdPKEVB3l+M27VGqzQ
         6fMYu8N9Ssg4xi7zyUcGkfs7gN9UfSfR1+t4kGpLhoHFg8Qr1OPNtw4oSy1EaxYX395M
         glaQbSPlZjnykek63tRn9kQ4n7vDFs4ohxfkMMNs5QcFBjPJd8afXzaDgu+2OS6HtX5c
         TvsQwbJGx4UAXQAK6HUwMEbl19QO7gB+WVNDpIVmYAKzdktX/A0he8KSTS7T1kEgXbEs
         C4XbBdS7i+5yyYa4i1H1yH7IbgeFFYXyqAaSavMmuXisnxzXaj0cckN+d6R2KQuO3I8G
         EI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSuwySJvvZMC41QuWeGuIxyS1n9toWCRSjipKJLR9NZPKwQ20J+GDYeHN3bLiCPQDZiKVJH3ciNUauEkgxt9cEUr6ikDXvlMsF2lLsBYIH
X-Gm-Message-State: AOJu0Yycdh3hetMnT9S60utbRPbLM1bSWinYO+qJFhJrl/asijXMP+yJ
	b7L4bWnb0H7y63oXfMuGeKyiYZmIsv41VZljvouRPfAyue+M5DuO5RrBk/DSqGqrQXrDrL+OnFS
	c5Ebv17KEyfA+FLGRCTC4iQCYV/mJCavR1BdcSWd7ghLizbtA
X-Google-Smtp-Source: AGHT+IHf09w1i22vg1fXed0YLn+7wm0ckmYmmD97kcyFXDIFeQRbyjfwZjVRPHxaxhZ8gPCDXVfoT1vtvO4SbKtPRNI=
X-Received: by 2002:a25:adc1:0:b0:e02:8f64:5010 with SMTP id
 3f1490d57ef6-e041b063931mr22988844276.14.1721053059505; Mon, 15 Jul 2024
 07:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com> <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
In-Reply-To: <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 16:17:28 +0200
Message-ID: <CACMJSesSpm=C67LE9Nn+fBS_JLZgzA_h-ocnPGy_wqzy8vH70Q@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 at 16:00, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Mon, Jul 15, 2024 at 9:56=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > > >  - qca: use the power sequencer for QCA6390
> > >
> > > Something suspicious here, I thought Bartosz sent a PR but the commit=
s
> > > appear with Luiz as committer (and lack Luiz's SoB):
> > >
> > > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module =
on the QCom WCN chipsets") committer Signed-off-by missing
> > >         author email:    bartosz.golaszewski@linaro.org
> > >         committer email: luiz.von.dentz@intel.com
> > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linar=
o.org>
> > >
> > > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
> > >         committer Signed-off-by missing
> > >         author email:    bartosz.golaszewski@linaro.org
> > >         committer email: luiz.von.dentz@intel.com
> > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linar=
o.org>
> > >
> > > Is this expected? Any conflicts due to this we need to tell Linus abo=
ut?
> >
> > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > is based) but I no longer see the Merge commit in the bluetooth-next
> > tree[1]. Most likely a bad rebase.
> >
> > Luiz: please make sure to let Linus (or whomever your upstream is)
> > know about this. I'm afraid there's not much we can do now, the
> > commits will appear twice in mainline. :(
>
> My bad, didn't you send a separate pull request though? I assumed it
> is already in net-next, but apparently it is not, doesn't git skip if
> already applied?
>

My PR went directly to Torvalds. It was never meant to go into
net-next. You should keep the merge commit in your tree and mention it
to Linus in your PR.

Bart

> > Bart
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
-next.git/log/
>
>
>
> --
> Luiz Augusto von Dentz
