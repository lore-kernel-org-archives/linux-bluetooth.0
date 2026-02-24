Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECF3A4F57
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953195; cv=pass; b=pDdlaBrS7cp0zKCi1KVJcUpsDLZHYB+1oueJOcNz7Tewv5Ge+T3tj1+II7qntYUsn4oDnplIjm8p2iZspbhtlZdo7wkamj05o974egFEUNVI8LuxRqG1EAgHjeBZqA6r35vBTH1gwDyB6szso2lJMYqM/Gyu/pI8xEWRfX2QGtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953195; c=relaxed/simple;
	bh=6ZM9/bd1w9xQtbGGBgdho4cnQl866moRs1zYMIzi/o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5sCyO2/2cKNqvWcUqZHpAjS5LFnS2qLBPoiRvJH7hn2g40/Y8yYIip2x1eEUAYF/z0FUnrB5cktW47yF5adVmEXmMjGQPNsat1uOeHWNoHpP8thLRQales9oRQV+vT8laXi7NBHlq9qvV8nIeTesnQrhP0atC9/C28lMSCZb9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+uIwoLr; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+uIwoLr"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ca09f2056so622862d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 09:13:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953192; cv=none;
        d=google.com; s=arc-20240605;
        b=M2Snd8Wtorb+266UjzZeeiYBoMGJ1KpENN6rwPwwvsRZ4dwDAhRXYdDdohbJL2MIKh
         mXsTPQUEhUCL6Vx7jknhp/AEpsZZhXNG7eREE1taUwfWlgrU6jduF0aFQOExZpkCULXO
         1GFwFjIcf+gO1UyivqtoEk8JHIo6hoIZo8MbNLxknf4WXZmQW97O3IrEDUl5hc+rVqo2
         8tKrFki9btNMs7FoDIUsbp+sEy7Ulf3AhtDwcCDR/ACZDX4ZUL5NGJeqV4oqTK90zC5m
         A7+ECCk5hRr5s1VD45xe9uc06NNxtFYHF3aOFs0qT4vTu4Kl8CVFBHSQLYWwaPDcYJy8
         qAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZM9/bd1w9xQtbGGBgdho4cnQl866moRs1zYMIzi/o8=;
        fh=8Io0VZBe7JoSjxGbow1LZUfwzwivX2R9aNskWMcQ7K4=;
        b=SyWKsn7ID1AzoAsQlAntEDYKI6n49ae2Ku4ZCxo/VIhO/H10MVHwl5Dt3wYfvZXJHh
         n/1D6lzd9hW/ZrQPBc0BJ/Kmr84EluBb7w5bbXeErBd90t+aQAXRaUIavlX8q2aDrySj
         axtTjDNxwiAt+X0X3QENNOfTpAs3wARt+WEsqk3Ark6hK7Fzqyof7otWNy5tNFRiHCD8
         VjLtf1KHwa0CJDRs1XYoRWMb4eXqQt88ieHrKXCYSkjckevbsVUyGSiQrjVftOjrkHVt
         xX0jSeP1EPaTqVw4P2gsJFKsESHQkJkc4aAOYW977fwTT1fsoVUcW8FPBl67HC8mo42e
         V1ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771953192; x=1772557992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZM9/bd1w9xQtbGGBgdho4cnQl866moRs1zYMIzi/o8=;
        b=U+uIwoLr9ISumN1QWHvG5QrogPX/hrc3adoUbEeONkRvTkrTnqVCSo1INQC+MWTCY6
         YBbQPjn3Z1iG9evAe+t8esBCQcFnStFtOf9U33sT93ft4FfX0JB+1G4bSNATGhcFXOzY
         WeLhv/OPatOxoLL0FuGJ8RxN591KFpbv4deNecugapMV+hmzqmTt94W1EFLXMdTzf0xw
         JFYDzmeDlprYkj3NcymgB4+d2TuhUVOckoWvgkzXKBYOospy6tuXqjZb6Nt1NURW8ryW
         HAM/wZYHL0mV4wont+pb8hsbC/ICqE/EmgIF0NfMXe6pwsqW2FNFXu+kPIrCfVU7Hy5I
         pOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953192; x=1772557992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZM9/bd1w9xQtbGGBgdho4cnQl866moRs1zYMIzi/o8=;
        b=EHa2EzBxWaYlbokLNudFeRMy3X1FqdQm3RE2SeIE3rxP2G+imlGUnJC3yW1Woia0SM
         mNRXgdOtCXx8DPZ0EnNhr6s2amNMChr4g7YVvg0MfHONZ44LceY8CndIUV9WPLTxR29v
         HOkkaLbXTMJb9EIP16t0VGNizaqjgnerCkQhMSzQ3dG+sN9DVYVxTWcZszZEHpXJvDBE
         Y8e1sjrU10czhhWslOlubTNbaXKMvffW7ZRN4OtRTx+2exGpWXkIBxVLhB0IIocgAtsr
         ChwZjpfYofk9jbb5EKUkjYiSdiXJ5EqSwb1huyy8cHWaLvayT4BJrecY6/tWr+7kfd+Z
         BPlg==
X-Gm-Message-State: AOJu0Yyx2dwXKavv8orcNFhg7Yl50tWPP1X8jDOZBL94I5kFgSg98ayZ
	CG1RRulFCt46TYLGwHr9tRRxFu/f1PfvfDigTkoax1oAItXpytp+oHELGPIzxuOD7t1xUF1vYY4
	NZ4ElIuln9pvwlTyvgCLtt9moXnQB6aRGbrwUkiw=
X-Gm-Gg: ATEYQzyeGqtjd98edvrpQacl+2arzhK7rlMbTBUnZelitAP5L+JT+MnBMyIUFKv7YYX
	QRfZoy7kGAr+ZELEFY29LKbnHiepaHGta/4xmOUDv29Prj6AT5cYw0S1EEQYYXrjBbnV5HZMzwC
	6iN2LqEIjuOytADPze/Tuf6UGQ/ttjGx1R546SeW5bYGMyXxUrSpeiSdYMJabwXWlvXwbMtFJ+N
	bZVglg2CaubNCUbu6hLc3d0rvxv/bcKzBc74Kdp3zGnPm7vSBlIOlRPnMDRsWmez+G+6318PHKI
	TfmydGs/KTNj1KF2WewjT4mcKVwM9LSf/drW3iC36vdmk2OsDx+jvEyiWI+sALvImAI=
X-Received: by 2002:a53:c742:0:b0:64a:ee14:ea18 with SMTP id
 956f58d0204a3-64c790a5e43mr7608984d50.85.1771953192351; Tue, 24 Feb 2026
 09:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c887efa-9722-4e24-b49a-da21eadc2ce0@schildbach.de>
In-Reply-To: <1c887efa-9722-4e24-b49a-da21eadc2ce0@schildbach.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Feb 2026 12:13:01 -0500
X-Gm-Features: AaiRm50Ls8AKqK_Qv-MgVUskloblI7uF6949X0PLPHkVt718G-U8_CjGjNWIFwQ
Message-ID: <CABBYNZLyBD2uJZpMEiu6NZYzivwnQprsAHW7Dfqr4L4ydcmaOw@mail.gmail.com>
Subject: Re: minimal permissions for BLE operations?
To: Andreas Schildbach <kernel.org@schildbach.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Feb 24, 2026 at 11:57=E2=80=AFAM Andreas Schildbach
<kernel.org@schildbach.de> wrote:
>
> I wonder what kernel capabilities or permissions are needed to use HCI fo=
r
>
> 1. passive BLE scan on channels 37, 38, 39,
> 2. (read) access to a BLE GAP (for Thread/Matter device commissioning)
> 3. hciconfig hci0 up/down

If really want to do low level access to HCI then you probably need to
use HCI_CHANNEL_USER and take full ownership of HCI state machine:

https://github.com/bluez/bluez/blob/master/doc/hci-protocol.rst

If you don't want to take ownership of HCI, the next best step is to
learn how to use BlueZ's D-Bus. Don't cut corners, because I believe
all 3 can be achieved with D-Bus or in the worst case, you will need a
socket for GAP (is that an L2CAP channel that is used as transport for
Thread/Matter?).

> I'm asking because I just hardened a Docker image by restricting to an
> unprivileged user, but the above BLE operations fail. I was expecting to
> add something like NET_ADMIN + NET_RAW kernel caps, but it didn't change
> anything. I also tried adding the unprivileged user to the bluetooth grou=
p.
>
> Does "hciconfig hci0 up" always need the root user, or is there a
> minimal permission I could grant instead? Currently, I get "Can't init
> device hci0: Operation not permitted (1)" if I try from an unprivileged
> user.
>
> Maybe related: is it normal that if you use HCI from within a Docker
> container you mount the DBus (/run/dbus) into the container? Is it
> perhaps possible to just pass the hci0 device via `--device` instead? I
> didn't manage to do that either.
>
> I'm on kernel 6.12.69, Docker version 26.1.5, bluez 5.82 (both on host
> and in container)
>
> Cheers,
> Andreas
>
>
>


--=20
Luiz Augusto von Dentz
