Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BED12836E
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933702; cv=none; b=OvJxNi0xJm5qUIZJq+gF2TpR69d+B4xcEoQfV1/VVsbToCMezwgqzbvF4Vv84jZihVZn5wYROb4jvJ6ege0KzMFcSY4+LREjWrV/owtAKDmHIFz8gvlZ35i5X4l7OHV+6m0V6SkmwAi3S3eXv6KMXd+30DgyD5cj1tNM8b6HCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933702; c=relaxed/simple;
	bh=R83Jk/6NPK40S/zaC4OzZZWNxgt3y+mq5BN48mIGVAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehIi1VMkDBnPUX1kocII0NB0MZ8eTvuHOS5edf6hhkhTGLQN+ARquvaQZ1Rp57UejrkzeFbZSFkwwBqguX5gRSUA2OEi9iufDfBTb/Ck8DY0ZZ16MSKsL+v0rlqQwxDycPNpNxCcJ+ySDmKl1ZOuxlUT059XVlXQeksHFOA15X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMJlKlRs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMJlKlRs"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso12175311fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707933698; x=1708538498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1pUZsz6lZ863ZQvQ8KSI7WxhlA++ZBDh1pDSQj23Lo=;
        b=IMJlKlRscvA5KRSj/3qFvGqPVNrscWZMKL0ByNnJrSH3ytZmHAJT4EpqdZ73/lAPOC
         jKKRruUrUEoGfjXdWCygk+luxlaLqlZ6R9XffF4NNYfN9C5FoD9P3oC+9j/tbQF1KRzg
         x8yy/jwjm1AumHKrCQpt7Wvod7ys+h3s2mqtroQNEGejmm8kPgaR6SImV+YUjyXAXKqP
         tE9nnXTBA8IbohRSg8+AOCPD32h9fxGU+o6+515937+cTl0H0YXFWdCxB9hGWVJKCtdS
         Wfy97u9aeGgTkA0mlyBD9A5SVuTxQAECBIOkAhZSVmaydQauomzEQ8sNMfkhaWWzb6CO
         67HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707933698; x=1708538498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1pUZsz6lZ863ZQvQ8KSI7WxhlA++ZBDh1pDSQj23Lo=;
        b=hqP+quYb+wz1AZpuxuCiUuFIJeHt/ZeH+nvGCd48dUateeGmbsvHkvmTuJQPjOpxSJ
         MccETIabUgYf2cFN22L23A5VwWldkKiq14YXbD4OVL8njvTbwWhhQG5UluT7B+EY00WO
         GkNyOLJUk/qJ05Ayw/56L5oqqkPr3bpXxzqAC9iQbg3fLbZbJmF7pQR+HVW+LGfiKrQa
         Zibp3DKK7iRA6NgjtGPxs/m+cXAkCG5dgNWJ0N9Hh3FIBhd1uXfD6l9jownpSnkXaXmd
         KLIc5pYJYHJ2FEuMRw78it+tuL66ZPrimFTazXeNydNAJ13OYrcVewIuNjY3MAI19Vlp
         OtRQ==
X-Gm-Message-State: AOJu0YwZAo3AGazmuG2v8wYlpo150qjGdwZ2hgdwOfW9D8p34eTK65eB
	EeLCSgUVo4y0geJ08h7V6HqS+kFgx25x9IiKXlxTBtvoSEllg1DBCw1eztqozt1nIxuZvUXXJ8M
	LM7x7z53NPhKiAvZgSHVhVhj7IpI=
X-Google-Smtp-Source: AGHT+IGGs1mQtLNFsdxLpFN36/y/EP8p89DCrYeZTegJXJ4AY6zbCHdFm7bNwgNQzIJd7wCfwdjE09n/8Aw/Zsb5bSg=
X-Received: by 2002:a05:651c:543:b0:2d0:77b1:de8a with SMTP id
 q3-20020a05651c054300b002d077b1de8amr1131211ljp.0.1707933698137; Wed, 14 Feb
 2024 10:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
In-Reply-To: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Feb 2024 13:01:25 -0500
Message-ID: <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Feb 14, 2024 at 12:04=E2=80=AFPM Emil Velikov <emil.l.velikov@gmail=
.com> wrote:
>
> Hello Luiz,
>
> Due to a bug in the CI bot, I've scraped this off the ML. Hope it's
> not too badly formatted :-)
>
> > Here is the summary with links:
> >  - [BlueZ,v2,01/10] Return at least the title attribute from player_lis=
t_metadata()
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df2671bf8f95=
1
> >  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerState
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3aeae79de4=
b
> >  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 shebang
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd31f04aa928=
a
> >  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1313351f714=
4
> >  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
> >    (no matching commit)
> >  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
> >    (no matching commit)
> >  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
> >    (no matching commit)
> >  - [BlueZ,v2,08/10] build: ship all config files with --enable-datafile=
s
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbe0e796299b=
0
> >  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate paths
> >    (no matching commit)
> >  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user sessi=
on
> >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db16b19885c5=
3
>
> Massive thanks for applying the above.
>
> Out of curiosity: is there anything wrong with the few remaining ones?
> I had a look through the ML archives on lore.kernel.org as well as my
> inbox and could not find any replies.

I don't think we should remove the syncevolution and tracker backends,
they shall probably be disabled first so we don't break platforms
still using them. As for the GLib helper I don't think that is really
needed, at least there doesn't seem to be a problem with current
handling.

--=20
Luiz Augusto von Dentz
