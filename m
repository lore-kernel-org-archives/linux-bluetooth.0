Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079A2DEA87
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120893; cv=none; b=YFDyM+4j4nVTxx2IYxQSHdieoXW6fGWfxsUznbqrQqyb1G084l1aCvbnhxSuXuL4c2X1BwKfBEmIWmiz/W3rUHLmJ2mJZT2vv4T4dE1AT3Ms8sYQ6qGJSsNRquVri+bLA+6axhep2qjpkBChcAG17LxuKsL1aYJruAqecBSfZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120893; c=relaxed/simple;
	bh=z08OiuheiJOxGVKBiW+guvYKDROBrlHFsNEImHapHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcUow7N9u1kslzj1iteztTGKv0XM8GwCQtyUgRiJV1isaFLismnHV8EsnbrCznaRicynQjVeadZK2c/UsjBdX9rnFu2rOQbOtb5pYVwWPW0l7PRWLUV9peO/cZY8zuWJaSagqxbJI+sRVg72xPiu/jelceYxPgDYCJ+uA4NoS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma6KHTci; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma6KHTci"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso41340821fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753120890; x=1753725690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2x7H6obV8F0XTrCKLuBYzfvjROyKv7AUibEz4F2mVM=;
        b=ma6KHTci+MlvYL/dbOr9eT9B5dyN3jxUaR1LLUx7nYLtFv8JbWrvLuQOlWZEO2r/Rp
         rt0vTRWZdRSac4MPmMjCqfxEJZKfmGe5usMo+FQk86kev8FtcmRfHLRKbqmUYvCWnMyK
         3WiJM8i4JPMbet/q+lqjSl2A306rE+OgwDR0SLdBwnDNbf6OGc69K4JZMITnAe4Hzvuw
         61SYcftynT0z/6eDP7CIl2npN6Jc09dm9yMwZDZeS3w73lyz2fEE675iOW6W8snpPLo0
         aHClUWsjzURAONPhp8I6XUj5tcneNeAx3o6VmSqDet7FMxDEXoUMpKfRDvUbefEBZrsv
         aILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120890; x=1753725690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2x7H6obV8F0XTrCKLuBYzfvjROyKv7AUibEz4F2mVM=;
        b=JK6tzcWWsQufroWlmd60DwOCX+ODnRSNeyff5OFiFBYZUQn9B4fByXVEkY5f3XAtpD
         wYFm4ssTDZ8Omh5UCpSpmYE0+bXuoktmg8zNSZtrmBMeTDVEzR/L39Az2SxTmhQAnmC0
         pDIHQVEInKa9yYCIZpjKhND9DU1RFh64RWCemrEKucF6ybtnEZqEs9AMO8UMG72NtK6x
         MxsrfSTEHdjcNQOIaWo265moUfE8Zm012Q2ojGQLNz5QQABwjxpRGl9b0kw6mlkDKdxj
         TO5WL1O4jqrvBtZOmYTlwhLeeqYBJaxwuasJu/a4HCpYsuDxPFd+jrTDqzo1p+PFrrVm
         7LLQ==
X-Gm-Message-State: AOJu0YwUtRjMSCRZAUIYsnyK2l6NQTELBEdsGA8BhU4zSJvtbu4rIUFV
	XIghOVgFHMPO8lCQzGepGqEAr5lfzAyXNv+A3l1d5/GpR7uiG6EI/M6F9HhnmSQ/77Yfci15V+i
	8Dz2kykdQoROX09/hLhUrkvNRYJxrZAh0DkEu
X-Gm-Gg: ASbGncu1oaA8Y/x8OwBmF1UmhDagLoE8IIEi1ETei77YAQo6Jxy02tgnh8qLxefZu6/
	6DwbwMkO1Fejt6KBrWsXFlfaHkybH37HSNcHO/hwYCt8k1VvoSweq6AEAadyd5s07A8ihpHh0h1
	KyOBWfqWTjKOUMmaM2lqxvYfNyNrxa63FI7c/OYlXhAOoK0JUey1prCbmW9QS7akDujULzfUZD9
	FEkGg==
X-Google-Smtp-Source: AGHT+IEnP2EcwoR8JTdFMSJFb3Y3tuAv954oJexxlXiQUw8t3sI5y0QjcRqRsBJqN9UkBnHmg8a5oxjJipBOleNnYH8=
X-Received: by 2002:a05:651c:220d:b0:32b:4521:73cf with SMTP id
 38308e7fff4ca-3308f4c38e6mr61046581fa.2.1753120887876; Mon, 21 Jul 2025
 11:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <CABBYNZLUK45-eBcYAn7oq9-gewhE_XLXpnPiwKXPF-tOX6JYrA@mail.gmail.com> <119538af-e432-47f8-ae87-4c59750cd4be@quicinc.com>
In-Reply-To: <119538af-e432-47f8-ae87-4c59750cd4be@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Jul 2025 14:01:15 -0400
X-Gm-Features: Ac12FXyrLhorUo8mV6Om2HD5i34T6gD02JOpafQ8d3juaCwPsUAGYdYGPuEBl7w
Message-ID: <CABBYNZJ2EAr-H+WKiifzqpC-bnxg8L2NSa1yG-Xjccw=oe3yVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Francesco Giancane <quic_fgiancan@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Mon, Jul 21, 2025 at 1:05=E2=80=AFPM Francesco Giancane
<quic_fgiancan@quicinc.com> wrote:
>
> Hello Luiz,
>
> Thanks for your feedbacks!
>
> On 21/07/2025 17:20, Luiz Augusto von Dentz wrote:
> > Hi Francesco,
> >
> > On Mon, Jul 21, 2025 at 11:24=E2=80=AFAM Francesco Giancane
> > <quic_fgiancan@quicinc.com> wrote:
> >> Hi,
> >>
> >> I am posting this patch series to better decouple `bluetoothd` daemon
> >> and `libbluetooth`, as mentioned in the subject.
> >>
> >> I am introducing this change to make new BlueZ more granular.
> >> This will allow more control on which components are actually selected
> >> to build.
> >>
> >> Major use case for this change is fixing circular dependencies when
> >> bootstrapping new builds where the whole build root is to be recreated
> >> (e.g. Yocto Project).
> >> In these scenarios, to have Bluetooth support enabled in Python,
> >> `libbluetooth` is required at build time to be present but the direct
> >> chain of dependencies would require a Python installation available,
> >> thus introducing circular dependency.
> >> Separating the library and header files from the rest allows build
> >> systems to break the dependency loop.
> > In theory what we should do to fix this is to add proper header to the
> > kernel, since libbluetooth is basically just used for syscalls to the
> > linux-bluetooth subsystem, btw doing that would also fix the likes of:
> > https://github.com/bluez/bluez/issues/989
>
> I see I see. I read through these issues jumping back and forth Python
> (it is interesting that it's covering the exact same case i'd like to
> fix :)).
>
> So if I understand correctly, your suggestion is to remove *our*
> internal headers and rely solely on kernel ones? Or better, move ours
> straight to the kernel UAPI.

Yes, moving our headers to UAPI is probably the right thing to do,
that said we will need to figure out if we can do this in one step,
and just start depending on it for the start, or if we gonna need to
ship with a copy as libbluetooth and have a transition step, from the
looks of it we will need to do the second option until distro catch up
and start to ship with Bluetooth UAPI headers, anyway we can probably
start with UAPI headers first along with any kernel changes required.

> I'd like to help here if you can provide more details I can work on a v2.
>
> Thanks for your time,
>
> >
> >> `--enable-bluetoothd` flag is added to the `configure` script and
> >> it is keeping the same behavior as other flags.
> >>
> >> Francesco Giancane (3):
> >>    configure.ac: introduce `--enable-bluetoothd` flag
> >>    Makefile.am: build `bluetoothd` if enabled
> >>    README: document `--enable-bluetoothd` flag
> >>
> >>   Makefile.am  |  8 ++++++++
> >>   README       | 14 ++++++++++++++
> >>   configure.ac |  4 ++++
> >>   3 files changed, 26 insertions(+)
> >>
> >> --
> >> 2.49.0.windows.1
> >>
> >>
> >



--=20
Luiz Augusto von Dentz
