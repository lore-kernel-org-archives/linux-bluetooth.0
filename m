Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB221E3C1
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088280; cv=none; b=nATRyUoWUUin62tNOpTXizZv2QKxY90TpOQWHspSPPYExLaY6qdFtJ4zb+K5P6/rt3GIQfHtAVKLIQTKA3pSzMKc4JdcsdPHjrlu/zrnfgA1XTHe+/RUJGU+FQ+QzMF7hdwP+Sr4Rx3sN64eLZVlkdmJTA5nNIMNGW6ipAokLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088280; c=relaxed/simple;
	bh=wnwr8VIeFoFDNIYnH2d4fwPiRi07/mlHhf2KDzBg0oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9hRlHx26jnmK+2svM1uYpMO3eVXPc+crERyiGWZhUVta/+6YVIY3uSWiE86WygNAmE1nxaFbSBoYIw3YsjyvJdzBrfd40FnbUiEp3jH4oRfT7xHF1f8TLgLkR2QHjf3D73OQmGZYjf6hH915Xg7tkRTjxZi9Co4hSoRgbtLW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4cfx6Hd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4cfx6Hd"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb587d0436so28562371fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729088276; x=1729693076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnwr8VIeFoFDNIYnH2d4fwPiRi07/mlHhf2KDzBg0oI=;
        b=U4cfx6HdqlbjO4dMReaQV45yjI27uV83ZRv+Q7gHazRYpq57cdCGoC+B0bB3W2UE24
         iF+i3XBipL8HZ1di+i7BVRvLr5T0OSe9cpaIuiWqvkUopMRcPuuNAH04w4h+xD67Ptjg
         /Ejsdo/UHsVmhqyNRptr3ISQFubUDJt9UXW8CQAqev8WYaNEucar5XzQjt/jPwBbR2k0
         gBKsf09QWhcdPjvg9NytYVFJvsEpc8sOkKu1dQCXbTQ+lxCoYMVpMxy+2F7FYHNDU79b
         ZRsckZ+N17LNting348fBz8Pm3CVsCaJNxsaB9DQQeWWw1aS4DG4ejObgaRV0qgbl3w6
         72rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088276; x=1729693076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnwr8VIeFoFDNIYnH2d4fwPiRi07/mlHhf2KDzBg0oI=;
        b=DAIk9TcC9fpl+c5sfg6HtG+USYUP622OoI/fHf1adardQP7p/TroajDBBZTZCRAV+S
         1EYIF0Bml9E92PhhthuU+y4tLJCh3K0X7mEKVrxI+lEnmGtV9UWG8uL/899mGrpLwQod
         forIE9e7sMhKWd17AIii+uzStAedmyoAZBuke+gYaMIV/FaltuK5LwGH6mxgXK9waB40
         KdNDMdI4FlQd0KW5CgXVTyITYDLYtg2/4cFSPo/rJlDJZfEm+HuQkHCXY+Y1lwgvyZif
         zTcAsY/owpmK/cEBIp0CIbgD+GtoYw6WoCLHl4zPJHF6sSAuItXXtKDFyaayu+4Cc3wm
         1sGA==
X-Forwarded-Encrypted: i=1; AJvYcCXOwDzHBiWdNWMMMph+wMwem0duQQ0/KWpJv6SCR+l3dAV4hAgOna2z90WDPAJKNsOzfLw04qnwUCYWWWczRWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qQLc91yqxIZvwM2sKhBYjFqMibYt5mCMokrN3l8/ZSBjFg5n
	zxc9ZufjB9TQgX7ThBCD5QjQNiqBsmPPz7hVLBMqF1KMm+/PFMIdfYPQE4hM8t1YMfl6Hj9RXTO
	7kyY1Fata0qIM0x6PYSkw2/8KDTQ=
X-Google-Smtp-Source: AGHT+IHFXScRRqpvQj4s4NzvgMd8nLjsaWhY+TMebYnEgA3IS1XU1uU3VypsyyQAzjGpmlv8DfS8LiEwMmxmmM7Em8I=
X-Received: by 2002:a2e:702:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fb3f1b764amr64519771fa.23.1729088276044; Wed, 16 Oct 2024
 07:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202326.381559-1-luiz.dentz@gmail.com> <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
 <CAJZ5v0hE_MVn2OJomHQzFK1Ft1hA4LWqp4KEauQYLt1CZmPopg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hE_MVn2OJomHQzFK1Ft1hA4LWqp4KEauQYLt1CZmPopg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 10:17:43 -0400
Message-ID: <CABBYNZLhGTNYK9dver42kGFnfJtw49MY6h+Sk66C0kXg86LAOw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect
 after suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael, Paul,

On Wed, Oct 16, 2024 at 8:06=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Oct 16, 2024 at 7:12=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.d=
e> wrote:
> >
> > Dear Luiz,
> >
> >
> > Thank you for the patch.
> >
> >
> > Am 14.10.24 um 22:23 schrieb Luiz Augusto von Dentz:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > Calls to hci_suspend_dev assumes the system-suspend which doesn't wor=
k
> > > well when just the device is being suspended because wakeup flag is o=
nly
> > > set for remote devices that can wakeup the system.
> >
> > Please mention that you revert most parts of the problematic commit.
>
> Yes, it would be good to say in the changelog that this is a partial reve=
rt.

Ack.

> > > Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> > > Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > Reported-by: Kenneth Crudup <kenny@panix.com>
> > > Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend r=
equests")
> >
> > That commit is not in the master branch,
> > 610712298b11b2914be00b35abe9326b5dbb62c8 is.

Right, looks like I need to rebase to get the updated hashes.

> Right.



--=20
Luiz Augusto von Dentz
