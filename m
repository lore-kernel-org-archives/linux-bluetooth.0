Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8C18DF73
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344670; cv=none; b=rZNBxWfI/aIeOqJKhFD8SvHzc2QpwPn8nlGkBBIGZGQi2uDjh1ABOSuXs/kskH3eDPWLiUVuArI0vsQUq8BVOVG+WBMpXj10LhH8duvVxlxL5O+sP8kE9rn3ZnKTd1huCUzF0cNnAKug+aJ0xDSTuXtQcXLRL0oCGDl4Vxd2gfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344670; c=relaxed/simple;
	bh=sEr7CgEjsXVdfgqKQqRf0NPKg0VJfQ1wB4wN4HiK4Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIp3UC/sDLQ2EpLVsW2OuDL1r7RdG5tLliZxxN/WsUqQKseKxPnIVMjhi3iRsTQoMXk3Mqivo1hOyx1NfiFhZmHLplZEn2GOBsHxNNvBsGrHe0k7kBBU/qwMJ6I2CWX+vAwAltlbF/gM/mH7rMhyYe9NOr+7UuLVKky7s61MJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2caCdbc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2caCdbc"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso1284521fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733344667; x=1733949467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmUpXiXPKCJKDAPA+VfMgXZ2Lese1oz/pMddoy8YjIk=;
        b=N2caCdbc4Ct/yMKibioE0l9GGTrLybqXoxpvq4/TD8I7hXMz7D+Tu6TyYy43+tX3Tk
         tX1RuTUWA6vivz3gzZthMGnTHIynz64rkPHJJCOad+G3KHIaXDWw0/aAkXFD08cX+9EF
         8KpS7g2TU8xm3BwUOtDGZum4dveSmk2uxRunx6GLQwuEkY+LePrZOX7kfyyqi1sSiJak
         pXT1n9zK/4X8NjfgGYZgv7wwy3BsP05NVHMESuzgznZCruiCmw/BYPZomfKPGYCxGcCR
         n4Ggwek+8XCKE4s7nq2FxdTUo3ZtZzBnEw0YuQgJzES2i24I9jFzGXyIib4pc2uGva5R
         ypkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344667; x=1733949467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmUpXiXPKCJKDAPA+VfMgXZ2Lese1oz/pMddoy8YjIk=;
        b=QNZ+cEgyxBOI7d5Ec43cZh4ptYhihqbxwxod+xl0zLQbfm+M75svZ+v6JVvaU5ACZ/
         V6YIXuJFRxmeRbIjdjo1Sr/x9oUFDhKLav8VxiVHZG7gxkki6uiUyIHGQFpbNr/5pad/
         j39EhuwBBtEoeWbf25Q0eZIhlRAmZkIcNfXp/uyobBQGEMw7n1rRw8gdZsnP6bPHW1L7
         iTP44hgUV/pvgsNMJ/TYqOukvSFirMoaykm4izYCX/pDycVcP4XowvzPo8gxIVeXGsbc
         oBWpKrcq1ea0vSfau8nPH9yylHOZemsn2pqUHHpzeiR9vy56HFbLILnd208mGb3ZXUEI
         Mleg==
X-Gm-Message-State: AOJu0YyCRqSzj/ErdxMZnxwUhiRsoH3ARY65a+/PJImOAfwKQoR6vp/R
	FZjqNil+VDWLVvbxRyLA5+qniBM05XhK4eiI1y3OZcs9QBDralaUQgF3O8S7FfgdotWmPn+o/DF
	Wz049bGQrGMR9nChQvh52lFqj2+21Przu
X-Gm-Gg: ASbGncsJNcuM1dWPgos0b9G6q6t++arxQjJvDg9nd6vJCG+DNLKUjfRGTb6Zq0/DlVx
	jhb1wtlj8yiWsDra3jmQrYLDlE3VAMQ==
X-Google-Smtp-Source: AGHT+IHGRJS6lKdYuFWskkByNB0Y4Og2GYXgFr03svtgoNlzBt0I/5dTbdxW1M4INGAfNs7oBd/UZ0U5fdUhGn8itAQ=
X-Received: by 2002:a2e:96d4:0:b0:300:160f:7c76 with SMTP id
 38308e7fff4ca-300160f7da7mr25470571fa.25.1733344667114; Wed, 04 Dec 2024
 12:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5bdab6f5-fe17-4060-8d43-f43754e452f7@gmx.de> <CABBYNZJ5pPNqH2ah9CcoP5Hr2OA0J+Jmo=ai35WDNMuzTNZ7Jg@mail.gmail.com>
In-Reply-To: <CABBYNZJ5pPNqH2ah9CcoP5Hr2OA0J+Jmo=ai35WDNMuzTNZ7Jg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 15:37:34 -0500
Message-ID: <CABBYNZJmyNojrLXsqz+VN3jV_NmBatYONK=MMMh75x2=rYM8ZA@mail.gmail.com>
Subject: Re: Bluez: Read-only config dir install
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fiona,

On Wed, Dec 4, 2024 at 3:31=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Fiona,
>
> On Wed, Dec 4, 2024 at 2:51=E2=80=AFPM Fiona Klute <fiona.klute@gmx.de> w=
rote:
> >
> > Hi,
> >
> > since February Bluez installs a config directory with mode 0555 [1].
> > This broke the Buildroot build, because files in that directory cannot
> > be deleted any more. Buildroot disabled the datafiles installation as a
> > workaround [2], but at least in my setup this breaks *running*
> > bluetoothd because the D-bus policy is missing that way.
> >
> > The commit message mentions needing specific permission, but does not
> > explain why /etc/bluetooth can't have mode 0755 (as it does on my Debia=
n
> > system, with Bluetooth working just fine).
> >
> > So my questions are: Can I just send a patch to change the permissions?
> > If not, why does it need to be read-only? I think I'll need to
> > understand that for a proper fix if changing permissions isn't right.
> >
> > Kind regards,
> > Fiona
> >
> >
> > [1]
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dbe0e796=
299b0e7a73bf06c5655b56180588550b0
> > [2]
> > https://gitlab.com/buildroot.org/buildroot/-/commit/1a8676aa6e4b0e372a1=
a744eac6e53c90c03bf0e
>
> Here is the discussion why end up setting it as 0555:
>
> https://github.com/bluez/bluez/issues/329#issuecomment-1102459104
>
> Now the question is why would buildroot delete files under
> ConfigurationDirectory? Or is the problem that the directory is
> created empty and then you add custom files later?

Ok, sounds like this really is _not_ how the distros are setting it up:

-rw-r--r--. 1 root root  1028 Nov  1 15:25 input.conf
-rw-r--r--. 1 root root 12929 Nov  1 15:25 main.conf
-rw-r--r--. 1 root root   120 Dec 24  2012 network.conf

So I think it should really have been 0755, so the likes of root can
write/delete it.

> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
