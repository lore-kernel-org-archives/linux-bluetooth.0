Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA0149C6A
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324973; cv=none; b=edP9SgL7jb3+rhPGDY7W8NWTY53Cl0TUYZRAefg7KUxWByCQSfGfSDeqI8OtyL6lZ1Jncjex7z3gZfXXJO8WBrWLQ07gDQzhiym5RL/ejiRo1/vlbTs6+CSFvXJi4AE+tH+UCDvndFs47mVyJWs2Hz1XIbEd4EQ0UsnIbFrb3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324973; c=relaxed/simple;
	bh=eGZx6pgnjJ+fJriUAIj3ohJbDZZoTI70+3JD2UAlU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+15o+ftjoQMPtWUvi0COrbvytos39PWXe/ExFjOdyJpLVDcxTAaoYGoJob9P6p7y6TXS0bDrN76R6qgtAizKpCVbkukiroVO3a+3rsBxf9Q3Wrcq47kk7ECWFgZcCw+FHQMBCB2Ozmwul6fEIjAPSuOde2WmOerTFo9GqTUFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebo5QMrA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebo5QMrA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bd70bd741bso185109a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324972; x=1716929772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIFrQ7w5AjsuMtDZekbpTec38sR/Z6OCZUIAcR2zrn8=;
        b=Ebo5QMrA7nYN8aThLkShUNlNTM3G7np1imDMvmlDMDjW7T80rigfrHpY4nPgP2VYeW
         MBB9+0FcLzLpQghE+4xM4bN1od5evGBVYL3XvxO8ZlDcUNRhB4CP4SDqu6I9MjISj/26
         o/xQb9ImH10F513K8r0BTj/tAE2duEvOfkx+QyxpyBjoNYrUpJxXOAqKSE/Ay8Ysiq7T
         63BnyugfyRo2NG6F6MUYrgxsJ/chzzjql2onY1Vh100FrGNM+E0C8/gxWABDN/DJCOPu
         BV+A2tF7BTS4pkL/qzzVBf0E5LXzUFF5lKi/r8Uj0n5UfcoLfQlpDaN9+QiceKMx7k5i
         Z4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324972; x=1716929772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIFrQ7w5AjsuMtDZekbpTec38sR/Z6OCZUIAcR2zrn8=;
        b=CxSd4Q8q7F6ZnyZSZQrMsjSPHwup1B7QynB5y7MTrX6Xo7/XYDVEe/Dme/mfY/36sq
         iXgFdKopw258wj3QvjtwqAPf4VhCo2OFFK/EFYGw2a+/OUORXp0jLl7ItNlvL4o+N1Ta
         Ie8TGipmG0JAzOY7517Bs2/EL3px9DMguvxZJ7Vt8wK4Im6aIscBxRMtl++frqaUzYWY
         Xuu+3E/iukdLjjt+5LMRJ8LNs4XyNHiDt5BEet19EK0PkJH7qC4xJh2JXtmhfDf7Dtk9
         kGYcA1onFPpx3eU+MWud8ixqK3/MbIZFupWbSwkRRtcHJyNUYPsDD0Mdur4Mw+m3ZqAs
         tQwA==
X-Gm-Message-State: AOJu0YzCaxN4wPP4l+ZwcSH2oOFbckKSUR2SR2fgq95BYAtRVRwsGTKu
	x8AE/AEn+m0iZga2bMbS51tuC5657O9RsvpXAyW5W/vLHUkb/468zQ04hOy0efhWXE+N19AHS7n
	/Ad7ijDNzWtjkGRh4iAmwNlrQ1JA=
X-Google-Smtp-Source: AGHT+IFlqFJgswlsTMmBGqgdGuu2YtblQKPYqU8zxrZVJddwrJyFkmZjybDYtAq3szfFeWp4uW38l5VhOOta2at5GjU=
X-Received: by 2002:a17:90b:716:b0:2a5:be1a:6831 with SMTP id
 98e67ed59e1d1-2bd60426bf1mr14178676a91.19.1716324971454; Tue, 21 May 2024
 13:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
In-Reply-To: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
From: Raul Cheleguini <raul.cheleguini@gmail.com>
Date: Tue, 21 May 2024 17:55:35 -0300
Message-ID: <CACk7upyANXexe1e9Zbtajqpo+ujmzJGUpciEEy7kNANTnQUbcg@mail.gmail.com>
Subject: Re: abandoned patches for ATS2851
To: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:14=E2=80=AFPM =D0=94=D0=B0=D0=BD=D0=B8=D0=BB <dan=
stiv404@gmail.com> wrote:
>
> Hello!
> I encountered a problem with a USB bluetooth adapter which probably uses
> an ATS2851.
> I'm not 100% sure about this, but the symptoms match the problem
> described in the patch.
>
> Here are the patches I found.
> 1. It seems to have been applied.
> https://lore.kernel.org/linux-bluetooth/168150781825.20001.49731394685407=
39153.git-patchwork-notify@kernel.org/T/#t
>
> 2. It seems it was not applied.
> https://lore.kernel.org/linux-bluetooth/20230323135804.3962783-1-raul.che=
leguini@gmail.com/T/#t
>
> 3. It seems it was not applied.
> https://patchwork.kernel.org/project/bluetooth/patch/20230426184017.20512=
11-1-raul.cheleguini@gmail.com/#25314789
>
> Patches 2 and 3 were not applied, as I understand, due to some minor
> problems with code formatting, is it possible to complete the process of
> applying them?
>
> Here is some information about the device:
>
> dmesg
> [    0.000000] Linux version 6.6.13+bpo-rt-amd64
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_RT Debian
> 6.6.13-1~bpo12+1 (2024-02-15)
> [    0.000000] Command line:
> BOOT_IMAGE=3D/boot/vmlinuz-6.6.13+bpo-rt-amd64
> root=3DUUID=3Db9338182-ab4b-48cb-b492-60e7ed340018 ro
> systemd.unified_cgroup_hierarchy=3Dfalse quiet reboot=3Dpci
> ...
> [  110.420763] usb 1-2: new full-speed USB device number 2 using uhci_hcd
> [  110.609798] usb 1-2: New USB device found, idVendor=3D10d7,
> idProduct=3Db012, bcdDevice=3D88.91
> [  110.609814] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [  110.609820] usb 1-2: Product: general adapter
> [  110.609824] usb 1-2: Manufacturer: Actions
> [  110.609829] usb 1-2: SerialNumber: ACTIONS1234
> [  110.614223] Bluetooth: hci1: HCI Read Default Erroneous Data
> Reporting command is advertised, but not supported.
> [  110.614245] Bluetooth: hci1: HCI Read Transmit Power Level command is
> advertised, but not supported.
> [  110.614252] Bluetooth: hci1: HCI LE Set Random Private Address
> Timeout command is advertised, but not supported.
> [  110.666673] Bluetooth: MGMT ver 1.22
>
> lsusb -v
> ...
> Bus 001 Device 002: ID 10d7:b012 Actions general adapter
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass          224 Wireless
>    bDeviceSubClass         1 Radio Frequency
>    bDeviceProtocol         1 Bluetooth
>    bMaxPacketSize0        64
>    idVendor           0x10d7
>    idProduct          0xb012
>    bcdDevice           88.91
>    iManufacturer           1 Actions
>    iProduct                2 general adapter
>    iSerial                 3 ACTIONS1234
>    bNumConfigurations      1
> ...
>
> btmon
> ...
> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 58 #48
> [hci0] 2.000505
>          Filter policy: Accept list is not used (0x00)
>          Own address type: Public (0x00)
>          Peer address type: Random (0x01)
>          Peer address: E8:42:26:5C:0F:07 (Static)
>          Initiating PHYs: 0x07
>          Entry 0: LE 1M
>            Scan interval: 60.000 msec (0x0060)
>            Scan window: 60.000 msec (0x0060)
>            Min connection interval: 30.00 msec (0x0018)
>            Max connection interval: 50.00 msec (0x0028)
>            Connection latency: 0 (0x0000)
>            Supervision timeout: 420 msec (0x002a)
>            Min connection length: 0.000 msec (0x0000)
>            Max connection length: 0.000 msec (0x0000)
>          Entry 1: LE 2M
>            Scan interval: 60.000 msec (0x0060)
>            Scan window: 60.000 msec (0x0060)
>            Min connection interval: 30.00 msec (0x0018)
>            Max connection interval: 50.00 msec (0x0028)
>            Connection latency: 0 (0x0000)
>            Supervision timeout: 420 msec (0x002a)
>            Min connection length: 0.000 msec (0x0000)
>            Max connection length: 0.000 msec (0x0000)
>          Entry 2: LE Coded
>            Scan interval: 60.000 msec (0x0060)
>            Scan window: 60.000 msec (0x0060)
>            Min connection interval: 30.00 msec (0x0018)
>            Max connection interval: 50.00 msec (0x0028)
>            Connection latency: 0 (0x0000)
>            Supervision timeout: 420 msec (0x002a)
>            Min connection length: 0.000 msec (0x0000)
>            Max connection length: 0.000 msec (0x0000)
>  > HCI Event: Command Status (0x0f) plen 4 #49 [hci0] 2.001242
>        LE Extended Create Connection (0x08|0x0043) ncmd 1
>          Status: Unknown HCI Command (0x01)
> ...
> The adapter supports le, I was able to connect to a le device from
> windows 11.
>

Hello,

To provide some context on the patches.

With all patches applied locally I managed to pair my Logitech mouse and us=
e it,
but the solution I don't feel is ideal, there were errors and other devices
might not pair well.

At the time I asked the datasheet for this adapter to multiple vendors, wit=
hout
success. I extensively researched forums, pdf repositories, and I did not f=
ind
relevant documentation.

One thing that I noticed watching the HCI dumps of a pairing process in Win=
dows
and Linux is that, in Linux the dump is chaotic and parallel. In other hand=
, the
dump in Windows is organized and more serialized. I don't know if I missed
something related to this at that time.

Anyways, my debug setup for this is disassembled right now, if anyone is wi=
lling
to resume and progress this issue is more than welcomed.
