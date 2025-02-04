Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5C21516F
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684811; cv=none; b=dNQMGIZzxD8K4Iq7pXYw0a5gzlGspuCYScFnOwa+mMfzGzhaYBSshzw837BNnmvMJTEhJNboC5qDtLGDidKE4pZoqNOZwT0Xe27Ln2jGjl88GUTQqPUTTwCfAT2eO+7V/p3qa+wjdq+ZwTvZ9Ve5F/9joYTtNE5HiwUOIN6xvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684811; c=relaxed/simple;
	bh=zc19VsMZ81KQwJioGoPZ91FZh7HTyceWIzVleEtSd60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKt3iUanmPyXoSlufnbrOSCYMz7e/10ZjUiH3L2QjPCSwjRZHP2CXf32/WtLBGkUHKXrIyl/qoONmUJtENIJbInIQJi5yFZ+djR7bRPNZW0Bk2HhVb1bdGrlsN/+gFc59U4t2Gs6ANgzn5QHYXUyiwvsVK4gX6QUV4+KjtYHabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMBvJnyr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMBvJnyr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30737db1aa9so56590841fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684806; x=1739289606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ek/49ztLkEvKpwtXUCcLEVy/UDtK2jUnAt0X2Q7lO4=;
        b=nMBvJnyrfpvUNdRvyuabdWFDGYZS5Lzq1NBwZoq0yodcDGrhfEET2bccFr0mRFMYGb
         WLhzKFBgSatL7rpI1Wpz7I+5xe/lnbIFvRoSJZ8g4uXhiHkZdKlCF0MLLJDCcArG+0mR
         wbY8SSaP0V4RHoA3z51FGuS6Eg9tAQuFZtLYJjE7LA/y6ws97JfOzs7r6cEZsjSGyqAA
         +4qyQLSu7Yb3zcc7B9AcL68aQ4AIdrDYeXkqJSggZpmMtqP/X3aKyMsDENZQgz1GSsdB
         MCRnFgRcggDAWNkE1m+i/E+n61n4o2zylNZitJ1VsvDdAj4E+cAi6J8izNY5JDoZDhzg
         w9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684806; x=1739289606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ek/49ztLkEvKpwtXUCcLEVy/UDtK2jUnAt0X2Q7lO4=;
        b=Y7CJ0UQa6fh7O8JBHsHBM8TbFCguEaR45UERErlY6L2bag5srh/THnsuxp7fXT0ZFc
         8+8y9JMcB+onxFQ92CkgzQLS/qr6YFYKyA61rn05MkMY4++YjINkOSqJ6mCBvvqRtWXr
         YkloaqDmDLL+6eQhSk6ZZ8zlwZ5d0ldPemaNsOWISR/wne+DqOGR3YdmACzHLvTCnnI8
         fKSNRn2RUQGHH1q1LMzbkauOTifgi2GPMC8AYjgKZRs8cX93DkcCaMbZfy4cODte3+1R
         GgK3ywiNTmji1tDYN+5rU8R7EiWQKeTNxv0ZwNeyUUbeos2NuxxWBEukE4qNJuaUozKt
         GpFA==
X-Gm-Message-State: AOJu0Yy41Owb8doxD5ceaY7LEOMaqzfKMKPCY5KkesExft48V7vLL7/f
	0nsGY+zJKvoZ8C2PIzdAmtj4RVGOr67pQQlrpEsfXf/SLgGua7nDFU2rltQw59c9n1SoybYN1eF
	VCyJ+N7V5i2k64edCTWP/h93PxVdghx4yOh+bnQ==
X-Gm-Gg: ASbGncsnoIYSTT9lEMDjvZrh7VE90DVcgx+7qcEMkU/PXMCVqGMYETdJnHU+Av/6rEj
	AjYQuuEYwWnxO/kZNrhtcEyTU8nlwYHbFn0amrsZNUvGr9Czb7S55mz2gvsWGP3qzBf5zFEfqSw
	==
X-Google-Smtp-Source: AGHT+IGPDPH4nl8Jm6V3nQNDJIBK8orbJJeO304xSxRrXRMWmUpegya5ft1SKq1YS744OWdM4hIVhTlv4O4OpEf2GLI=
X-Received: by 2002:a2e:bc85:0:b0:300:31db:a782 with SMTP id
 38308e7fff4ca-307968100edmr92728851fa.6.1738684804235; Tue, 04 Feb 2025
 08:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204101612.66823-1-pmontes@shsconsultores.es> <20250204101612.66823-2-pmontes@shsconsultores.es>
In-Reply-To: <20250204101612.66823-2-pmontes@shsconsultores.es>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Feb 2025 10:59:52 -0500
X-Gm-Features: AWEUYZnZTlgQU3R4w7VWoOdrwazzq1Qhb7lCoClDwGQZmQyVMz3xtveu1xNq4rA
Message-ID: <CABBYNZ++i8_KULumH4LcTmsW6utc_S47-u26C1wZ-a-Zdg1sVQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] emulator: Fix Werror=stringop-overflow
To: Pablo Montes <pmontes@shsconsultores.es>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On Tue, Feb 4, 2025 at 5:17=E2=80=AFAM Pablo Montes <pmontes@shsconsultores=
.es> wrote:
>
> Warning on read for a possible packet offset
> greater than buffer size is treated as error.
>
> I suggest using ssize_t so it is always positive.
> Returning if packet offset makes no sense might
> not discard the whole packet and start again
>
> ---
>  emulator/serial.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/serial.c b/emulator/serial.c
> index b74556b13..13b844033 100644
> --- a/emulator/serial.c
> +++ b/emulator/serial.c
> @@ -79,6 +79,7 @@ static void serial_read_callback(int fd, uint32_t event=
s, void *user_data)
>         uint8_t *ptr =3D buf;
>         ssize_t len;
>         uint16_t count;
> +       ssize_t available;
>
>         if (events & (EPOLLERR | EPOLLHUP)) {
>                 mainloop_remove_fd(serial->fd);
> @@ -87,8 +88,16 @@ static void serial_read_callback(int fd, uint32_t even=
ts, void *user_data)
>         }
>
>  again:
> +
> +       if(serial->pkt_offset > sizeof(buf)) {
> +               printf("packet offset overflow\n");
> +               serial->pkt_offset =3D 0;
> +               return;
> +       }
> +
> +       available =3D sizeof(buf) - serial->pkt_offset;
>         len =3D read(serial->fd, buf + serial->pkt_offset,
> -                       sizeof(buf) - serial->pkt_offset);
> +                       available);
>         if (len < 0) {
>                 if (errno =3D=3D EAGAIN)
>                         goto again;
> --
> 2.43.0

I suspect the whole idea of buf being static is not really necessary
since pkt_data exists we can probably remove the static from buf:

diff --git a/emulator/serial.c b/emulator/serial.c
index b74556b13547..f8062ae5eac3 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -75,7 +75,7 @@ static void serial_write_callback(const struct iovec
*iov, int iovlen,
 static void serial_read_callback(int fd, uint32_t events, void *user_data)
 {
        struct serial *serial =3D user_data;
-       static uint8_t buf[4096];
+       uint8_t buf[4096];
        uint8_t *ptr =3D buf;
        ssize_t len;
        uint16_t count;
@@ -87,8 +87,7 @@ static void serial_read_callback(int fd, uint32_t
events, void *user_data)
        }

 again:
-       len =3D read(serial->fd, buf + serial->pkt_offset,
-                       sizeof(buf) - serial->pkt_offset);
+       len =3D read(serial->fd, buf, sizeof(buf));
        if (len < 0) {
                if (errno =3D=3D EAGAIN)
                        goto again;
@@ -98,7 +97,7 @@ again:
        if (!serial->btdev)
                return;

-       count =3D serial->pkt_offset + len;
+       count =3D len;

        while (count > 0) {
                hci_command_hdr *cmd_hdr;


--=20
Luiz Augusto von Dentz
