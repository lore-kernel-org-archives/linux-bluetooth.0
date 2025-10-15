Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42C26C3A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569028; cv=none; b=Kw75hFoakmcJ/9h/gWCwkOvBmW7tyqGqnqnMzTGvPxTSAk6DamA0f0iZdDeh2JC2BVTYYk9Rq/2wVsZqfH1Anh1lyAGwOC7k5H0r2Sn4NLTMSz+luvZq8cDMw/ZStKmdgh0p5gVGA5AgHSdGXBeJZ81fZsM5V1bSTNrMkuMqPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569028; c=relaxed/simple;
	bh=wCxCuFV+ZgSpXmX71bZY0UpUFS1gGjv49aosWoHBmn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdCdU1hX1Vo2IwZrbLFanIPBQSXV2ofvV5aLpC7NA9g5VlbLLphUo7bHgAdADG1JCS8Qc9aXn04R4XT6gpfcivy59hutcZ2kpB10OHomjJ/8W62p99rkyzMWDoGWC1m5tvRYHfbmSHDBZTDvjVGdw22CpbUQPTRMe1FD0VHOTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxJJO4Ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxJJO4Ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AEFC4CEFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760569028;
	bh=wCxCuFV+ZgSpXmX71bZY0UpUFS1gGjv49aosWoHBmn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bxJJO4UizonQ3104Dy1ghV4S+n+vTN/uKSOQkwFJq4TRQ5lJQS70c+laNoe1O+Iwj
	 jyyk6A9Rx1bv7e07AseJi4MCGSJ0tShKRX8v1dlJ+mu+iBxODAqfDxzCqrYwFrpm/U
	 xv5feeJwDdPz6YgpJw+EgaA3DsKUmR/eChW5i8lDexfkxz75UFU4rEvCMHpAacuiq8
	 4o5m2LPrPW4D7ItarBUfg+4UZMSXGwzXvGEedVV6dicQjT2LQd79V4LYAy0IKeVlIM
	 aI19/cIphuxm1eMlo7oYrt8Z2GP3hU7FcZKZFO5XAf0lgZ7Ysiq0+ypsaRITBodMXt
	 J2v6BHRCIieDA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-36527ac0750so564081fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 15:57:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/Q3jxicQrMJ/eDKhaS9yLMJbumhK5HKvSZyNNteZql/edLfKl
	Qk/+9JzYn7Od12FyJdYtNtyMxTg6gLkI8B2IEKOtzhgY5fCZgSbsbgtjBt9B4sK4wXZUVbJBRPu
	CnjWGx6HyLTPz24JJXx2/UQawfehaji0=
X-Google-Smtp-Source: AGHT+IG+/X5R1ZTZ4dfjVO4h6pavIg7zAVvsJrMtanP9NZghUGvVv86hOkwmY0GFwz90F8mhrNUHQqCRq1FbPgXJObM=
X-Received: by 2002:a05:651c:222c:b0:36d:e147:3f34 with SMTP id
 38308e7fff4ca-37609cea8d5mr79612831fa.2.1760569026357; Wed, 15 Oct 2025
 15:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gzdSvfc7SQjhFkcntlBuhEWV1nthryRut4Tlw-45PuMe0Zs69tE8sDcR0g1lio07xaaNFMhB5SpMF6aAYIHTc5ZWjhtgZQvBZr0c5YeG0OI=@proko.dev>
In-Reply-To: <gzdSvfc7SQjhFkcntlBuhEWV1nthryRut4Tlw-45PuMe0Zs69tE8sDcR0g1lio07xaaNFMhB5SpMF6aAYIHTc5ZWjhtgZQvBZr0c5YeG0OI=@proko.dev>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 15 Oct 2025 17:56:54 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzq17MXB1s3U9EXCpCPAwdjO1fNmAzftoJ_hyVinXsLG3A@mail.gmail.com>
X-Gm-Features: AS18NWBvDxF-hMjZyqvSHzRT2HhNlOKLXSLrtiiY_mc4WdQGiTPMmcEfGJCH5nQ
Message-ID: <CAGp9Lzq17MXB1s3U9EXCpCPAwdjO1fNmAzftoJ_hyVinXsLG3A@mail.gmail.com>
Subject: Re: [BUG] btmtk: LE Audio connection failure on MT7925
To: =?UTF-8?Q?Ar=C5=ABnas_Prokopas?= <arunas@proko.dev>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ar=C5=ABnas,
Could you please capture and share a btmon log while reproducing the
LE Audio issue? It will help the vendor diagnose the problem
effectively.
Thank you!

On Tue, Sep 23, 2025 at 8:48=E2=80=AFPM Ar=C5=ABnas Prokopas <arunas@proko.=
dev> wrote:
>
> Hello,
>
> I have encounter a bug with the btmtk driver on an MT7925 chip, where LE =
Audio (ISO) connections consistently fail. Classic A2DP audio works correct=
ly.
>
>
> Setup:
>
> Device: Motherboard with onboard MediaTek MT7925
> Kernel: 6.16-8-2-cachyos
> BlueZ: 5.84-1
> linux-firmware: 1:20250808-1 (provides `mediatek/mt7925/BT_RAM_CODE_MT792=
5_1_1_hdr.bin`)
>
>
> Steps to Reproduce:
>
> - Enable and force LE audio in `/etc/bluetooth/main.conf`:
>     [General]
>     Experimental =3D true
>     KernelExperimental =3D 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
>     ControllerMode =3D le
> - Restart the bluetooth service: `systemctl restart bluetooth.service`
> - Re-pair the LE audio device
> - Attempt to connect
>
>
> Expected Behavior:
>
> The LE Audio transport should be established successfully, as the hardwar=
e advertises support for the necessary features to the host driver.
>
>
> Observed Behavior:
>
> The device connects, but the audio transport fails to establish. `bluetoo=
thctl` shows a continuous loop of creating and deleting transports. The ker=
nel and bluetoothd logs show a clear failure.
>
>
> 1. The kernel log (`dmesg`) show a few issues:
>
> - The firmware version isn't reported correctly, suggesting an initializa=
tion problem.
> - A warning is logged that a feature is being advertised but not supporte=
d.
> - Despite the ISO layer being initialized by kernel successfully, the dri=
ver rejects the `LE_SET_CIG_PARAMS` command (Opcode `0x2062`) repeatedly.
>
>     [   36.005161] mt7925e 0000:0b:00.0: enabling device (0000 -> 0002)
>     [   36.009348] mt7925e 0000:0b:00.0: ASIC revision: 79250000
>     [   36.084024] mt7925e 0000:0b:00.0: HW/SW Version: 0x8a108a10, Build=
 Time: 20250721232852a
>     [   36.423286] mt7925e 0000:0b:00.0: WM Firmware Version: ____000000,=
 Build Time: 20250721232943
>     ...
>     [   63.633518] Bluetooth: hci1: HW/SW Version: 0x00000000, Build Time=
: 20250825220109
>     [   82.298593] Bluetooth: hci1: Device setup in 18160764 usecs
>     [   82.298597] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connec=
tion command is advertised, but not supported.
>     ...
>     [   82.515641] Bluetooth: ISO socket layer initialized
>     ...
>     [ 1272.202995] Bluetooth: hci1: Opcode 0x2062 failed: -95
>     [ 1272.446987] Bluetooth: hci1: Opcode 0x2062 failed: -95
>     [ 1272.474975] Bluetooth: hci1: Opcode 0x2062 failed: -95
>
>
> 2. The bluetoothd log (`journalctl`) correctly reports the error from the=
 kernel:
>
>     Sep 24 01:58:19 my-pc bluetoothd[17487]: profiles/audio/bap.c:iso_con=
nect_cb() connect to 80:99:E7:F0:37:7E: Operation not supported (95)
>     Sep 24 01:58:19 my-pc bluetoothd[17487]: profiles/audio/bap.c:iso_con=
nect_cb() connect to 80:99:E7:F0:37:7E: Operation not supported (95)
>
>
> 3. `bluetoothctl` output (sample of the loop):
>
>     [CHG] Device 80:99:E7:F0:37:7E Connected: yes
>     [CHG] LE 80:99:E7:F0:37:7E Connected: yes
>     [NEW] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd14
>
>     [NEW] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_source0/fd1=
5
>
>     [CHG] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd14 =
Links: /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_source0/fd15
>     [CHG] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_source0/fd1=
5 Links: /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd14
>     [DEL] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd14
>
>     [DEL] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_source0/fd1=
5
>
>     [NEW] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd16
>
>     [CHG] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd16 =
Volume: 0x0066 (102)
>     [DEL] Transport /org/bluez/hci1/dev_80_99_E7_F0_37_7E/pac_sink0/fd16
>
>
>
> Additional Context:
>
> This may indicate an incomplete implementation for this specific chipset,=
 possibly related to the development work discussed in this thread from May=
 2024:
> Link: https://lore.kernel.org/linux-bluetooth/dc0445c08b4a7189388a006765d=
4c647e6ba0164.camel@mediatek.com/
>
>
> Please let me know if any further logs, tests, or information are needed.
>
> Thanks,
> Arunas Prokopas
