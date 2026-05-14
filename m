Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58972C1594
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762057; cv=pass; b=P1/XEEUvjh8RDSPltLce6jW4Gl3ZmLLfZd5hoDOmzh5VEBE/d+JDD0eCFGSQRfYV5QqWx3KxNBemx/bIv9/c1eKFcNm+yH+XEVT4pD6eDs8ZDFWk7yMOlY5HG3P1p+HgBZq5TIUC6TtcLmjIBTBHjgkI2BNuRX6Vsqvnw3aX4fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762057; c=relaxed/simple;
	bh=7UCJTwED7ciEjo8Z3G6fddRRHfqdc8XEPQWuuetnraI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3614Pd52sanhpb+7oDBv/L6cCnoKAj//IQMWSlnB9DWCQ7n3Cy4zQroGhXFXk3/vQ3hTu0K/3uliFNLLi53pwWLa+zZBcQl8GXxEzrth08bGMifFZBvKKCKTHL3UuVGBiKNDYLBsFPz5XBAcfdSAEHCw/xTI/eVDECO93ZBh+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp/6zYJR; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/6zYJR"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso9091310d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 05:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778762055; cv=none;
        d=google.com; s=arc-20240605;
        b=CQYnvUJwHhMWUcZRW70msX6TfY+V3hM/M0u7+VNASHC5Eqkjr5iZiJ+xyEJ7AlbXQZ
         8Yx5vwvrMed0nVr0Oa5GMNEgjLs5h0Z5MdtVYaJDyfRuezZMySTHDen4vd7UEIyI3CFb
         jwCRUDuUneTlUwUrDkcs/QSDqPZyu56UF2M7EmLEJrrEwtm+3+XrSBt9CreKbTOdos/B
         3hE3dE6TvbAvfUxATgCZzBqrDu5ZqSgBb/P88vbQb16rT/Y40/Z/BzU4DiDcjnm3ml/7
         FUkebJugArH+vGv9KWaSTI0zFXXkQw9WNr8MW2pyHNCN2H3xOK520YJH6dwRZ6JuAtUi
         ahZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gz2TTawh0MHiUepdIXeJXiiqSS32AKe5VIOrS1JsoNA=;
        fh=AgHgUtD/7w+Cabg7jFloqGrIZFc62mpbK7i/ool+Qhg=;
        b=BznWTL4WOkr2zd3ikIatYrQcu6yDNSe5WPPfllwYyfdsiCcifzUpbvjLBoM6gXdyHI
         JecOg4dqav0OsPpIVz8E4/uVgyNpkviqn6OdQL9isQ4gQZZS9A/c/1hARGRB2uUtOCck
         XKH+LyROcQrtMKwzEaB79YYKkYNFvEVyeWwj5cF0KE31JB5lIMOlKO7TNTmLvbe0EhbZ
         gCKghSS9X3g68S1HIsG0STz3BA48c3UsgqC0Q7kAqizRLkSjDBhQyFkWQnWOrEDCYdqy
         v02Ewb3ZKCHWL01ZKcT3HHs4EaSATNG525VL9akrO9sHHRJh8pWK8i0NXD9UMoOjnWf/
         S06w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762055; x=1779366855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz2TTawh0MHiUepdIXeJXiiqSS32AKe5VIOrS1JsoNA=;
        b=Vp/6zYJRz/skyvYNa08MS0WIz9vM+GdF1aqCXAli36GlgqT4crNqVsDx89JSHVJke7
         vmpbgsEvF2ewBa1sgNSyNDD+kJH2pWaoQ+FHne1nJMb6gFh7d/YfvbTk7VKPsmTIrhRE
         S9zn97b2FB/HBpkjLuIoH4RNlKk/ESHwtgZDILHeAgQ/UvfjHZo+98Y1eAX35elPvVuf
         D2QxKddq5xkY38dQ3ZpGBXKYu0I3lK2mP1zZlse2Uz4Ya5VTCXgmwZRC+Ot/Z5PHrsom
         1BpO0VoKi+6RuIl7a1cA8kvAtqBLjPczPPsmWjVB9KLPRvMIx9qi76QqSvrFKHdDaGjR
         SvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762055; x=1779366855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz2TTawh0MHiUepdIXeJXiiqSS32AKe5VIOrS1JsoNA=;
        b=cUBqsxWdD9tvYmoMQL/iQ+AXGcaPlkrQo3UKLjhUbThsYvg4TAEPzNdcgxNik5dIZX
         AL4D/A3ZfSsyVdT1vVrJA8yEapyPFxzSfFFn9jhrXQ77sj3uGFkw/axw/OsnA2VBmSTO
         UMq91XyiB3k77BQfVhw4sCcpmF8F8Q8U3Yg34V2rvpUHKRjFPFGenMDmkhOoNQ648DTM
         vMumtQrcN8rkRrn81y4XJ7Yi6psfelGUJBvFFH8Kt+IJOduYJSWMt/JRclvzMeNYKeul
         VulxsQuhyg9vyqGFAF1GT/l8PCFGoMLHJ0BUwqhqQ7V9FHqkEP4qUPQtqrlTd9QhE2+7
         T6aA==
X-Forwarded-Encrypted: i=1; AFNElJ88hLeiSiYPMaEE1E4clV2RiYL5LedTyKX5kYD6JADBc5o8lChgQ+/Z/QIKFCgovxhvYb0YhYQziaASoboWNAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7x8p3nc+0k90yVIS1+Ld1vYS8Ya2ZV3iZ3SZn6S9mzUrba/D
	IiRh0aRECGfQp4JyB/4Bohi4ki2jHO3qvfwfEgb8pk6K6Mf9S4cMKXaadRH8uYA5rNzFj4kjSxm
	AVGwHw6p6d6AMr6wxWl0NHvgr6j21qWfNOoCIP68=
X-Gm-Gg: Acq92OHvG4THAg8omSlACCJLB0BT+/P8G0Zqlhq0Z97iikSU6m12Nwx2S1b7htY/T3G
	GzO8uL3ilpMwbKlpLwule7eYq2KmABN5+hqgq46sKrX3YAaMlU1b7R3hURwxh+jcH7uhdY7nQvK
	wnSOLimwtI4XqULaEl4hX8/MnhsAGROjlZQfITc/W2W6Y5idB8cC4WIdMKTQUs3bj8j4gHeaeG3
	/8R+hRffPNATya4L8tjSt0Ls4Hy+t7XDG0QbEPpvmDIkhcLrIu/XF57jRgxYAo5EC09uKRxc2BS
	7x1ifesw3/c6tfbKN1QHI1WqeKuxHwKc3scXFMdXEQWSTFgBVaPLQayPn27Axsnq55yu
X-Received: by 2002:a05:690e:bcf:b0:65c:47ad:26c8 with SMTP id
 956f58d0204a3-65df622f493mr7388194d50.18.1778762054675; Thu, 14 May 2026
 05:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <46f7ee10-3fa8-490c-bb17-5929229206fa@vii.li> <3da9180c46e0b3651a3ee4d552bb5cf5f8b70186.camel@iki.fi>
In-Reply-To: <3da9180c46e0b3651a3ee4d552bb5cf5f8b70186.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 08:34:03 -0400
X-Gm-Features: AVHnY4JOlxxWcK_8rJd0jURzW4zP6fszFLk9s9ecAXA_aliIbYrUbe61UU-CL5M
Message-ID: <CABBYNZKVNxbq_eDf-EWqh5XDAUbYd4J=4OCYKu5_vyjB8Q5+9g@mail.gmail.com>
Subject: Re: MT7922 does not work in 7.1-rc3, works ok in 7.0
To: Pauli Virtanen <pav@iki.fi>
Cc: =?UTF-8?Q?Taneli_V=C3=A4h=C3=A4kangas?= <taneli@vii.li>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Taneli,

On Thu, May 14, 2026 at 7:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2026-05-14 kello 12:57 +0300, Taneli V=C3=A4h=C3=A4kangas kirjoitti:
> > Hey, this might be also a mishap on my side, not yet familiar enough
> > with pacman to say with certainty I didn't mess up something (like
> > firmware loading), but here goes anyway.
> >
> > Bluetooth is provided by:
> > Bus 001 Device 003: ID 0e8d:0616 MediaTek Inc. Wireless_Device
> > I believe. This is a gmktec nucbox k8 plus by dmi information.
> >
> > With distribution's 7.0 kernel bluetooth shows up fine in Gnome and I
> > can connect my headphones and get audio. Using "linux-git" package,
> > which built 7.1-rc3 (+ some commits on top in torvalds tree). Booting t=
o
> > it, bluetooth can't be enabled in Gnome, everything stays grayed out an=
d
> > no devices are shown. (I tried 7.1-rc1 earlier, which also didn't work,
> > but I didn't take any notes back then.)
> >
> > The difference in dmesg is that on 7.0:
> > [    6.152649] Bluetooth: hci0: Device setup in 173263 usecs
> > [    6.152661] Bluetooth: hci0: HCI Enhanced Setup Synchronous
> > Connection command is advertised, but not supported.
> > [    6.216582] Bluetooth: hci0: AOSP extensions version v1.00
> > [    6.216593] Bluetooth: hci0: AOSP quality report is supported
> > 8<-- 8<--
> >
> > And on 7.1-rc3:
> > [    6.270455] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
> > [    6.270466] Bluetooth: hci0: HCI Enhanced Setup Synchronous
> > Connection command is advertised, but not supported.
> > 8<-- 8<--
>
> This has fix pending
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3D162b1adeb057d28ad84fd8a03f3c50cf08db5c62

Will send the PR today.

> >
> > There are some changes in btmtk.c between these versions, but can't see
> > on glance anything wrong with them, only adding support for MT6639.
> >
> > I'm not on the list, please Cc: if I can provide more info.
> >
> > Cheers,
> >
> >       Taneli
>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
