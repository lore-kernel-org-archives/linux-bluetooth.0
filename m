Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4229DB86
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029771; cv=pass; b=AKeJpW2bBbRLwl/L4poI1fG4mOGdWey6QepgNA/haj+ZbvsV7rPhdLGw+9RGZDXxCr2+0gmopvrn5p2mUiZieHJFBpSf5UtekeD96bprV0pIH301+OoTqv3tKiHtGdhJACtakSpcu0G3lYZprnlDFt8dMmnUIOrsDkwcIVNq7qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029771; c=relaxed/simple;
	bh=wN6kpZeaNONl9B4mFN236xU8f+pgFkGY773WjFaxrS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqLZXofoOEU5gcXeRZFMXSV6Okl0H460VxGNtwX6gzz7NTdD8fyYBs6+sz+D41gciEImpt5dKO1SQkNDkJ3ek4B/C5O9PAphWfabS4fLrGs/4xz1D6k00QPgJhuBtUW/rhxSJej7EvdaIotdsTxRvb/VqNTEMszUS5kumzCDWQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjakDrV; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjakDrV"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca423ad53so2532414d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029768; cv=none;
        d=google.com; s=arc-20240605;
        b=VQmOaKaSrodcqB5o8+tNKXh1nAKZzBK6RyM+4wBFRSjUsEAQh0QarYQUqQofR4kBIO
         SCULe52OJVdMoTON8ry1BRqsJrG8l805O7sZsSiIZwl64MorG1k7edC8yLUIshOcduHO
         5NaI5XuzzMJ3YU0t/zH2GXyxgEXxXRA0GgMlFm/L44X2S82Fd2cGvIB0D54PnNs209En
         L4oAIHLymBUjS1/0ANWTaqv5CtYS2yWm0c/RpfBg48nFc9nJsjQxCUuz+VA0F7bi4lKd
         V7z/7M7kVrU5xQoA8bagX1UGrDdmeB7ZoTUWqPmRQT0JSkjzcdkRwrtVTHFryFJL0i6X
         V4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        fh=lV9tb2ZvkTBrlnFL+I/ZZaJGaDkL6kLF0sYCFoGPB18=;
        b=JrNpEOEj/jm4f/2Zj20uOl/opQz9u84RxZ7CxJl9ICOSkoBBsDoJBG8/BaCI7eU/s4
         CgoHxEiEePuv3E0iO8LD50CcV+CB6b0n2ioXe/Q72KKCZCaYDH7L+R7bnY/qGnGWNQMI
         Gl+XoRREdCVfsy0V58ipOUQZs25yYps6Yox314y4rXnCiF38lNR498hn5Ze0KMOCuVbm
         NesqlkaM/bfCFYzBBI9jUHQ8r4KX+XeWKTilYMWZeFmfYBjzRd04D7U8P9UzqLHLyzgN
         CkbBJMVlTytmHjiEgitvcyyDVnWj6zMdv8QedwgLihQZqjWPCPGveaXEVYJR30VPzguJ
         xSUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774029768; x=1774634568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        b=iAjakDrV2JnOdSKmzB/JTsv0Lskd7+OGsZMlcbFAOyGpswwXoPuchIgp90W5+W7QCP
         hkzYtDpKR5NEb1l7vPx3rXWEXCWiY2SCRlrIpZDp1u4zNBeDs3veV3uHah5qdYEBysAw
         DwUazMAuTd0laNFypAARYC6E/X563galHQuwJnOuBgfkS9YAuFH/8Dk4JiYjfqGH38Ri
         rMwowIoCDMq5WOAVOSTKKAWvLlMfYI/OaVsyan7sOl9Gb/drRMe6896mHRqkDrVSnBkX
         ED7UtqI357Koen7IoPAG+Rj6g3DdnTKkIicb92Hcwwqj0MlRnUFdBaxE6HoLVIPXuOKb
         fkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029768; x=1774634568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        b=ob8hdXTo1+hJ1sgnv4ynZJBx7rzR+oPgHXw7cHJp1Pyvewnxhvd8yP3S/mdHRRECl2
         ahcuBICF2fE2ik/U/IuQ6LW+JJKkOa4QeP7vQ3/JsUqehjJ8i39MBAcZJfADN3MKUGHZ
         GQbJj3YOYH+xaSqdcJkL0aR33lQyLi8Oim64ilJZmTbQdbwUySaSIf2Sr+iQYOWpIeU9
         FRUqqHdLRW5XraxKm2HG+Ja//P845aQmLFZj4loiL5FlI9PCBR1ime4Sj/oEnY7PTTjx
         Iyu9kMRVlNdGZNq2TZ9+oIfx1sWn1dQG81dT7CokYSFoAGCUrsZrVq5ueb9TZ6F+vNZ+
         ui1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzHAUb85ZstzV6SMhhh73ni1U4bq76gV/1Vs8ci122Ie9YZUskM+E8EyQgael/ViRMF4b3klg8Rmka9nPSqAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVeC/QzKu+jnrCeKz8mGGN7Np7BXfk4Bu56j2PIr9NgQhV0TJ
	l8EYC8TKDe2E6hkLySewotMJSh65Of/rZ5ZoZ7Z7nnLXl8w2bLXIRQSfVNf0duYId1ghKuY6sU0
	P+lsbrpcKctTtjqYtSH6di5Faigwi9rA=
X-Gm-Gg: ATEYQzwx5C8zKDVRCHEnGG3ib2gNzJ44PZ1a2PUFL5A5jfaBn2F49nOVGJByEFaLZ1R
	rIOrGTlCcB0cPz7yOz27mIfD2FuyociYu9i/ULOJ93weEjIzGh7UVXV8RStU9Sx/7YJMY3jlrxi
	+gHSF5mMZmAI5a66twwEIn43CGwHfQ8x6mVeWZ6J0g0j8aHvA3Z1TKi4soLlPTEYMRmnDUrXH2j
	ZAoZOq5TCqmxt5d65tFZjSyT3WiWrYW4p4PMLIUYXfF6En0HOeGxaqJuBW6gr8Amu745ISsbJaN
	VZzUT2jPnYW9n7+ZnUjdfKoVMX9I7Lg7SoQs4kXEkgL+iaEFOpQO4AkLz+BxwaogIOEWEhMg1bv
	Bp0ho
X-Received: by 2002:a05:690e:4292:10b0:649:e6de:8f3f with SMTP id
 956f58d0204a3-64eaa6de62emr3219341d50.32.1774029767001; Fri, 20 Mar 2026
 11:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
In-Reply-To: <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 14:02:34 -0400
X-Gm-Features: AaiRm53NYqewKQi3pNJ2dEJTs9aDibGtDwtQHrJUYixyc7-oeqpSDV2VIuxCqs4
Message-ID: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: kuba@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Fri, Mar 20, 2026 at 12:47=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 3/20/26 01:00, patchwork-bot+netdevbpf@kernel.org wrote:
> > This pull request was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
> >> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa=
9f229:
> >>
> >>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (202=
6-03-19 09:37:48 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2026-03-19
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [GIT,PULL] bluetooth 2026-03-19
> >     https://git.kernel.org/netdev/net/c/57ce3b2e9cda
>
> [preface: sorry for being a pest again and making life of maintainers
> harder with mails like this; but I think Linus (CCed) wants me to bring
> up situations like this; Linus, if I'm wrong, please do not hesitate to
> tell me]
>
> The quoted bluetooth pull to net afaics came a tiny bit too late for
> this week's net PR to mainline. I assume there won't be another this
> week, as that would be unusual from a look at the history (and well, if
> I'm wrong I'm happy!). That is kind of unfortunate, as those bluetooth
> changes contained a fix[1] for a regression that at least three people
> reported (and I know of at least one other person that was affected)[2].
> A regression that is known for nearly a month now and thus already took
> way longer than the "fix within a week, preferably before the next rc."
> rule of thumb Linus recently mentioned[3].

Afaik, it was tagged as regression on March 1st afaik, according to
[2]; traces were only provided on March 15th, so yeah it was fixed
within a week once the necessary traces were supplied.

> We had a similar situation last week already with the netfilter PR to
> net[4], which came on a Friday -- and missed last week's net PR to
> mainline, so those netfilter changes were only mainlined yesterday. Due
> to this a revert[5] that fixes a regression multiple people reported[6]
> missed -rc4 and will only be in -rc5.
>
> These two examples make me wonder if we might want to optimize something
> here. Have a second net PR to mainline in some weeks? Or should the net
> PR to mainline maybe be sent later during the week whenever possible
> (say on a Friday)? That would have avoided the problem. And yes, I know,
> Linus at some point due to last-minute problems asked to send net
> mainline PRs mid-week. But he iirc (not totally sure, hence correct me
> if I'm wrong) recently mentioned that things have improved. That's why
> I'm wondering if we should forget about the mid-week thing again and
> shift things a little.

Bluetooth regressions are normally device-specific, though. In this
case, the regression was introduced to pass a new Bluetooth
Qualification test, so we would have to weigh what is more important:
compliance or interoperability? Which would probably be a split
decision, though we always tried to balance that, since both are
important. However, I can't remove a valid compliance fix just because
a user (later more appeared which raized the severity) said his device
stopped working.

> Ciao, Thorsten
>
> P.S. Once again I wonder if we should have a dedicated tree to collect
> and quickly mainline regression fixes subsystem maintainers ACKed -- but
> at the same time I think strongly that it's a totally stupid idea, as
> bypassing subsystem has many downsides (like bypassing subsystem
> specific CIs, the need for backmerges [or duplicated commits] and things
> like that).
>
> [1]
> https://lore.kernel.org/all/20260319152247.13225-1-luiz.dentz@gmail.com/
> -- in next as 761fb8ec8778f0
> [2]
> https://lore.kernel.org/all/20260301233619.1807980-1-joanbrugueram@gmail.=
com/
> and links to bugzilla in that thread
> [3]
> https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2=
BLsMyJmcuMSA@mail.gmail.com/
> [4] https://lore.kernel.org/all/20260313150614.21177-1-fw@strlen.de/
> [5] https://lore.kernel.org/all/20260313150614.21177-5-fw@strlen.de/
> [6] https://bugzilla.kernel.org/show_bug.cgi?id=3D221152,
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221158 , and
> https://lore.kernel.org/all/143e1a402ad78dd7076516a6ceb637f378310b16.came=
l@sapience.com/
> (some of those are with stable kernels, where the culprit was backported
> and reverted earlier already due to the regression)



--=20
Luiz Augusto von Dentz
