Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36D1799D;
	Sat,  8 Jun 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717873251; cv=none; b=H33ZmmbfIGAB7sXWNuFEoyGU81JVTGw03IgxnrAQadZ2Yn5jtjK/Ve1UQhfhAHMaZampxWpSxyif8UEL3CdBHALdaIkQjwZM8iwzEHJDuSHEY8jk4BbHnmrFIzTKcCPrr6BxR/P5MaOiK35XLRi84976P3DC5Nk7+T4rI7OPu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717873251; c=relaxed/simple;
	bh=lUKcZ0NOZIGF2roeexyRtcuCwZmnc8vD0aRuMnMXqlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1wP1OA2h+5D9zz/0tfuIDXrabBfXoiZDhm29xgK0MH9tL86DgdJ2pQRSC8ZH5iUCn9M1ZM9Pr7jqTlX8RTD5bdrxPQBWP+tmAInH9Z0Vx9mSF39Wf60JpOsOe4tEnNPT75NJGjPRN0xd3I9fqZAIfqitH8oJjKQgdgjGYGuQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYRErWMe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYRErWMe"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c27bc473d9so2634560a91.3;
        Sat, 08 Jun 2024 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717873250; x=1718478050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzPlb+KNnIK84yqsSCymGwCYl+X3d6bDXkoBesrFE4w=;
        b=ZYRErWMeDVvXikFtbtlzEWWqUMh+RVrnZx8JafCCeIqEUcJbhQPU8MENkk+13rBeJQ
         XDA3djwsVnOdddi+wtJctlsuCp+eMVz9GkTqbqvD0jhRA1Ls3M/jcqjwFq4ALkBfV09y
         HWnAGukeYk0ZeyBGFoqIjONr6O84dUiA7ZdBFhUX4k0E1IMb4jmeclWpRfKLHfriDu+k
         +Pl/aB3xb0XLz63T/20kwLtu4UlGkn9SuOxWHR0ndIbgIZPqLwhs7BT8M/fQBR2Z5/Hi
         pki5PhcG5FFfd/yeV+EeECoIruI9xccFEOVunZcLnfDxFPbh3ZmSn4HP0HMMK2hCOvI1
         sXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717873250; x=1718478050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzPlb+KNnIK84yqsSCymGwCYl+X3d6bDXkoBesrFE4w=;
        b=L4msxDid0q4YF9pdk3Ey1PzXvwf4FxJpNVjb9cc+gv+kuJwaAP0eamoCuIYSLgvbvd
         lLVl91NUQXoakZMLnSB0+O4VvDx2mENHQwvzagqXoEcRUl4BI+S5GFtYndH1bu+u3RHm
         Fkwz60SZExC1MNkbRSW7AEu34nVSMEHqd/nC2njYoGsu6cDlmSIMQrlrj8RjREfCsCd0
         RrF1w0hVIadwkHrRWKpo1zZGEDNd3YSw+aaMJ6RoT3kQqSnhz3SC85NPTLCxGjhzRPf5
         gF9UFaOf9TktJNHSX1SKWu9mo9MDrjtTOb9MwYQ84H86VI9+UlXI0iWVQkcuhPVGRZ23
         6KDg==
X-Forwarded-Encrypted: i=1; AJvYcCWvf7KAYVx7rmvRY6R5MtqV/t6EpftubKo2wvGc1mCK1g8b/pXx06kvsIwQVi9fNSuIBeiF4MemBsjV7au9204qTqPYM5CBlM4PY4KxNaLhw4SVdWLQCyRjfGsTWV3vtr1ROunZcDrpBnF4mBO/
X-Gm-Message-State: AOJu0YzBV5T59ghe1Azjnqg4Hx82NVBvdZvqncJc8zJG5nYnRSp9e7Vn
	Be9WwB9PSN9TWiYPD9CPdl+QiGXAL65pRskfwNHxNmipVwvXq01Xu4Po+mW2w9kCzQw1XqeSxZB
	ii+gU3ilafK1wYRP5kIrqWUwj8nk=
X-Google-Smtp-Source: AGHT+IHy69wumVASu/61R/Fjf2UyRyAY0w+h+xTzlnA5QSxt9N/pf88fG72ZcV37ZMbk6kGOKqksuj3im194CCMHYPk=
X-Received: by 2002:a17:90a:f614:b0:2c1:424c:1721 with SMTP id
 98e67ed59e1d1-2c2bcad1161mr5292449a91.3.1717873249617; Sat, 08 Jun 2024
 12:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606183032.684481-1-andreas@kemnade.info> <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
 <20240606221941.333a9704@aktux>
In-Reply-To: <20240606221941.333a9704@aktux>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 8 Jun 2024 14:00:38 -0500
Message-ID: <CAHCN7xLhbiqTTOwPZ22KekALDn0KtH6vNQEJpSmSCTiMggX5Qg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org, johan@kernel.org, 
	pmenzel@molgen.mpg.de, jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Tony Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, robh@kernel.org, 
	hns@goldelico.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:19=E2=80=AFPM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
>
> Hi Luiz,
>
> On Thu, 6 Jun 2024 16:04:10 -0400
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> > Hi Andreas,
> >
> > On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kemnade=
.info> wrote:
> > >
> > > Some of these chips have GNSS support. In some vendor kernels
> > > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > > device which speaks the secretive Air Independent Interface (AI2) pro=
tocol.

I think you may have sent me a file to test, but I can't find the
e-mail.   Can you tell me what tool you used to test it?  I can get
gnss0 to enumerate, so I am close.

[   20.759857] hci-ti serial0-0: using DT
'/ocp@68000000/serial@4806c000/bluetooth-gnss' for 'enable' GPIO
lookup
[   20.770263] of_get_named_gpiod_flags: parsed 'enable-gpios'
property of node '/ocp@68000000/serial@4806c000/bluetooth-gnss[0]' -
status (0)
[   29.221588] gnss: GNSS driver registered with major 244


adam

> > >
> > > To be more compatible with userspace send out NMEA by default but
> > > allow a more raw mode by using a module parameter.
> > >
> > > This was tested on the Epson Moverio BT-200.
> > >
> > > Who will take this series (1-3)? GNSS with ack from Bluetooth?
> > >
> > > Changes since V3:
> > > - Finally remove the period from 1/4 subject
> > > - include things directly for get_unaligned_le16() to fix 0-day issue=
s
> > >
> > > Changes since V2:
> > > - Optimize waits
> > > - Fix some packet analysis / checksum computation issue
> > > - Adding a proposal for removing those waits as RFC
> > > - Minor spell corrections and improved descriptions
> > >
> > > Changes since V1:
> > > - Set up things for NMEA output
> > > - Powerup/down at open()/close()
> > > - split out logic between drivers/bluetooth and drivers/gnss
> > > - leave out drivers/misc/ti-st driver removal to avoid
> > >   filling up mailboxes during the iterations, this series is
> > >   still a proof that it is not needed, will take the brush after
> > >   this series is accepted.
> > >
> > >
> > > Andreas Kemnade (4):
> > >   gnss: Add AI2 protocol used by some TI combo chips
> > >   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips
> >
> > The bluetooth one looks relatively simple so I could take that one and
> > push to bluetooth-next if there are no dependencies on the other
> > changes.
> >
> There is:
>
> include/linux/ti_wilink_st.h |   8 +
>
> We have compile time deps here. Patch 3 compile time depends on patch 2. =
If we
> cannot take everything in for  6.11, you might opt to take the bluetooth =
part.
> That would work.
>
> Regards,
> Andreas
