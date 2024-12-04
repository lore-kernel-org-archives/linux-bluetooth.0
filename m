Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FE18DF65
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344332; cv=none; b=rRj0F+4S1dwYsnmu62TbVxMtgHEQh7c79X3DV19UxN7y6TV7jglMvIBVImIegDGGbWDcr+fo7xrK1xQ1ojDub0uafdDgO0DXCI8Eb/dDWgss/hwSX8RcHjob5MSmp8DhtX8R358CispMMncpEbbLXMyDrpWuHshzx0AvmFeRxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344332; c=relaxed/simple;
	bh=TBcOXyq6HmqGcyd1FgfflqiMOAf9dECQoygh7pBj9e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/CLdVKkVU3qKs6eC+nMcxbaky3fD4Yfu54cSzS+9t88+l+WjKsqmvoOLqzoh3LIuXkaTexhrpwBaABCWJ0tOtLStjyNwEDn2cyZ13me2x5Ji9L9CiU3rlz8nz6DkPDTccdT7/Gabeb3S5NyreEkpdxcpO/N0S16HnhJ6l+fO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jStZBa5a; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jStZBa5a"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so1032601fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733344329; x=1733949129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBcOXyq6HmqGcyd1FgfflqiMOAf9dECQoygh7pBj9e0=;
        b=jStZBa5aL9iGkO9NWrcwW0V1CgHOS90NvifgGIWclHnGv1SKPzZjnrgpTh02M+SrPw
         WzA1te3GmeGlf1qHpnuQnLbSgHmw5rfPgg4itB2enbzmS2iKCBijEYCuVKC7F72xNJjW
         pL4Jy72Uu8Dt3VchuxeGSt8slRhdq3CTq2jw9ea1DaPNiiQYrujQaTMzcqreeUosh8vA
         lCdeDj/RkOAi0ADC+sZCXBBGxhTm+JlnmGkT07ojK25F8ai+GKooiwJR8p8qBSNriyZu
         Dv7OkAZwCV9lvxQsv2G8WWE10+W7k/8Pq7frzb7jG0viNMqkGSi3394L7KWRdoraao+G
         LZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344329; x=1733949129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBcOXyq6HmqGcyd1FgfflqiMOAf9dECQoygh7pBj9e0=;
        b=mAzTnWwMtT0ZTzErxxvt//Jq4GZptsPUChKx6sUXSs1on5CO2IgQY5WrYJL5v74PTP
         3h85VBkGxfizqvEzifD0M3/h4iyUCl1x6YPNE/YFt4aIvlojpwVInZ04DqGSCgk2Iz6c
         lSw0kbI5ffCvhKvAHfH0Vt1rcjStMah5cX3WVTHDyoHcY7n4X6Jr65ZlK+M491Zr9mGg
         A0WbGa3nwjiAvd1ZxNNl6veW61OeD8ljWo0it6AqEk2zlvnLmDkmWVwSemdmpCT/sem9
         cMvH29pOLtdZVd4sNh2wlGGr/u2/HeLBbn+ddybZIWKX4QJ1bfVWOsDuZTN+VHfTW6UU
         Wd8Q==
X-Gm-Message-State: AOJu0Yxa1bf6y09PLO9xa79cwd2FW+qU9DJmfjziYHB9gVbHr9g/D2eu
	lRZrd2JVK8/cmm+PvSJHRfGlg+NEEIjaW/OKCElSV38KTm41BEMfj9RzJUPXHY4Gk/PLsxUsEww
	f9Q2fQE2eRupqfMh8ysP2xvn72/fViZoi
X-Gm-Gg: ASbGncsO8W/HLcFABz/1seQWQVxf1fl4gZdxGTUTcxCMiSiGzaBxdtk72O0ZwcAcXmW
	GkFGgPVzmVfmTRc1YXmlBzPI898c1Pw==
X-Google-Smtp-Source: AGHT+IHmdY5kL2Ir7beEz88KcUL4ik18PuDzdnfu2o0ZXcC9IZdZ0zCmvyQSaRmZtkp+JmmS8hz7YPkVe9coXBdA4OE=
X-Received: by 2002:a2e:91c6:0:b0:300:c10:7c26 with SMTP id
 38308e7fff4ca-3000c108676mr48771121fa.4.1733344328872; Wed, 04 Dec 2024
 12:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5bdab6f5-fe17-4060-8d43-f43754e452f7@gmx.de>
In-Reply-To: <5bdab6f5-fe17-4060-8d43-f43754e452f7@gmx.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 15:31:56 -0500
Message-ID: <CABBYNZJ5pPNqH2ah9CcoP5Hr2OA0J+Jmo=ai35WDNMuzTNZ7Jg@mail.gmail.com>
Subject: Re: Bluez: Read-only config dir install
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fiona,

On Wed, Dec 4, 2024 at 2:51=E2=80=AFPM Fiona Klute <fiona.klute@gmx.de> wro=
te:
>
> Hi,
>
> since February Bluez installs a config directory with mode 0555 [1].
> This broke the Buildroot build, because files in that directory cannot
> be deleted any more. Buildroot disabled the datafiles installation as a
> workaround [2], but at least in my setup this breaks *running*
> bluetoothd because the D-bus policy is missing that way.
>
> The commit message mentions needing specific permission, but does not
> explain why /etc/bluetooth can't have mode 0755 (as it does on my Debian
> system, with Bluetooth working just fine).
>
> So my questions are: Can I just send a patch to change the permissions?
> If not, why does it need to be read-only? I think I'll need to
> understand that for a proper fix if changing permissions isn't right.
>
> Kind regards,
> Fiona
>
>
> [1]
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dbe0e79629=
9b0e7a73bf06c5655b56180588550b0
> [2]
> https://gitlab.com/buildroot.org/buildroot/-/commit/1a8676aa6e4b0e372a1a7=
44eac6e53c90c03bf0e

Here is the discussion why end up setting it as 0555:

https://github.com/bluez/bluez/issues/329#issuecomment-1102459104

Now the question is why would buildroot delete files under
ConfigurationDirectory? Or is the problem that the directory is
created empty and then you add custom files later?

--=20
Luiz Augusto von Dentz
