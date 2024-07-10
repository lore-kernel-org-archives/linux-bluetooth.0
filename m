Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5682C7E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643249; cv=none; b=BbcCrUA3n5eTl87MotLi5wRkeaJmeIUwkbLX6UGr2D0Q7Zgu+/GAVLY7p46gP0ToFLjTfqIFIk/8J+2C6YwMVU8Huewlg9f3gyFyRoTgAWr0vuPDr1yyhYOPDgfcIKWbkOAX86sqmguuJV8x+tvmOqguA3PCVa+rky/kYpEOH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643249; c=relaxed/simple;
	bh=4CPKnLv5YGeKV42vHmGmzaFvl7qLCE7lhfJsxy0sWpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=r2H1svVxnoohLeCfOM3xkPkSySJWu7LdYSTXYSlqLYOTuWMhRmJyaSsRvpPIedoOEk99sPuHhmNhBxhCnDkjhJn0cEOiwfgKgyxD9dbXqw3dU3xm2QZdBiCvXhRp3x4YMGHK0z3SGaYPB8nNOo33nlKtyxTgqNwVpX3YoYeMCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7Smvtg5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Smvtg5"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea16b429dso995144e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720643246; x=1721248046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lUsxMnu7tSnbBvVgV2fGBrAra0PztjJb9lEOIvE5Xc=;
        b=d7Smvtg5ujUe520Ahpg53sIirlmMDk8bB3dLWhW8K7yd2Fsw7ncxoVih7cHwHx9EOU
         iaXK0ngyvOigBwaX9NApGsEa0xYKvFEKEwUHTU113DY3UuX6TDAKY3OdGgEO4/0uwekb
         9qJ2lBoG9hNqFcmNRghEFlMMA6GHrDkHT63Dn8Ri2LXta5Wq+cCozW07JsUX9fCe2/G/
         Pgac0Y93qtjbIL+6jTSMUNEzmbqgVZkzwdOXit/0zZGkLvGVGeiHusWy9bJAAzyEVpWh
         fzlliJ6wGlgJdL9lDDEUqgWcrDpPnVFOej3JXti1McsJbeCaQt9JLNiEI37caUswPzON
         cjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643246; x=1721248046;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lUsxMnu7tSnbBvVgV2fGBrAra0PztjJb9lEOIvE5Xc=;
        b=H0LjESqIklWEg9ESl1irpBXdkg/QmkwpcpjDAUrDL4oJDum+HDMrk1HRJ/6m4kRX3K
         79tVrzEhnjnaAvamEMvYjdaSxKpcW2wnXhelWtCkKSAJDgXTGeGfYsawFt4m/3tUIbfR
         JziFPNvh95a9UQKJ53bhqVNljr0nByDjC4bQX9xDxsZYpKyHRYGienhw2hZWBUvvndnH
         82ns7rcAANQ9jiAwUvnD5cO1sqJOQiIlNGfNW2eTxSkn9xisqOxkQs815QqxlN94X3ry
         eNwQN9H0bD3ypHfrZ/PEeadrRQGytALILSctWerylyZVbtnDi+mHlyPKL3ETEiowG5tT
         GWlQ==
X-Gm-Message-State: AOJu0YwJHYXAib3mysfLag6ZSrbj+sJRzRIZ551tBWIpeHb2Aks5CvvG
	/Bc96wki1BUciIw1JlTxT/wLKTqbLciSJzNHrAFq4LgAHDdQ1uEVQrL18e1qNLyk25wd
X-Google-Smtp-Source: AGHT+IEdIRNPHtQO82VrqWDJl7KG/k7pw3Fl4/n57vCq7+G9jOA8lBp6JcuUfnX5mqzbzl2pw3LwrQ==
X-Received: by 2002:ac2:4c56:0:b0:52c:8978:af11 with SMTP id 2adb3069b0e04-52ec3d122d7mr218964e87.4.1720643245369;
        Wed, 10 Jul 2024 13:27:25 -0700 (PDT)
Received: from [192.168.82.219] ([188.162.5.3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e347bdsm766381e87.27.2024.07.10.13.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 13:27:24 -0700 (PDT)
Message-ID: <d622f591-f9ef-4ec7-a71b-a803c409caa7@gmail.com>
Date: Thu, 11 Jul 2024 03:27:22 +0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: abandoned patches for ATS2851
To: linux-bluetooth@vger.kernel.org
References: <b00b4f66-1aba-4182-bae2-01f37eb1c34b@gmail.com>
 <CACk7upyANXexe1e9Zbtajqpo+ujmzJGUpciEEy7kNANTnQUbcg@mail.gmail.com>
Content-Language: ru, en-GB
Cc: raul.cheleguini@gmail.com, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 marcel@holtmann.org
From: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
In-Reply-To: <CACk7upyANXexe1e9Zbtajqpo+ujmzJGUpciEEy7kNANTnQUbcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

I have applied all patches, now I can establish a connection, but after 
a while the following happens:

< HCI Command: LE Create Connect.. (0x08|0x000d) plen 25  #156 [hci0] 
13.247617
         Scan interval: 60.000 msec (0x0060)
         Scan window: 60.000 msec (0x0060)
         Filter policy: Accept list is not used (0x00)
         Peer address type: Random (0x01)
         Peer address: E8:42:26:5C:0F:07 (Static)
         Own address type: Public (0x00)
         Min connection interval: 30.00 msec (0x0018)
         Max connection interval: 50.00 msec (0x0028)
         Connection latency: 0 (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4                 #157 [hci0] 
13.249522
       LE Create Connection (0x08|0x000d) ncmd 1
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 19                 #158 [hci0] 
13.353869
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 1536
         Role: Central (0x00)
         Peer address type: Random (0x01)
         Peer address: E8:42:26:5C:0F:07 (Static)
         Connection interval: 52.50 msec (0x002a)
         Connection latency: 0 (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Central clock accuracy: 0x01
@ MGMT Event: Device Connected (0x000b) plen 40       {0x0001} [hci0] 
13.354007
         LE Address: E8:42:26:5C:0F:07 (Static)
         Flags: 0x00000008
           Connection Locally Initiated
         Data length: 27
         Name (complete): RFS-KKL002
         Flags: 0x06
           LE General Discoverable Mode
           BR/EDR Not Supported
         Company: Transenergooil AG (450)
           Data: 4000070f5c2642e8
...
...
< HCI Command: LE Create Connecti.. (0x08|0x000e) plen 0  #217 [hci0] 
17.268019
 > HCI Event: Command Status (0x0f) plen 4                 #218 [hci0] 
17.269377
       LE Create Connection Cancel (0x08|0x000e) ncmd 1
         Status: Command Disallowed (0x0c)


I'm trying to connect a smart kettle to the home assistant, after the 
connection is established, data is exchanged (several thousand log lines).

After receiving Command Disallowed, the exchange continues, control of 
the kettle remains available.

Is this a critical issue? Can it be fixed? Does it need to be fixed?

In any case, I believe that an adapter that works at least somewhat is 
better than one that doesn't work at all, and probably patches should be 
merged.

22.05.2024 3:55, Raul Cheleguini пишет:
> On Mon, May 13, 2024 at 2:14 PM Данил <danstiv404@gmail.com> wrote:
>> Hello!
>> I encountered a problem with a USB bluetooth adapter which probably uses
>> an ATS2851.
>> I'm not 100% sure about this, but the symptoms match the problem
>> described in the patch.
>>
>> Here are the patches I found.
>> 1. It seems to have been applied.
>> https://lore.kernel.org/linux-bluetooth/168150781825.20001.4973139468540739153.git-patchwork-notify@kernel.org/T/#t
>>
>> 2. It seems it was not applied.
>> https://lore.kernel.org/linux-bluetooth/20230323135804.3962783-1-raul.cheleguini@gmail.com/T/#t
>>
>> 3. It seems it was not applied.
>> https://patchwork.kernel.org/project/bluetooth/patch/20230426184017.2051211-1-raul.cheleguini@gmail.com/#25314789
>>
>> Patches 2 and 3 were not applied, as I understand, due to some minor
>> problems with code formatting, is it possible to complete the process of
>> applying them?
>>
>> Here is some information about the device:
>>
>> dmesg
>> [    0.000000] Linux version 6.6.13+bpo-rt-amd64
>> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU
>> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_RT Debian
>> 6.6.13-1~bpo12+1 (2024-02-15)
>> [    0.000000] Command line:
>> BOOT_IMAGE=/boot/vmlinuz-6.6.13+bpo-rt-amd64
>> root=UUID=b9338182-ab4b-48cb-b492-60e7ed340018 ro
>> systemd.unified_cgroup_hierarchy=false quiet reboot=pci
>> ...
>> [  110.420763] usb 1-2: new full-speed USB device number 2 using uhci_hcd
>> [  110.609798] usb 1-2: New USB device found, idVendor=10d7,
>> idProduct=b012, bcdDevice=88.91
>> [  110.609814] usb 1-2: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=3
>> [  110.609820] usb 1-2: Product: general adapter
>> [  110.609824] usb 1-2: Manufacturer: Actions
>> [  110.609829] usb 1-2: SerialNumber: ACTIONS1234
>> [  110.614223] Bluetooth: hci1: HCI Read Default Erroneous Data
>> Reporting command is advertised, but not supported.
>> [  110.614245] Bluetooth: hci1: HCI Read Transmit Power Level command is
>> advertised, but not supported.
>> [  110.614252] Bluetooth: hci1: HCI LE Set Random Private Address
>> Timeout command is advertised, but not supported.
>> [  110.666673] Bluetooth: MGMT ver 1.22
>>
>> lsusb -v
>> ...
>> Bus 001 Device 002: ID 10d7:b012 Actions general adapter
>> Device Descriptor:
>>     bLength                18
>>     bDescriptorType         1
>>     bcdUSB               2.00
>>     bDeviceClass          224 Wireless
>>     bDeviceSubClass         1 Radio Frequency
>>     bDeviceProtocol         1 Bluetooth
>>     bMaxPacketSize0        64
>>     idVendor           0x10d7
>>     idProduct          0xb012
>>     bcdDevice           88.91
>>     iManufacturer           1 Actions
>>     iProduct                2 general adapter
>>     iSerial                 3 ACTIONS1234
>>     bNumConfigurations      1
>> ...
>>
>> btmon
>> ...
>> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 58 #48
>> [hci0] 2.000505
>>           Filter policy: Accept list is not used (0x00)
>>           Own address type: Public (0x00)
>>           Peer address type: Random (0x01)
>>           Peer address: E8:42:26:5C:0F:07 (Static)
>>           Initiating PHYs: 0x07
>>           Entry 0: LE 1M
>>             Scan interval: 60.000 msec (0x0060)
>>             Scan window: 60.000 msec (0x0060)
>>             Min connection interval: 30.00 msec (0x0018)
>>             Max connection interval: 50.00 msec (0x0028)
>>             Connection latency: 0 (0x0000)
>>             Supervision timeout: 420 msec (0x002a)
>>             Min connection length: 0.000 msec (0x0000)
>>             Max connection length: 0.000 msec (0x0000)
>>           Entry 1: LE 2M
>>             Scan interval: 60.000 msec (0x0060)
>>             Scan window: 60.000 msec (0x0060)
>>             Min connection interval: 30.00 msec (0x0018)
>>             Max connection interval: 50.00 msec (0x0028)
>>             Connection latency: 0 (0x0000)
>>             Supervision timeout: 420 msec (0x002a)
>>             Min connection length: 0.000 msec (0x0000)
>>             Max connection length: 0.000 msec (0x0000)
>>           Entry 2: LE Coded
>>             Scan interval: 60.000 msec (0x0060)
>>             Scan window: 60.000 msec (0x0060)
>>             Min connection interval: 30.00 msec (0x0018)
>>             Max connection interval: 50.00 msec (0x0028)
>>             Connection latency: 0 (0x0000)
>>             Supervision timeout: 420 msec (0x002a)
>>             Min connection length: 0.000 msec (0x0000)
>>             Max connection length: 0.000 msec (0x0000)
>>   > HCI Event: Command Status (0x0f) plen 4 #49 [hci0] 2.001242
>>         LE Extended Create Connection (0x08|0x0043) ncmd 1
>>           Status: Unknown HCI Command (0x01)
>> ...
>> The adapter supports le, I was able to connect to a le device from
>> windows 11.
>>
> Hello,
>
> To provide some context on the patches.
>
> With all patches applied locally I managed to pair my Logitech mouse and use it,
> but the solution I don't feel is ideal, there were errors and other devices
> might not pair well.
>
> At the time I asked the datasheet for this adapter to multiple vendors, without
> success. I extensively researched forums, pdf repositories, and I did not find
> relevant documentation.
>
> One thing that I noticed watching the HCI dumps of a pairing process in Windows
> and Linux is that, in Linux the dump is chaotic and parallel. In other hand, the
> dump in Windows is organized and more serialized. I don't know if I missed
> something related to this at that time.
>
> Anyways, my debug setup for this is disassembled right now, if anyone is willing
> to resume and progress this issue is more than welcomed.
