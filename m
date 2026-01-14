Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10237F8BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401922; cv=none; b=OeL5RLWL9xYh4erX4TAzs5JgUCM8H6fIEWuBAgj1f8e8lg3bWUq61Xk4L3omln7x7lCIkV8llD4p0ey4yp0oiRBa9JQ2SnZ0cCdb9xF9IdTogKL9fbGkpXxVOgyuYrGz/ACbrDmT7kLCapoyog3UHrYcfW7L0mycmvGTmf4rEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401922; c=relaxed/simple;
	bh=vFJg+aTNId7zrKUYjAaEApU4grZFJa+f51ZdKTke1gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uu/q3zHgRif8A7DMK/ubAHxyzaVJLFGm2d72SyHRNvVgPOhR1vgCV0TB/TO1tUzoKOX7VVvRXRTcG0vdR7VDQYAU+QVR3bJesTKN2TFygC9lUogfLxS9m3RnUE7doqLA3RnWiPTvKDQHyfkcntAi7NTV7lfK/rssSIoqV/zbUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIF3IW6Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIF3IW6Y"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78fb7704cb4so84311057b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768401920; x=1769006720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPNdnlMK9UUnSAdDO4mpGE1zX2sXMdo07aIB9JapbIg=;
        b=MIF3IW6YIRivoNhpk02zmKNsBBSIMJ7n7X6V1XTc2cgpHOVH6qIxJgXMt3gqvtJfp9
         bs5hoyEAcuA+r5vjjT2/1FS74uo7w/jXZepgx68LZv5GJMsRUQZ2FyMA+Vv/V4eFGiQc
         fnTzvaY5BcJWxl+p1JlMmOgnjmoKoPfFjSCFHWMIc+rk6owB6u469/FlMrMXRCk2ftkN
         h4INgtjtHCdZraY6VEByjDKYk67m+G2DAKuEs/4hjVHiPYD8hHkH3lhj9/SUPvrvSvk8
         TZVS/CM/aKcAVCGykB5IEj/GqXaxAAOLJmkU9zT7rcS/CqdzbgIBCGCQco/rb48OwRfX
         A4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401920; x=1769006720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPNdnlMK9UUnSAdDO4mpGE1zX2sXMdo07aIB9JapbIg=;
        b=HZ19R3VqSCXSBZ+0oMzv1nhxNDyJFdAt+TQoJCJE5f4nrjRYzswxKLHdJpIj+Od/vN
         1GCRZeD09hySgD8I87hJ8eC9ov9zFd/8lZumbFOoIV3gBKX3LaIF0+/xCFITLOnmwCfl
         YQRgHemmC38G6g0NIn2gaF+r8mT0bwswTLBCIP8rSlYT8iGWc3BetT+8vky4wXFEpOE/
         66lTWPmJ3l7qysIZMvffYMH0H2tpiRLx/ErurtJDR6XZkAw4Jp7afwfINUmjPD63ILTs
         nayE7dRbpB602/8GZfPckzMPTxVFvI2BThhcfcTyDJdfrYVGBLbLuNGd2DcmoF14YKOz
         VIjg==
X-Forwarded-Encrypted: i=1; AJvYcCUjLLpATP80Rko79LT069omRB7WdxoHOYrU39CNVZtWfv+ciOwRQhnPQS6Q/gUtdryCEheHeovfWvGa4Bwcmb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkpZ3acZ4dZbeeMyc0GAVZCDrFBdXEIBzdqgNeoLKpptmsrqt
	90vRxFQbvySX+WbCbGGccZdIWrFtK5cWsnDsHuapkDKCTIyUBc/F72tFLNE0TnCmFNM2S+1s+d7
	7hn+r4hmRC7LB8f5THg5zVL3/AxfI9VI=
X-Gm-Gg: AY/fxX6mzm/3H+kdOIG6j5j5BTIQur1d6S8s8Ze3z8rHREQwlhrP1kIOAx2bsiOeCZ0
	vO+nifsmgfNW5ascJsOb6XrV8ekCL+j54mCNkM4/Ws6lkjU7DQwyoQs+9oPukdsmBViOngSyS7n
	bftdzQN0F2PksldDbBrQSu1HwoLldi7JqprviCzojBgavGRo44RvvZXn+BDAtH4IvmfwQ04pztd
	buSO2docLvOtBHvJ+XiK8EcNYjpx8ZbSQQ8d+0gFvMAAGc5yKsGVjwXOK/6IIeJgjmXTzTSqIJp
	O0teIQf48z74MqI0dbZzrYtWanU3jwodbkfNoBp9KQWPglhg3h8hKgUpPw==
X-Received: by 2002:a05:690e:1893:b0:646:5127:ad81 with SMTP id
 956f58d0204a3-64901b29241mr2189678d50.95.1768401920082; Wed, 14 Jan 2026
 06:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
 <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
 <CABBYNZ+P6SUq4QAD9MS3MYw3yUDv6q8O5tDjR+wk8Zi9gmhAAQ@mail.gmail.com> <AS4PR04MB9692112F8A4D81D905716131E78FA@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB9692112F8A4D81D905716131E78FA@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Jan 2026 09:45:08 -0500
X-Gm-Features: AZwV_Qjk06YwLF-ZaivAiH_qxbWxYsHAXWOxM5wHVjIeYD3fCJaiyvqXWtrFGug
Message-ID: <CABBYNZLNG3hAMVZW=kkgi7A3JCO7Efi0fZef_V8YrFO_AXykig@mail.gmail.com>
Subject: Re: [EXT] Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add
 secure interface support for NXP chipsets
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Sherry Sun <sherry.sun@nxp.com>, Dmitrii Lebed <dmitrii.lebed@nxp.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ethan Lo <ethan.lo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

On Wed, Jan 14, 2026 at 4:19=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Hi Luiz,
>
> > > On Tue, Jan 13, 2026 at 2:46=E2=80=AFAM Neeraj Sanjay Kale
> > > <neeraj.sanjaykale@nxp.com> wrote:
> > > >
> > > > This patch series adds secure interface support for NXP Bluetooth
> > > > chipsets to protect against UART-based attacks on Bluetooth securit=
y keys.
> > > >
> > > > Problem Statement:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Bluetooth UART drivers are vulnerable to physical attacks where
> > > > adversaries can monitor UART TX/RX lines to extract sensitive
> > cryptographic material.
> > > > As demonstrated in research [1], attackers can capture H4 packets
> > > > containing Link Keys, LTKs, and other pairing data transmitted in
> > > > plaintext over UART.
> > > >
> > > > Once an attacker obtains these keys from UART traffic, they can:
> > > > - Decrypt all Bluetooth communication for paired devices
> > > > - Impersonate trusted devices
> > > > - Perform man-in-the-middle attacks
> > > >
> > > > This vulnerability affects any Bluetooth implementation using UART
> > > > transport, making physical access to UART lines equivalent to
> > > > compromising all paired device security.
> > > >
> > > > Solution:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Implement a TLS 1.3-inspired secure interface that:
> > > > - Authenticates the chipset using ECDSA signature verification
> > > > - Establishes shared encryption keys via ECDH key exchange
> > > > - Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.)=
 using
> > > >   AES-GCM
> > > > - Decrypts encrypted vendor events from the chipset
> > > >
> > > > This ensures that even with full UART access, attackers cannot
> > > > extract usable cryptographic keys from the communication channel.
> > > >
> > > > Implementation Overview:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > The solution is implemented in 11 incremental patches:
> > > >
> > > > 1-2:   Add firmware metadata parsing and version detection
> > > > 3-4:   Establish secure interface framework and crypto setup
> > > > 5-7:   Implement TLS handshake (Host Hello, Device Hello, authentic=
ation)
> > > > 8:     Derive application traffic keys for encryption/decryption
> > > > 9-10:  Add command encryption and event decryption support
> > > > 11:    Add required crypto algorithm dependencies
> > > >
> > > > The implementation automatically detects secure interface capabilit=
y
> > > > via firmware version strings and enables encryption only when
> > > > needed. Legacy chipsets continue to work without modification.
> > > >
> > > > Security Properties:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > - Chipset authentication prevents rogue device substitution
> > > > - Forward secrecy through ephemeral ECDH key exchange
> > > > - Authenticated encryption (AES-GCM) prevents tampering
> > > > - Per-session keys limit exposure from key compromise
> > > >
> > > > Testing:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > Tested on AW693 chipsets with secure firmware. Verified that:
> > > > - Authentication handshake completes successfully
> > > > - Sensitive commands are encrypted before transmission
> > > > - Encrypted events are properly decrypted
> > > > - UART monitoring shows only encrypted payloads for sensitive
> > > > operations
> > > > - Legacy chipsets remain unaffected
> > > >
> > > > [1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fne
> > > >
> > tsec.ethz.ch%2Fpublications%2Fpapers%2Fdsn22_blap.pdf&data=3D05%7C02%
> > 7
> > > >
> > Cneeraj.sanjaykale%40nxp.com%7C0e6161848dee43987e5a08de52cfc89c%7
> > C68
> > > >
> > 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639039249553069390%7C
> > Unknow
> > > >
> > n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIl
> > AiOiJX
> > > >
> > aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dj%2
> > FQoD6
> > > > BOhlNZQxaq4%2FEgfZaZMKNqNTwc5wgjWV7lQNc%3D&reserved=3D0
> > >
> > > Ok, I start reading the document above but it says the problem is wit=
h
> > > HCI itself though:
> > >
> > > 'We first present a link key extraction attack that exploits the
> > > security flaw in the HCI dump, which records all data passed through
> > > the HCI interface in a log file, including link keys.'
> > >
> > > It does say that it is passed to a log file though, maybe the
> > > permission of the file is the problem then, either way this would be
> > > UART expecific. We do require NET_ADMIN (aka. root) for accessing HCI
> > > though, both for monitoring or generating HCI traffic (e.g.
> > > HCI_USER_CHANNEL), so I don't believe these claims are valid with
> > > respect to Linux since for collecting the logs with the likes of btmo=
n
> > > that will require root access, that said perhaps the -w option shall
> > > limit the permission of the file to root only as well, in any case it
> > > is not like btmon can be run by an attacker without root access, so i=
t
> > > beats me how Linux could be considered vulnerable here.
> >
> > Just reading thru it says:
> >
> > 'Moreover, it is also straightforward to implement the link key extract=
ion
> > attack in Linux OS by leveraging both USB sniff and HCI dump log, becau=
se
> > there are USB sniffing solu- tions as well as the bluez-hcidump package=
.
> > However, running USB sniffing and bluez-hcidump, and accessing the bond=
ing
> > information file in Linux require the superuser privilege. Thus, the pr=
acticality
> > of link key extraction in Linux depends on the attacker=E2=80=99s affor=
dable privilege.'
> >
> > Anything is trivial if you have superuser privilege, so I don't think w=
e should
> > consider Linux vulnerable just because someone thinks having root acces=
s is
> > something trivial to get, that in itself is the real vulnerability if y=
ou ask me.
>
> Agree =E2=80=94 the BLAP attack=E2=80=99s Linux path requires superuser f=
or USB/HCI logging, so we=E2=80=99re not claiming an unprivileged Linux iss=
ue. Our series targets a different, OS=E2=80=91independent risk: "physical =
sniffing of plaintext link=E2=80=91key exchanges" on H4 UART (common on M.2=
 Key=E2=80=91E bring=E2=80=91up paths), which an attacker can tap without h=
ost permissions =E2=80=94 hence we encrypt those HCI messages. The use of s=
tolen keys to decrypt on=E2=80=91air traffic is described in the BLAP; we=
=E2=80=99re removing the key=E2=80=91extraction vector from the UART bus.

Alright, but you shouldn't have mentioned BLAP, what you describing is
physical sniffing/wire tapping, BLAP is about accessing the HCI logs
which doesn't really apply to the former, so instead of using BLAP as
example would simply just mentioned the EU/ETSI requirements and SESIP
certification.

> Thanks,
> Neeraj



--=20
Luiz Augusto von Dentz
