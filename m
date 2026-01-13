Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3512F6594
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328152; cv=none; b=JoAxpSSdEBCIW377tYofNph/wf6AtVAVBYgISb1wm1kXq+AhDcDpeEUU25lLaHorRnw7vzxvTbsmt4dRXhPSCBRgcQIimJk92nI8VdP/3w9PGh8kLa6aVfvj/VIDkRgXAxWjTTUWPngBwlB1HUQnzff9UNKrBqJXMr5V4l3LdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328152; c=relaxed/simple;
	bh=nuGsXZAFuQqEZPIZ5MiJtE1x5wKVuBz90pbKrZ+YFyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoZRy3Mru4CniFSYRqijQLQ6zRAB+ZzDpKGQMLaNVNJCqvU7uiThvj31DDJcHXZvQrx+7lXG7xNmFsZ88XRMAm6a8XYaHv/l1FwvrpMMElP8pGXH5Hp0VztgTI8soyV8SiJIEsuqBr2tgAGa0Wjl0rdpOMltaZXgm1q9aKKCtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl+cLYkt; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl+cLYkt"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-790b7b3e594so63810777b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 10:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768328150; x=1768932950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q67EzGxxe7938qql6TShc/GYCG/mD9d/0dmjvuA/5ZM=;
        b=fl+cLYktzkLZ1B3AugQ5ZOajucbLHji8ELaHPUh6fDaY7w31Dmbai5nMgzLlXmEeE9
         sBywz5uF2racZgYMe+NwYsnfPVQ495m36t/nSR8JLg5KR6mghSsqCvPNUi6VE2dtRmqC
         pfoDaPiIu0ckdRzY7BAcTzYYFPlZ+SOHwgo+m4HFfbOVNzE7fAQ1CF7rDuRTM/Mc6bTU
         5YwUB0vjZh4m/dYTNoc73hUqjm5H049HuxWhCSWVNWTz8k+zs4T4dgC+Ce3JtIEWT+y9
         T+8zHb/5vFHZkcjQtWexXXUkj+iDCSNfpzHG67ePsfRiFDvMXmax+3kZc1VNHe8OEuu7
         emgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768328150; x=1768932950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q67EzGxxe7938qql6TShc/GYCG/mD9d/0dmjvuA/5ZM=;
        b=vPWI8jU+KbPdqQwMOkHiZoLuB34BYWMmla5eOX1DJSH7VGt2/39UAaWNh4LSSGa8sJ
         CZE4xPbWQo5ILW4peVqRwDQsUmx5xm+hEfSz5BfaiPVEzz7cRSzQ6ekeqb6EeCBiWFUy
         uIjzQN8acFhRPTFpvarvMGKMFYyvTKdCGnYSibKGmPUHSe+REAPqygDRdUNW8/zefBvt
         yQPT4eJMBOqpPVpHASWA10VTDAUSrei4wbXO4ojuOSMzJR857lssHLZSMVgqGz2861pt
         awGSx29wLpjbI+PSP3h9Lt+ZpyFCLaFJMPpcF+LZsk5+ng4Ew0FF41OG+PtkhL3Ff5yQ
         O49w==
X-Forwarded-Encrypted: i=1; AJvYcCUnNuqtM9FW6g1rYmOYp7kTSW1sl99Nv+rCCbo2sODbwhCVRB7lsZR5ZutF68mzo4gWGiTfyIAZ+ZQLAOfSFO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsaI/c/FZ+x3M4+n/xQsXe7XNidc847hAM+oLW6rQr3sA4HwQ
	h4A0+HssRhCvkzH+lIZDuvflO/usqyv+BgMd5hdwg/Hwj6JagJNHRmMbxAWrbNZgN80mwrbTt4b
	IMuGxwmi0gu5pYrm0NmdRysPERfwmgW4=
X-Gm-Gg: AY/fxX5B0OhiyLueBUSe+AhkT7ZTHuM/2oh8usA7orVjKetHfK7LYqVYoHseBfYYhGQ
	hNcFh4z9znatsYhNdXRxLbxvtAOCekkL1/jsTy+yZ/VH72ECMrXguvey+yIH0Hx1XNuGMKsG6RJ
	rFBW8Cfw7oWrplgtIOogMHPtrzXC6TfJsD9VecXXG2Ee6hHty3/OgF3smvGyZBR85Rw68xCcq3S
	RhQhque6L0H5OfbRnwOpUujKCSLRuz59WQg3FzC/85aCnaEmZeP3MJTKkCQ3aQL/OW58v/ZgBqV
	58P7sKYEJUw3BLj23zdwIttF3dwl4nmG5WATJ895ndeE9G+z2gHCp4ZOdg==
X-Received: by 2002:a05:690e:1287:b0:63f:7da8:6b93 with SMTP id
 956f58d0204a3-64901b0a6d9mr110323d50.55.1768328149550; Tue, 13 Jan 2026
 10:15:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com> <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
In-Reply-To: <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Jan 2026 13:15:37 -0500
X-Gm-Features: AZwV_QioS4TQ1T-ofSRkTXneQfWWueJR_UJTNvTgkfuNGWiMPTDbnm9hChBIFoM
Message-ID: <CABBYNZ+P6SUq4QAD9MS3MYw3yUDv6q8O5tDjR+wk8Zi9gmhAAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add secure
 interface support for NXP chipsets
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, amitkumar.karwar@nxp.com, sherry.sun@nxp.com, 
	dmitrii.lebed@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 13, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Tue, Jan 13, 2026 at 2:46=E2=80=AFAM Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com> wrote:
> >
> > This patch series adds secure interface support for NXP Bluetooth chips=
ets
> > to protect against UART-based attacks on Bluetooth security keys.
> >
> > Problem Statement:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Bluetooth UART drivers are vulnerable to physical attacks where adversa=
ries
> > can monitor UART TX/RX lines to extract sensitive cryptographic materia=
l.
> > As demonstrated in research [1], attackers can capture H4 packets
> > containing Link Keys, LTKs, and other pairing data transmitted in plain=
text
> > over UART.
> >
> > Once an attacker obtains these keys from UART traffic, they can:
> > - Decrypt all Bluetooth communication for paired devices
> > - Impersonate trusted devices
> > - Perform man-in-the-middle attacks
> >
> > This vulnerability affects any Bluetooth implementation using UART
> > transport, making physical access to UART lines equivalent to compromis=
ing
> > all paired device security.
> >
> > Solution:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Implement a TLS 1.3-inspired secure interface that:
> > - Authenticates the chipset using ECDSA signature verification
> > - Establishes shared encryption keys via ECDH key exchange
> > - Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.) usi=
ng
> >   AES-GCM
> > - Decrypts encrypted vendor events from the chipset
> >
> > This ensures that even with full UART access, attackers cannot extract
> > usable cryptographic keys from the communication channel.
> >
> > Implementation Overview:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > The solution is implemented in 11 incremental patches:
> >
> > 1-2:   Add firmware metadata parsing and version detection
> > 3-4:   Establish secure interface framework and crypto setup
> > 5-7:   Implement TLS handshake (Host Hello, Device Hello, authenticatio=
n)
> > 8:     Derive application traffic keys for encryption/decryption
> > 9-10:  Add command encryption and event decryption support
> > 11:    Add required crypto algorithm dependencies
> >
> > The implementation automatically detects secure interface capability vi=
a
> > firmware version strings and enables encryption only when needed. Legac=
y
> > chipsets continue to work without modification.
> >
> > Security Properties:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Chipset authentication prevents rogue device substitution
> > - Forward secrecy through ephemeral ECDH key exchange
> > - Authenticated encryption (AES-GCM) prevents tampering
> > - Per-session keys limit exposure from key compromise
> >
> > Testing:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > Tested on AW693 chipsets with secure firmware. Verified that:
> > - Authentication handshake completes successfully
> > - Sensitive commands are encrypted before transmission
> > - Encrypted events are properly decrypted
> > - UART monitoring shows only encrypted payloads for sensitive operation=
s
> > - Legacy chipsets remain unaffected
> >
> > [1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
> >     https://netsec.ethz.ch/publications/papers/dsn22_blap.pdf
>
> Ok, I start reading the document above but it says the problem is with
> HCI itself though:
>
> 'We first present a link key extraction attack that exploits
> the security flaw in the HCI dump, which records all data
> passed through the HCI interface in a log file, including
> link keys.'
>
> It does say that it is passed to a log file though, maybe the
> permission of the file is the problem then, either way this would be
> UART expecific. We do require NET_ADMIN (aka. root) for accessing HCI
> though, both for monitoring or generating HCI traffic (e.g.
> HCI_USER_CHANNEL), so I don't believe these claims are valid with
> respect to Linux since for collecting the logs with the likes of btmon
> that will require root access, that said perhaps the -w option shall
> limit the permission of the file to root only as well, in any case it
> is not like btmon can be run by an attacker without root access, so it
> beats me how Linux could be considered vulnerable here.

Just reading thru it says:

'Moreover, it is also straightforward to implement the
link key extraction attack in Linux OS by leveraging both USB
sniff and HCI dump log, because there are USB sniffing solu-
tions as well as the bluez-hcidump package. However, running
USB sniffing and bluez-hcidump, and accessing the bonding
information file in Linux require the superuser privilege. Thus,
the practicality of link key extraction in Linux depends on the
attacker=E2=80=99s affordable privilege.'

Anything is trivial if you have superuser privilege, so I don't think
we should consider Linux vulnerable just because someone thinks having
root access is something trivial to get, that in itself is the real
vulnerability if you ask me.

>
> >
> >
> >
> > Neeraj Sanjay Kale (11):
> >   Bluetooth: btnxpuart: Add firmware metadata parsing for secure
> >     interface
> >   Bluetooth: btnxpuart: Print FW version and enable chip specific
> >     features
> >   Bluetooth: btnxpuart: Add secure interface TLS authentication support
> >   Bluetooth: btnxpuart: Implement TLS authentication crypto framework
> >   Bluetooth: btnxpuart: Add TLS host hello handshake implementation
> >   Bluetooth: btnxpuart: Add TLS device hello processing
> >   Bluetooth: btnxpuart: Add device authentication
> >   Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
> >   Bluetooth: btnxpuart: Add command encryption for sensitive HCI
> >     commands
> >   Bluetooth: btnxpuart: Add encrypted event handling
> >   Bluetooth: btnxpuart: Select crypto algorithms for secure interface
> >
> >  drivers/bluetooth/Kconfig     |    7 +
> >  drivers/bluetooth/btnxpuart.c | 1442 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 1440 insertions(+), 9 deletions(-)
> >
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
