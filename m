Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EB2942A
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597545; cv=none; b=KxIrrQQDm6OLSBbwibgrEM1TU9Ryl3RZPPZH/PIUyNcnxl3Cd+LZ6MV2rx9RGksQyr1wyDpThYA8YLaasKlvVC/qj6vhGcf5+hA531/3y5H/TSePr9YLwGAekfr9p2fznRSRrPC8WdlWfiI3kgdd/x2AlSJukT882JuMuKmV91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597545; c=relaxed/simple;
	bh=zJMJN2pmn//PNrLsjb7a+36q0IWfBOAhj6vXjWwrJ+w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QVV+iHy+Gpbwfv26ZjhaUH7oNaGdZhZR55ljyXS+56ZmMx4iit9zBtUKjfTDgEfadYzQtJs4IA/FUCqwqa7DoIYesDBGNult39Hu9ZJtOjDEGQd3f8IG3/GvxShzukHSt6fr5Zk7Va0N9fYJyHg+w7MJa9y0hVZNHeJLFeOn6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPxKi9zU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPxKi9zU"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so132308941fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705597542; x=1706202342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML4LH4t9zLaUek4aG19folN5FbOHTdkO6zc/ujiKFXc=;
        b=iPxKi9zUHLgNA3XM4fUMfNCff/e7EwdMulChg75JX6lASD2KbS0cqyiTLBVX/cuLdu
         WbtGRlSddQzXeRRi0z+csgrHcftOdtezUUHDoXaYOC6ohDhV42pPlbpPH+oB1NLtGYEA
         SUH+y0ZwBdbE8AexkvNPNswHj2/OPHRqIXm3k7+fGEDUXREsD6SqiiU2eUnVTeOXraoF
         Cyfnud0mO22Fc0Gj8GcNq0k4y8elajR1MVdlY4rltsY8AdpwxyrBVm3HgG7LnRKBy4ZT
         0WyYtC1EBzcpxKYmPEjQaoRn+1N3e01q5V4kbJV2r4b8uwmcTxOAiAjyrpcfeYUemHGh
         lVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597542; x=1706202342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML4LH4t9zLaUek4aG19folN5FbOHTdkO6zc/ujiKFXc=;
        b=ruEQFJ1gQCoSYNo89N9is1R/lBw9DJ94NwiXGy3DwmR2ZfZ33nfZsOvIDSVEvxfgm9
         7xG0WJXWUp1X0gsPro61WUIWpVi6+/WaXi8TYzmm9f9vowHoSarf+Yr2ic3cAYjQoHlA
         gAf5ARU5aDkHXes2YfIzWl4OzSXCFlv1saoVF6JZ2p/xBdJ0lgi6vunsjYh3b9W508pW
         HKe+F3DHa/AAHpu4Se0pG1jPYcZ8fw0qD8KWVTAQcxfS99RupxUK+RUntuayuTUl0463
         kbOWRqcmd/JMJmRYdmzGbi0pYh9yqI8prXY6o88HzC+Oy62K0yQusyGv+XtIU/gO8+Wp
         jtXg==
X-Gm-Message-State: AOJu0YxI9Mi+G+n9BxhjXCkRGJFHZzjX3wciP6GY0D5Z2cJNBZ5BYuFZ
	Hp96/vajvCsL6FLyqJGKgWUeJHt9yTY67VXxaYLu6RwtVg6j/8Do3oxQ6H4uVzar/Wa6Ny+koYH
	KDbZmgIwM/g/p/Ic0klj+3uQHOsA/7hWNtw8=
X-Google-Smtp-Source: AGHT+IGrlNLRT6GrsmK+4m5fBzVkx6mgAYHO9+rW25P+QWtYU9gZDVnwOBNkKTy48RRu7zuVCLK5m5BqP3tsbFhmiPs=
X-Received: by 2002:a2e:9909:0:b0:2cd:23a7:a33c with SMTP id
 v9-20020a2e9909000000b002cd23a7a33cmr503923lji.52.1705597541854; Thu, 18 Jan
 2024 09:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
 <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
 <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com> <CACvgo5064TQ5qwNiBgpc5BcdnHWoD7xEc45ZyR_PcexKwubR2A@mail.gmail.com>
In-Reply-To: <CACvgo5064TQ5qwNiBgpc5BcdnHWoD7xEc45ZyR_PcexKwubR2A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jan 2024 12:05:29 -0500
Message-ID: <CABBYNZJckSdAfMziUsMTmjnoGDj+9GOxsn29XPpZ5+ikrNUd4Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, Jan 18, 2024 at 11:12=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail=
.com> wrote:
>
> On Wed, 17 Jan 2024 at 08:39, Emil Velikov <emil.l.velikov@gmail.com> wro=
te:
> >
> > On Tue, 16 Jan 2024 at 18:40, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >
> > >
> > > This one seems to be causing some build regression, when trying to
> > > apply it breaks the builds.
> > >
> >
> > Thanks for the quick feedback Luiz.
> >
> > Would be happy to help but need some details:
> >  - configure options used
> >  - autoconf, make, gcc(?) version
> >  - the error log
> >
>
> Just went through all the patches and they apply and build just fine.
> Both in terms of "./bootstrap-configure && make distcheck" as well as
> the Arch specific configure options as seen here [1].
>
> Any pointers about the issue you're seeing and the platform in
> question would be appreciated.
>
> Thanks again,
> Emil
>
> [1] https://gitlab.archlinux.org/archlinux/packaging/packages/bluez/-/blo=
b/main/PKGBUILD?ref_type=3Dheads

/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/
9/../../../x86_64-linux-gnu/Scrt1.o: in function `_start':
(.text+0x24): undefined reference to `main'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5864: mesh/bluetooth-meshd] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4674: all] Error 2

This might be due to using scan-build, anyway CI also run into the same pro=
blem:

https://github.com/BluezTestBot/bluez/pull/2010#issuecomment-1893971347

--=20
Luiz Augusto von Dentz
