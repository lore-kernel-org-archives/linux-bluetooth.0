Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15A178381
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940639; cv=none; b=jhvZWtfS0PRwRKhCx9N1A6+0TWhUvu/+K3AFz/RCMchfZDOeu1oXBM4SRTZlztu+66MO5KjjnGDcgWTHKlJTbtsziPeqR5iY0banxrTH5QExZsVCJZmhUAr+SMqKUDuo/L//p0mC+xEtBEZpJGz5XWd3Cp3DRv3dxvi8X7l11oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940639; c=relaxed/simple;
	bh=AOr76nH0YpCkPTyrnS1upKuHjNtmC81YlhymAft8bj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktZbAD6j2BHBtzxWA2537zavOIxcl6sTKwb/+D0Psc8xGWG74PMPa+7rE+phsWrI45swNlPSmwfBULvs8Mzx8x7wKmfB1n8/Dh580mNvHP/zPfVkJQ0jaRdeGNYy1V/lRJ9TK0EFmfJp5R3UkP7CzQsl9rfnTap270MJ1RlWqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrZDx74+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrZDx74+"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso48041901fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719940636; x=1720545436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpaWApTn4/DjJPxnM+MjYO0iZ34UIVfItX0XiiFtt+M=;
        b=MrZDx74+vzqTlQMz3NadL5ZPzwKL967GOuGNYBKnhafj7KU3Fp0SOydr6iKW7L65mq
         wgzLF24aAqPgOwOP5kG2Mw7fzjROh5XuHMODuEQVVRfGqyqzNCaRNS671+AIwV7xKLQ2
         I7upOd/UAD0NClDO5AKcbiwnBuT6rdR76VVNV1y4hrQUmzzXZ7d3Z0HO/NpSAPEdDyhs
         T2AtT23C4FPaHX8JoF3S6P7TIsRKBfIZVDasZjW0TL77Qt4s7CQSpWJO4i7A5yk9ff5f
         e6z+SplkfpFHhlApwCNA1xLMTVXGknd3Qp+Aotg1w6p/JTKAiVkhy1JlFcSo+68HkrHJ
         MYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940636; x=1720545436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpaWApTn4/DjJPxnM+MjYO0iZ34UIVfItX0XiiFtt+M=;
        b=EjHyZLA508YJm4ff2JjuTwdrkj7PgaxRPPWh+BYZqE8+uWcosKXajDZWYXFDnpyCZS
         6Z8YZyUjrghOn5D4Mg9oDm/f/5sA3OuO6/Yz+PK95tJe2ylEhZ7K2yAFezUm5ZQYkqtI
         iEkxbLo6TnSgvvLuVUgJ2pr1urpz3MNm8Bzw9d+Yl0CXaqgD3hekkIp3xoXy+EZHfNfn
         0OF0ddkBWk+RiH45Y0dHQXuypMb6KWJypr84h/VOx0sQqf0RlbC8aEuCPGSUAp7A3sis
         sQ4r28zVsZKvlLrQYG4+1ziL6N1h09f5OPvyyhoG2d9LSD2JWMoyf9RHpLT7wTFY4Hcs
         OfUQ==
X-Gm-Message-State: AOJu0YznKzYBhLECLHmK91TKOZtRozDxLv1H88G8liK9u2yg06a2Cj5i
	9fQhZPYEUQUBfJbaNPS4ADW9AxECk6WsvJBL5nf5hh46s+DZwarz9SGnumPC8Px74iJOpOFUAAL
	dkJ7vre2iQctBi2oBV50MgI0omgA=
X-Google-Smtp-Source: AGHT+IEXuP7L9K6OrCEg5edRrjUDwoj9FGHsnlRbiC7GBL8pwmuJy73vGh0AEkyhXaZyC+dfftwZH2ve3X2MebW5pXA=
X-Received: by 2002:a05:651c:2112:b0:2ec:50dc:af8d with SMTP id
 38308e7fff4ca-2ee5e3920d3mr64892741fa.12.1719940635592; Tue, 02 Jul 2024
 10:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Wz8HSZhvOzF1mcJnF44ilQFAE_utAwvRXYILQZzH_sGhEV4tGHH0duomsVNwj5aa-OzSJFCU1ZqbCZkbtqzGXJbUmVbwMgLjVqx9BmhJI3s=@proton.me>
In-Reply-To: <Wz8HSZhvOzF1mcJnF44ilQFAE_utAwvRXYILQZzH_sGhEV4tGHH0duomsVNwj5aa-OzSJFCU1ZqbCZkbtqzGXJbUmVbwMgLjVqx9BmhJI3s=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jul 2024 13:17:01 -0400
Message-ID: <CABBYNZ+yC=Z5PDK2nmegZFXGsJuu2S4y8ho6fMcQdb4xK4LKVQ@mail.gmail.com>
Subject: Re: Issue with Logitech MX5500 (recurring)
To: lexicdark@proton.me
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Jul 2, 2024 at 9:25=E2=80=AFAM <lexicdark@proton.me> wrote:
>
> Solution requested:  Please remove the entries for the logitech MX5500 in=
 /lib/udev/rules.d/97-hid2hci.rules again (and please don't put them back i=
n later)
> This issue now keeps coming back every time a bluez update is pushed. And=
 it has been going on since I have had it and reported to the Debian forums=
 several times (but that has been useless, at best). It had been removed fr=
om configs. about a decade ago then it regressed when someone put it back.
> Any self respecting Logitech MX5500 user wouldn't install bluez unless th=
ey had to (for other devices).
> If I edit out the c71[bc] entries for the 046d device and the keyboard an=
d mouse work again. These devices never have (and likely never will) work w=
ith this forced mode switch. The devices only appear to work in the raw mod=
e.  hid2hci --method=3Dlogitech-hid only stops the device from working beca=
use the hardware doesn't actually support it (supplementary: likely a too e=
arly BT implementation, it has it's own bluetooth usb device which is to ta=
lk with the mouse and keyboard but it seems you can't use it with other dev=
ices, and the mouse and keyboard don't work with other BT dongles, at least=
 as far as I have tried).
>
> lsusb
> Bus 007 Device 004: ID 046d:c71c Logitech, Inc. Logitech BT Mini-Receiver
> Bus 007 Device 003: ID 046d:c71b Logitech, Inc. Logitech BT Mini-Receiver
> Bus 007 Device 005: ID 046d:c709 Logitech, Inc. BT Mini-Receiver (HCI mod=
e)/lib/udev/rules.d/97-hid2hci.rules
> first two are mouse and keyboard, c709 is the dongle.

Are you talking about the following rules:

# Logitech devices
KERNEL=3D=3D"hiddev*", ATTRS{idVendor}=3D=3D"046d",
ATTRS{idProduct}=3D=3D"c70[345abce]|c71[34bc]", \
  RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"

I don't know who came up with these rules but it definitely hasn't
changed in a long long time:

commit 7ca701a6120778fb65905f02305963b79ff6d8de
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Dec 10 22:56:05 2012 +0100

    build: Put hid2hci udev rules next to the source code

>
> Thanks,
> Alex
>


--=20
Luiz Augusto von Dentz
