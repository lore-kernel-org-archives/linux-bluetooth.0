Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76899134CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359377; cv=none; b=pqDBCxcmmQnP4f3duLyRJzUb6HOmJz0YW5nSjfOJBCfA41oObn3tM2I11nYMAUoSBBRCJ33CLbQIUoKF40znLAalVpgudujNJurhMyEUKu19iL1oMBcZ7nwRhoeWwPvuJh1H/ivw7ANa67gxU4g6NPNVrI7nwZweSNUrwj/Oy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359377; c=relaxed/simple;
	bh=jXVXD4e9X1ws6n7thztInxdGSs3pTAyciEd4cRwV7mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP6JH4Lmst84JNxtIgSGOtny6LpzyzE4yQ1EY2v5a5zjp8wzYpY4dnsiQ2wkM0DKX3+QHEEbKFnTplbD6N0N5tr/f+T4rZg0Ldvpde2wUuoi14zyIjE4JV8Yk7EL4L/OEngDIm1RRkxs5c5u31nWwNmfutpgDq8z5Ge3NjDtkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAsMHe0v; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAsMHe0v"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2df848f9325so27341511fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715359373; x=1715964173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufoUHVOTiY36Uypwbp0wiBykyUQPUadzrK+GjKbi2uY=;
        b=bAsMHe0vXTU6IYdrczlgCFlmrajUpgJCGm+czL2elQO8LFRzObsEiltFqAltUrMFLp
         aA3wgCF94XVVUAc2W29SnCfxlGx7QZXbWzrINhc3zT96blvW1TgFDqAKfbqiQuWsvGG/
         ym8F1WyM1s5B3/d2xuttSe53/mehLQh2nt3p4a1eCSUQhvPWEDpP9m8RHGQUfRgPfowS
         niRaNcaLOPja+oenwpXbovA2AzT4N9tL2Ol/K6t96tYuyogUcbgFUyfMmhIDND3bOHWv
         XJSkGujqGYeBfkjhknb9Mv7Ly73dJQh+2ZO55TKDXvccSqfDAK+HKR4n+Bmsbksyji1z
         OuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715359373; x=1715964173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufoUHVOTiY36Uypwbp0wiBykyUQPUadzrK+GjKbi2uY=;
        b=Bh9wgM5x7KPIsIG8FArjVBguVKEGTK+ILDhDV1wiBBS3N3ptp6hH76RCXlpEhtB6h9
         oA7blXHIzFEi4neaMrDyDdZt66NYIlN9ex2o2vvVGYrivppXjqMhWf81X4Ybj88/hSML
         ZKNNmALzKq6cNFvT2j6gfHPwfdHtu7lud/PsqpKFBKSGS6rPeepDcArpIGmhl1dzgHHa
         ZGU82fdGvD9ptLtGvdK5cLBeduHNAEe4nSSm7o2lStCZMymHaofFzUxpJI9F2cKbfzQk
         DVRnpkN+YIN8MF4DZY39UUZ1E7wDDxYeMqZh4VRutAoewGqE5+T1r6K/qthPlgxUhuqd
         NaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUx4pHrVkdNc5nMGBJ5QHHwmyXZ7QwguVALZ6ssqUDAeugXaoCM18UrzCg7R9NqmIvVWT+eRId0yuIUkhN8B7Y6rJRo0+Hhahmf7fqOiU+K
X-Gm-Message-State: AOJu0YwbZop/tJWGzHG4EFDs/DgrcYjf6Bp4GBnGVNvQVG2LfElK4ilR
	UPFropP8L6VtUQljxWSd5R4m1y5Y3NHR1yBZNImhRMqb+QfLenXf62u9kkFyc3ssQjg63Tc6Rxm
	Us4qfj2SXFzLxH5DVxT9Kd8iMrxe8oQ==
X-Google-Smtp-Source: AGHT+IFvo2Gje13T7scplnrBf8FbTTSaxKX/VCglWp9fCaLJhGEnze8OKXR7F5/obbyvdJ6vUGPgSxe9Jdro1uqw4Uw=
X-Received: by 2002:a2e:b8c8:0:b0:2d8:408c:3f5b with SMTP id
 38308e7fff4ca-2e51fd2dd15mr29019041fa.5.1715359373209; Fri, 10 May 2024
 09:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510121355.3241456-1-hadess@hadess.net> <171535563283.2819.15014215823661998089.git-patchwork-notify@kernel.org>
In-Reply-To: <171535563283.2819.15014215823661998089.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 12:42:41 -0400
Message-ID: <CABBYNZJevU71O4wp_=UG+ch5HY42Gp9=7Fqf5OERp0GvZ9Cppg@mail.gmail.com>
Subject: Re: [BlueZ v2 00/20] Fix a number of static analysis issues
To: patchwork-bot+bluetooth@kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Fri, May 10, 2024 at 11:48=E2=80=AFAM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Fri, 10 May 2024 14:10:10 +0200 you wrote:
> > Changes since v1:
> > - added 6 patches
> > - Fix syntax error in "client/gatt: Check write_value() retval"
> >
> > Bastien Nocera (20):
> >   adapter: Use false instead of 0 for bool
> >   attrib/gatt: Guard against possible integer overflow
> >   client/gatt: Don't pass negative fd on error
> >   client/gatt: Check write_value() retval
> >   client/main: Fix array access
> >   client/main: Fix mismatched free
> >   monitor/att: Fix memory leak
> >   bap: Fix memory leaks
> >   media: Fix memory leak
> >   main: Fix memory leaks
> >   isotest: Consider "0" fd to be valid
> >   isotest: Fix error check after opening file
> >   client/player: Fix copy/paste error
> >   shared/vcp: Fix copy/paste error
> >   isotest: Fix fd leak
> >   iso-tester: Fix fd leak
> >   sdp: Fix use of uninitialised memory
> >   monitor: Work-around memory leak warning
> >   avrcp: Fix uninitialised memory usage
> >   main: Simplify variable assignment
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v2,01/20] adapter: Use false instead of 0 for bool
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3fcc77f99da
>   - [BlueZ,v2,02/20] attrib/gatt: Guard against possible integer overflow
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1e22fd9adbb3
>   - [BlueZ,v2,03/20] client/gatt: Don't pass negative fd on error
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1ba9e5f21ca2
>   - [BlueZ,v2,04/20] client/gatt: Check write_value() retval
>     (no matching commit)
>   - [BlueZ,v2,05/20] client/main: Fix array access
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df3f762b77b58
>   - [BlueZ,v2,06/20] client/main: Fix mismatched free
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dab325450b0c2
>   - [BlueZ,v2,07/20] monitor/att: Fix memory leak
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0b842fe9b1fe
>   - [BlueZ,v2,08/20] bap: Fix memory leaks
>     (no matching commit)
>   - [BlueZ,v2,09/20] media: Fix memory leak
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D3652e98d2bb6
>   - [BlueZ,v2,10/20] main: Fix memory leaks
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D45d151ec8a0f
>   - [BlueZ,v2,11/20] isotest: Consider "0" fd to be valid
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd30dc38b0425
>   - [BlueZ,v2,12/20] isotest: Fix error check after opening file
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9a36f191aa78
>   - [BlueZ,v2,13/20] client/player: Fix copy/paste error
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6f041df23ecf
>   - [BlueZ,v2,14/20] shared/vcp: Fix copy/paste error
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D856353b254da
>   - [BlueZ,v2,15/20] isotest: Fix fd leak
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D3e03788ba80c
>   - [BlueZ,v2,16/20] iso-tester: Fix fd leak
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc81f9320357b
>   - [BlueZ,v2,17/20] sdp: Fix use of uninitialised memory
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Ddc60ce0b460a
>   - [BlueZ,v2,18/20] monitor: Work-around memory leak warning
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De5925dbb84fa
>   - [BlueZ,v2,19/20] avrcp: Fix uninitialised memory usage
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Daf2634ce0a62
>   - [BlueZ,v2,20/20] main: Simplify variable assignment
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D87edbabf3956
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Had to revert the last one since it was causing bluetoothd to crash at star=
.

--=20
Luiz Augusto von Dentz
