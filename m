Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1294087B
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001921; cv=none; b=n3waYN5ecLaV6KghYZNjBMcbpmabJ2gTLIP6o8qjOLhyPETv6uDJdJZiahIDg45QeRkfekptH566qk5MUS4qBtkVKAH6Vabr1oJw6T+/mUbSoEgQv/uvQl9E5dLL/h023kBC89OUmesdRJjfwc5AeJdqbVbfAmWY9O9TSiZqlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001921; c=relaxed/simple;
	bh=JWMSlqj+XkBCw4DeQntDdcfciAkgQUZAt+rZ1eov1og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js1CPXRvF958pG5QVe+PBIEQfwtpmbqipUHUJFzppBm+A2PSB4gumTAe4GFAcUtHmdfJgsbVJX1o6RDIY4N2nhuKaHZDjozBRzBUveumxTjK8KX9WLhOwAKxRlQWOZKbo8ZVQELi46Ekd3eY4eil11s6P5OGs6Z60PCuK2oI2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL8lF2CF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL8lF2CF"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so49097381fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712001918; x=1712606718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG4sWfMiNDasD2tcge/Z1GGrPDPcsV5Hgq4qNe4PouA=;
        b=SL8lF2CFK0yLAunn26hp7KDHHT0mMIeW0CndwD2r+rHrHcxkw8Tji3NKbO39deCE/N
         QJO06gzun25MD15RBEOwF0uV3Ox4eH2FXTuOqLbIoJHUBFv0tFMD4Q1Bf3CL4Jz2JJ63
         D8TLhMUbLL72A85XCYT4S2prrbEm+FSKNArW665PswXHVT41ywPgHeQVIydKSazi5bfC
         XHl/Nt3efvmvwxuxnNgkgGOi75iYzXHghhV57t4y0kGbhAxpT1vVHhAxSh+QJW4qOVej
         tQIGmzBXw2pwsML8gHFe0W0S/K/u9lsUqrWM18kyTWvD2uoczOIxUjsPP7tXVN523P9C
         zG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712001918; x=1712606718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG4sWfMiNDasD2tcge/Z1GGrPDPcsV5Hgq4qNe4PouA=;
        b=s6oVL+A2y896+ORmjZ6mb5yPQ4vRKNtS9DSZlkBN4bheQDOmsPg6W7FoP7OSc/FOa7
         KKavk1wj9uh1iTJX4uhqaoXAsr8X0eVSFro3ZxiUycZNOpqmVdT8vTdvUQhv+2QIXHm1
         iBUOMirxq5wjv0qunp6HnJEY04O3Ywd72pUOLRtvaUhLZ8tMqFKCY3mrzMJOEKCZYk99
         MAq0MnIAyJRDrLrSO8538qIn7Mqo7UnVYqXXuRWpYw+8ULPCJJePhDG5TdUqaFERsnuE
         4Y/zOC9NYiUDLTkrVRuaD9sY82kj6dLC32TXsiIT2FkcskoZGG/Qvja//OzS5s7KL5xH
         kR9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWXNXVIOqlEyzUTUSyvNWC9+jLEuuB/xPmSsuB4QOotMEjqfhw9Mq4acgQMVlJ8iEzlrkZt7bVSQ1nXZrrtUwc17+TdLX2C+6y7GZZLiq8
X-Gm-Message-State: AOJu0YwiuhRu1VXsMS0q2U9STjC1+kAC7L5eoo6ln6qcKLrSYr8z29mE
	Xs7wL/2z9SnN13Bk+YJXMDyFdZgkhmw17McZF/145VZQpIOL796Ju8ONY2DByKrVcR1PMTMIoWb
	YwJRwBSj24JBNRr4XkwRm4XPGy5I=
X-Google-Smtp-Source: AGHT+IEnjcXZdwvXM8Qz+6nBCnli/DsamUgZ/I0iB84rRTE5SP4Io33TwYju6hBKN5LHqrI3EcxPQsHIhiERjJBm46E=
X-Received: by 2002:a2e:90c2:0:b0:2d6:c1fa:f2bd with SMTP id
 o2-20020a2e90c2000000b002d6c1faf2bdmr3554198ljg.2.1712001917508; Mon, 01 Apr
 2024 13:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710440392.git.pav@iki.fi> <171200163859.25745.12369452892917865813.git-patchwork-notify@kernel.org>
In-Reply-To: <171200163859.25745.12369452892917865813.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Apr 2024 16:05:01 -0400
Message-ID: <CABBYNZ++1tDjXPGhBJND6qBqGR-07CFabW2to1G38RFsohxPmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Bluetooth: add TX timestamping for ISO/SCO/L2CAP
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Apr 1, 2024 at 4:00=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Thu, 14 Mar 2024 20:20:16 +0200 you wrote:
> > Add support for TX timestamping in ISO/SCO/L2CAP sockets.
> >
> > These patches allow fixing / working around controller(?) issue where
> > two ISO streams in same group get desynchronized. It also gives user
> > applications the best latency information as available to kernel.
> >
> > Also add sockopt BT_NO_ERRQUEUE_POLL to optionally disable POLLERR
> > wakeup on TX timestamp arrival, which is mainly a nuisance in the use
> > case here.  The alternative to this seems be to deal with the POLLERR
> > wakeups in BlueZ side, but this seems hard as it's always enabled in
> > poll() flags so not clear if anything else than polling at regular
> > intervals can be done there.
> >
> > [...]
>
> Here is the summary with links:
>   - [v2,1/5] Bluetooth: add support for skb TX timestamping
>     https://git.kernel.org/bluetooth/bluetooth-next/c/0368e609d090
>   - [v2,2/5] Bluetooth: ISO: add TX timestamping
>     https://git.kernel.org/bluetooth/bluetooth-next/c/3067d73e114f
>   - [v2,3/5] Bluetooth: L2CAP: add TX timestamping
>     https://git.kernel.org/bluetooth/bluetooth-next/c/e22f35ed23a7
>   - [v2,4/5] Bluetooth: SCO: add TX timestamping
>     https://git.kernel.org/bluetooth/bluetooth-next/c/b7adccd0e8b6
>   - [v2,5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
>     (no matching commit)

Ive left 5/5 out on purpose, let's have it behind an experimental flag
so we can later rework it if necessary, I know it is a little annoying
to have to do extra setup in order to test it but we are not supposed
to introduce something like this without some safeguards that we can
later rework if necessary.


> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
