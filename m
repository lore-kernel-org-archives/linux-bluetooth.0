Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A231FC1D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782855; cv=none; b=LhOuPojLW6yBd2piAjzKnIKv+0wazEB3q6mftUgXVahqc+JDqfljO6ct24INt7UMM4FiegOzncZLIJNFoQ2MNFy3tII5jvWGX1A2OCkvGhLNg+KbB1DeioCafRp1F7aQ5ZOVBEL8cm5N8/anqAVFvm8apmG+veQH/+I+NpmuuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782855; c=relaxed/simple;
	bh=gifUe3lNY/oj+wrVd4J3SbQlywZC4PeB5JOcE+E6aTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8NhwyWFSLa5k5kKokCl1nAYbf9955OojhzAtzu4ISbXN8VOOuNzgykX7UYEHFUgSmffeRJeZM1zmEKX06CkQSdrv7MZFDc0XCGDDsjtRiQH0cBsH2ssVqm/c6sbyTRgZvvxno31FAoxsLN5WZ5z4MeHnzOy6n0gGVazGK391I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjZtv48N; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjZtv48N"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d28051376eso5860311fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 19:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709782852; x=1710387652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9Vpu0Y/TYz8zA/kY2VOs6ZO4FJ55QrYjprNjE1Eqo8=;
        b=ZjZtv48NZsF7nqwTuC6CvjfKGt9/WrUgYMK2HQvfXTW7o03Z2nTTlZ28TJygO+OXXe
         MpAyszxnlfLjwesVMNKQUuadLi7xuUbnJsLtimwC4x6PHso+g1eAw9QWv7dEwrhB8Xir
         A4rRi3vqnzcYQ2mBbp5HJQtaBQIgN+IMVr6cXXIraPsZl0TD6jHPuGXTu3+U9GJ/Xr7p
         pLZ61Fmiio6ncOxXpjtojFODAWr7eXSqntGJdGSnqORszpbeUH9hhasHQbTdwtMt9Zxt
         3XTdY/KbcKn35UOtTP7iLOVmrFf71AoubRhPPbLx0bCwN3djZb47USWDYV8AhP8CNRiV
         iEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709782852; x=1710387652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9Vpu0Y/TYz8zA/kY2VOs6ZO4FJ55QrYjprNjE1Eqo8=;
        b=SzibFvxqQPEvJPe+Omc1r27AyOYNuwJv1fZUsn13Ko/jSC1Bhn95fK3hlYGKwkTx3B
         kYpxUW4WQN61QkIF/5vow9ddintv5qJwNTgN/WrGFfmZ1RKupEBQrjNwWzL3fi7zF9Vx
         CS7MeAHjsoEuJHMQKUwmJPxc185h6lh5IdraCeUof/zkJsxHIV2kYMjKq/cIHk9+n+Rx
         CCJtaH7xqRfowrzTc4SDKD+1miHNzuIS0NimJ/fE66FfwYPKvphJsL/SCQPB4N1c4H+Y
         2TmCGe8F19YXf2wOXjnzDbfyWITQ3adrdCZ5Hy82Lhr8pZToc3szAn46Ox63qgusT3AO
         yYQg==
X-Gm-Message-State: AOJu0Ywurwc1xXaFf5y1p6xfTXo6kKJuH2kfQS+u+fHNcatTlq72Z4hZ
	xnjsoFO9rJ+A2IPh7hdph4b6bIDH7CPSe/RPb3bhIqTm/mayMRdUmiO17/SDFV2MyxZlEKiJ0Zj
	4+fZ/AUZKp7/Hx/rKDqbPDW1R9ObHG+gOCME=
X-Google-Smtp-Source: AGHT+IG7htNecXr6yyyfTh1DvCBUK1IQMOim9nxkbL9K5mpbwQZNcfTZGnpAUEShe5uHhLRTvX14ILB+Ywtj3G19yfw=
X-Received: by 2002:a2e:8e2f:0:b0:2d2:e897:bd06 with SMTP id
 r15-20020a2e8e2f000000b002d2e897bd06mr409156ljk.46.1709782851799; Wed, 06 Mar
 2024 19:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Mar 2024 22:40:39 -0500
Message-ID: <CABBYNZKixCvfq-eZLVgq7ccv_mui-h6QH+5WJ0=mUPut-z4P5Q@mail.gmail.com>
Subject: Re: [PATCH] obexd: Install D-BUS service for non systemd
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: "linux-bluetooth @ vger . kernel . org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joakim,

On Wed, Mar 6, 2024 at 7:40=E2=80=AFPM Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
>
> non systemd(like OpenRC) machines need D-BUS activation for obexd as
> they lack --user service.
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> ---
>  Makefile.obexd | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 385e5618d..cfcc115b7 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  if OBEX
>
> -if SYSTEMD
>  systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
>  systemduserunit_DATA =3D obexd/src/obex.service
>
> @@ -10,10 +9,6 @@ obexd-add-service-symlink:
>
>  obexd-remove-service-symlink:
>         rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.servic=
e
> -else
> -obexd-add-service-symlink:
> -obexd-remove-service-symlink:
> -endif
>
>  dbussessionbusdir =3D $(DBUS_SESSIONBUSDIR)
>  dbussessionbus_DATA =3D obexd/src/org.bluez.obex.service
> --
> 2.43.0
>

I guess you want to revert 9cc8b97b8f5d060e334207136100e947732aed08,
but then we need to fix the checkpatch error:

commit 9cc8b97b8f5d060e334207136100e947732aed08
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Mar 4 12:44:08 2024 -0500

    build: obexd: Fix make distcheck

    This fixes the following error:

    /usr/bin/install: cannot remove
    '/usr/share/dbus-1/services/org.bluez.obex.service': Permission denied



--=20
Luiz Augusto von Dentz
