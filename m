Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9118134738
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938121; cv=none; b=EhSqv7kpCQtkr+LzWJKL9u1Mth6ecSkR+GFt4i8O87UuJ3+AJyea7e341QSRg4EFodtm2kULMH0DKpY9UuOaV9KAnjxHcXhdVE6HtWL3jrje5yLnMHPga6+DJU3jAfaoDHPKx5JrXZpf5AGR3XbJ901O5+wLoA9f/YeR8lydR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938121; c=relaxed/simple;
	bh=Iiu6HeM+xC+X02aosnt3RGvyIHNqV7xdRmX7KINkAlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDpuhPfsu1AGHhLv6Bo0PxWT9WUF3YGZmk9bXsp/X0JGZAWrE/2Y/G6GzWucih11dYzHAl2dJQCijqTOc81XEEJggui0PG7uy3StAioRNNpz+4P4upIZkAJjva7jj4T3UV3uqhqcHWaSCWiPr1KSxsnpuAoAPX/Fk+mc4IfwZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKMCCHEI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKMCCHEI"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso7051276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707938118; x=1708542918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uoiHmGBEdfOYqNMigscx7wscxRdugOSeoXoJLPq0Ws=;
        b=RKMCCHEIQ8TRFCZnYgm9nzX8IQZvH2zlgQGB3bk+uApMgnQjBJD+536pm9m111yASN
         gjoTmVqOjPwfc72l1B/sRya+Cqq9t+FqAm0LbAoUfLjKSPhTVMQPWcYWp56dyJ9gyMMw
         u3CgdqOhH96Y+rNY6J1eS1qszPNzHYFPJ5R9bB9ULsqOJxXnSAyADV70TqEUiHDpfJiE
         4HJ/+6PZND1R3VYb4XH3GAEHqg5j7GFEotldfSiEWTPh/AKZyou5ywkgZ8hd5Y8wPmGG
         NHQn5RK0ULQ5y5z2qDYUhALTe6FGnkNWuKZtjK+QGnAj02u4Cmx+CtsIqDsLUWi6Kgl9
         wWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938118; x=1708542918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uoiHmGBEdfOYqNMigscx7wscxRdugOSeoXoJLPq0Ws=;
        b=oD2Edzru3gX3jF5lhjfhc0FggMQd5ByetHmXHeJqavwBUV5EvA33NGu3txPqkiqIG9
         gTgNTMrYv3Jzi3vTH8gCNFUzHVGgfEn/xteb+L5m3NIZrmbRVlYmHvnfgXVOEPBDoVpQ
         mSDwrc7okfgD/oNgsR2JDMPJJwnFGRxpG2tG36X92Yg+X6fJFXcwt5sZv/mpxSC+Tw5M
         jBD82sac2nFbslUeMRB/QYYdgWKrky6/HZreCOaBg+LlbhT0pwtIYw9gNs75GpDAln4Q
         deQipFvZIRTeLoijUfucQGwnjkr86JTzBVVtULylalArJ8Bd+8rg2Ktf7NPBWmwsnygZ
         tI2w==
X-Gm-Message-State: AOJu0YwJO/p2NQs6Lpuhjk3R8bOx2id8gBe1NESe5tKGCvtAEA+PZVlc
	Op9RSRtjLtDUp1dRTCv/C6Lbjbe1eYQmltgH8d7YRwVwMnAcqMNbSumgpW89YvcXGlJlgN/sez3
	H4MhhYO2KR45O4GteIy6uxxxDKqo=
X-Google-Smtp-Source: AGHT+IE0C5t3epe/BERcNk1u8+WuZHwWOWhm/1L1AAFzf3sLVLbGk1cBgAAitM8/buJM9VIK9T5/4bVOB0zvuz+RVoc=
X-Received: by 2002:a25:2e06:0:b0:dc2:398b:fa08 with SMTP id
 u6-20020a252e06000000b00dc2398bfa08mr3146840ybu.31.1707938118646; Wed, 14 Feb
 2024 11:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
 <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
In-Reply-To: <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 19:15:07 +0000
Message-ID: <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 18:01, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Wed, Feb 14, 2024 at 12:04=E2=80=AFPM Emil Velikov <emil.l.velikov@gma=
il.com> wrote:
> >
> > Hello Luiz,
> >
> > Due to a bug in the CI bot, I've scraped this off the ML. Hope it's
> > not too badly formatted :-)
> >
> > > Here is the summary with links:
> > >  - [BlueZ,v2,01/10] Return at least the title attribute from player_l=
ist_metadata()
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df2671bf8f=
951
> > >  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerState
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3aeae79d=
e4b
> > >  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 sheba=
ng
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd31f04aa9=
28a
> > >  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1313351f7=
144
> > >  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
> > >    (no matching commit)
> > >  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
> > >    (no matching commit)
> > >  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
> > >    (no matching commit)
> > >  - [BlueZ,v2,08/10] build: ship all config files with --enable-datafi=
les
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbe0e79629=
9b0
> > >  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate path=
s
> > >    (no matching commit)
> > >  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user ses=
sion
> > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db16b19885=
c53
> >
> > Massive thanks for applying the above.
> >
> > Out of curiosity: is there anything wrong with the few remaining ones?
> > I had a look through the ML archives on lore.kernel.org as well as my
> > inbox and could not find any replies.
>
> I don't think we should remove the syncevolution and tracker backends,
> they shall probably be disabled first so we don't break platforms
> still using them. As for the GLib helper I don't think that is really
> needed, at least there doesn't seem to be a problem with current
> handling.
>

Unless I am missing something, all four backends/implementations are
effectively disabled and unused.

Ignoring the first that you've merged already, the other three are
syncevolution, messages-tracker, phonebook tracker. All of those obexd
specific and have been practically dead code for approximately 6
years. In particular ever since the obexd git repo was imported into
bluez, they were never wired into the build system.

In order to use them, one has to manually hack the bluez build system.
Furthermore for people using the release tarball, the source files for
syncevolution, messages-tracker are missing all together.
Based on my archeology session - distributions (Fedora, Gentoo, Arch,
Debian and OpenWRT at least) use the tarball and none of them change
the build system to support/enable these.

So I think they are pretty much safe to remove.

Will have another look at the GLib helper and reply inline, with a
specific example/failure mode.

Thanks again o/
Emil
