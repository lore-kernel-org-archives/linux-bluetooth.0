Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB4C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972A12065E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 18:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc5LAIv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKNSvn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Nov 2020 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgKNSvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Nov 2020 13:51:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A3C0613D1;
        Sat, 14 Nov 2020 10:51:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r17so14023698wrw.1;
        Sat, 14 Nov 2020 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2lGDcZqHUYroY/J2DNpQLd0qjoXiPgBSpZPrYWi33gQ=;
        b=vc5LAIv0bjDQEEG/3ZmZmEBcbLTW9sNcY9MrkuMRCkt6iQ9zVvddgolWqo8XNthZCi
         1jn3TBcXd2AypC9V+sFBUJ91O3jVNq+XtUy2akaZtlKEUKFF2PwqYvQ+XzIT2CHwMjPB
         HueOa5VWby1o/OIBYL0oVcF7nZmj8ytlecp9L9NBbhlgCDXvzSMPMIx2TLayXBJt2VpI
         ifUEuuzILS5iRxY3ASUOXaUIuEerIvkv9qQS21vgkR9mGLFrp5aUodC+B+PKMiCnsnwT
         96FRIBzKaLzraP9quq4rMj7DISl6eIc4hRvWjwFkLwwpJPQjKdMDRQbewHZcE8gKiNf0
         2TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2lGDcZqHUYroY/J2DNpQLd0qjoXiPgBSpZPrYWi33gQ=;
        b=rWYUJCEmhzUme4z9NcbnjhvcsnLYaFuNMJSaoc3WdTt5v+OwM8+1L/9ZkrhTpTSX9O
         tteUO8blWLR5y/iPAJKG68YC7k/Qd4j/LH8EFVDhIAP7dc5z23vipw6D4CwHf5bVU+d6
         xf/lir66MAh+8zbkdrfu4e8ZpYZgNenPWF8aeiYAEh4mCsEGbPZK5TP4Gkc9Iv2ozFUL
         NXNkaKYNvz1cksYSh2M6U7JIYi5x/mRxnCcIcKL4xGeURvR9C8OGG1MUkAPSd7b3M3Vu
         jLa54NK6SMtQGdH5g1kebYIm9xW0NsuDA/+AZxLBcIGbDxzkqqKsg2bvXZXrw28i4FZ/
         oXBA==
X-Gm-Message-State: AOAM532OnEkuSoIpFHwybdzv8B8HDOnqJfYMDza0J3UHWf8580koR8J5
        OKp52GzOnWFo6PAc5JCQytlHKGZ9fEpjIw==
X-Google-Smtp-Source: ABdhPJzm6ZuI+FweAsSaI2RMdwa30wrxMg2cvStUNUxTDfdynoHXgU6MNkthj4KwNfYvPc5V2jbwTw==
X-Received: by 2002:adf:e351:: with SMTP id n17mr10986509wrj.308.1605379894911;
        Sat, 14 Nov 2020 10:51:34 -0800 (PST)
Received: from [192.168.0.66] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id m20sm19644836wrg.81.2020.11.14.10.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 10:51:33 -0800 (PST)
Subject: Re: BCM20702A0 bluetooth dongle not working
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
References: <20201113174558.so7gzmwesorqo6ad@medion>
Message-ID: <052a9343-a730-b2bc-3a83-9fa2f56997b2@gmail.com>
Date:   Sat, 14 Nov 2020 18:50:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113174558.so7gzmwesorqo6ad@medion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update for anyone interested: it seems like it does work ok, but only 
for BLE devices. The names of other devices didn't come up (only the MAC 
addresses) and when I try to connect (e.g. to my phone phone) it fails.

If anyone could help me figure out what's going awry in the btusb driver 
here that'd be great.

Best,
Alex

On 13/11/2020 17:45, Alex Dewar wrote:
> Hi all!
>
> I've just got a Broadcom BCM20702A0 USB Bluetooth dongle but it seems
> not to be working :-(. Whenever I search for devices only their MAC
> addresses appear (not their names) and I can't seem to pair with them.
>
> Logs are below. Any help would be massively appreciated :-)
> 	Alex
>
> Here's the output from bluetoothctl:
> Agent registered
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller 21:49:86:00:DF:07 Discovering: yes
> [NEW] Device 54:21:37:1D:E4:DF 54-21-37-1D-E4-DF
> [NEW] Device 02:2A:33:D5:7E:8A 02-2A-33-D5-7E-8A
> [NEW] Device 5B:86:F7:54:B1:32 5B-86-F7-54-B1-32
> [NEW] Device 69:DC:0F:D0:1F:A2 69-DC-0F-D0-1F-A2
> [NEW] Device 55:6F:E0:7F:20:8E 55-6F-E0-7F-20-8E
> [NEW] Device 80:E6:50:15:35:4B 80-E6-50-15-35-4B
> [NEW] Device F4:5C:89:CD:85:4C F4-5C-89-CD-85-4C
> [NEW] Device 43:A8:29:63:ED:E4 43-A8-29-63-ED-E4
> [NEW] Device 4C:87:5D:8A:57:81 LE-wowowo
> [NEW] Device 5A:66:15:FB:19:8B 5A-66-15-FB-19-8B
> [NEW] Device 6D:41:3D:DA:FD:1E 6D-41-3D-DA-FD-1E
> [NEW] Device 49:66:93:39:7A:2F 49-66-93-39-7A-2F
> [CHG] Device 69:DC:0F:D0:1F:A2 ManufacturerData Key: 0x004c
> [CHG] Device 69:DC:0F:D0:1F:A2 ManufacturerData Value:
>    0c 0e 00 43 40 fd f6 6d f8 b3 1d 20 34 fa 85 30  ...C@..m... 4..0
> [CHG] Device 4C:87:5D:8A:57:81 TxPower: 8
> [CHG] Device 80:E6:50:15:35:4B ManufacturerData Key: 0x004c
> [CHG] Device 80:E6:50:15:35:4B ManufacturerData Value:
>    10 05 4b 1c a0 20 21                             ..K.. !
> [NEW] Device 4C:87:5D:86:F7:59 LE-reserved_x
> [CHG] Device 43:A8:29:63:ED:E4 RSSI: -85
> [CHG] Device 55:6F:E0:7F:20:8E ManufacturerData Key: 0x004c
> [CHG] Device 55:6F:E0:7F:20:8E ManufacturerData Value:
>    0c 0e 00 68 a0 c5 c6 42 c5 5d 9c 20 bd d1 8a 82  ...h...B.]. ....
>    10 05 5b 1c 01 62 3d                             ..[..b=
> [DEL] Device 49:66:93:39:7A:2F 49-66-93-39-7A-2F
> [CHG] Device 69:DC:0F:D0:1F:A2 ManufacturerData Key: 0x004c
> [CHG] Device 69:DC:0F:D0:1F:A2 ManufacturerData Value:
>    0c 0e 00 45 40 46 21 c9 48 93 98 ef dc 2a 58 0f  ...E@F!.H....*X.
> [NEW] Device 58:EC:6B:08:6F:CC 58-EC-6B-08-6F-CC
> [DEL] Device 4C:87:5D:86:F7:59 LE-reserved_x
> [NEW] Device 4C:87:5D:86:F7:59 LE-reserved_x
> [NEW] Device B8:78:2E:37:31:BB B8-78-2E-37-31-BB
> [NEW] Device 57:F8:5F:03:2C:B0 57-F8-5F-03-2C-B0
> [DEL] Device 02:2A:33:D5:7E:8A 02-2A-33-D5-7E-8A
> [DEL] Device 55:6F:E0:7F:20:8E 55-6F-E0-7F-20-8E
> [CHG] Device 58:EC:6B:08:6F:CC RSSI: -95
> [CHG] Device 43:A8:29:63:ED:E4 ManufacturerData Key: 0x004c
> [CHG] Device 43:A8:29:63:ED:E4 ManufacturerData Value:
>    10 06 6d 1e db 79 d9 cd                          ..m..y..
> [CHG] Device 4C:87:5D:86:F7:59 TxPower: 8
> [CHG] Device 58:EC:6B:08:6F:CC RSSI: -85
> [CHG] Device 80:E6:50:15:35:4B ManufacturerData Key: 0x004c
> [CHG] Device 80:E6:50:15:35:4B ManufacturerData Value:
>    10 05 47 1c a0 20 21                             ..G.. !
> [DEL] Device B8:78:2E:37:31:BB B8-78-2E-37-31-BB
> [DEL] Device 57:F8:5F:03:2C:B0 57-F8-5F-03-2C-B0
> [bluetooth]#
> [bluetooth]# quit
>
> And here's my dmesg:
> [    0.000000] Linux version 5.9.8-arch1-1 (linux@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Tue, 10 Nov 2020 22:44:11 +0000
> [    0.000000] Command line: initrd=\amd-ucode.img initrd=\initramfs-linux.img root=UUID=6327d610-a19c-4e9e-a93e-6a08667200db rw resume=UUID=763b483b-e65a-4fea-ad7b-1c55cab29a45 mitigations=off nowatchdog amdgpu.dc=0
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d7ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009d80000-0x0000000009ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20bfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000000a20c000-0x000000000affffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000dbd61fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dbd62000-0x00000000dbeabfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000dbeac000-0x00000000dc02cfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dc02d000-0x00000000dc43efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000dc43f000-0x00000000dd048fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000dd049000-0x00000000deffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f37ffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0xd860e018-0xd861c057] usable ==> usable
> [    0.000000] e820: update [mem 0xd860e018-0xd861c057] usable ==> usable
> [    0.000000] e820: update [mem 0xd85f0018-0xd860d057] usable ==> usable
> [    0.000000] e820: update [mem 0xd85f0018-0xd860d057] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009d7ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009d80000-0x0000000009ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20bfff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000000a20c000-0x000000000affffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b01ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000b020000-0x00000000d85f0017] usable
> [    0.000000] reserve setup_data: [mem 0x00000000d85f0018-0x00000000d860d057] usable
> [    0.000000] reserve setup_data: [mem 0x00000000d860d058-0x00000000d860e017] usable
> [    0.000000] reserve setup_data: [mem 0x00000000d860e018-0x00000000d861c057] usable
> [    0.000000] reserve setup_data: [mem 0x00000000d861c058-0x00000000dbd61fff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000dbd62000-0x00000000dbeabfff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000dbeac000-0x00000000dc02cfff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000dc02d000-0x00000000dc43efff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000dc43f000-0x00000000dd048fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000dd049000-0x00000000deffffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000df000000-0x00000000dfffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000041f37ffff] usable
> [    0.000000] efi: EFI v2.70 by American Megatrends
> [    0.000000] efi: ACPI 2.0=0xdc3bc000 ACPI=0xdc3bc000 SMBIOS=0xdce94000 MEMATTR=0xd863e018 ESRT=0xd87c3f98 RNG=0xdceaed98
> [    0.000000] efi: seeding entropy pool
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7C51/A320M-A PRO (MS-7C51), BIOS 1.30 11/08/2019
> [    0.000000] tsc: Fast TSC calibration failed
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] last_pfn = 0x41f380 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF write-through
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
> [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
> [    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
> [    0.000000]   3 base 0000DC7B0000 mask FFFFFFFF0000 uncachable
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] TOM2: 0000000420000000 aka 16896M
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000000] total RAM covered: 3583M
> [    0.000000] Found optimal setting for mtrr clean up
> [    0.000000]  gran_size: 64K 	chunk_size: 64M 	num_reg: 4  	lose cover RAM: 0G
> [    0.000000] e820: update [mem 0xdc7b0000-0xdc7bffff] usable ==> reserved
> [    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
> [    0.000000] last_pfn = 0xdf000 max_arch_pfn = 0x400000000
> [    0.000000] esrt: Reserving ESRT space from 0x00000000d87c3f98 to 0x00000000d87c3fd0.
> [    0.000000] e820: update [mem 0xd87c3000-0xd87c3fff] usable ==> reserved
> [    0.000000] check: Scanning 1 areas for low memory corruption
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] Secure boot disabled
> [    0.000000] RAMDISK: [mem 0x7f87d000-0x7fff5fff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000DC3BC000 000024 (v02 ALASKA)
> [    0.000000] ACPI: XSDT 0x00000000DC3BC0A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FACP 0x00000000DC3C3BB8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: DSDT 0x00000000DC3BC1F0 0079C4 (v02 ALASKA A M I    01072009 INTL 20120913)
> [    0.000000] ACPI: FACS 0x00000000DC428E00 000040
> [    0.000000] ACPI: APIC 0x00000000DC3C3CD0 00015E (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FPDT 0x00000000DC3C3E30 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FIDT 0x00000000DC3C3E78 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: SSDT 0x00000000DC3C3F18 0000C8 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
> [    0.000000] ACPI: SSDT 0x00000000DC3C3FE0 008C98 (v02 AMD    AMD ALIB 00000002 MSFT 04000000)
> [    0.000000] ACPI: SSDT 0x00000000DC3CCC78 00366B (v01 AMD    AMD AOD  00000001 INTL 20120913)
> [    0.000000] ACPI: MCFG 0x00000000DC3D02E8 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
> [    0.000000] ACPI: HPET 0x00000000DC3D0328 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
> [    0.000000] ACPI: UEFI 0x00000000DC3D0360 000042 (v01 ALASKA A M I    00000002      01000013)
> [    0.000000] ACPI: IVRS 0x00000000DC3D03A8 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
> [    0.000000] ACPI: PCCT 0x00000000DC3D0478 00006E (v01 AMD    AMD PCCT 00000001 AMD  00000000)
> [    0.000000] ACPI: SSDT 0x00000000DC3D04E8 002F29 (v01 AMD    AMD CPU  00000001 AMD  00000001)
> [    0.000000] ACPI: CRAT 0x00000000DC3D3418 000B58 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
> [    0.000000] ACPI: CDIT 0x00000000DC3D3F70 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
> [    0.000000] ACPI: BGRT 0x00000000DC3D3FA0 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: SSDT 0x00000000DC3D3FD8 001D4A (v01 AMD    AmdTable 00000001 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000DC3D5D28 0000BF (v01 AMD    AMD PT   00001000 INTL 20120913)
> [    0.000000] ACPI: WSMT 0x00000000DC3D5DE8 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000041f37ffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x41f37c000-0x41f37ffff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000041f37ffff]
> [    0.000000]   Device   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009d7ffff]
> [    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
> [    0.000000]   node   0: [mem 0x000000000a20c000-0x000000000affffff]
> [    0.000000]   node   0: [mem 0x000000000b020000-0x00000000dbd61fff]
> [    0.000000]   node   0: [mem 0x00000000dbeac000-0x00000000dc02cfff]
> [    0.000000]   node   0: [mem 0x00000000dd049000-0x00000000deffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000041f37ffff]
> [    0.000000] Zeroed struct page in unavailable ranges: 12531 pages
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000041f37ffff]
> [    0.000000] On node 0 totalpages: 4181773
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 29 pages reserved
> [    0.000000]   DMA zone: 3999 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 14128 pages used for memmap
> [    0.000000]   DMA32 zone: 904174 pages, LIFO batch:63
> [    0.000000]   Normal zone: 51150 pages used for memmap
> [    0.000000]   Normal zone: 3273600 pages, LIFO batch:63
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
> [    0.000000] e820: update [mem 0xd8577000-0xd85d3fff] usable ==> reserved
> [    0.000000] smpboot: Allowing 32 CPUs, 20 hotplug CPUs
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0x09d80000-0x09ffffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20bfff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd8577000-0xd85d3fff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd85f0000-0xd85f0fff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd860d000-0xd860dfff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd860e000-0xd860efff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd861c000-0xd861cfff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd87c3000-0xd87c3fff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xdbd62000-0xdbeabfff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xdc02d000-0xdc43efff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xdc43f000-0xdd048fff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xdf000000-0xdfffffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfcffffff]
> [    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xffffffff]
> [    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> [    0.000000] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:32 nr_node_ids:1
> [    0.000000] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.000000] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
> [    0.000000] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4116402
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: initrd=\amd-ucode.img initrd=\initramfs-linux.img root=UUID=6327d610-a19c-4e9e-a93e-6a08667200db rw resume=UUID=763b483b-e65a-4fea-ad7b-1c55cab29a45 mitigations=off nowatchdog amdgpu.dc=0
> [    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] printk: log_buf_len total cpu_extra contributions: 126976 bytes
> [    0.000000] printk: log_buf_len min size: 131072 bytes
> [    0.000000] printk: log_buf_len: 262144 bytes
> [    0.000000] printk: early log buf free: 116264(88%)
> [    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.000000] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
> [    0.000000] Memory: 16234444K/16727092K available (14339K kernel code, 1505K rwdata, 7948K rodata, 1660K init, 2944K bss, 492388K reserved, 0K cma-reserved)
> [    0.000000] random: get_random_u64 called from __kmem_cache_create+0x26/0x520 with crng_init=0
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
> [    0.000000] ftrace: allocating 40882 entries in 160 pages
> [    0.000000] ftrace: allocated 160 pages with 2 groups
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=32.
> [    0.000000] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
> [    0.000000] 	Rude variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
> [    0.000000] NR_IRQS: 20736, nr_irqs: 1224, preallocated irqs: 16
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] printk: console [tty0] enabled
> [    0.000000] ACPI: Core revision 20200717
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.000000] APIC: Switch to symmetric I/O mode setup
> [    0.003333] Switched APIC routing to physical flat.
> [    0.006666] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.026666] tsc: PIT calibration matches HPET. 1 loops
> [    0.026666] tsc: Detected 3800.123 MHz processor
> [    0.000002] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d8d985b725, max_idle_ns: 881590622553 ns
> [    0.000004] Calibrating delay loop (skipped), value calculated using timer frequency.. 7603.92 BogoMIPS (lpj=12667076)
> [    0.000005] pid_max: default: 32768 minimum: 301
> [    0.002605] LSM: Security Framework initializing
> [    0.002607] Yama: becoming mindful.
> [    0.002643] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.002666] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.002833] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.002880] LVT offset 1 assigned for vector 0xf9
> [    0.003012] LVT offset 2 assigned for vector 0xf4
> [    0.003048] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.003048] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
> [    0.003051] Speculative Store Bypass: Vulnerable
> [    0.003221] Freeing SMP alternatives memory: 32K
> [    0.115373] smpboot: CPU0: AMD Ryzen 5 3600XT 6-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
> [    0.115428] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.115430] ... version:                0
> [    0.115430] ... bit width:              48
> [    0.115430] ... generic registers:      6
> [    0.115431] ... value mask:             0000ffffffffffff
> [    0.115431] ... max period:             00007fffffffffff
> [    0.115431] ... fixed-purpose events:   0
> [    0.115431] ... event mask:             000000000000003f
> [    0.115455] rcu: Hierarchical SRCU implementation.
> [    0.115721] smp: Bringing up secondary CPUs ...
> [    0.115786] x86: Booting SMP configuration:
> [    0.115787] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> [    0.138890] smp: Brought up 1 node, 12 CPUs
> [    0.138890] smpboot: Max logical packages: 3
> [    0.138890] smpboot: Total of 12 processors activated (91239.07 BogoMIPS)
> [    0.140047] devtmpfs: initialized
> [    0.140053] x86/mm: Memory block size: 128MB
> [    0.140684] PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20bfff] (49152 bytes)
> [    0.140684] PM: Registering ACPI NVS region [mem 0xdc02d000-0xdc43efff] (4268032 bytes)
> [    0.140684] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> [    0.140684] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.140684] pinctrl core: initialized pinctrl subsystem
> [    0.140684] PM: RTC time: 16:30:44, date: 2020-11-13
> [    0.140684] NET: Registered protocol family 16
> [    0.140684] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.140684] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.140684] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.140684] audit: initializing netlink subsys (disabled)
> [    0.140684] audit: type=2000 audit(1605285043.166:1): state=initialized audit_enabled=0 res=1
> [    0.140684] thermal_sys: Registered thermal governor 'fair_share'
> [    0.140684] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.140684] thermal_sys: Registered thermal governor 'step_wise'
> [    0.140684] thermal_sys: Registered thermal governor 'user_space'
> [    0.140684] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.140684] cpuidle: using governor ladder
> [    0.140684] cpuidle: using governor menu
> [    0.140684] Detected 1 PCC Subspaces
> [    0.140684] Registering PCC driver as Mailbox controller
> [    0.140684] ACPI: bus type PCI registered
> [    0.140684] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.140684] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.140684] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> [    0.140684] PCI: Using configuration type 1 for base access
> [    0.140999] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.140999] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.143426] ACPI: Added _OSI(Module Device)
> [    0.143426] ACPI: Added _OSI(Processor Device)
> [    0.143427] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.143427] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.143428] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.143428] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.143429] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.150973] ACPI: 7 ACPI AML tables successfully acquired and loaded
> [    0.151477] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.153827] ACPI: Interpreter enabled
> [    0.153838] ACPI: (supports S0 S3 S4 S5)
> [    0.153839] ACPI: Using IOAPIC for interrupt routing
> [    0.154086] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.154312] ACPI: Enabled 2 GPEs in block 00 to 1F
> [    0.160388] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.160392] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.160520] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug PME LTR DPC]
> [    0.160641] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug AER PCIeCapability]
> [    0.160649] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.160914] PCI host bridge to bus 0000:00
> [    0.160915] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [    0.160916] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [    0.160916] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
> [    0.160917] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.160917] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.160918] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> [    0.160918] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
> [    0.160919] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
> [    0.160919] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.160930] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
> [    0.161023] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
> [    0.161119] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
> [    0.161196] pci 0000:00:01.3: [1022:1483] type 01 class 0x060400
> [    0.161225] pci 0000:00:01.3: enabling Extended Tags
> [    0.161273] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
> [    0.161394] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
> [    0.161467] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
> [    0.161539] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
> [    0.161603] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
> [    0.161716] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
> [    0.161791] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
> [    0.161864] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
> [    0.161934] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
> [    0.161958] pci 0000:00:07.1: enabling Extended Tags
> [    0.161995] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> [    0.162089] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
> [    0.162161] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
> [    0.162185] pci 0000:00:08.1: enabling Extended Tags
> [    0.162225] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    0.162322] pci 0000:00:08.2: [1022:1484] type 01 class 0x060400
> [    0.162347] pci 0000:00:08.2: enabling Extended Tags
> [    0.162387] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
> [    0.162485] pci 0000:00:08.3: [1022:1484] type 01 class 0x060400
> [    0.162509] pci 0000:00:08.3: enabling Extended Tags
> [    0.162549] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
> [    0.162656] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [    0.162781] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [    0.162902] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
> [    0.162947] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
> [    0.162991] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
> [    0.163035] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
> [    0.163080] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
> [    0.163124] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
> [    0.163169] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
> [    0.163216] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
> [    0.163324] pci 0000:03:00.0: [1022:43bc] type 00 class 0x0c0330
> [    0.163345] pci 0000:03:00.0: reg 0x10: [mem 0xfcca0000-0xfcca7fff 64bit]
> [    0.163389] pci 0000:03:00.0: enabling Extended Tags
> [    0.163445] pci 0000:03:00.0: PME# supported from D3hot D3cold
> [    0.163538] pci 0000:03:00.1: [1022:43b8] type 00 class 0x010601
> [    0.163590] pci 0000:03:00.1: reg 0x24: [mem 0xfcc80000-0xfcc9ffff]
> [    0.163598] pci 0000:03:00.1: reg 0x30: [mem 0xfcc00000-0xfcc7ffff pref]
> [    0.163604] pci 0000:03:00.1: enabling Extended Tags
> [    0.163648] pci 0000:03:00.1: PME# supported from D3hot D3cold
> [    0.163713] pci 0000:03:00.2: [1022:43b3] type 01 class 0x060400
> [    0.163761] pci 0000:03:00.2: enabling Extended Tags
> [    0.163810] pci 0000:03:00.2: PME# supported from D3hot D3cold
> [    0.163913] pci 0000:00:01.3: PCI bridge to [bus 03-28]
> [    0.163916] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
> [    0.163918] pci 0000:00:01.3:   bridge window [mem 0xfcb00000-0xfccfffff]
> [    0.164017] pci 0000:20:04.0: [1022:43b4] type 01 class 0x060400
> [    0.164068] pci 0000:20:04.0: enabling Extended Tags
> [    0.164129] pci 0000:20:04.0: PME# supported from D3hot D3cold
> [    0.164227] pci 0000:20:05.0: [1022:43b4] type 01 class 0x060400
> [    0.164278] pci 0000:20:05.0: enabling Extended Tags
> [    0.164339] pci 0000:20:05.0: PME# supported from D3hot D3cold
> [    0.164431] pci 0000:20:06.0: [1022:43b4] type 01 class 0x060400
> [    0.164482] pci 0000:20:06.0: enabling Extended Tags
> [    0.164543] pci 0000:20:06.0: PME# supported from D3hot D3cold
> [    0.164636] pci 0000:20:07.0: [1022:43b4] type 01 class 0x060400
> [    0.164687] pci 0000:20:07.0: enabling Extended Tags
> [    0.164749] pci 0000:20:07.0: PME# supported from D3hot D3cold
> [    0.164852] pci 0000:03:00.2: PCI bridge to [bus 20-28]
> [    0.164857] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
> [    0.164860] pci 0000:03:00.2:   bridge window [mem 0xfcb00000-0xfcbfffff]
> [    0.164941] pci 0000:25:00.0: [10ec:8168] type 00 class 0x020000
> [    0.164969] pci 0000:25:00.0: reg 0x10: [io  0xf000-0xf0ff]
> [    0.165008] pci 0000:25:00.0: reg 0x18: [mem 0xfcb04000-0xfcb04fff 64bit]
> [    0.165032] pci 0000:25:00.0: reg 0x20: [mem 0xfcb00000-0xfcb03fff 64bit]
> [    0.165184] pci 0000:25:00.0: supports D1 D2
> [    0.165184] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.165393] pci 0000:20:04.0: PCI bridge to [bus 25]
> [    0.165398] pci 0000:20:04.0:   bridge window [io  0xf000-0xffff]
> [    0.165400] pci 0000:20:04.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
> [    0.165439] pci 0000:20:05.0: PCI bridge to [bus 26]
> [    0.165483] pci 0000:20:06.0: PCI bridge to [bus 27]
> [    0.165527] pci 0000:20:07.0: PCI bridge to [bus 28]
> [    0.165612] pci 0000:29:00.0: [1002:67df] type 00 class 0x030000
> [    0.165627] pci 0000:29:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
> [    0.165637] pci 0000:29:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
> [    0.165643] pci 0000:29:00.0: reg 0x20: [io  0xe000-0xe0ff]
> [    0.165650] pci 0000:29:00.0: reg 0x24: [mem 0xfcf00000-0xfcf3ffff]
> [    0.165656] pci 0000:29:00.0: reg 0x30: [mem 0xfcf40000-0xfcf5ffff pref]
> [    0.165669] pci 0000:29:00.0: BAR 0: assigned to efifb
> [    0.165728] pci 0000:29:00.0: supports D1 D2
> [    0.165729] pci 0000:29:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.165825] pci 0000:29:00.1: [1002:aaf0] type 00 class 0x040300
> [    0.165840] pci 0000:29:00.1: reg 0x10: [mem 0xfcf60000-0xfcf63fff 64bit]
> [    0.165920] pci 0000:29:00.1: supports D1 D2
> [    0.166010] pci 0000:00:03.1: PCI bridge to [bus 29]
> [    0.166013] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
> [    0.166015] pci 0000:00:03.1:   bridge window [mem 0xfcf00000-0xfcffffff]
> [    0.166018] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.166056] pci 0000:2a:00.0: [1022:148a] type 00 class 0x130000
> [    0.166084] pci 0000:2a:00.0: enabling Extended Tags
> [    0.166192] pci 0000:00:07.1: PCI bridge to [bus 2a]
> [    0.166247] pci 0000:2b:00.0: [1022:1485] type 00 class 0x130000
> [    0.166279] pci 0000:2b:00.0: enabling Extended Tags
> [    0.166387] pci 0000:2b:00.1: [1022:1486] type 00 class 0x108000
> [    0.166402] pci 0000:2b:00.1: reg 0x18: [mem 0xfc900000-0xfc9fffff]
> [    0.166414] pci 0000:2b:00.1: reg 0x24: [mem 0xfca08000-0xfca09fff]
> [    0.166422] pci 0000:2b:00.1: enabling Extended Tags
> [    0.166519] pci 0000:2b:00.3: [1022:149c] type 00 class 0x0c0330
> [    0.166532] pci 0000:2b:00.3: reg 0x10: [mem 0xfc800000-0xfc8fffff 64bit]
> [    0.166561] pci 0000:2b:00.3: enabling Extended Tags
> [    0.166605] pci 0000:2b:00.3: PME# supported from D0 D3hot D3cold
> [    0.166675] pci 0000:2b:00.4: [1022:1487] type 00 class 0x040300
> [    0.166684] pci 0000:2b:00.4: reg 0x10: [mem 0xfca00000-0xfca07fff]
> [    0.166709] pci 0000:2b:00.4: enabling Extended Tags
> [    0.166752] pci 0000:2b:00.4: PME# supported from D0 D3hot D3cold
> [    0.166845] pci 0000:00:08.1: PCI bridge to [bus 2b]
> [    0.166848] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
> [    0.166895] pci 0000:30:00.0: [1022:7901] type 00 class 0x010601
> [    0.166929] pci 0000:30:00.0: reg 0x24: [mem 0xfce00000-0xfce007ff]
> [    0.166938] pci 0000:30:00.0: enabling Extended Tags
> [    0.166991] pci 0000:30:00.0: PME# supported from D3hot D3cold
> [    0.167081] pci 0000:00:08.2: PCI bridge to [bus 30]
> [    0.167085] pci 0000:00:08.2:   bridge window [mem 0xfce00000-0xfcefffff]
> [    0.167131] pci 0000:31:00.0: [1022:7901] type 00 class 0x010601
> [    0.167165] pci 0000:31:00.0: reg 0x24: [mem 0xfcd00000-0xfcd007ff]
> [    0.167174] pci 0000:31:00.0: enabling Extended Tags
> [    0.167227] pci 0000:31:00.0: PME# supported from D3hot D3cold
> [    0.167318] pci 0000:00:08.3: PCI bridge to [bus 31]
> [    0.167322] pci 0000:00:08.3:   bridge window [mem 0xfcd00000-0xfcdfffff]
> [    0.167613] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167653] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167688] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167733] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167776] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167809] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167841] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
> [    0.167873] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
> [    0.170006] iommu: Default domain type: Translated
> [    0.170017] pci 0000:29:00.0: vgaarb: setting as boot VGA device
> [    0.170017] pci 0000:29:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.170017] pci 0000:29:00.0: vgaarb: bridge control possible
> [    0.170017] vgaarb: loaded
> [    0.170116] SCSI subsystem initialized
> [    0.170129] libata version 3.00 loaded.
> [    0.170129] ACPI: bus type USB registered
> [    0.170129] usbcore: registered new interface driver usbfs
> [    0.170129] usbcore: registered new interface driver hub
> [    0.170129] usbcore: registered new device driver usb
> [    0.170129] pps_core: LinuxPPS API ver. 1 registered
> [    0.170129] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.170129] PTP clock support registered
> [    0.170129] EDAC MC: Ver: 3.0.0
> [    0.170136] Registered efivars operations
> [    0.170136] NetLabel: Initializing
> [    0.170136] NetLabel:  domain hash size = 128
> [    0.170136] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.170136] NetLabel:  unlabeled traffic allowed by default
> [    0.170136] PCI: Using ACPI for IRQ routing
> [    0.171402] PCI: pci_cache_line_size set to 64 bytes
> [    0.171402] Expanded resource Reserved due to conflict with PCI Bus 0000:00
> [    0.171402] e820: reserve RAM buffer [mem 0x09d80000-0x0bffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xd8577000-0xdbffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xd85f0018-0xdbffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xd860e018-0xdbffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xd87c3000-0xdbffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xdbd62000-0xdbffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xdc02d000-0xdfffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
> [    0.171402] e820: reserve RAM buffer [mem 0x41f380000-0x41fffffff]
> [    0.173365] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.173366] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.175411] clocksource: Switched to clocksource tsc-early
> [    0.180327] VFS: Disk quotas dquot_6.6.0
> [    0.180338] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.180375] pnp: PnP ACPI init
> [    0.180435] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
> [    0.180438] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.180493] system 00:01: [mem 0xfd000000-0xfd0fffff] has been reserved
> [    0.180495] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.180520] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.180653] system 00:03: [io  0x0a00-0x0a0f] has been reserved
> [    0.180654] system 00:03: [io  0x0a10-0x0a1f] has been reserved
> [    0.180654] system 00:03: [io  0x0a20-0x0a2f] has been reserved
> [    0.180655] system 00:03: [io  0x0a40-0x0a4f] has been reserved
> [    0.180657] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.180846] pnp 00:04: [dma 0 disabled]
> [    0.180866] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.181014] system 00:05: [io  0x04d0-0x04d1] has been reserved
> [    0.181015] system 00:05: [io  0x040b] has been reserved
> [    0.181016] system 00:05: [io  0x04d6] has been reserved
> [    0.181017] system 00:05: [io  0x0c00-0x0c01] has been reserved
> [    0.181017] system 00:05: [io  0x0c14] has been reserved
> [    0.181018] system 00:05: [io  0x0c50-0x0c51] has been reserved
> [    0.181018] system 00:05: [io  0x0c52] has been reserved
> [    0.181019] system 00:05: [io  0x0c6c] has been reserved
> [    0.181020] system 00:05: [io  0x0c6f] has been reserved
> [    0.181020] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
> [    0.181021] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
> [    0.181021] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
> [    0.181022] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
> [    0.181023] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
> [    0.181023] system 00:05: [io  0x0800-0x089f] has been reserved
> [    0.181025] system 00:05: [io  0x0b00-0x0b0f] has been reserved
> [    0.181026] system 00:05: [io  0x0b20-0x0b3f] has been reserved
> [    0.181026] system 00:05: [io  0x0900-0x090f] has been reserved
> [    0.181027] system 00:05: [io  0x0910-0x091f] has been reserved
> [    0.181028] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.181029] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
> [    0.181029] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
> [    0.181030] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.181031] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
> [    0.181032] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
> [    0.181033] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> [    0.181035] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.181335] pnp: PnP ACPI: found 6 devices
> [    0.186537] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.186581] NET: Registered protocol family 2
> [    0.186754] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.186849] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.187038] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.187111] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.187189] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.187232] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.187271] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.187338] NET: Registered protocol family 1
> [    0.187343] NET: Registered protocol family 44
> [    0.187355] pci 0000:20:04.0: PCI bridge to [bus 25]
> [    0.187357] pci 0000:20:04.0:   bridge window [io  0xf000-0xffff]
> [    0.187362] pci 0000:20:04.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
> [    0.187369] pci 0000:20:05.0: PCI bridge to [bus 26]
> [    0.187381] pci 0000:20:06.0: PCI bridge to [bus 27]
> [    0.187392] pci 0000:20:07.0: PCI bridge to [bus 28]
> [    0.187403] pci 0000:03:00.2: PCI bridge to [bus 20-28]
> [    0.187404] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
> [    0.187408] pci 0000:03:00.2:   bridge window [mem 0xfcb00000-0xfcbfffff]
> [    0.187416] pci 0000:00:01.3: PCI bridge to [bus 03-28]
> [    0.187417] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
> [    0.187420] pci 0000:00:01.3:   bridge window [mem 0xfcb00000-0xfccfffff]
> [    0.187425] pci 0000:00:03.1: PCI bridge to [bus 29]
> [    0.187426] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
> [    0.187428] pci 0000:00:03.1:   bridge window [mem 0xfcf00000-0xfcffffff]
> [    0.187430] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.187433] pci 0000:00:07.1: PCI bridge to [bus 2a]
> [    0.187440] pci 0000:00:08.1: PCI bridge to [bus 2b]
> [    0.187442] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
> [    0.187446] pci 0000:00:08.2: PCI bridge to [bus 30]
> [    0.187449] pci 0000:00:08.2:   bridge window [mem 0xfce00000-0xfcefffff]
> [    0.187453] pci 0000:00:08.3: PCI bridge to [bus 31]
> [    0.187455] pci 0000:00:08.3:   bridge window [mem 0xfcd00000-0xfcdfffff]
> [    0.187460] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
> [    0.187461] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
> [    0.187462] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
> [    0.187462] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
> [    0.187463] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
> [    0.187464] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
> [    0.187465] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
> [    0.187465] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
> [    0.187466] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
> [    0.187467] pci_bus 0000:03: resource 1 [mem 0xfcb00000-0xfccfffff]
> [    0.187467] pci_bus 0000:20: resource 0 [io  0xf000-0xffff]
> [    0.187468] pci_bus 0000:20: resource 1 [mem 0xfcb00000-0xfcbfffff]
> [    0.187469] pci_bus 0000:25: resource 0 [io  0xf000-0xffff]
> [    0.187469] pci_bus 0000:25: resource 1 [mem 0xfcb00000-0xfcbfffff]
> [    0.187470] pci_bus 0000:29: resource 0 [io  0xe000-0xefff]
> [    0.187471] pci_bus 0000:29: resource 1 [mem 0xfcf00000-0xfcffffff]
> [    0.187471] pci_bus 0000:29: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.187472] pci_bus 0000:2b: resource 1 [mem 0xfc800000-0xfcafffff]
> [    0.187473] pci_bus 0000:30: resource 1 [mem 0xfce00000-0xfcefffff]
> [    0.187474] pci_bus 0000:31: resource 1 [mem 0xfcd00000-0xfcdfffff]
> [    0.187652] pci 0000:29:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.187664] pci 0000:29:00.1: D0 power state depends on 0000:29:00.0
> [    0.187750] PCI: CLS 64 bytes, default 64
> [    0.187772] Trying to unpack rootfs image as initramfs...
> [    0.237556] Freeing initrd memory: 7652K
> [    0.237572] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.237625] pci 0000:00:01.0: Adding to iommu group 0
> [    0.237632] pci 0000:00:01.3: Adding to iommu group 1
> [    0.237640] pci 0000:00:02.0: Adding to iommu group 2
> [    0.237649] pci 0000:00:03.0: Adding to iommu group 3
> [    0.237655] pci 0000:00:03.1: Adding to iommu group 4
> [    0.237664] pci 0000:00:04.0: Adding to iommu group 5
> [    0.237671] pci 0000:00:05.0: Adding to iommu group 6
> [    0.237680] pci 0000:00:07.0: Adding to iommu group 7
> [    0.237686] pci 0000:00:07.1: Adding to iommu group 8
> [    0.237697] pci 0000:00:08.0: Adding to iommu group 9
> [    0.237704] pci 0000:00:08.1: Adding to iommu group 10
> [    0.237711] pci 0000:00:08.2: Adding to iommu group 11
> [    0.237717] pci 0000:00:08.3: Adding to iommu group 12
> [    0.237728] pci 0000:00:14.0: Adding to iommu group 13
> [    0.237733] pci 0000:00:14.3: Adding to iommu group 13
> [    0.237755] pci 0000:00:18.0: Adding to iommu group 14
> [    0.237761] pci 0000:00:18.1: Adding to iommu group 14
> [    0.237766] pci 0000:00:18.2: Adding to iommu group 14
> [    0.237772] pci 0000:00:18.3: Adding to iommu group 14
> [    0.237777] pci 0000:00:18.4: Adding to iommu group 14
> [    0.237783] pci 0000:00:18.5: Adding to iommu group 14
> [    0.237789] pci 0000:00:18.6: Adding to iommu group 14
> [    0.237795] pci 0000:00:18.7: Adding to iommu group 14
> [    0.237808] pci 0000:03:00.0: Adding to iommu group 15
> [    0.237815] pci 0000:03:00.1: Adding to iommu group 15
> [    0.237823] pci 0000:03:00.2: Adding to iommu group 15
> [    0.237826] pci 0000:20:04.0: Adding to iommu group 15
> [    0.237830] pci 0000:20:05.0: Adding to iommu group 15
> [    0.237833] pci 0000:20:06.0: Adding to iommu group 15
> [    0.237836] pci 0000:20:07.0: Adding to iommu group 15
> [    0.237839] pci 0000:25:00.0: Adding to iommu group 15
> [    0.237860] pci 0000:29:00.0: Adding to iommu group 16
> [    0.237869] pci 0000:29:00.1: Adding to iommu group 16
> [    0.237877] pci 0000:2a:00.0: Adding to iommu group 17
> [    0.237885] pci 0000:2b:00.0: Adding to iommu group 18
> [    0.237894] pci 0000:2b:00.1: Adding to iommu group 19
> [    0.237902] pci 0000:2b:00.3: Adding to iommu group 20
> [    0.237911] pci 0000:2b:00.4: Adding to iommu group 21
> [    0.237918] pci 0000:30:00.0: Adding to iommu group 22
> [    0.237925] pci 0000:31:00.0: Adding to iommu group 23
> [    0.241285] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    0.241287] pci 0000:00:00.2: AMD-Vi: Extended features (0x58f77ef22294ade):
> [    0.241287]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    0.241289] AMD-Vi: Interrupt remapping enabled
> [    0.241289] AMD-Vi: Virtual APIC enabled
> [    0.241289] AMD-Vi: X2APIC enabled
> [    0.241375] AMD-Vi: Lazy IO/TLB flushing enabled
> [    0.242134] amd_uncore: AMD NB counters detected
> [    0.242141] amd_uncore: AMD LLC counters detected
> [    0.242281] LVT offset 0 assigned for vector 0x400
> [    0.242359] perf: AMD IBS detected (0x000003ff)
> [    0.242367] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
> [    0.242446] check: Scanning for low memory corruption every 60 seconds
> [    0.242774] Initialise system trusted keyrings
> [    0.242784] Key type blacklist registered
> [    0.242813] workingset: timestamp_bits=41 max_order=22 bucket_order=0
> [    0.243411] zbud: loaded
> [    0.245795] Key type asymmetric registered
> [    0.245795] Asymmetric key parser 'x509' registered
> [    0.245812] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
> [    0.245857] io scheduler mq-deadline registered
> [    0.245858] io scheduler kyber registered
> [    0.245875] io scheduler bfq registered
> [    0.246314] pcieport 0000:00:07.1: AER: enabled with IRQ 29
> [    0.246415] pcieport 0000:00:08.1: AER: enabled with IRQ 30
> [    0.246546] pcieport 0000:00:08.2: AER: enabled with IRQ 31
> [    0.246674] pcieport 0000:00:08.3: AER: enabled with IRQ 32
> [    0.247311] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.247350] efifb: probing for efifb
> [    0.247360] efifb: framebuffer at 0xe0000000, using 3072k, total 3072k
> [    0.247361] efifb: mode is 1024x768x32, linelength=4096, pages=1
> [    0.247361] efifb: scrolling: redraw
> [    0.247362] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.247382] fbcon: Deferring console take-over
> [    0.247383] fb0: EFI VGA frame buffer device
> [    0.247429] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    0.247444] ACPI: Power Button [PWRB]
> [    0.247469] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    0.248552] ACPI: Power Button [PWRF]
> [    0.248632] Monitor-Mwait will be used to enter C-1 state
> [    0.248641] ACPI: \_PR_.C000: Found 2 idle states
> [    0.248742] ACPI: \_PR_.C002: Found 2 idle states
> [    0.248795] ACPI: \_PR_.C004: Found 2 idle states
> [    0.248866] ACPI: \_PR_.C006: Found 2 idle states
> [    0.248944] ACPI: \_PR_.C008: Found 2 idle states
> [    0.249002] ACPI: \_PR_.C00A: Found 2 idle states
> [    0.249057] ACPI: \_PR_.C001: Found 2 idle states
> [    0.249157] ACPI: \_PR_.C003: Found 2 idle states
> [    0.249213] ACPI: \_PR_.C005: Found 2 idle states
> [    0.249264] ACPI: \_PR_.C007: Found 2 idle states
> [    0.249319] ACPI: \_PR_.C009: Found 2 idle states
> [    0.249410] ACPI: \_PR_.C00B: Found 2 idle states
> [    0.249647] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.249787] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.250313] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    0.250862] ahci 0000:03:00.1: version 3.0
> [    0.250958] ahci 0000:03:00.1: SSS flag set, parallel bus scan disabled
> [    0.250998] ahci 0000:03:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
> [    0.250999] ahci 0000:03:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
> [    0.251319] scsi host0: ahci
> [    0.251395] scsi host1: ahci
> [    0.251452] scsi host2: ahci
> [    0.251507] scsi host3: ahci
> [    0.251559] scsi host4: ahci
> [    0.251616] scsi host5: ahci
> [    0.251669] scsi host6: ahci
> [    0.251719] scsi host7: ahci
> [    0.251740] ata1: SATA max UDMA/133 abar m131072@0xfcc80000 port 0xfcc80100 irq 40
> [    0.251742] ata2: SATA max UDMA/133 abar m131072@0xfcc80000 port 0xfcc80180 irq 40
> [    0.251742] ata3: DUMMY
> [    0.251742] ata4: DUMMY
> [    0.251744] ata5: SATA max UDMA/133 abar m131072@0xfcc80000 port 0xfcc80300 irq 40
> [    0.251745] ata6: SATA max UDMA/133 abar m131072@0xfcc80000 port 0xfcc80380 irq 40
> [    0.251745] ata7: DUMMY
> [    0.251746] ata8: DUMMY
> [    0.251860] ahci 0000:30:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> [    0.251861] ahci 0000:30:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
> [    0.251958] scsi host8: ahci
> [    0.251978] ata9: SATA max UDMA/133 abar m2048@0xfce00000 port 0xfce00100 irq 42
> [    0.252071] ahci 0000:31:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> [    0.252072] ahci 0000:31:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
> [    0.252162] scsi host9: ahci
> [    0.252181] ata10: SATA max UDMA/133 abar m2048@0xfcd00000 port 0xfcd00100 irq 44
> [    0.252206] usbcore: registered new interface driver usbserial_generic
> [    0.252208] usbserial: USB Serial support registered for generic
> [    0.252224] rtc_cmos 00:02: RTC can wake from S4
> [    0.252370] rtc_cmos 00:02: registered as rtc0
> [    0.252403] rtc_cmos 00:02: setting system clock to 2020-11-13T16:30:44 UTC (1605285044)
> [    0.252411] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    0.252517] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.252571] drop_monitor: Initializing network drop monitor service
> [    0.252665] NET: Registered protocol family 10
> [    0.255237] Segment Routing with IPv6
> [    0.255238] RPL Segment Routing with IPv6
> [    0.255248] NET: Registered protocol family 17
> [    0.255724] microcode: CPU0: patch_level=0x08701013
> [    0.255727] microcode: CPU1: patch_level=0x08701013
> [    0.255731] microcode: CPU2: patch_level=0x08701013
> [    0.255737] microcode: CPU3: patch_level=0x08701013
> [    0.255740] microcode: CPU4: patch_level=0x08701013
> [    0.255745] microcode: CPU5: patch_level=0x08701013
> [    0.255750] microcode: CPU6: patch_level=0x08701013
> [    0.255754] microcode: CPU7: patch_level=0x08701013
> [    0.255758] microcode: CPU8: patch_level=0x08701013
> [    0.255762] microcode: CPU9: patch_level=0x08701013
> [    0.255767] microcode: CPU10: patch_level=0x08701013
> [    0.255772] microcode: CPU11: patch_level=0x08701013
> [    0.255789] microcode: Microcode Update Driver: v2.2.
> [    0.255888] resctrl: L3 allocation detected
> [    0.255889] resctrl: L3DATA allocation detected
> [    0.255889] resctrl: L3CODE allocation detected
> [    0.255889] resctrl: MB allocation detected
> [    0.255890] resctrl: L3 monitoring detected
> [    0.255892] IPI shorthand broadcast: enabled
> [    0.255897] sched_clock: Marking stable (282544796, -26663076)->(320300882, -64419162)
> [    0.255973] registered taskstats version 1
> [    0.255980] Loading compiled-in X.509 certificates
> [    0.257189] Loaded X.509 cert 'Build time autogenerated kernel key: 8a1ebdb83e6cd1dd6d45cbc32415fde47d555c5b'
> [    0.257279] zswap: loaded using pool lz4/z3fold
> [    0.257373] Key type ._fscrypt registered
> [    0.257374] Key type .fscrypt registered
> [    0.257374] Key type fscrypt-provisioning registered
> [    0.257640] PM:   Magic number: 12:183:540
> [    0.257689]  node: hash matches
> [    0.257759] RAS: Correctable Errors collector initialized.
> [    0.566516] ata9: SATA link down (SStatus 0 SControl 300)
> [    0.568567] ata10: SATA link down (SStatus 0 SControl 300)
> [    0.728671] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    0.728765] ata1.00: ATA-11: P3-128, 1.00, max UDMA/133
> [    0.728766] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    0.728862] ata1.00: configured for UDMA/133
> [    0.728948] scsi 0:0:0:0: Direct-Access     ATA      P3-128           1.00 PQ: 0 ANSI: 5
> [    0.729045] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
> [    0.729049] sd 0:0:0:0: [sda] Write Protect is off
> [    0.729050] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    0.729056] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    0.731272]  sda: sda1 sda2 sda3
> [    0.731536] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.200445] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.244936] ata2.00: ATA-7: ST3500830AS, 3.AAD, max UDMA/133
> [    1.244938] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32)
> [    1.250438] tsc: Refined TSC clocksource calibration: 3799.997 MHz
> [    1.250449] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d8cab05ec1, max_idle_ns: 881590646801 ns
> [    1.250492] clocksource: Switched to clocksource tsc
> [    1.303237] ata2.00: configured for UDMA/133
> [    1.303435] scsi 1:0:0:0: Direct-Access     ATA      ST3500830AS      D    PQ: 0 ANSI: 5
> [    1.303659] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    1.303668] sd 1:0:0:0: [sdb] Write Protect is off
> [    1.303669] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.303676] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.346909]  sdb: sdb1 sdb2
> [    1.347295] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    1.773791] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.780410] ata5.00: ATA-10: SATA3 1TB SSD, T0519A0, max UDMA/133
> [    1.780413] ata5.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.789672] ata5.00: configured for UDMA/133
> [    1.789835] scsi 4:0:0:0: Direct-Access     ATA      SATA3 1TB SSD    9A0  PQ: 0 ANSI: 5
> [    1.790041] sd 4:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [    1.790047] sd 4:0:0:0: [sdc] Write Protect is off
> [    1.790048] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    1.790056] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.792313]  sdc: sdc1
> [    1.792697] sd 4:0:0:0: [sdc] Attached SCSI disk
> [    2.260451] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.263618] ata6.00: ATAPI: HL-DT-ST DVDRAM GH20NS10, EL00, max UDMA/100
> [    2.268007] ata6.00: configured for UDMA/100
> [    2.385498] scsi 5:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH20NS10  EL00 PQ: 0 ANSI: 5
> [    2.427132] Freeing unused decrypted memory: 2040K
> [    2.427340] Freeing unused kernel image (initmem) memory: 1660K
> [    2.427342] Write protecting the kernel read-only data: 24576k
> [    2.427727] Freeing unused kernel image (text/rodata gap) memory: 2044K
> [    2.427815] Freeing unused kernel image (rodata/data gap) memory: 244K
> [    2.437160] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.437164] Run /init as init process
> [    2.437165]   with arguments:
> [    2.437165]     /init
> [    2.437165]   with environment:
> [    2.437166]     HOME=/
> [    2.437166]     TERM=linux
> [    2.469808] fbcon: Taking over console
> [    2.469851] Console: switching to colour frame buffer device 128x48
> [    2.512409] xhci_hcd 0000:03:00.0: xHCI Host Controller
> [    2.512414] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> [    2.558793] random: fast init done
> [    2.567838] xhci_hcd 0000:03:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000008000410
> [    2.567983] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
> [    2.567984] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.567985] usb usb1: Product: xHCI Host Controller
> [    2.567986] usb usb1: Manufacturer: Linux 5.9.8-arch1-1 xhci-hcd
> [    2.567986] usb usb1: SerialNumber: 0000:03:00.0
> [    2.568061] hub 1-0:1.0: USB hub found
> [    2.568075] hub 1-0:1.0: 9 ports detected
> [    2.568281] xhci_hcd 0000:03:00.0: xHCI Host Controller
> [    2.568283] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
> [    2.568284] xhci_hcd 0000:03:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.568311] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.568321] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
> [    2.568321] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.568322] usb usb2: Product: xHCI Host Controller
> [    2.568323] usb usb2: Manufacturer: Linux 5.9.8-arch1-1 xhci-hcd
> [    2.568323] usb usb2: SerialNumber: 0000:03:00.0
> [    2.568371] hub 2-0:1.0: USB hub found
> [    2.568377] hub 2-0:1.0: 3 ports detected
> [    2.568502] xhci_hcd 0000:2b:00.3: xHCI Host Controller
> [    2.568504] xhci_hcd 0000:2b:00.3: new USB bus registered, assigned bus number 3
> [    2.568607] xhci_hcd 0000:2b:00.3: hcc params 0x0278ffe5 hci version 0x110 quirks 0x0000000000000410
> [    2.568855] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
> [    2.568856] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.568856] usb usb3: Product: xHCI Host Controller
> [    2.568857] usb usb3: Manufacturer: Linux 5.9.8-arch1-1 xhci-hcd
> [    2.568857] usb usb3: SerialNumber: 0000:2b:00.3
> [    2.568903] hub 3-0:1.0: USB hub found
> [    2.568908] hub 3-0:1.0: 4 ports detected
> [    2.569018] xhci_hcd 0000:2b:00.3: xHCI Host Controller
> [    2.569020] xhci_hcd 0000:2b:00.3: new USB bus registered, assigned bus number 4
> [    2.569021] xhci_hcd 0000:2b:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.569042] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.569052] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
> [    2.569053] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.569053] usb usb4: Product: xHCI Host Controller
> [    2.569054] usb usb4: Manufacturer: Linux 5.9.8-arch1-1 xhci-hcd
> [    2.569054] usb usb4: SerialNumber: 0000:2b:00.3
> [    2.569097] hub 4-0:1.0: USB hub found
> [    2.569102] hub 4-0:1.0: 4 ports detected
> [    2.659015] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    2.659016] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    2.690292] sr 5:0:0:0: Attached scsi CD-ROM sr0
> [    2.896676] usb 1-4: new low-speed USB device number 2 using xhci_hcd
> [    2.896681] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [    3.037674] usb 3-1: New USB device found, idVendor=0424, idProduct=2504, bcdDevice= 0.01
> [    3.037675] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.081196] hub 3-1:1.0: USB hub found
> [    3.081548] hub 3-1:1.0: 4 ports detected
> [    3.156864] usb 1-4: New USB device found, idVendor=045e, idProduct=00db, bcdDevice= 1.73
> [    3.156865] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.156866] usb 1-4: Product: Natural® Ergonomic Keyboard 4000
> [    3.156866] usb 1-4: Manufacturer: Microsoft
> [    3.160165] usb 4-3: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [    3.166102] hid: raw HID events driver (C) Jiri Kosina
> [    3.177095] usb 4-3: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 3.00
> [    3.177097] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.177098] usb 4-3: Product: USB3.0 802.11ac 1200M Adapter
> [    3.177099] usb 4-3: Manufacturer: Realtek
> [    3.177100] usb 4-3: SerialNumber: 123456
> [    3.193660] usbcore: registered new interface driver usbhid
> [    3.193661] usbhid: USB HID core driver
> [    3.195939] input: Microsoft Natural® Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.0/0003:045E:00DB.0001/input/input2
> [    3.250057] microsoft 0003:045E:00DB.0001: input,hidraw0: USB HID v1.11 Keyboard [Microsoft Natural® Ergonomic Keyboard 4000] on usb-0000:03:00.0-4/input0
> [    3.250181] input: Microsoft Natural® Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.1/0003:045E:00DB.0002/input/input3
> [    3.286683] usb 1-5: new high-speed USB device number 3 using xhci_hcd
> [    3.300009] usb 3-4: new low-speed USB device number 3 using xhci_hcd
> [    3.306767] microsoft 0003:045E:00DB.0002: input,hidraw1: USB HID v1.11 Device [Microsoft Natural® Ergonomic Keyboard 4000] on usb-0000:03:00.0-4/input1
> [    3.453112] usb 3-4: New USB device found, idVendor=093a, idProduct=2521, bcdDevice= 1.00
> [    3.453113] usb 3-4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [    3.453114] usb 3-4: Product: USB OPTICAL MOUSE
> [    3.475231] input: USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:08.1/0000:2b:00.3/usb3/3-4/3-4:1.0/0003:093A:2521.0003/input/input4
> [    3.475267] hid-generic 0003:093A:2521.0003: input,hidraw2: USB HID v1.11 Mouse [USB OPTICAL MOUSE] on usb-0000:2b:00.3-4/input0
> [    3.513362] usb 3-1.4: new full-speed USB device number 4 using xhci_hcd
> [    3.584104] usb 1-5: New USB device found, idVendor=1b71, idProduct=0056, bcdDevice= 0.00
> [    3.584105] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [    3.584106] usb 1-5: Product: USB 2.0 Camera
> [    3.584107] usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
> [    3.643063] usb 3-1.4: New USB device found, idVendor=0a5c, idProduct=21ec, bcdDevice= 1.12
> [    3.643064] usb 3-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.643065] usb 3-1.4: Product: BCM20702A0
> [    3.643066] usb 3-1.4: Manufacturer: Broadcom Corp
> [    3.643067] usb 3-1.4: SerialNumber: 21498600DF07
> [    3.863121] PM: Image not found (code -22)
> [    3.929275] F2FS-fs (sda2): Mounted with checkpoint version = 2d88db33
> [    4.055028] random: crng init done
> [    4.055059] systemd[1]: Successfully credited entropy passed from boot loader.
> [    4.056574] systemd[1]: systemd 246.6-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [    4.070194] systemd[1]: Detected architecture x86-64.
> [    4.104761] systemd[1]: Set hostname to <medion>.
> [    4.216284] systemd[1]: Queued start job for default target Graphical Interface.
> [    4.216971] systemd[1]: Created slice system-getty.slice.
> [    4.217193] systemd[1]: Created slice system-modprobe.slice.
> [    4.217385] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [    4.217588] systemd[1]: Created slice User and Session Slice.
> [    4.217646] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [    4.217698] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [    4.217800] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [    4.217857] systemd[1]: Reached target Local Encrypted Volumes.
> [    4.217891] systemd[1]: Reached target Login Prompts.
> [    4.217930] systemd[1]: Reached target Remote File Systems.
> [    4.217961] systemd[1]: Reached target Slices.
> [    4.218019] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [    4.218222] systemd[1]: Listening on LVM2 metadata daemon socket.
> [    4.218597] systemd[1]: Listening on LVM2 poll daemon socket.
> [    4.219518] systemd[1]: Listening on Process Core Dump Socket.
> [    4.219757] systemd[1]: Listening on Journal Audit Socket.
> [    4.219824] systemd[1]: Listening on Journal Socket (/dev/log).
> [    4.220251] systemd[1]: Listening on Journal Socket.
> [    4.220789] systemd[1]: Listening on udev Control Socket.
> [    4.221197] systemd[1]: Listening on udev Kernel Socket.
> [    4.222010] systemd[1]: Mounting Huge Pages File System...
> [    4.222918] systemd[1]: Mounting POSIX Message Queue File System...
> [    4.223792] systemd[1]: Mounting Kernel Debug File System...
> [    4.224638] systemd[1]: Mounting Kernel Trace File System...
> [    4.225665] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [    4.226590] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [    4.227391] systemd[1]: Starting Load Kernel Module drm...
> [    4.229030] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [    4.229046] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [    4.229889] systemd[1]: Starting Journal Service...
> [    4.232020] systemd[1]: Starting Load Kernel Modules...
> [    4.232875] systemd[1]: Starting Remount Root and Kernel File Systems...
> [    4.234552] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [    4.234958] systemd[1]: Starting Coldplug All udev Devices...
> [    4.235966] systemd[1]: Mounted Huge Pages File System.
> [    4.236409] systemd[1]: Mounted POSIX Message Queue File System.
> [    4.236868] systemd[1]: Mounted Kernel Debug File System.
> [    4.237274] systemd[1]: Mounted Kernel Trace File System.
> [    4.237890] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [    4.238438] Linux agpgart interface v0.103
> [    4.241390] systemd[1]: Finished Remount Root and Kernel File Systems.
> [    4.241926] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
> [    4.249585] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [    4.250360] systemd[1]: Starting Load/Save Random Seed...
> [    4.250800] systemd[1]: Condition check resulted in Create System Users being skipped.
> [    4.251440] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    4.258030] Asymmetric key parser 'pkcs8' registered
> [    4.258521] systemd[1]: modprobe@drm.service: Succeeded.
> [    4.258775] systemd[1]: Finished Load Kernel Module drm.
> [    4.263447] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    4.265026] systemd[1]: Starting Rule-based Manager for Device Events and Files...
> [    4.265950] systemd[1]: Finished Load/Save Random Seed.
> [    4.270497] vboxdrv: loading out-of-tree module taints kernel.
> [    4.270631] vboxdrv: module verification failed: signature and/or required key missing - tainting kernel
> [    4.271844] vboxdrv: Found 12 processor cores
> [    4.282909] systemd[1]: Finished Coldplug All udev Devices.
> [    4.293471] vboxdrv: TSC mode is Invariant, tentative frequency 3799995383 Hz
> [    4.293472] vboxdrv: Successfully loaded version 6.1.16 (interface 0x00300000)
> [    4.294297] VBoxNetAdp: Successfully started.
> [    4.295615] VBoxNetFlt: Successfully started.
> [    4.296238] systemd[1]: Finished Load Kernel Modules.
> [    4.296683] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
> [    4.297221] systemd[1]: Mounting Kernel Configuration File System...
> [    4.298040] systemd[1]: Starting Apply Kernel Variables...
> [    4.298766] systemd[1]: Mounted Kernel Configuration File System.
> [    4.302576] systemd[1]: Finished Apply Kernel Variables.
> [    4.407138] systemd[1]: Started Journal Service.
> [    4.407603] audit: type=1130 audit(1605285048.651:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    4.458194] audit: type=1130 audit(1605285048.701:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    4.459266] audit: type=1130 audit(1605285048.701:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    4.478696] acpi_cpufreq: overriding BIOS provided _PSD data
> [    4.556106] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [    4.556109] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
> [    4.556195] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [    4.556225] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> [    4.556793] input: PC Speaker as /devices/platform/pcspkr/input/input5
> [    4.560749] libphy: Fixed MDIO Bus: probed
> [    4.562575] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
> [    4.562660] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
> [    4.562669] sp5100-tco sp5100-tco: Watchdog hardware is disabled
> [    4.625528] ccp 0000:2b:00.1: enabling device (0000 -> 0002)
> [    4.625658] ccp 0000:2b:00.1: ccp: unable to access the device: you might be running a broken BIOS.
> [    4.629537] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [    4.629540] RAPL PMU: hw unit of domain package 2^-16 Joules
> [    4.635909] mc: Linux media interface: v0.10
> [    4.636700] Adding 4194624k swap on /dev/sda3.  Priority:-2 extents:1 across:4194624k SSFS
> [    4.637238] cryptd: max_cpu_qlen set to 1000
> [    4.645368] AVX2 version of gcm_enc/dec engaged.
> [    4.645369] AES CTR mode by8 optimization enabled
> [    4.651247] libphy: r8169: probed
> [    4.651418] r8169 0000:25:00.0 eth0: RTL8168h/8111h, 2c:f0:5d:53:5c:48, XID 541, IRQ 58
> [    4.651419] r8169 0000:25:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> [    4.708292] audit: type=1130 audit(1605285048.951:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    4.745656] videodev: Linux video capture interface: v2.00
> [    4.765280] snd_hda_intel 0000:29:00.1: Force to non-snoop mode
> [    4.766538] snd_hda_intel 0000:2b:00.4: enabling device (0000 -> 0002)
> [    4.784215] usb 1-5: 3:1: cannot get freq at ep 0x84
> [    4.854397] mousedev: PS/2 mouse device common for all mice
> [    4.866966] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input6
> [    4.867034] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input7
> [    4.867089] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input8
> [    4.867143] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input9
> [    4.867207] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input10
> [    4.867254] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.1/0000:29:00.1/sound/card1/input11
> [    4.868553] usbcore: registered new interface driver snd-usb-audio
> [    4.873011] kvm: Nested Virtualization enabled
> [    4.873031] SVM: kvm: Nested Paging enabled
> [    4.873032] SVM: Virtual VMLOAD VMSAVE supported
> [    4.873032] SVM: Virtual GIF supported
> [    4.873741] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [    4.873743] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    4.873745] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    4.873745] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
> [    4.873746] snd_hda_codec_realtek hdaudioC2D0:    inputs:
> [    4.873747] snd_hda_codec_realtek hdaudioC2D0:      Front Mic=0x19
> [    4.873748] snd_hda_codec_realtek hdaudioC2D0:      Rear Mic=0x18
> [    4.873749] snd_hda_codec_realtek hdaudioC2D0:      Line=0x1a
> [    4.875449] MCE: In-kernel MCE decoding enabled.
> [    4.877255] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (1b71:0056)
> [    4.900441] EDAC amd64: F17h_M70h detected (node 0).
> [    4.900486] EDAC amd64: Node 0: DRAM ECC disabled.
> [    4.920628] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:2b:00.4/sound/card2/input12
> [    4.920681] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:2b:00.4/sound/card2/input13
> [    4.920722] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:2b:00.4/sound/card2/input14
> [    4.920763] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:2b:00.4/sound/card2/input15
> [    4.920805] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:2b:00.4/sound/card2/input16
> [    4.948375] input: USB 2.0 Camera: HD 720P Webcam as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-5/1-5:1.0/input/input17
> [    4.948428] usbcore: registered new interface driver uvcvideo
> [    4.948429] USB Video Class driver (1.1.1)
> [    4.999153] r8169 0000:25:00.0 enp37s0: renamed from eth0
> [    5.009303] EDAC amd64: F17h_M70h detected (node 0).
> [    5.009356] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.014102] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    5.014277] Bluetooth: Core ver 2.22
> [    5.014295] NET: Registered protocol family 31
> [    5.014297] Bluetooth: HCI device and connection manager initialized
> [    5.014300] Bluetooth: HCI socket layer initialized
> [    5.014303] Bluetooth: L2CAP socket layer initialized
> [    5.014308] Bluetooth: SCO socket layer initialized
> [    5.016830] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    5.019930] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    5.019931] cfg80211: failed to load regulatory.db
> [    5.038872] audit: type=1130 audit(1605285049.281:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.066318] audit: type=1130 audit(1605285049.308:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-66292c7e\x2d43e1\x2d45e4\x2da2d9\x2dfd895a3869b5 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.067318] EDAC amd64: F17h_M70h detected (node 0).
> [    5.067379] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.095558] audit: type=1130 audit(1605285049.338:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-CC5A\x2d65C3 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.110508] [drm] amdgpu kernel modesetting enabled.
> [    5.110602] amdgpu: Ignoring ACPI CRAT on non-APU system
> [    5.110608] Virtual CRAT table created for CPU
> [    5.110622] amdgpu: Topology: Add CPU node
> [    5.110766] checking generic (e0000000 300000) vs hw (e0000000 10000000)
> [    5.110767] fb0: switching to amdgpudrmfb from EFI VGA
> [    5.110834] Console: switching to colour dummy device 80x25
> [    5.110867] amdgpu 0000:29:00.0: vgaarb: deactivate vga console
> [    5.111061] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67DF 0x1462:0x341B 0xEF).
> [    5.111065] amdgpu 0000:29:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> [    5.111078] [drm] register mmio base: 0xFCF00000
> [    5.111079] [drm] register mmio size: 262144
> [    5.111090] [drm] add ip block number 0 <vi_common>
> [    5.111091] [drm] add ip block number 1 <gmc_v8_0>
> [    5.111092] [drm] add ip block number 2 <tonga_ih>
> [    5.111094] [drm] add ip block number 3 <gfx_v8_0>
> [    5.111096] [drm] add ip block number 4 <sdma_v3_0>
> [    5.111097] [drm] add ip block number 5 <powerplay>
> [    5.111099] [drm] add ip block number 6 <dce_v11_0>
> [    5.111101] [drm] add ip block number 7 <uvd_v6_0>
> [    5.111102] [drm] add ip block number 8 <vce_v3_0>
> [    5.111284] amdgpu 0000:29:00.0: No more image in the PCI ROM
> [    5.111351] amdgpu: ATOM BIOS: 113V34122-F3
> [    5.111370] [drm] UVD is enabled in VM mode
> [    5.111370] [drm] UVD ENC is enabled in VM mode
> [    5.111373] [drm] VCE enabled in VM mode
> [    5.111528] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
> [    5.112737] amdgpu 0000:29:00.0: amdgpu: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
> [    5.112739] amdgpu 0000:29:00.0: amdgpu: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
> [    5.112745] [drm] Detected VRAM RAM=8192M, BAR=256M
> [    5.112746] [drm] RAM width 256bits GDDR5
> [    5.112795] [TTM] Zone  kernel: Available graphics memory: 8201666 KiB
> [    5.112796] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    5.112797] [TTM] Initializing pool allocator
> [    5.112801] [TTM] Initializing DMA pool allocator
> [    5.112830] [drm] amdgpu: 8192M of VRAM memory ready
> [    5.112833] [drm] amdgpu: 8192M of GTT memory ready.
> [    5.112834] [drm] GART: num cpu pages 65536, num gpu pages 65536
> [    5.115177] [drm] PCIE GART of 256M enabled (table at 0x000000F400300000).
> [    5.117039] [drm] Chained IB support enabled!
> [    5.121750] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
> [    5.121785] [drm] AMDGPU Display Connectors
> [    5.121786] [drm] Connector 0:
> [    5.121786] [drm]   DP-1
> [    5.121786] [drm]   HPD6
> [    5.121787] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 0x486b 0x486b
> [    5.121787] [drm]   Encoders:
> [    5.121787] [drm]     DFP1: INTERNAL_UNIPHY2
> [    5.121788] [drm] Connector 1:
> [    5.121788] [drm]   DP-2
> [    5.121788] [drm]   HPD4
> [    5.121788] [drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872 0x4872 0x4873 0x4873
> [    5.121789] [drm]   Encoders:
> [    5.121789] [drm]     DFP2: INTERNAL_UNIPHY2
> [    5.121789] [drm] Connector 2:
> [    5.121789] [drm]   DP-3
> [    5.121789] [drm]   HPD1
> [    5.121790] [drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e 0x486f 0x486f
> [    5.121790] [drm]   Encoders:
> [    5.121790] [drm]     DFP3: INTERNAL_UNIPHY1
> [    5.121791] [drm] Connector 3:
> [    5.121791] [drm]   HDMI-A-1
> [    5.121791] [drm]   HPD5
> [    5.121791] [drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 0x4877 0x4877
> [    5.121792] [drm]   Encoders:
> [    5.121792] [drm]     DFP4: INTERNAL_UNIPHY1
> [    5.121792] [drm] Connector 4:
> [    5.121792] [drm]   DVI-D-1
> [    5.121792] [drm]   HPD3
> [    5.121793] [drm]   DDC: 0x487c 0x487c 0x487d 0x487d 0x487e 0x487e 0x487f 0x487f
> [    5.121793] [drm]   Encoders:
> [    5.121793] [drm]     DFP5: INTERNAL_UNIPHY
> [    5.123419] [drm] Found UVD firmware Version: 1.130 Family ID: 16
> [    5.125229] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
> [    5.140827] EDAC amd64: F17h_M70h detected (node 0).
> [    5.140886] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.143610] usbcore: registered new interface driver btusb
> [    5.150980] audit: type=1130 audit(1605285049.394:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.152179] RTW: module init start
> [    5.152180] RTW: rtl88x2bu v5.8.7.2_36899.20200819_COEX20191120-7777
> [    5.152181] RTW: build time: Nov 12 2020 12:23:30
> [    5.152181] RTW: rtl88x2bu BT-Coex version = COEX20191120-7777
> [    5.152222] RTW: [HALMAC]11692M
>                 HALMAC_MAJOR_VER = 1
>                 HALMAC_PROTOTYPE_VER = 6
>                 HALMAC_MINOR_VER = 5
>                 HALMAC_PATCH_VER = 6*
> [    5.152800] RTW: ERROR [HALMAC][ERR]Dump efuse in suspend
> [    5.218363] [drm] UVD and UVD ENC initialized successfully.
> [    5.255327] Bluetooth: hci0: BCM: chip id 63
> [    5.256312] Bluetooth: hci0: BCM: features 0x07
> [    5.260572] EDAC amd64: F17h_M70h detected (node 0).
> [    5.260640] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.272309] Bluetooth: hci0: medion
> [    5.272311] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1460
> [    5.274229] Bluetooth: hci0: BCM20702A1 'brcm/BCM20702A1-0a5c-21ec.hcd' Patch
> [    5.301662] audit: type=1130 audit(1605285049.544:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-c26efc96\x2d2725\x2d4add\x2da519\x2d29b0e0d28ed9 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.315899] RTW: HW EFUSE
> [    5.315902] RTW: 0x000: 29 81 00 3C  09 00 A1 00  B6 04 64 10  00 00 A3 00
> [    5.315907] RTW: 0x010: 2E 2E 2E 2E  2E 2E 2C 2C  2C 2C 2C F2  00 00 FF FF
> [    5.315912] RTW: 0x020: FF FF 28 2A  2C 2E 25 25  24 24 23 24  23 23 22 22
> [    5.315916] RTW: 0x030: F0 00 FF FF  00 FF C0 00  FF FF 2B 2B  2B 2B 2B 2B
> [    5.315920] RTW: 0x040: 29 29 2A 2A  2A 13 00 00  FF FF FF FF  29 29 28 28
> [    5.315925] RTW: 0x050: 25 27 28 2A  29 2E 2F 2F  2E 2E E0 00  FF FF 00 FF
> [    5.315930] RTW: 0x060: C0 00 FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315936] RTW: 0x070: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315941] RTW: 0x080: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315946] RTW: 0x090: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315950] RTW: 0x0A0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315954] RTW: 0x0B0: FF FF FF FF  FF FF FF FF  7F 33 21 00  FF FF FF FF
> [    5.315958] RTW: 0x0C0: FF 09 00 11  00 00 00 00  00 FF 03 FF  FF FF FF FF
> [    5.315962] RTW: 0x0D0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315967] RTW: 0x0E0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315971] RTW: 0x0F0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.315975] RTW: 0x100: DA 0B 12 B8  C1 67 02 1C  BF CE F6 64  CF 09 03 52
> [    5.315979] RTW: 0x110: 65 61 6C 74  65 6B 1F 03  55 53 42 33  2E 30 20 38
> [    5.315983] RTW: 0x120: 30 32 2E 31  31 61 63 20  31 32 30 30  4D 20 41 64
> [    5.315988] RTW: 0x130: 61 70 74 65  72 08 03 31  32 33 34 35  36 FF FF FF
> [    5.315992] RTW: 0x140: 33 0A 1F 01  00 00 21 0F  FF FF FF FF  FF FF FF FF
> [    5.315996] RTW: 0x150: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316000] RTW: 0x160: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316004] RTW: 0x170: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316009] RTW: 0x180: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316013] RTW: 0x190: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316017] RTW: 0x1A0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316021] RTW: 0x1B0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316025] RTW: 0x1C0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316029] RTW: 0x1D0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316034] RTW: 0x1E0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316038] RTW: 0x1F0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316042] RTW: 0x200: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316046] RTW: 0x210: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316050] RTW: 0x220: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316054] RTW: 0x230: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316059] RTW: 0x240: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316063] RTW: 0x250: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316067] RTW: 0x260: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316071] RTW: 0x270: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316075] RTW: 0x280: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316079] RTW: 0x290: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316084] RTW: 0x2A0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316088] RTW: 0x2B0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316092] RTW: 0x2C0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316096] RTW: 0x2D0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316100] RTW: 0x2E0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316104] RTW: 0x2F0: FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
> [    5.316113] RTW: hal_com_config_channel_plan chplan:0x7F
> [    5.316116] RTW: ERROR [HALMAC][ERR]Dump efuse in suspend
> [    5.319307] [drm] VCE initialized successfully.
> [    5.320307] kfd kfd: Allocated 3969056 bytes on gart
> [    5.320879] Virtual CRAT table created for GPU
> [    5.320950] amdgpu: Topology: Add dGPU node [0x67df:0x1002]
> [    5.320952] kfd kfd: added device 1002:67df
> [    5.320954] amdgpu 0000:29:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 9, active_cu_number 32
> [    5.322201] RTW: [HALMAC][ALWAYS]shall R reg twice!!
> [    5.365049] RTW: ERROR [HALMAC][ERR]Dump efuse in suspend
> [    5.365127] RTW: ERROR [HALMAC][ERR]Dump efuse in suspend
> [    5.365205] RTW: ERROR [HALMAC][ERR]Dump efuse in suspend
> [    5.365293] RTW: [RF_PATH] ver_id.RF_TYPE:RF_2T2R, rf_reg_path_num:2, max_tx_cnt:2
> [    5.365294] RTW: [RF_PATH] PG's trx_path_bmp:0x00, max_tx_cnt:0
> [    5.365295] RTW: [RF_PATH] Registry's RF PATH:UNKNOWN
> [    5.365296] RTW: [RF_PATH] HALDATA's trx_path_bmp:0x33, max_tx_cnt:2
> [    5.365297] RTW: [RF_PATH] HALDATA's rf_type:RF_2T2R
> [    5.365297] RTW: [RF_PATH] NumTotalRFPath:2
> [    5.365298] RTW: [TRX_Nss] HALSPEC - tx_nss :2, rx_nss:2
> [    5.365299] RTW: [TRX_Nss] Registry - tx_nss :0, rx_nss:0
> [    5.365300] RTW: [TRX_Nss] HALDATA - tx_nss :2, rx_nss:2
> [    5.365565] RTW: rtw_regsty_chk_target_tx_power_valid return _FALSE for band:0, path:0, rs:0, t:-1
> [    5.365758] RTW: rtw_ndev_init(wlan0) if1 mac_addr=1c:bf:ce:f6:64:cf
> [    5.366157] usbcore: registered new interface driver rtl88x2bu
> [    5.366159] RTW: module init ret=0
> [    5.383952] EDAC amd64: F17h_M70h detected (node 0).
> [    5.384003] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.395849] F2FS-fs (sdc1): Mounted with checkpoint version = 187cfd6d
> [    5.544125] EDAC amd64: F17h_M70h detected (node 0).
> [    5.544201] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.559184] [drm] fb mappable at 0xE0830000
> [    5.559184] [drm] vram apper at 0xE0000000
> [    5.559185] [drm] size 8294400
> [    5.559185] [drm] fb depth is 24
> [    5.559185] [drm]    pitch is 7680
> [    5.559231] fbcon: amdgpudrmfb (fb0) is primary device
> [    5.610714] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: (null)
> [    5.650427] EDAC amd64: F17h_M70h detected (node 0).
> [    5.650475] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.756964] EDAC amd64: F17h_M70h detected (node 0).
> [    5.757008] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.830320] Console: switching to colour frame buffer device 210x65
> [    5.850451] EDAC amd64: F17h_M70h detected (node 0).
> [    5.850494] EDAC amd64: Node 0: DRAM ECC disabled.
> [    5.983916] EDAC amd64: F17h_M70h detected (node 0).
> [    5.983970] EDAC amd64: Node 0: DRAM ECC disabled.
> [    6.040332] Bluetooth: hci0: Broadcom Bluetooth Device
> [    6.040334] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1460
> [    6.053624] amdgpu 0000:29:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [    6.065741] EDAC amd64: F17h_M70h detected (node 0).
> [    6.065790] EDAC amd64: Node 0: DRAM ECC disabled.
> [    6.074735] [drm] Initialized amdgpu 3.39.0 20150101 for 0000:29:00.0 on minor 0
> [    6.081460] audit: type=1130 audit(1605285050.324:11): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.088956] audit: type=1127 audit(1605285050.331:12): pid=596 uid=0 auid=4294967295 ses=4294967295 msg=' comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
> [    6.091907] audit: type=1130 audit(1605285050.334:13): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.098738] audit: type=1130 audit(1605285050.341:14): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=amdgpu-fancontrol comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.101203] audit: type=1130 audit(1605285050.344:15): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.117209] audit: type=1334 audit(1605285050.361:16): prog-id=7 op=LOAD
> [    6.117251] audit: type=1334 audit(1605285050.361:17): prog-id=8 op=LOAD
> [    6.167116] audit: type=1130 audit(1605285050.411:18): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=bluetooth comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.176913] NET: Registered protocol family 38
> [    6.181303] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.181303] Bluetooth: BNEP filters: protocol multicast
> [    6.181306] Bluetooth: BNEP socket layer initialized
> [    6.249833] RTW: [HALMAC][ALWAYS]shall R reg twice!!
> [    6.857435] RTW: txpath=0x3, rxpath=0x3
> [    6.857437] RTW: txpath_1ss:0x1, num:1
> [    6.857438] RTW: txpath_2ss:0x3, num:2
> [    6.872891] start_addr=(0x20000), end_addr=(0x40000), buffer_size=(0x20000), smp_number_max=(16384)
> [    6.875509] RTW: wlan0- hw port(0) mac_addr =1c:bf:ce:f6:64:cf
> [    6.913365] Generic FE-GE Realtek PHY r8169-2500:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-2500:00, irq=IGNORE)
> [    7.076846] r8169 0000:25:00.0 enp37s0: Link is Down
> [    7.477340] RTW: nolinked power save enter
> [   10.394693] kauditd_printk_skb: 25 callbacks suppressed
> [   10.394696] audit: type=1131 audit(1605285054.638:44): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.085219] audit: type=1130 audit(1605285057.328:45): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-wait-online comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.306727] audit: type=1130 audit(1605285057.551:46): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=colord comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.437315] audit: type=1130 audit(1605285057.681:47): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=org.cups.cupsd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.571877] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [   13.575646] Bridge firewalling registered
> [   13.604395] audit: type=1325 audit(1605285057.848:48): table=nat family=2 entries=0 op=xt_register pid=881 comm="modprobe"
> [   13.608509] audit: type=1325 audit(1605285057.851:49): table=filter family=2 entries=0 op=xt_register pid=883 comm="modprobe"
> [   13.622904] audit: type=1325 audit(1605285057.864:50): table=nat family=2 entries=5 op=xt_replace pid=903 comm="iptables"
> [   13.624361] audit: type=1325 audit(1605285057.868:51): table=filter family=2 entries=4 op=xt_replace pid=905 comm="iptables"
> [   13.625740] audit: type=1325 audit(1605285057.868:52): table=filter family=2 entries=6 op=xt_replace pid=907 comm="iptables"
> [   13.627114] audit: type=1325 audit(1605285057.871:53): table=filter family=2 entries=8 op=xt_replace pid=909 comm="iptables"
> [   13.634204] Initializing XFRM netlink socket
> [   13.986723] process 'docker/tmp/qemu-check970278276/check' started with executable stack
> [   16.164894] fuse: init (API version 7.31)
> [   16.326816] kauditd_printk_skb: 51 callbacks suppressed
> [   16.326818] audit: type=1130 audit(1605285060.571:105): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   16.827156] audit: type=1130 audit(1605285061.071:106): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=rtkit-daemon comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   16.978149] audit: type=1131 audit(1605285061.221:107): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   16.980778] RTW: [HALMAC][ALWAYS]shall R reg twice!!
> [   17.004677] usb 1-5: 3:1: cannot get freq at ep 0x84
> [   17.035682] usb 1-5: 3:1: cannot get freq at ep 0x84
> [   17.301751] audit: type=1334 audit(1605285061.544:108): prog-id=13 op=LOAD
> [   17.301779] audit: type=1334 audit(1605285061.544:109): prog-id=14 op=LOAD
> [   17.579872] Bluetooth: RFCOMM TTY layer initialized
> [   17.579878] Bluetooth: RFCOMM socket layer initialized
> [   17.579882] Bluetooth: RFCOMM ver 1.11
> [   17.599667] RTW: txpath=0x3, rxpath=0x3
> [   17.599668] RTW: txpath_1ss:0x1, num:1
> [   17.599669] RTW: txpath_2ss:0x3, num:2
> [   17.615182] start_addr=(0x20000), end_addr=(0x40000), buffer_size=(0x20000), smp_number_max=(16384)
> [   17.618175] RTW: wlan0- hw port(0) mac_addr =1c:bf:ce:f6:64:cf
> [   17.626190] RTW: nolinked power save leave
> [   17.874604] audit: type=1130 audit(1605285062.118:110): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=upower comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   18.286844] audit: type=1130 audit(1605285062.531:111): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=wpa_supplicant comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   18.288474] audit: type=1130 audit(1605285062.531:112): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=geoclue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   18.343050] audit: type=1130 audit(1605285062.584:113): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=udisks2 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   18.414856] audit: type=1130 audit(1605285062.658:114): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=blueman-mechanism comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   21.733354] RTW: rtw_set_802_11_connect(wlan0)  fw_state=0x00000008
> [   21.852451] RTW: start auth
> [   21.853590] RTW: auth success, start assoc
> [   21.855850] RTW: assoc success
> [   21.856641] RTW: ============ STA [48:d3:43:03:66:6f]  ===================
> [   21.856643] RTW: mac_id : 0
> [   21.856644] RTW: wireless_mode : 0x44
> [   21.856644] RTW: mimo_type : 2
> [   21.856645] RTW: static smps : N
> [   21.856646] RTW: bw_mode : 80MHz, ra_bw_mode : 80MHz
> [   21.856647] RTW: rate_id : 9
> [   21.856648] RTW: rssi : -1 (%), rssi_level : 0
> [   21.856649] RTW: is_support_sgi : Y, is_vht_enable : Y
> [   21.856649] RTW: disable_ra : N, disable_pt : N
> [   21.856650] RTW: is_noisy : N
> [   21.856650] RTW: txrx_state : 0
> [   21.856651] RTW: curr_tx_rate : CCK_1M (L)
> [   21.856652] RTW: curr_tx_bw : 20MHz
> [   21.856652] RTW: curr_retry_ratio : 0
> [   21.856653] RTW: ra_mask : 0x00000000fffffff0
>
> [   21.869658] RTW: recv eapol packet 1/4
> [   21.869938] RTW: send eapol packet 2/4
> [   21.881751] RTW: recv eapol packet 3/4
> [   21.882222] RTW: send eapol packet 4/4
> [   21.882265] RTW: set group key camid:4, addr:48:d3:43:03:66:6f, kid:2, type:TKIP
> [   21.882689] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [   21.883278] RTW: set pairwise key camid:5, addr:48:d3:43:03:66:6f, kid:0, type:AES
> [   22.012048] kauditd_printk_skb: 1 callbacks suppressed
> [   22.012050] audit: type=1130 audit(1605285066.254:116): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   23.816517] audit: type=1131 audit(1605285068.058:117): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@972 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   23.825860] audit: type=1131 audit(1605285068.068:118): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@972 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   31.981933] audit: type=1131 audit(1605285076.224:119): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   36.372830] audit: type=1131 audit(1605285080.614:120): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   36.676747] audit: type=1334 audit(1605285080.921:121): prog-id=10 op=UNLOAD
> [   36.676751] audit: type=1334 audit(1605285080.921:122): prog-id=9 op=UNLOAD
> [   49.450324] audit: type=1131 audit(1605285093.694:123): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=blueman-mechanism comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'

