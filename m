Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2BC8FE
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817506; cv=none; b=DVBtGn/pu0AGECWMN7CvwTsMJVtYDxagNo/1WAlEmzOWrJJJgzKoWOKkS1XH0mksx3w7E1rfyoNFR6XLgw8CNsF17zbWbbHiy7WAtaz6iSQ0UYBX/YJW4QdjoO936xqlICaXvtXye9xi1hDs6zFyEb5IYisCl8S+CFnudn0zYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817506; c=relaxed/simple;
	bh=Zx/6exNTPiB3pk0ayBrph3ElzmqtUWkLTk0LeNNyQ7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGAzlRZy32T7P6sPnGf8DVd1kDgH7Slqlh9pBC9pQbH9qtH8OzXJutFDG0Ed/oRoJv1ahi3/t/zKjEOAj610+ve2kRVEu4maAoK8NCgpYzru0/1rSJu7GGLmSV0/4p0XE7WZydBhVik87qb4RioeWhKKvPmMEhBdEV6738dqs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X18GQXdE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X18GQXdE"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30c461a45f8so60830671fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817502; x=1745422302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XJSHE7UV1hHzWY3CJSYo92IKiVSFXfUxl1I17rHCd8=;
        b=X18GQXdEnTMvvr0uRjfz/1yRlqSJIn6G6S+LgCTd0DfnlztAbIBcjhaHRJRJX0ZRBA
         X3gX+1k6FGC1s+V6HOd+meXPIfM7i48v9bn7pd0ZJ6H33LKO8Q+4xlpGOqd1eR9hbAHs
         063AqKTLxKmkq6dwF1I+6eJwJXZQkM8OTRV51y7p5sPOU6Fr19mSX7ipZtPyHin/ExDT
         GMBX8N25U8Aq9RXy+1kT9NA+gJAZwhy+jDbNpuoMATyrB2RI4/Dd5rCGBIidZlDjpQ7Y
         nnvL/s6Y/Sa/wBx6HOdDbTBvW/rrdecIZ2r7C1s6HS1/tz6DAmt/iw+DAsmn5msKVMdv
         OEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817502; x=1745422302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XJSHE7UV1hHzWY3CJSYo92IKiVSFXfUxl1I17rHCd8=;
        b=ZGtZw7vm0/AF8m/oi2F4+mcBUO/ku3dgwbVSOf2xxVoyhs5SuiCiYXYiX4CQia/QXs
         yMfHETfRyAHxD/GpGeBmX/npA+Wt1Hj8hSxS+QoofFs//M5feXukV2H3VLlDd7gOelnI
         u3fB1hGffUDOPF2+pMPOPHC8cLoO19ZSV/J0bWqEnRAPKwIjGARKdBng6EMi7TnwtCdM
         kBy3/7m+5rppDqZf4VHEKLxrrEaHvi73PMQwQgDA6sByyy/VIbGW0ebV7+SbWiPk+UY0
         8u3mg9AmT4JKZzw9nSM7PQ1L61DwP4kk/4In84hBmw4JcEGrGaIghs6fNedSIeWtnOh/
         UgHA==
X-Gm-Message-State: AOJu0YzHJC+03lhKK529cScNe2yC3wAyLcW/IkrC1lzD/gOwuZXj5aHQ
	LetkJy/mkt0c+07k9BdNk/M03K/KqNPt5yf4T4qbEyyLkxGqrlr20fpB1gAUKL/LYaJ1fGJ1r0H
	YrKd46UBPAjRmG1dK01NaCY0PMQ0f9FM6
X-Gm-Gg: ASbGncuNRNneJ+tIxPwAeKz0OzOs9SVRYJIEaaNh6F6J/Xx/yTrM4CFBFUHQQgbTJA8
	AGlIGPIaqKHGEapsisS11SGCOgPBDEInQOUKbPCY3CDZjf0e5Qko0Cf/qOZXhaMCGwoXytDUm48
	p8cYLY3jkrBtOcOtbZX/nN
X-Google-Smtp-Source: AGHT+IFk0FYenH3/5qTFQn29zxCB7Rl7pAQxd6FLoe+/Em7NqwVe7tA95CDPY+Eyig00tI34KWrjKnG/D2mWEY6EbEw=
X-Received: by 2002:a05:651c:150d:b0:30c:514c:55d4 with SMTP id
 38308e7fff4ca-3107f6bf45emr8263101fa.16.1744817501151; Wed, 16 Apr 2025
 08:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416152039.971257-1-kernel.org@pileofstuff.org> <20250416152039.971257-2-kernel.org@pileofstuff.org>
In-Reply-To: <20250416152039.971257-2-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Apr 2025 11:31:28 -0400
X-Gm-Features: ATxdqUGiCK5IK37sXNeZFsonRm_SkcCpiPfxGW9XCk3TspqxWOMSfr4TC2CysSc
Message-ID: <CABBYNZLULgM_9DPvbD-Vf-_h3nQvTNsnYK4b-6X4BkaHO1T0_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] build: add bluez.tmpfiles
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Apr 16, 2025 at 11:21=E2=80=AFAM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> Systemd tmpfiles ensure the status of particular files.
> Add a file that bluez can use in future.
>
> Distributors should install the new "tools/bluez.tmpfiles" file, e.g. by
> moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir}`
> variable.

Not really following the purpose of this one, it just in order to tell
the packages to create this file? Is this specific to obexd lock file?
If it is then we probably should have it somewhere under obexd folder.

> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  .gitignore              | 1 +
>  configure.ac            | 1 +
>  tools/bluez.tmpfiles.in | 0
>  3 files changed, 2 insertions(+)
>  create mode 100644 tools/bluez.tmpfiles.in
>
> diff --git a/.gitignore b/.gitignore
> index 108c3b820..e4431443f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -157,6 +157,7 @@ obexd/src/obex.service
>  obexd/src/org.bluez.obex.service
>  tools/obex-client-tool
>  tools/obex-server-tool
> +tools/bluez.tmpfiles
>  unit/test-gobex
>  unit/test-gobex-apparam
>  unit/test-gobex-header
> diff --git a/configure.ac b/configure.ac
> index 1e089aaa7..4ebd513d6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -530,5 +530,6 @@ AC_CONFIG_FILES(
>         src/bluetooth.service
>         tools/bluetooth-logger.service
>         tools/mpris-proxy.service
> +       tools/bluez.tmpfiles
>  )
>  AC_OUTPUT
> diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> new file mode 100644
> index 000000000..e69de29bb
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
