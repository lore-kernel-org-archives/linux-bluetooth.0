Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544C1A0AFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728582; cv=none; b=iWozletiJElPCjhiS0DQHcFh15twDyrzKu79o8NhBGeyFYGrj6JUa2SXotg5QQexzLIpfcGlnED9VZv+z8psTGkH/aKGEyiz+5wKPxOytQgXXFfPy5PyU8x1A6INOlKD1hkVEUV4yMf+owPRcYL3DZGyVl7KLg11jpIWZs+lfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728582; c=relaxed/simple;
	bh=JI5NfGq0gMASplyD5moBErjerGTvBDt0poQONGmeICo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+faN62Ny9RzcOmklqlC+FpQvXMa1fOAy2as3B4UQDQXEvISIvwMJ3DCw0EvOvD9jxKZ1Z9NPmqx7Yd5P4Jg3XueOO5OHXN3cfuhfw2XARlqyOU+MSMbWqfYRvdp0I1UloXhLZUipjDO8zWv4uU+zhSLKoknk3KTAnNF/FhLzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5j90IpQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5j90IpQ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so55766811fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728577; x=1728333377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZC6XyIOiJHJwZocn3wl48AQYobh5kChYXVoUiIHlcI=;
        b=B5j90IpQ+RRtbhJIg2ZX9DUlzru3wuyG65N7a52mUmpGLgygJIxcMxgylv2+JzLmJf
         oXy2N9/Nz3SOJqChWcDWtsn8wtPF9+ONIi2SgGhwznfQvNqjezcV6xxngAEAcNVd+2jD
         zvYDetGWft0oirLanfXz8j5VVzGa340Hx9/kkSrt27E9nj1KW16qWHxFFP3YBaa/MNZh
         8oXmqnePJ5TGsaAfdOrY7Rl0v1WU/+LebJ4CBnhiqtxqY4TQidMQA0u6k6KhTquHtRoC
         zP1mIHJWf2Fv5ZDvr/iai+JCEqBOOtqMZzilVV8uL72Hzc9nDWVG0ZV3uboF7koM0ZxS
         gSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728577; x=1728333377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZC6XyIOiJHJwZocn3wl48AQYobh5kChYXVoUiIHlcI=;
        b=XdXG1zeKBzK5uCzv/IfsMwl1rD2nKsoXkETFgsTKpDuapAuwtJk26NbaJSwkPvxKdS
         z3a4JFK0ICvpS5mbVbIYrzEy8+7MmrS8gxWxOJIO+CQAQHYfL+mdSKtrJsMuBViA2LZU
         ofKNi+Gg/hdtoojZKwTopOqX9Ru5ZRP/heXdZK0dujumdFTkNIgmfyZCY+tga20w/ecW
         2+id3Jc8/5lXUblsbp8o1UVQyXfwv3NS77oUOqxgi3aVGYZsIlEH6rPJYu528Zuag28m
         mGoTvz2DEnmrmj87xnMxK82Y/b7B6H2x36xumxqPgCT6i1/V4PW2Jz91dFMveJOCjerH
         g6hQ==
X-Gm-Message-State: AOJu0YxrVFxA/D4w2Y9m/CRPDJkArT8/yXYQnK9jgQAeQX7GuGDcYNfk
	0XVepQ7youbeDJu3HRJviBJRCnEmfRpEcA77xK5qRseDPQzLtyliY9tEO5SGempzsJdG65QeKLq
	bm6qP4Eo1ypqtFkj8fsB74EYfJU5gNg==
X-Google-Smtp-Source: AGHT+IET5WwhrUr38ieQIhr/88au9MytXt8vqmOtbYp1MzZtjLNCgTGCuOaqMlWoilITEwPR7gPaEanR7wkrrJrQO+M=
X-Received: by 2002:a2e:a99c:0:b0:2fa:d978:a6cf with SMTP id
 38308e7fff4ca-2fad978a992mr3364571fa.6.1727728576269; Mon, 30 Sep 2024
 13:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930193044.2907716-1-luiz.dentz@gmail.com>
In-Reply-To: <20240930193044.2907716-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Sep 2024 16:36:03 -0400
Message-ID: <CABBYNZJmvW8B65OR3M19pWnKCipDzoHbxKVtGvoQZCBi5feK+g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:30=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> rfcomm_sk_state_change attempts to use sock_lock so it must never be
> called with it locked but rfcomm_sock_ioctl always attempt to lock it
> causing the following trace:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor386/5093 is trying to acquire lock:
> ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: l=
ock_sock include/net/sock.h:1671 [inline]
> ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: r=
fcomm_sk_state_change+0x5b/0x310 net/bluetooth/rfcomm/sock.c:73
>
> but task is already holding lock:
> ffff88807badfd28 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x226/0x6=
a0 net/bluetooth/rfcomm/core.c:491
>
> Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd7ce59b06b3eb14fd218
> Fixes: 3241ad820dbb ("[Bluetooth] Add timestamp support to L2CAP, RFCOMM =
and SCO")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/rfcomm/sock.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 37d63d768afb..f48250e3f2e1 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -865,9 +865,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, uns=
igned int cmd, unsigned lon
>
>         if (err =3D=3D -ENOIOCTLCMD) {
>  #ifdef CONFIG_BT_RFCOMM_TTY
> -               lock_sock(sk);
>                 err =3D rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
> -               release_sock(sk);
>  #else
>                 err =3D -EOPNOTSUPP;
>  #endif
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz
