Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B112882A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949440; cv=none; b=h9VkSZONq7TO3wQgGwCHFMdPsnStAekjGNtT5d9BfG1546TrveM7GFCeuJ765NDKr/2KZ3TcbPJ24jIzV4XJYPtms10tMPUGASsJPbO9py0qpv2qF+HwwWRKv+gTN16jRHrWicQgZgw4cETnoXiIxbsM2bFP/PKYi++uB5vFKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949440; c=relaxed/simple;
	bh=UZWu2/krPZ/h6GcL42EQRHdgxMqDW7m3QFD5YWBWBD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK1tgim8R1ThG00MdLJt6OcvdYhX4KHD/7RZNbU5ObLmcvOlPJc/8LyoZ/SSpXMza9c4xKcb9/4wgkSlDq2/Um5lvGThZjSf5RdyIhtBu271XcGDvIYOeBD0kiZjrpsedqL2rSus/YS4BDwDU372i+g17R0EoVVwrKpGwKDPKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYhOy4Cd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYhOy4Cd"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso14776611fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707949436; x=1708554236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMpJhfyBBAwMMYGHAWDHpyiu99kNed/I2NKZjQNay0U=;
        b=mYhOy4Cdz+eJn48luuykOWxaDreagWBk3xA5WsSqYaxoVzfrSO/ILPFi6uJpUAbsPi
         d+kaKRAzFqauS1LRgCbCKKaB1PKNzJ5XbAPju3tLO/AJUdcKzTF4WGbjE0k2bqWlQuMu
         Me88gB3Eyn392QZV93dsDcREuTKRT+0SstUV6A8VM9JT2GbJGxLMfzTuEg2jgOkqJQ81
         TgL251+Fz0QkvD0Q70cVjsdHM54DB8pUqtX0m+CxyIRhJ/CeYJ59G0v91g4l5D94JqzO
         1Z7FdAtTyuRjmapVUwIQJ/omhXkdMipZIaEZKzdR5INdvq3fZPm9XC08XuNssbjEAQvJ
         GNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707949436; x=1708554236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMpJhfyBBAwMMYGHAWDHpyiu99kNed/I2NKZjQNay0U=;
        b=aJ3Z5FbVS/JJNTu2ISNuRxO7WCj+PaB7csfd7JLClkrHbpZmAwtkLX9xpVnOEPwhbC
         gV3OvmtSMTmJqkOjt8n4kKd69/DpMp5pZvfiD6wdzSbCiG6zBBDk1OswvqrsG0xUAV84
         iu6T43ROkgSOwMcr/tDKY1P2sVXYVucvc1zQz/dr/tZkEhExDEdhvkbEp9niXM5naZlv
         ck2ndIOMlp5zrbpQUwN94Ohm6aE39UMBuS33/rLRAkWlK0Dpkl5jSBp/tNc8bnl5lpwM
         Os6BEa5OuUChvgAMEO6ko1Xd9g1wMNYl3GZ//xKBZMaoYrJCFRaXxb06tp07N0M1YWZb
         JktQ==
X-Gm-Message-State: AOJu0Yy5osMh9VRvTDZvhZHqay3XNDHNL6qw0AkR5SbOkvTjO2iRYII/
	yVMI5+ib24NQ30Egw93tHO3Lz/oyepKABy9SweMKAXDMqLnrlPeYtMM7qny8DfheatqbAeHFvex
	LYS5cKwXZocoSEJcjmx5zc8cxlsV4SU4R
X-Google-Smtp-Source: AGHT+IFGcmUa0WyxqmvFOeyNNS9EloxhzIuKQXWvQE+aHO65Lt9J8DTqX8ZxuA3J+CtyFYCOcvhh27BwkZx6Ce+zfKQ=
X-Received: by 2002:a2e:8908:0:b0:2d0:e5e5:f40d with SMTP id
 d8-20020a2e8908000000b002d0e5e5f40dmr996402lji.17.1707949436204; Wed, 14 Feb
 2024 14:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com> <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com>
In-Reply-To: <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Feb 2024 17:23:43 -0500
Message-ID: <CABBYNZJE6h9MKo8Eyh9SNyYWBSH9Kq6q5o3bcH-wEb41QXaAvw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] build: fold separate install-data-hooks
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Feb 14, 2024 at 5:02=E2=80=AFPM Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> From: Emil Velikov <emil.l.velikov@gmail.com>
>
> Autoconfigure throws a useful error, that I've missed previously. As-is
> with two identical hooks `make install` will fail.
>
> Just fold them into single place - not particularly pretty but works.
>
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
>  Makefile.am    | 9 +++++++++
>  Makefile.obexd | 6 ------
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 5207c172b..e67551761 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -34,6 +34,15 @@ statedir =3D $(localstatedir)/lib/bluetooth
>  install-data-hook:
>         install -dm555 $(DESTDIR)$(confdir)
>         install -dm700 $(DESTDIR)$(statedir)
> +if OBEX
> +if SYSTEMD
> +       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org=
.bluez.obex.service
> +
> +uninstall-hook:
> +       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.servic=
e
> +endif
> +endif
> +
>  if DATAFILES
>  dbusdir =3D $(DBUS_CONFDIR)/dbus-1/system.d
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 81456544d..b91ca6644 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -2,12 +2,6 @@
>  if SYSTEMD
>  systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
>  systemduserunit_DATA =3D obexd/src/obex.service
> -
> -install-data-hook:
> -       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org=
.bluez.obex.service
> -
> -uninstall-hook:
> -       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.servic=
e
>  endif

Hmm, isn't it possible to do target specific install hooks?

>  dbussessionbusdir =3D $(DBUS_SESSIONBUSDIR)
>
> --
> 2.43.1
>
>


--=20
Luiz Augusto von Dentz
