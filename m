Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AF3BBF6
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799272; cv=none; b=L+XCQy+JjVBkbrS+ho3qyrRJh+c9XuNRpL9NtGl/3I3XkfxX+MLiRjOzGo5MEI6sXagJNphsNAUnvlnjJLO7nWwsK44/Kh7Tc+vCOBGbPo+kJvU0ffztwkiz3mmm4jNHCljubhOnR7HYo1KG5TXwe73Fb2sIyWMQ52HGBLaWhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799272; c=relaxed/simple;
	bh=hjio7Sn1KDdRYB41xhBIlYR2jWAchFBGcBam8iPEX0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=j3oaO+9aVN14j4ECPfQlZVDJRCaVYJPQyPX5ZdzNf4fHFfk26gs/V4pIrxTWh1+CMCR76CN8GBhjPweJCfROMWgCTGJYDhQvbhd0Kfn90x7fKw5ZiBQAoU0c8MyxJ5e/6YJ/U2a3afasbkL50tC9JmrsLPMzXSvR9VmWh3Tbt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtYiYOeh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtYiYOeh"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5231efd80f2so4918195e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715799268; x=1716404068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpzDVN9xEFaaaoSvggsaGDOC7EzPMQ13dlrCeT5SfOE=;
        b=EtYiYOeh/goEtudBcHEtQ0sykPM0pnh9DYxLLiZElxBwfgvOf1Qtbb7e8p+8G6rbQh
         wZC/eWJ21P776fRs491x2NkGVVnkKrHId9mYtp/K11yW5uOCv6D5U88pDp11MxTowEmd
         PCRdR6jA2Y2QfhY6ZfOI7oiUR+xWFaXhFHL+ZhzmQV3TwFBWEHDS6YyuAS8bbOqKQ4eI
         lm68oWKMovQr8uXRenfKMvWum+SN3oWTQngHiUwPk6jx1E2NOls4Dug0FGjUDdeBAZUi
         ifF7omYELk3uvD0/k6ou0Uk5v5lr01qz1DAZAeBWoFsOX9LVFxl6lWbNOlKghPm5Uf85
         sVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715799268; x=1716404068;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpzDVN9xEFaaaoSvggsaGDOC7EzPMQ13dlrCeT5SfOE=;
        b=LAth/lRcfnYuwIu/idUlDBEz3gfHQRItbmRE9K+d3DCqRkCeIT9h1hx/vj9PyR2IBU
         qVBR9H2OMNPIxnjjM5tFzpZhJe+sF+flNQaOhh7pbh2tanwsC+Rf15Bad+3AWRx9aCC2
         Ur/BbW8qMzaQCIqiTjY8DD8sbVgM5vQ6xA7q5+ujGIY661naGoUp+EynDaXEdb5HXUGH
         5YWlXDGT8hLbMYR4PtngbAuss55S6BOKP5yRnVxMchJtc8mqaVKnMLFXn2JM+g7hT8Y9
         L02tZT2XjxLVY302+fusbLB1ISC2FCC4FwtCy2x/j6d+neP8dlWVLz14/BES2KPPMEHB
         chYw==
X-Gm-Message-State: AOJu0Yzk5QWcbEbRLpGBjfiT9lHuxmQ7E5wXXI43Rgh9ym9d3Zs0iEau
	mh+UPSIX1mc5CwTT2wng/RgsPgWAs3MUPMgzG9ODOWMylm6Y0lsYtssc97mQq9Sg2Cpf
X-Google-Smtp-Source: AGHT+IHaC3butomcIG2Xqvsm4kVDDD3/c6M/deJ2bJIVWQALx9QWWEG6f0NFso6aQ4PgN5WBQfroXw==
X-Received: by 2002:a05:6512:3605:b0:51f:b781:729d with SMTP id 2adb3069b0e04-5220fd7acf5mr9079550e87.38.1715799268120;
        Wed, 15 May 2024 11:54:28 -0700 (PDT)
Received: from [192.168.50.232] ([176.196.131.103])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52394a319f1sm351304e87.64.2024.05.15.11.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 11:54:27 -0700 (PDT)
Message-ID: <2e9efc65-d408-48db-bf7c-1c186bd73446@gmail.com>
Date: Thu, 16 May 2024 01:54:26 +0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: abandoned patches for ATS2851
From: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org
References: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
Content-Language: ru, en-GB
In-Reply-To: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!
Sorry, this is my first time interacting with a kernel mailing list, and 
I think I should have specified more recipients.
Now I'm trying again.

14.05.2024 0:14, Данил пишет:
> Hello!
> I encountered a problem with a USB bluetooth adapter which probably 
> uses an ATS2851.
> I'm not 100% sure about this, but the symptoms match the problem 
> described in the patch.
>
> Here are the patches I found.
> 1. It seems to have been applied.
> https://lore.kernel.org/linux-bluetooth/168150781825.20001.4973139468540739153.git-patchwork-notify@kernel.org/T/#t 
>
>
> 2. It seems it was not applied.
> https://lore.kernel.org/linux-bluetooth/20230323135804.3962783-1-raul.cheleguini@gmail.com/T/#t 
>
>
> 3. It seems it was not applied.
> https://patchwork.kernel.org/project/bluetooth/patch/20230426184017.2051211-1-raul.cheleguini@gmail.com/#25314789 
>
>
> Patches 2 and 3 were not applied, as I understand, due to some minor 
> problems with code formatting, is it possible to complete the process 
> of applying them?
>
> Here is some information about the device:
>
> dmesg
> [    0.000000] Linux version 6.6.13+bpo-rt-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, 
> GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_RT Debian 
> 6.6.13-1~bpo12+1 (2024-02-15)
> [    0.000000] Command line: 
> BOOT_IMAGE=/boot/vmlinuz-6.6.13+bpo-rt-amd64 
> root=UUID=b9338182-ab4b-48cb-b492-60e7ed340018 ro 
> systemd.unified_cgroup_hierarchy=false quiet reboot=pci
> ...
> [  110.420763] usb 1-2: new full-speed USB device number 2 using uhci_hcd
> [  110.609798] usb 1-2: New USB device found, idVendor=10d7, 
> idProduct=b012, bcdDevice=88.91
> [  110.609814] usb 1-2: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=3
> [  110.609820] usb 1-2: Product: general adapter
> [  110.609824] usb 1-2: Manufacturer: Actions
> [  110.609829] usb 1-2: SerialNumber: ACTIONS1234
> [  110.614223] Bluetooth: hci1: HCI Read Default Erroneous Data 
> Reporting command is advertised, but not supported.
> [  110.614245] Bluetooth: hci1: HCI Read Transmit Power Level command 
> is advertised, but not supported.
> [  110.614252] Bluetooth: hci1: HCI LE Set Random Private Address 
> Timeout command is advertised, but not supported.
> [  110.666673] Bluetooth: MGMT ver 1.22
>
> lsusb -v
> ...
> Bus 001 Device 002: ID 10d7:b012 Actions general adapter
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          224 Wireless
>   bDeviceSubClass         1 Radio Frequency
>   bDeviceProtocol         1 Bluetooth
>   bMaxPacketSize0        64
>   idVendor           0x10d7
>   idProduct          0xb012
>   bcdDevice           88.91
>   iManufacturer           1 Actions
>   iProduct                2 general adapter
>   iSerial                 3 ACTIONS1234
>   bNumConfigurations      1
> ...
>
> btmon
> ...
> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 58 #48 
> [hci0] 2.000505
>         Filter policy: Accept list is not used (0x00)
>         Own address type: Public (0x00)
>         Peer address type: Random (0x01)
>         Peer address: E8:42:26:5C:0F:07 (Static)
>         Initiating PHYs: 0x07
>         Entry 0: LE 1M
>           Scan interval: 60.000 msec (0x0060)
>           Scan window: 60.000 msec (0x0060)
>           Min connection interval: 30.00 msec (0x0018)
>           Max connection interval: 50.00 msec (0x0028)
>           Connection latency: 0 (0x0000)
>           Supervision timeout: 420 msec (0x002a)
>           Min connection length: 0.000 msec (0x0000)
>           Max connection length: 0.000 msec (0x0000)
>         Entry 1: LE 2M
>           Scan interval: 60.000 msec (0x0060)
>           Scan window: 60.000 msec (0x0060)
>           Min connection interval: 30.00 msec (0x0018)
>           Max connection interval: 50.00 msec (0x0028)
>           Connection latency: 0 (0x0000)
>           Supervision timeout: 420 msec (0x002a)
>           Min connection length: 0.000 msec (0x0000)
>           Max connection length: 0.000 msec (0x0000)
>         Entry 2: LE Coded
>           Scan interval: 60.000 msec (0x0060)
>           Scan window: 60.000 msec (0x0060)
>           Min connection interval: 30.00 msec (0x0018)
>           Max connection interval: 50.00 msec (0x0028)
>           Connection latency: 0 (0x0000)
>           Supervision timeout: 420 msec (0x002a)
>           Min connection length: 0.000 msec (0x0000)
>           Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Status (0x0f) plen 4 #49 [hci0] 2.001242
>       LE Extended Create Connection (0x08|0x0043) ncmd 1
>         Status: Unknown HCI Command (0x01)
> ...
> The adapter supports le, I was able to connect to a le device from 
> windows 11.
>
