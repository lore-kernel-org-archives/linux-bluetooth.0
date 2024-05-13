Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40911C694
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620464; cv=none; b=CxNNPqfDZh62EDH43HY88z7yv0uPt8YvDJUp6wIGRyAI+d8tHsZsec6ph7+z3RbdXrguVgK6Xvs7+TSsg8SIPhYblfOGlBKCWcCnGoZlpcAOg5TGPA47HpHNW9k9vdfVwhyF7a7xc8RkdcO4Huh8+oX16wD5SxdXHJTtb/jkLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620464; c=relaxed/simple;
	bh=0Hj3m80/vcjsB9jFL3IohRMKJJXwbmqb2e3u4HQN/CI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=SkQrvy6jC1Xyk7xmESUm75L+XUXfxTr7om2isQn4A3/owORiQjd3VVFjjeHVd4lMI37GzfFdnCLeKQaEU1cS4jPl+kh1X+efkHfX1rwqQi764yKgVcH/70eA9lQbokU0QWmvLC4LXkntpMhqOunv5PWNuv3rsdBrauOnjcVuYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDZ2syMp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDZ2syMp"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so40554291fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715620461; x=1716225261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC+8wb41tXnmaqSI69k73+yCS7xP3be/jrlSImwrGQ0=;
        b=eDZ2syMpQwcO4lqBLVxtmiWKHs3P6pbC0onbDyGOM3KGaigL9iVD9MrB0R80zDOaqC
         pa/FMAac5zI5iT+2tIdwGmb6/iZue3X76Jxxf5KTfSOuEBA96PbGUyIEs6V4blCkvMhH
         +G0p48yLLsrYn8f3zi0YCINxf7w8TkKhg91Nyl1fBerwKUKxsObs/YsPjvLIIKiDKuBf
         f0BQf3yT+rQrVUU2tfWCfRQ9gDzfayrmBN0Fz9cAU2WnR6zRtfPwPE/OtYEK6NeEM2m1
         S1GwjueK7yko7JLSkzjYo29fWqk2XVjn78f2yuXpyJwmFWsXzlvQN9BLLoBQXPY/c9XN
         BNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620461; x=1716225261;
        h=content-transfer-encoding:cc:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JC+8wb41tXnmaqSI69k73+yCS7xP3be/jrlSImwrGQ0=;
        b=FIasWmEIYTwJFyVskMeTaD0AESbwZS0Is/jDwjhsMk7yDYUbcHN7MnWWY2hytHeS9m
         G8BtZJGL5ZOFuGOeuAltwkXR8DmOLqY9xkliFdHZTgBpLPSUngU8ofif+gQOiwwDqd7w
         IRgT1g8UBsTG+BPcfkiUQyKgXow8EXJ0XA1beXb9p5E5vxzY6XAzPIBQc6O8iUQmREV1
         nmb32gC0jBA251fg2QeG2kdQQnXFP2kDy4tfAW4sPNe4rr/+qsd6fr8TJI3gV+9k31Dl
         HgCEcPYO7/S/WgGWq3FRc0R9ZQkcpm2Dg/f4bXGsZKKYKqunUakusW2BCrX5Eu5Skbh5
         OUjQ==
X-Gm-Message-State: AOJu0YwA3TcaShkLsENDAgAkn0RUiCayoLW5LRVFeRXvaXwqAz8KleYo
	iWPCSY+CcxLy+ePNqqEW98D4tzBBsFQ1PWXyLUj37QIRipxPAyTVXJzgQKa32befVA==
X-Google-Smtp-Source: AGHT+IEPZWPuJ8XpzdHgv2PyzI3IYX+vCFt4CRRdwS0Ky5SX0dl0Dc2w42UHpQUXeVt//92yqXEzQg==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr69979311fa.3.1715620451491;
        Mon, 13 May 2024 10:14:11 -0700 (PDT)
Received: from [192.168.50.232] ([176.196.131.103])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e55d7ce0f5sm10163831fa.50.2024.05.13.10.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 10:14:11 -0700 (PDT)
Message-ID: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
Date: Tue, 14 May 2024 00:14:11 +0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: ru, en-GB
From: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
Subject: abandoned patches for ATS2851
Cc: raul.cheleguini@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!
I encountered a problem with a USB bluetooth adapter which probably uses 
an ATS2851.
I'm not 100% sure about this, but the symptoms match the problem 
described in the patch.

Here are the patches I found.
1. It seems to have been applied.
https://lore.kernel.org/linux-bluetooth/168150781825.20001.4973139468540739153.git-patchwork-notify@kernel.org/T/#t

2. It seems it was not applied.
https://lore.kernel.org/linux-bluetooth/20230323135804.3962783-1-raul.cheleguini@gmail.com/T/#t

3. It seems it was not applied.
https://patchwork.kernel.org/project/bluetooth/patch/20230426184017.2051211-1-raul.cheleguini@gmail.com/#25314789

Patches 2 and 3 were not applied, as I understand, due to some minor 
problems with code formatting, is it possible to complete the process of 
applying them?

Here is some information about the device:

dmesg
[    0.000000] Linux version 6.6.13+bpo-rt-amd64 
(debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_RT Debian 
6.6.13-1~bpo12+1 (2024-02-15)
[    0.000000] Command line: 
BOOT_IMAGE=/boot/vmlinuz-6.6.13+bpo-rt-amd64 
root=UUID=b9338182-ab4b-48cb-b492-60e7ed340018 ro 
systemd.unified_cgroup_hierarchy=false quiet reboot=pci
...
[  110.420763] usb 1-2: new full-speed USB device number 2 using uhci_hcd
[  110.609798] usb 1-2: New USB device found, idVendor=10d7, 
idProduct=b012, bcdDevice=88.91
[  110.609814] usb 1-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[  110.609820] usb 1-2: Product: general adapter
[  110.609824] usb 1-2: Manufacturer: Actions
[  110.609829] usb 1-2: SerialNumber: ACTIONS1234
[  110.614223] Bluetooth: hci1: HCI Read Default Erroneous Data 
Reporting command is advertised, but not supported.
[  110.614245] Bluetooth: hci1: HCI Read Transmit Power Level command is 
advertised, but not supported.
[  110.614252] Bluetooth: hci1: HCI LE Set Random Private Address 
Timeout command is advertised, but not supported.
[  110.666673] Bluetooth: MGMT ver 1.22

lsusb -v
...
Bus 001 Device 002: ID 10d7:b012 Actions general adapter
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x10d7
   idProduct          0xb012
   bcdDevice           88.91
   iManufacturer           1 Actions
   iProduct                2 general adapter
   iSerial                 3 ACTIONS1234
   bNumConfigurations      1
...

btmon
...
< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 58 #48 
[hci0] 2.000505
         Filter policy: Accept list is not used (0x00)
         Own address type: Public (0x00)
         Peer address type: Random (0x01)
         Peer address: E8:42:26:5C:0F:07 (Static)
         Initiating PHYs: 0x07
         Entry 0: LE 1M
           Scan interval: 60.000 msec (0x0060)
           Scan window: 60.000 msec (0x0060)
           Min connection interval: 30.00 msec (0x0018)
           Max connection interval: 50.00 msec (0x0028)
           Connection latency: 0 (0x0000)
           Supervision timeout: 420 msec (0x002a)
           Min connection length: 0.000 msec (0x0000)
           Max connection length: 0.000 msec (0x0000)
         Entry 1: LE 2M
           Scan interval: 60.000 msec (0x0060)
           Scan window: 60.000 msec (0x0060)
           Min connection interval: 30.00 msec (0x0018)
           Max connection interval: 50.00 msec (0x0028)
           Connection latency: 0 (0x0000)
           Supervision timeout: 420 msec (0x002a)
           Min connection length: 0.000 msec (0x0000)
           Max connection length: 0.000 msec (0x0000)
         Entry 2: LE Coded
           Scan interval: 60.000 msec (0x0060)
           Scan window: 60.000 msec (0x0060)
           Min connection interval: 30.00 msec (0x0018)
           Max connection interval: 50.00 msec (0x0028)
           Connection latency: 0 (0x0000)
           Supervision timeout: 420 msec (0x002a)
           Min connection length: 0.000 msec (0x0000)
           Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4 #49 [hci0] 2.001242
       LE Extended Create Connection (0x08|0x0043) ncmd 1
         Status: Unknown HCI Command (0x01)
...
The adapter supports le, I was able to connect to a le device from 
windows 11.

