Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E6E571
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496812; cv=none; b=EfG/fp+qMn+c/ZnjMOw5PodvS1CQM58xvJWmLr5XwgaGHZ+yecPbD6vg6INX5ws08I3z6TcAnLVkJpF76kCHbJIqhDCZpgMQw/6ZQ+EWvv6Iln25PZ8p8hQeJdcvqS6+qEVArQHY41Rqn1xvxzMg81R67dyRQcjrxCkeLp/I0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496812; c=relaxed/simple;
	bh=zncZBQUKxTXQF5YvyTuzKefl0+/Kq1ljUch1K4MlRG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCQ72e9lEQQeP0Goa0/vf8Mfq/6EYHYcQ/2zfyoa0gIotVfExUc6QSN9pkOYeormpctcom0FyHeUAc+3v5a21J59ABJbBYzNv8ns2CxHEE9TaUe8r6fbjxOyyisiokoRDp/5ifZt9keEJNrzfr3vj5lr7TEdpSrIDq9quXTz0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho9gPZuy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho9gPZuy"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3106217268dso37912881fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749496809; x=1750101609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG388MIQDyWlP58npx4tS0eL0dTASv/pBaGKUwqVunY=;
        b=Ho9gPZuy6Do1rVtt0s6iO8GAb2HDA4Iv+DY092mLpxP85WxyH2bROzvm3NxHX7q646
         BAX/tJIvPclYy07BIRbtrP7070qEdFlr+wZj4zgTz1QWtxr+g8J0OVu3A9LnEybCbfoJ
         dUfshcKbZAkP4Ae8c8MiPvRt/Hig93ykDv10oh4abaGkmbisneAnCXbfT5Kpg+Mv8ZUP
         RLyYy5C9DQpcCJHz3w4S0RGZwjfxKEACJmORALteKURoCZeuNMD1gstu0GXv9jcg7tXw
         L1XKPzip/v9LTOAsHy3SEqOtB5AZGXFTaFi4UW8DVRV2d83+b+VPuPK1efsyOaEdas20
         vHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749496809; x=1750101609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG388MIQDyWlP58npx4tS0eL0dTASv/pBaGKUwqVunY=;
        b=TgRrFdMvKsqa+FTMJNJaMKXpGqVZdEj05+r96ZRyi5aTBAygxKLCQWqxJrb6/Up/pJ
         373fOJ+QbnxuT/Lo5GCNMdBPGLkCwNVPw2SualOX6nF8nVZBDD5ntyz2wlYePYQ751Lz
         xVL6B4vmNILGAcWHZL/JUAUqSAxoaH0iqJiYAGEC+AVwdqfimJnvddiOMJunTBiJa9wa
         i/BNeknQs6V9mNqfk6uc3h+JGqjHoPL2OC3n0rK0En78Bhc3AizuirOY86hwSND4YFxx
         a+5A6oXpKsvm1WcUpPhvtriMrycMXM/o+F9OU12CJTcV/11BZYqO0O9jSwXTSoHerpKg
         IGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEF2HWEuVFOnWVoJRocV1sW0QcbI4Xht3JYmT9PAVFPZyR+JM4EPPrBmGu3kHxkBBVfbjKI3oh+qHdV6mRVos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8a/HI+VYqDoDWZ6BcSm1lpQjhIf4szuojMuDrMjGZAIC0CxSU
	xWp8225/7/iXvzn4zhG9upOacEeDw8WAZL538phxh0Brn6L/up3QNIe/2haEVKFocMGBRW1AcsE
	EMTTnyCHaFivGIpj9Ay6CL6k3ptGtf4A=
X-Gm-Gg: ASbGncs5fZatyaEDgZZp2BecIb+1jZUV1UerSp6JIRzhujRSw5JVWmRgqkxpVQii2hy
	RJOvhL8eS0Q+Pc4V2kD0BlDp6Z06luO0eUEnXriGgV59pcXL5GlijaqNQccGqOVz6lUaC3btgWd
	bGsxxmp4esLsQqYc/7IdKdwdBCtU5uAgx3smNPyZzx3g==
X-Google-Smtp-Source: AGHT+IGxoXFG/eaDaC4G23NnEPMc60WwLymd/IHkoRfLLyoafqOQrNaSNKR5ylXrlikWYhRUIq3Z6/sDq7HiPBV/Z9E=
X-Received: by 2002:a2e:bc16:0:b0:30b:cacd:fd7b with SMTP id
 38308e7fff4ca-32adfd259f1mr32171411fa.12.1749496809005; Mon, 09 Jun 2025
 12:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609143811.566331-1-d3dx12.xx@gmail.com> <174949592448.1356526.15327081211524527340.git-patchwork-notify@kernel.org>
In-Reply-To: <174949592448.1356526.15327081211524527340.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Jun 2025 15:19:55 -0400
X-Gm-Features: AX0GCFvDMjce7hLqxZuZOZKnsJ_PoLrRnTziMfyRO0uuCiD9NxK0Sny8gI9xEfk
Message-ID: <CABBYNZ+EbiWRZGh8YPhnJuP+MrXoxb6LbvQfodOwKXJeVH+S1Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] btvirt improvements for LE Audio
To: patchwork-bot+bluetooth@kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitrii,

On Mon, Jun 9, 2025 at 3:05=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Mon,  9 Jun 2025 16:38:07 +0200 you wrote:
> > This patch series improves some bits around btvirt, its interfaces,
> > advertising and isochronous channel handling.
> >
> > These changes enable btvirt to be used for simulation testing of
> > Zephyr Bluetooth stack implementation of BAP server for LE Audio.
> >
> > Dmitrii Sharshakov (4):
> >   btdev: implement extended advertising
> >   btdev: fix LE Remove ISO Data Path command
> >   emulator: add option to listen on TCP
> >   emulator: server: handle ISO, use BR/EDR+LE 5.2 by default
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,1/4] btdev: implement extended advertising
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D964585e3b352
>   - [BlueZ,2/4] btdev: fix LE Remove ISO Data Path command
>     (no matching commit)
>   - [BlueZ,3/4] emulator: add option to listen on TCP
>     (no matching commit)
>   - [BlueZ,4/4] emulator: server: handle ISO, use BR/EDR+LE 5.2 by defaul=
t
>     (no matching commit)

Did some minor changes to coding style. Btw, I wonder if we could do
some cross testing with this, so testing zephyr vs bluez.

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
