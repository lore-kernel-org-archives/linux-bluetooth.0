Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6C2727E6
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062094; cv=none; b=ImZ/gqYtAeNLoYCAqIgx7xWUO+V/aaIWp7QKec3J+bHo8q8h0hpwTIeZCLFwIm93O1b+maMnHDkhjgsZYwOVy4pAkLD9V+FlhQ8TyVDzG0ZYn5x5oOnZJAiKoknzryxmXXoXB7fThbm+RZfveZ9dgfazqfAo7F8KF/vbMtP4R2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062094; c=relaxed/simple;
	bh=QaRhFLKjS7lb3Uzvzei2f/m74ZCu/hMM0LowHTdx0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQKjP6jUQtXstYsFLEy+OjSHlRnt0eB5QaWYZVgCH9ZyWhP0WvmBBXFiCJsBqbtUFlcCmwqPCuCrnt8VrUEGTZ0NTSmDs8BEnxmF5IFKUdoY9VJC6IbCiKYnlsgJcbrvtAyEWLDnAHSCItV1pmDBDuO9aiDWY4BzqaD6r2mwiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEcq7Nlb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEcq7Nlb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af937728c3eso112575266b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Aug 2025 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062090; x=1754666890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80q60wd9ZtmjIOjAfp+QSjzn7p702Pqk/yvC1CpCtxA=;
        b=bEcq7Nlbx0pFhH0uH8wowJrSFJiglZEJrsSknyE34a8QSMQg1eDoa5p2hgzFaAKBB0
         NJKmaZrvH95OkMPM1v+7xEKOJsEXIdBvZfmxXoGcL00Hpug7HoiWpd3SK9qb79MxmbPU
         nQdD7Q84ej+vgoIrCtYOjlekcV9dedbj67E3S6F5ClFtgU3Rw+vQZ51CMZzcXwNDM3u5
         nQUm5mexU79/iW7JKt4VKckpQeDSfQnfGJxv0m7p575CdtcXbHe2EpJ5GhxjYdRxGR83
         JoQdxBxxgkkPhz1qibatpPpKWlW/lAuvBk0gUIzZ5H2L54eLMPenCqw/o2sr5MsOcJjd
         S4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062090; x=1754666890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80q60wd9ZtmjIOjAfp+QSjzn7p702Pqk/yvC1CpCtxA=;
        b=dUvdOjsvgABokzNf3Jojy6gjeWeKquee81d94I/IFdlrhzxrdWkzf8feIa6y2KprjT
         zM+FeN/sCiXTj7P4Qstd3OwXAaiG7MEJstIRs7U0cmp2o7tjkcdDfGIi8qo0siOvvJFO
         2EA/cQOc1ev1/IX4o/UoTCrn3VOG9XSk45NA5QlqSBhF1hSPi5mw3ptpf+wqeVoYH0VI
         xSx20pEEPss7aGLZgKsdi+Juv4XAzymW7zZfkByxdeuL4cxUOUzJRtCA/CaS9DGY349t
         qwetZzTmzjD2nNxrMjZmC7nmYu0xzunwTNr4d6yOg/wqWGmMFM3SCtePNveC3TzvU+LV
         RyyA==
X-Gm-Message-State: AOJu0YwgaiuWDIlfs5tlCT6yEKrd5IBYXTNyLGWG+nH0TmnuX7aX551I
	MEcLAmLOKFmBr2dL+gvPZxxnaXn3aghpjxRqr1K7zq0WPBP4HTF3srmIPc/WDzOGSg5Cl7ai5Zo
	417gxrq1zFzBoymKPTqfllp6/UrU98q0=
X-Gm-Gg: ASbGncsLrzmsEBy09F7WWV7VMrekIdSOukPBP86CpfEweG/+xNl5Wr2zNkuu/EBRFY3
	nwvybYR1chNy1oh5MYQg/XvSHzQHjN2ylV/RzMh7PCHz9FIlIB8aZTGSjrI8pfJ62gfOx75Ykjs
	dFPnDp/ZYI8j/pKUaHLPW7kCu4piHSAz/K56PtHEkSw06NX9bmKUwqivIuPpCef85/7Tk=
X-Google-Smtp-Source: AGHT+IHbVAdUUWWoEp2nRkIMfhVZZQCe+us2DV2TOlABVG0P7Hh7fKWwb4tqQHZaJriNgyUiLkbOem6GNpKbk0ypIGw=
X-Received: by 2002:a17:906:b84d:b0:af9:3f99:1422 with SMTP id
 a640c23a62f3a-af93f991badmr38604066b.5.1754062090228; Fri, 01 Aug 2025
 08:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nAgFfu-0=hRWNOomWiJvhutY0mEBqD23mhBDF+WdVkn0MWNg@mail.gmail.com>
 <15bf85af-eae7-416c-9feb-ef744cdf4b0a@molgen.mpg.de>
In-Reply-To: <15bf85af-eae7-416c-9feb-ef744cdf4b0a@molgen.mpg.de>
From: Antti Garding <antti.garding.oss@gmail.com>
Date: Fri, 1 Aug 2025 18:27:59 +0300
X-Gm-Features: Ac12FXwSTC0OaC2wi51-bq8CGCg13htOMnnCrGg10ACYo55-XB-WAL2Oqd-IOKU
Message-ID: <CA+nAgFc+afnmr8ZJhDgJyZzvCqWBx3aovY=chcRrwvN8nXJRig@mail.gmail.com>
Subject: Re: Headset is disconnected immediately
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I created a bug report containing my original post on this list and
the requested logs, as you may have already noticed. The id is 220391
and a link to the report is
https://bugzilla.kernel.org/show_bug.cgi?id=3D220391 .


BR,
Antti
On Thu, Jul 31, 2025 at 8:12=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dera Antti,
>
>
> Thank you for your report.
>
> Am 31.07.25 um 19:07 schrieb Antti Garding:
> > I am having a issue using my Bluetooth headset (Sony WH-1000XM3) in
> > Linux. When I turn it on, the headset is immediately connected, but
> > after that, it is also immediately disconnected. This
> > connect-disconnect is automatically repeated three times with some
> > seconds between the occasions.
> >
> > My environment is a Lenovo Thinkpad E14 Gen 4 laptop running Xubuntu
> > 22.04. The computer has an integrated WLAN + Bluetooth adapter based
> > on Intex AX201, connected on USB bus. WLAN works fine and also the
> > Bluetooth works when running Windows. I have read on Intel=E2=80=99s fo=
rum
> > that the driver for the chip should have been ok since kernel version
> > 5.10. My distribution comes with 6.8 so this issue shouldn=E2=80=99t be=
 about
> > that.
>
> Please attach the full output of `dmesg`.
>
> > Log time ago, I managed to pair the headset and it is still listed as
> > a paired device. Trying to unpair it in the bluetoothctl console
> > results in error message saying the device doesn=E2=80=99t exist.
> >
> > Here is what happens in bluetoothctl console when I try to connect the
> > headset manually:
> >
> > [bluetooth]# connect 38:18:4C:D4:C2:94
> > Attempting to connect to 38:18:4C:D4:C2:94
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> > Failed to connect: org.bluez.Error.Failed br-connection-canceled
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> > [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> >
> > Here are some log prints related to Bluetooth in general:
> >
> > sudo dmesg | grep -i blue
> > [    2.899284] Bluetooth: Core ver 2.22
> > [    2.899534] NET: Registered PF_BLUETOOTH protocol family
> > [    2.899535] Bluetooth: HCI device and connection manager initialized
> > [    2.899574] Bluetooth: HCI socket layer initialized
> > [    2.899593] Bluetooth: L2CAP socket layer initialized
> > [    2.899601] Bluetooth: SCO socket layer initialized
> > [    2.951909] Bluetooth: hci0: Device revision is 2
> > [    2.951914] Bluetooth: hci0: Secure boot is enabled
> > [    2.951915] Bluetooth: hci0: OTP lock is enabled
> > [    2.951916] Bluetooth: hci0: API lock is enabled
> > [    2.951917] Bluetooth: hci0: Debug lock is disabled
> > [    2.951918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> > [    2.951920] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype =
1 build 38
> > [    2.952008] Bluetooth: hci0: DSM reset method type: 0x00
> > [    2.960708] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4=
150.sfi
> > [    2.960752] Bluetooth: hci0: Boot Address: 0x100800
> > [    2.960754] Bluetooth: hci0: Firmware Version: 107-51.22
> > [    3.272512] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio =
is blocked
> > [    4.012759] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [    4.012763] Bluetooth: BNEP filters: protocol multicast
> > [    4.012770] Bluetooth: BNEP socket layer initialized
> > [    4.684563] Bluetooth: hci0: Waiting for firmware download to comple=
te
> > [    4.684902] Bluetooth: hci0: Firmware loaded in 1683777 usecs
> > [    4.685041] Bluetooth: hci0: Waiting for device to boot
> > [    4.700965] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> > [    4.701034] Bluetooth: hci0: Device booted in 15702 usecs
> > [    4.701904] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0=
040-4150.ddc
> > [    4.704071] Bluetooth: hci0: Applying Intel DDC parameters completed
> > [    4.707146] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1 =
build 56683
> > [    4.707151] Bluetooth: hci0: Firmware SHA1: 0xe2305c5c
> > [    4.776168] Bluetooth: MGMT ver 1.22
> > [    6.448715] Bluetooth: RFCOMM TTY layer initialized
> > [    6.448724] Bluetooth: RFCOMM socket layer initialized
> > [    6.448727] Bluetooth: RFCOMM ver 1.11
> >
> > Are there any known solutions to this issue? If not, are there any
> > recommendations where to look for a solution? If this could be a bug,
> > I might be interested in trying to fix it.
> >
> > By the way, I would have asked this on the user mailing list first,
> > but the BlueZ web page didn't mention how to subscribe to it, so I
> > decided to try this developer list.
>
> Please run `btmon -w /dev/shm/20250731--linux-6.8-pairing-issue.cap` and
> provide that. (The developers often ask for this.)
>
> (You could create an issue in the Linux Kernel Bugzilla to attach the log=
s.)
>
>
> Kind regards,
>
> Paul
