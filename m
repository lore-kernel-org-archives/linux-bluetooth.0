Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348153BBEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802214; cv=none; b=hnvbeEOBmjY1P2HJNrWYptm73im7tOF3Y8CBY7hb4dJkBKhCvZUST4CT1C1UzAzg2eiTMJvf5Bka7hJa/3p8U7HTmN6BQxWwqJDid9NGqJmEArgJgl3b0DB3nUCMfbqgqZlOf3qn4ACB1Webiwv+GxPxjB7/wjFYfj8D5NP8v6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802214; c=relaxed/simple;
	bh=b1pw7JooSBq1I22NDbKu3kX6Se6D/2SgMCGOZx4mb0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLkKtl7AI1jLh7gtEEsSCmBvhOp3QRvDvODRs79k3xnsNQCNG0bpJ58d1KcGigdBok+zZ6lJV2UHFqhXPQpK4HidBzp3nPQ+Th8ls8COkRThF2o0RRCD8q3AmFphbWXLX3iy0mHvJjSYy8hBjDKuaHjuaf/jPw70TzVFf0bFTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvL8+9On; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvL8+9On"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so21003611fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715802210; x=1716407010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtDjUzK5fncxIE31/MG5fH/L8guHHjN1Oj09RQ1JU84=;
        b=EvL8+9Onl24CK8DDNu48iUo0UmDgYNVh6KSaLikPmo0wV7UQKV9+4e7riE+T8NmSLB
         BAi9I5vfgsXVE8zTPmRk3C1Wwpp1EEw7VGNHus1rvplD3RS0yJEf2L3c1k4kYi7H02t6
         TaUrFl66fBenZx1lS69gPwKqfwkIX7BFcZwM3CRo46f63vxbET8zOovOxH3hpRIoWaCu
         6SlvHPU+HKUE9ZonpON0WOlduf/HA8gDqCaM6pxzZ9F7N58NCBPqT7CqRns6rGMMSbHN
         1GpP14qTOz6ZdKAb1OGJP0DOcAp2HmFYLJl64OiQw/XmCUsOUL7yxvWRthIWtiDDmqhU
         nb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802210; x=1716407010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtDjUzK5fncxIE31/MG5fH/L8guHHjN1Oj09RQ1JU84=;
        b=M7cpvLYjEMI60Jw3Cd3NT2qcLYFuoJD4PVSnkWR/6qWA9Rq+I/OFQ60C2cZh2VaYJl
         /sS2gzDBxdLgnzYKxCERVtNBMmwBfoiwWNniNza8PlObMJwr0RuzgRK9Ph+yAHGOybJ9
         /lDF6YYXSNOkhtwAE7Cmyi1+UbbH9hxKQ0yeZ7LaEr+XbRo7tjweCvZQbwNJw5S8JnEd
         AFT2HCW25ev/mk8v9+V+hrjarAymk8bG9rg1VYpybpzDG0l6nw8EIex/oZLkBuVsAjhS
         xIwdY0YfquBdzuV1o3tWlL6SlOYBcPS7enhbU85TYX1yHXF2+VROdhIurn0uEZhtUJbC
         bWcw==
X-Gm-Message-State: AOJu0YweGDX7gI+df3xrHekV5LwDflXp6RQYNpBiGrz5vhFSmhNfKUPI
	Uc/3cYJ3m9JbNrmMc1MmpqHoKG+kbSNqf5elIjsAZF8oMyAemzFncmSPai/psyBTJ7FiZG19TML
	KIsdT6MTvdd73kgYmK45XZ9zTAgKB4w==
X-Google-Smtp-Source: AGHT+IHsw9JNxf5Jvy4xVGuPcR+/D696QudOQR0bc3yNXtCn84F6b2CgHhh4/4+iPFKl1DYOCwQbs1pIjhRFEwjpRZQ=
X-Received: by 2002:a2e:8847:0:b0:2dd:2bd8:a4c1 with SMTP id
 38308e7fff4ca-2e51fc3406cmr149531731fa.10.1715802209975; Wed, 15 May 2024
 12:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com> <2e9efc65-d408-48db-bf7c-1c186bd73446@gmail.com>
In-Reply-To: <2e9efc65-d408-48db-bf7c-1c186bd73446@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 May 2024 15:43:17 -0400
Message-ID: <CABBYNZLuhWF7KgPAZLaqB8dukBtpWDGQKy1bDiStvCJPqny46Q@mail.gmail.com>
Subject: Re: abandoned patches for ATS2851
To: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 15, 2024 at 2:54=E2=80=AFPM =D0=94=D0=B0=D0=BD=D0=B8=D0=BB <dan=
stiv404@gmail.com> wrote:
>
> Hello!
> Sorry, this is my first time interacting with a kernel mailing list, and
> I think I should have specified more recipients.
> Now I'm trying again.
>
> 14.05.2024 0:14, =D0=94=D0=B0=D0=BD=D0=B8=D0=BB =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > Hello!
> > I encountered a problem with a USB bluetooth adapter which probably
> > uses an ATS2851.
> > I'm not 100% sure about this, but the symptoms match the problem
> > described in the patch.
> >
> > Here are the patches I found.
> > 1. It seems to have been applied.
> > https://lore.kernel.org/linux-bluetooth/168150781825.20001.497313946854=
0739153.git-patchwork-notify@kernel.org/T/#t
> >
> >
> > 2. It seems it was not applied.
> > https://lore.kernel.org/linux-bluetooth/20230323135804.3962783-1-raul.c=
heleguini@gmail.com/T/#t
> >
> >
> > 3. It seems it was not applied.
> > https://patchwork.kernel.org/project/bluetooth/patch/20230426184017.205=
1211-1-raul.cheleguini@gmail.com/#25314789
> >
> >
> > Patches 2 and 3 were not applied, as I understand, due to some minor
> > problems with code formatting, is it possible to complete the process
> > of applying them?

These probably need to be resend to get the CI to test them.

> >
> > Here is some information about the device:
> >
> > dmesg
> > [    0.000000] Linux version 6.6.13+bpo-rt-amd64
> > (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0,
> > GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_RT Debian
> > 6.6.13-1~bpo12+1 (2024-02-15)
> > [    0.000000] Command line:
> > BOOT_IMAGE=3D/boot/vmlinuz-6.6.13+bpo-rt-amd64
> > root=3DUUID=3Db9338182-ab4b-48cb-b492-60e7ed340018 ro
> > systemd.unified_cgroup_hierarchy=3Dfalse quiet reboot=3Dpci
> > ...
> > [  110.420763] usb 1-2: new full-speed USB device number 2 using uhci_h=
cd
> > [  110.609798] usb 1-2: New USB device found, idVendor=3D10d7,
> > idProduct=3Db012, bcdDevice=3D88.91
> > [  110.609814] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,
> > SerialNumber=3D3
> > [  110.609820] usb 1-2: Product: general adapter
> > [  110.609824] usb 1-2: Manufacturer: Actions
> > [  110.609829] usb 1-2: SerialNumber: ACTIONS1234
> > [  110.614223] Bluetooth: hci1: HCI Read Default Erroneous Data
> > Reporting command is advertised, but not supported.
> > [  110.614245] Bluetooth: hci1: HCI Read Transmit Power Level command
> > is advertised, but not supported.
> > [  110.614252] Bluetooth: hci1: HCI LE Set Random Private Address
> > Timeout command is advertised, but not supported.
> > [  110.666673] Bluetooth: MGMT ver 1.22
> >
> > lsusb -v
> > ...
> > Bus 001 Device 002: ID 10d7:b012 Actions general adapter
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          224 Wireless
> >   bDeviceSubClass         1 Radio Frequency
> >   bDeviceProtocol         1 Bluetooth
> >   bMaxPacketSize0        64
> >   idVendor           0x10d7
> >   idProduct          0xb012
> >   bcdDevice           88.91
> >   iManufacturer           1 Actions
> >   iProduct                2 general adapter
> >   iSerial                 3 ACTIONS1234
> >   bNumConfigurations      1
> > ...
> >
> > btmon
> > ...
> > < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 58 #48
> > [hci0] 2.000505
> >         Filter policy: Accept list is not used (0x00)
> >         Own address type: Public (0x00)
> >         Peer address type: Random (0x01)
> >         Peer address: E8:42:26:5C:0F:07 (Static)
> >         Initiating PHYs: 0x07
> >         Entry 0: LE 1M
> >           Scan interval: 60.000 msec (0x0060)
> >           Scan window: 60.000 msec (0x0060)
> >           Min connection interval: 30.00 msec (0x0018)
> >           Max connection interval: 50.00 msec (0x0028)
> >           Connection latency: 0 (0x0000)
> >           Supervision timeout: 420 msec (0x002a)
> >           Min connection length: 0.000 msec (0x0000)
> >           Max connection length: 0.000 msec (0x0000)
> >         Entry 1: LE 2M
> >           Scan interval: 60.000 msec (0x0060)
> >           Scan window: 60.000 msec (0x0060)
> >           Min connection interval: 30.00 msec (0x0018)
> >           Max connection interval: 50.00 msec (0x0028)
> >           Connection latency: 0 (0x0000)
> >           Supervision timeout: 420 msec (0x002a)
> >           Min connection length: 0.000 msec (0x0000)
> >           Max connection length: 0.000 msec (0x0000)
> >         Entry 2: LE Coded
> >           Scan interval: 60.000 msec (0x0060)
> >           Scan window: 60.000 msec (0x0060)
> >           Min connection interval: 30.00 msec (0x0018)
> >           Max connection interval: 50.00 msec (0x0028)
> >           Connection latency: 0 (0x0000)
> >           Supervision timeout: 420 msec (0x002a)
> >           Min connection length: 0.000 msec (0x0000)
> >           Max connection length: 0.000 msec (0x0000)
> > > HCI Event: Command Status (0x0f) plen 4 #49 [hci0] 2.001242
> >       LE Extended Create Connection (0x08|0x0043) ncmd 1
> >         Status: Unknown HCI Command (0x01)
> > ...
> > The adapter supports le, I was able to connect to a le device from
> > windows 11.
> >



--=20
Luiz Augusto von Dentz
