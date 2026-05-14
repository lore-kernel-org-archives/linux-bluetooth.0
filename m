Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FCF4F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785906; cv=pass; b=rUVY2muGzLwAq55Uvhu/NYIf2TXEPH4Sa0DD2ISkY1uIOHMBiGUKwVQNEeaXGq/05TWvTODKWyDL69VPhpcBm/1Z45LXErQyBcfjrR2TtRiJwtBjZfVUjYBUHOVLzzulvUxoKXViIo0VhpwhFkzfoF7aEf4dA0BF7QD3uthiNsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785906; c=relaxed/simple;
	bh=UP9h5GM6PLwgvCVN6Nh3PMqGfXKI5IorIF1o7raLRnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzJpxdfUqjQ7PnyWcrCvodytCnAKJt/egl8QTx+rMQIsaUbJqiBlt3XlqoeCK2kLHA2xNbQbMjCdi8/8LWm5UhiAzRvuRa8iNRuQ9zi7Aj98MqOKt6wcjEv1ARGgZA+9QrhOB83vyCbookMv3mGfjSyE45/iwzyAZc0cHhqmZ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaWTecQL; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaWTecQL"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so10627973d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778785904; cv=none;
        d=google.com; s=arc-20240605;
        b=cU2bAa6wytMIAhuhxZPASudhLMGSAGllonqjNQ4GQmKEOSUtkYVkyQULQYqjBqBV/x
         kPm3sNeEDb3UpjrKL0muzI3ZIocFwU3O00grcEyjDMVAvi8C3YVkVX4i/t/WiTY6cT+K
         B6byaemu9mm8KRsS64sUiWkizfaxVgu6imGQPe69UD10B+44FbOAMZlEKqRqd1tbQtaQ
         z1Rg2flcBB3rof9zciBW5Ssse0QI6tLJXSBYLVpoQRCfchIkVSJojCoT9sofsalSYZBD
         KsiOH8bmhFHm8mF6Jk9I2HlR57Vnj4UYh7CzE1YVYltwZm0mywDbNT7gUSkaWUvrnpo3
         bO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb6cQoHEe5ebtky8TdxJ6yIXf0QUE8fvlZwHPXwHyL4=;
        fh=PiCd/HnMTiswTcbbIqXiAXvOdD8DkeEa/lPiZ66bgq4=;
        b=kDfxNAr/6haxfyd1eVuWC63kWaW0qMMZJISgEWy6sDVTEzrKnGQ0qXlR00MzDRLY8k
         llX3aH9uZoIzRLpBrTBAMKaCvdH7bRsB9oq39QSbV9WPRvI9D2RlvSnQGzWpHROrMq0g
         E2dtT2Etyw3kGIowTdpFcdKZ7vhm1rMHGz20txhP7OH6+USUMaFLgSMXNsNQxijwkd6U
         AWWXmAKzdykkFAx7juGf7nhy+1DvZyjboFKQzmaKxLN8jPwDwj1M/SEhhnoTrX+q8g8R
         gQ749RG20XauQFbWe9diJHrWBCtDyUGuTjghHeVlZIygSb54m0SeJBkFYwUkPJvJcNK3
         dVdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778785904; x=1779390704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb6cQoHEe5ebtky8TdxJ6yIXf0QUE8fvlZwHPXwHyL4=;
        b=GaWTecQL1HrLB/eUdH2jeYQCrMhPIUQ1oMWFWYOSkeZiLRtQxegS2qj+vB2CjPafDj
         /5h4l+pXqAWqSqnD+vz8z2Agl2ez1j5Q0/65UzrN+DkWEe4WliBlFnrI3mbmBfJjVMNZ
         yBNBR8p1HQ+hyYL/mVlLd4yHkpj9tUi2AmvFrODgX/DisSayoSaegoe9Rs49M91S76aL
         FOedIIezvyAkTaWhabVcaLgdQQWfr556gyqHoIc8+pvg2RUCeNRdZGIEu88/R5mVZU6r
         4vZ0ob9f2zT/07yUONf0z7vfwnqXOoJQn9WtRqK0B+//HI7vAlhYjWDghheNRJGBDMYB
         6+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785904; x=1779390704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vb6cQoHEe5ebtky8TdxJ6yIXf0QUE8fvlZwHPXwHyL4=;
        b=d0I+xz6XFuN86qjXztn1EIA05m/MwKzUYdywkgRDSepZfbXQjCVbDThBBTnETI1eT2
         mQTl0tOHMipGBpPIe3KJTC7ZzA4FA3iDhpBkxzIur9MhTSA41M3KqK2bvW3W/4hk5QJS
         7uXKOp5IYoq/NGW23GmlAdJF6ThNFPD7P31OjzNGGXqrlLcyNIA7lCfyD2MI/xlgbx49
         cWzD5nnS7k+ONWJnzsV4osxM0b3nd2jI7Ab5vIzWdrcOZWe+/n86g88+40b6K4nMAnMA
         x4peYmpwBSBkpXVFsu/nMfLs28Idl1JID5fjfQIMdtt5qQzrRx7MxkI8gISyzZH/Wf9E
         +Krg==
X-Forwarded-Encrypted: i=1; AFNElJ8TDxhAKg+HoOyf4eSvfaepvTANsuctVOlJcHtr3WqP8446lr7ARZEEKV1KNIO/1CL1N9uq0jAJINvNkUj3jko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWYLtFMhzRU7hNI+dmSYHG0nPIecamDLXdhBsbMjM8vd1x8RI
	m2ViTTZhVgH/NZtO9tV+w/uJm34FEH+jRgzAKtJ36ih3dx8Ab1NKhDzP5AMiwuMkvNW+HflJJ+V
	K5gGpulEWcMDt1cg1bWCSffKXovZAZA6jHciSDoE=
X-Gm-Gg: Acq92OGMt1F3pzEiZS9QrNPR+l7fBH0coKgprQbSnyT74h1tY4W0O1zGWObCqGNzb10
	Tt82RYE+gwTnXFUWCbMUcNRlHHx9SK5mTjByWhf/ZB4UZrT24kP1tEhVGpyuEaBv69TL33mrjH6
	WzParEOBXuZclDcgSgc9eezHwiLWBDx684JrvFyVfIOKkSFqpZ23TIDu1Y9ZX0HxDDfp8DYBj8/
	OlcTQVqBkV0QhlxSOl9dod+Y2Job7n+LF9O2YuyAgnP6tuPEXbEdoby+BvcQLZdIHrBV+acEeEA
	YoQyXw9uhqy084CnqbM0rjTJg59Vc2GGWUN/UIZ5e9U5ANTIClGC4C38hAHfzEDBFv2VlCJrv/o
	1bItq
X-Received: by 2002:a53:b252:0:b0:65e:217e:9b7b with SMTP id
 956f58d0204a3-65e228eec0emr524383d50.57.1778785904009; Thu, 14 May 2026
 12:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778688966.git.pav@iki.fi> <177878100755.31561.18184220318055008237.git-patchwork-notify@kernel.org>
In-Reply-To: <177878100755.31561.18184220318055008237.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 15:11:33 -0400
X-Gm-Features: AVHnY4IC4YCNFw4lKCw32Um65kgQwuVOVnWZy2Zosmn_RbsnC6EoTrEVqzZNiEQ
Message-ID: <CABBYNZKaLPxRvMUDsTSByV64=iZKZCbtNZ6FTrjVohefY1+1bg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 00/16] Functional/integration testing
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, May 14, 2026 at 1:51=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Wed, 13 May 2026 19:17:17 +0300 you wrote:
> > Add framework for writing tests simulating "real" environments where
> > BlueZ and other parts of the stack run on different virtual machine
> > hosts that communicate with each other.
> >
> > *** v5 ***
> >
> > https://github.com/pv/bluez/compare/func-test-v4-r..func-test-v5
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v5,01/16] emulator: btvirt: check pkt lengths, don't get stuck=
 on malformed
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De19c771841e9
>   - [BlueZ,v5,02/16] emulator: btvirt: allow specifying where server unix=
 sockets are made
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5ee43f9993dd
>   - [BlueZ,v5,03/16] emulator: btvirt: support SCO data packets
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dcc077e4a12dd
>   - [BlueZ,v5,04/16] emulator: btdev: clear more state on Reset
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df1a303e1d07a
>   - [BlueZ,v5,05/16] test-runner: enable path argument for --unix
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dff2ecb82e4c3
>   - [BlueZ,v5,06/16] test-runner: Add -o/--option option
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D82c635c879bf
>   - [BlueZ,v5,07/16] test-runner: allow source tree root for -k
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1929b3a99d2f
>   - [BlueZ,v5,08/16] test-runner: use virtio-serial for implementing -u d=
evice forwarding
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D908c14fc3abb
>   - [BlueZ,v5,09/16] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7856de4d69d6
>   - [BlueZ,v5,10/16] doc: enable KVM paravirtualization & clock support i=
n tester kernel config
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D48cb22a572c7

Push the ones that didn't introduce new functionality, there were some
complaints from the likes of checkpatch regarding scripts with execute
permission, and Id like to go more in detail about how to write tests
and what is the RPC message protocol since we could in teory use the
same protocol used for autopts for example.

>   - [BlueZ,v5,11/16] doc: add functional/integration testing documentatio=
n
>     (no matching commit)
>   - [BlueZ,v5,12/16] test: add functional/integration testing framework
>     (no matching commit)
>   - [BlueZ,v5,13/16] build: add functional testing target
>     (no matching commit)
>   - [BlueZ,v5,14/16] test: functional: impose Python code formatting
>     (no matching commit)
>   - [BlueZ,v5,15/16] test: functional: add some Agent1 interface tests
>     (no matching commit)
>   - [BlueZ,v5,16/16] test: functional: add basic obex file transfer tests
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
