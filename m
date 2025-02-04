Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F8215F7D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687125; cv=none; b=IKBcPKYVbQ0LYuPNXKjndrTdWOOggbGPKyg67mWgrslEXzRQx8+jeez0GMkhSyFxOgZGRSKOKW/fxJ3Ax8qClRLeVFRjt9nHS0Vz7kH8U6ZndJcozdeKkdgswGZmuKx7eJtNLQpTmiyYwKFYGuCYyzEC7C8kWlyx87vIkXdGmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687125; c=relaxed/simple;
	bh=VqXwdTT4aYAIspkwnA41t/VoBSsJjN+IdxJrwqDAuh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro1T9JcyY5Ocx4r+F0IWuDr9k+ldCkFvntQJQpXlr9z7SLgLf1EZIJqlJmka9KXnl186zdSitvWEyazm9VGKUjSVWA2D0NInDPnLZOXEs885lf3Lt6q7Ty5quJzx3u4zejNwNOm94ZKUr2hbmT72pr4UYazthJjM14ZZ83GbKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLICpPF0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLICpPF0"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3072f8dc069so55677851fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738687121; x=1739291921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gvzIMShBLWXAJpp3Hx/A4xdBhamgyadD6Coa6DxcDY=;
        b=RLICpPF0FmdQzmw+xTvcNsDDZO6a8dTLOgNiyu6ALqoBmb8zwAphR2qVnvPaoFsAFe
         oqX5aKXe1m8N6qkLqDj2kCnhV9H+6YBIEHu2/u//MZBqe1IJzcHIeY6vaIGMxWtnCI0y
         SZ0oE2LH71kvssi9nESzYj30tLeUhZt1EQ0N4uTPUcJUIQGn9FBh/LlxZ2HJxRAoHClT
         oJDy4sBc8hYFx/5o+7goGmbpCI5BGSyEVNo7vFWLW1CrleRMrbACfZL9bmR/mk5c+Sg2
         UZt+nCCasYLPqorNO6lxSw0ixzghvmuKLGXGm2btRQO5R1ahUKJqk4nX9+e2ECNILjvj
         AvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687121; x=1739291921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gvzIMShBLWXAJpp3Hx/A4xdBhamgyadD6Coa6DxcDY=;
        b=NwGvMn/oJQk8JUNtpMMuDWcbHI+yPaTIUE/P4iRhL2gUuuU71ChYVvzlQVveQk2nz1
         FZwov8DWGShLvqL2tIyMg62WzkvUxZhFt69lrnqm2nAsqJTibMt+IFDiY2HslNdr1PBZ
         Ispjdfp/WCgIeVpkaigLL0tO696jDXO7F98qrtEpFXf6YmyppTpxOJfdoI1a/7nhV8fP
         QqkKsSp0axHGdRyOS6m9mplGvzNFDYsLoWJCqve8MpByx/CN5KIRFNQBb15YNvy/RJRu
         kfAM/abCWy2HU8Nv7UGbsxQzqXT+aTeHCKuaIPIQjaLBg0gZ6UEjMh869xDPscS1OVbK
         QGuA==
X-Gm-Message-State: AOJu0YxlSeifOItaCesrECYIFJ7A9PQyCWVNF8yL6Dib4+M9mKP6k2gD
	dCJqcus+C6tp3pL7jqRjomOTHfbOZhr4a1WYhhd0VnLOGu7h9xXexbdZDqQkXjzVkOWw6CPP87L
	NNdlVIemS/GcSt6RQw77EpWVvfADDMHNa+eii+w==
X-Gm-Gg: ASbGncsw95Dxvo7g7GMJLUnQDi8/kwdXutOAMdghFjovaBbay/bugHO/xT1c0l6S+Ht
	YV9JZeL0V80fjaL2yXQPKRuggC/iYSWaB2KLzbwD+8KFxQ0iNgSHRldg67H1WLOfS4oaMCF+ShQ
	==
X-Google-Smtp-Source: AGHT+IHw01uZPX04zfb8+C+SWmZLwr3dVg2NJNnhtDMNhZgksQvpCqFntYrpxVFCEyHr1vNBWnuWiQLgo8rDgb72SGU=
X-Received: by 2002:a05:651c:2208:b0:302:3003:97e with SMTP id
 38308e7fff4ca-3079695585dmr91944791fa.30.1738687120636; Tue, 04 Feb 2025
 08:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204101612.66823-1-pmontes@shsconsultores.es>
 <20250204101612.66823-2-pmontes@shsconsultores.es> <CABBYNZ++i8_KULumH4LcTmsW6utc_S47-u26C1wZ-a-Zdg1sVQ@mail.gmail.com>
In-Reply-To: <CABBYNZ++i8_KULumH4LcTmsW6utc_S47-u26C1wZ-a-Zdg1sVQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Feb 2025 11:38:28 -0500
X-Gm-Features: AWEUYZn53De4gGox5RXYvd3cgyWDLV_ZdJtPQ7Z44reeFDc_Y41_gE3aXVCa2JY
Message-ID: <CABBYNZKmMxh1sZwRXn9bmDAD3yxM7h8Qnwa_kDryGynsB1pjcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] emulator: Fix Werror=stringop-overflow
To: Pablo Montes <pmontes@shsconsultores.es>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On Tue, Feb 4, 2025 at 10:59=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pablo,
>
> On Tue, Feb 4, 2025 at 5:17=E2=80=AFAM Pablo Montes <pmontes@shsconsultor=
es.es> wrote:
> >
> > Warning on read for a possible packet offset
> > greater than buffer size is treated as error.
> >
> > I suggest using ssize_t so it is always positive.
> > Returning if packet offset makes no sense might
> > not discard the whole packet and start again
> >
> > ---
> >  emulator/serial.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/emulator/serial.c b/emulator/serial.c
> > index b74556b13..13b844033 100644
> > --- a/emulator/serial.c
> > +++ b/emulator/serial.c
> > @@ -79,6 +79,7 @@ static void serial_read_callback(int fd, uint32_t eve=
nts, void *user_data)
> >         uint8_t *ptr =3D buf;
> >         ssize_t len;
> >         uint16_t count;
> > +       ssize_t available;
> >
> >         if (events & (EPOLLERR | EPOLLHUP)) {
> >                 mainloop_remove_fd(serial->fd);
> > @@ -87,8 +88,16 @@ static void serial_read_callback(int fd, uint32_t ev=
ents, void *user_data)
> >         }
> >
> >  again:
> > +
> > +       if(serial->pkt_offset > sizeof(buf)) {
> > +               printf("packet offset overflow\n");
> > +               serial->pkt_offset =3D 0;
> > +               return;
> > +       }
> > +
> > +       available =3D sizeof(buf) - serial->pkt_offset;
> >         len =3D read(serial->fd, buf + serial->pkt_offset,
> > -                       sizeof(buf) - serial->pkt_offset);
> > +                       available);
> >         if (len < 0) {
> >                 if (errno =3D=3D EAGAIN)
> >                         goto again;
> > --
> > 2.43.0
>
> I suspect the whole idea of buf being static is not really necessary
> since pkt_data exists we can probably remove the static from buf:
>
> diff --git a/emulator/serial.c b/emulator/serial.c
> index b74556b13547..f8062ae5eac3 100644
> --- a/emulator/serial.c
> +++ b/emulator/serial.c
> @@ -75,7 +75,7 @@ static void serial_write_callback(const struct iovec
> *iov, int iovlen,
>  static void serial_read_callback(int fd, uint32_t events, void *user_dat=
a)
>  {
>         struct serial *serial =3D user_data;
> -       static uint8_t buf[4096];
> +       uint8_t buf[4096];
>         uint8_t *ptr =3D buf;
>         ssize_t len;
>         uint16_t count;
> @@ -87,8 +87,7 @@ static void serial_read_callback(int fd, uint32_t
> events, void *user_data)
>         }
>
>  again:
> -       len =3D read(serial->fd, buf + serial->pkt_offset,
> -                       sizeof(buf) - serial->pkt_offset);
> +       len =3D read(serial->fd, buf, sizeof(buf));
>         if (len < 0) {
>                 if (errno =3D=3D EAGAIN)
>                         goto again;
> @@ -98,7 +97,7 @@ again:
>         if (!serial->btdev)
>                 return;
>
> -       count =3D serial->pkt_offset + len;
> +       count =3D len;
>
>         while (count > 0) {
>                 hci_command_hdr *cmd_hdr;
>
>
> --
> Luiz Augusto von Dentz

I'm trying to reproduce this, but even with -Wstringop-overflow it
doesn't catch this case, perhaps I need -D_FORTIFY_SOURCE as well? Or
maybe there is a way to detect what ubuntu is using so we can start
including this as well.



--=20
Luiz Augusto von Dentz
