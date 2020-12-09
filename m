Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0BC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 07:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F241E233EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 07:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgLIHee (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 02:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgLIHe2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 02:34:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA9C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 23:33:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t4so559748wrr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e78yAPduHMdrRfr0uxG7/AAj2sVRNsAvvSrIZp/aCIQ=;
        b=XBHfUZnPqDgetrfJn/Y7bp9TCnUS2W89prAZSw6JF0vEYL3t7UKtLJ5GnCRDX152DP
         cUXKXAVRzY4b+BaBqEH/bo0mesGd5UjrfBtiSPBzMlc5TBQkWnbjASC1/nJXTDhsW7jk
         pH2YaUpe0pT1734li/P2B6WhBCu+wxntDXWv3UO6L/umY0aesqvf47FP7aroNCiWuPGR
         qoK7bDuvrLyq+eWjG8RRaAnvOX4/kaga/xPOm+9NDB9LKWIpPK35gDNPu/DuCA/kl23A
         sQ/ZJ0DsyGQ9JUuSqJZusHe8HdvzQBU1Y72QkDKbx96oCQuE/dPqXy6eJ3vsHUmbo3oW
         cofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e78yAPduHMdrRfr0uxG7/AAj2sVRNsAvvSrIZp/aCIQ=;
        b=tYkKpf4daVI+31YWWMWE51TH3iw7oIvJZtagEldfAhqAIfZUZIOEkSm94b8GChvLLT
         vJrAPjvZzYOWx0fHuWwMQciC3P4dK1uJmmkllWqphPS5FLQYWezUqsDyffP5CWOTwZKT
         a4qCH56aPr+PXFcHbKEX7eLT/VQFS4LFqsy8gm6BTMnowsdeTn0EyviK5oU3OBuN4ozW
         PF3crGlVqJDC1JGz8/i884THP74qftXfbGJgMU1GDEkxFDTDEYMtJNqLbTmkO9uTte0Y
         4PuWuNZr/EFLS4Fdqvc5Dm5OPlNgaMH9M7kkz6Haw6BwFliYdgqCvMt1pkeM/Mwrpg8h
         rpiQ==
X-Gm-Message-State: AOAM533NZ4dS3JwVssPk/P1MR+HnS74V9hPyjP64iYLDwo30BoPjOueV
        +LQ/ghrJ7nfJnrqnEMvNnxIWopy4Efo=
X-Google-Smtp-Source: ABdhPJxF72m9OiZaeuf5IgrT8QzBD4i7TAXz2oxLJ4OezFOdxmE0WoKlIfan08Kqg/HYYULKZifkJg==
X-Received: by 2002:adf:90f1:: with SMTP id i104mr1112926wri.348.1607499226562;
        Tue, 08 Dec 2020 23:33:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:dc43:c735:4625:9787? (p200300ea8f065500dc43c73546259787.dip0.t-ipconnect.de. [2003:ea:8f06:5500:dc43:c735:4625:9787])
        by smtp.googlemail.com with ESMTPSA id 94sm1788798wrq.22.2020.12.08.23.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 23:33:45 -0800 (PST)
Subject: Re: linux-next-2020-12-04: Failed to send firmware data (-38) with
 AX210
To:     "K, Kiran" <kiran.k@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
References: <ece7cd5c-14ff-5a6d-29b5-c6a16b2638e8@gmail.com>
 <BYAPR11MB3141EC7D2A5E98DCCE285AFFF5CC0@BYAPR11MB3141.namprd11.prod.outlook.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ba90be36-e515-3755-b222-59d5b075021c@gmail.com>
Date:   Wed, 9 Dec 2020 08:33:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3141EC7D2A5E98DCCE285AFFF5CC0@BYAPR11MB3141.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 09.12.2020 um 01:40 schrieb K, Kiran:
> Hi Heiner Kallweit,
> 
Hi Kiran,

thanks for following up.

> Please provide more information test environment.
> 
> 1.   cat  /proc/cpuinfo

For one of the four cores:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 92
model name      : Intel(R) Celeron(R) CPU N3450 @ 1.10GHz
stepping        : 9
microcode       : 0x40
cpu MHz         : 1093.748
cache size      : 1024 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 21
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology tsc_reliable nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl est tm2 ssse3 sdbg cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave rdrand lahf_lm 3dnowprefetch cpuid_fault cat_l2 ibrs ibpb stibp fsgsbase tsc_adjust smep erms mpx rdt_a rdseed smap clflushopt intel_pt sha_ni xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts md_clear arch_capabilities
bugs            : monitor spectre_v1 spectre_v2
bogomips        : 2188.80
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:


> 2.   Is this an intermittent issue ?

No, it's perfectly reproducible. Happens always after a power cycle.

I don' think it's related to the following, but I'd like to mention
it nevertheless. After each reboot (not only after power cycle) the
WiFi PCI device is missing. Therefore I have to reboot with
reboot=pci. See also bug 202399 in kernel bugzilla.

> 3.   Are you using any specific distro ?
> 
Arch, headless

> I didn't observe any such issue on my system.
> 
> Thanks,
> Kiran
> 
Heiner

> 
>> -----Original Message-----
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Sent: Tuesday, December 8, 2020 1:26 AM
>> To: K, Kiran <kiran.k@intel.com>; Marcel Holtmann <marcel@holtmann.org>
>> Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
>> Subject: linux-next-2020-12-04: Failed to send firmware data (-38) with AX210
>>
>> With an AX210 card I get "Failed to send firmware data (-38)" on linux-next
>> from Dec 4th in case of a cold-boot after power-cycle.
>>
>> "hk: bt code = 0x001f" is a private debug message to check which BT code is
>> mapped to ENOSYS (-38). From what I found 0x1f is "Unspecified error".
>>
>> The second attempt to load the firmware is successful then.
>>
>>
>> [    4.192718] Bluetooth: Core ver 2.22
>> [    4.192756] Bluetooth: Starting self testing
>> [    4.192785] Bluetooth: Finished self testing
>> [    4.192937] Bluetooth: HCI device and connection manager initialized
>> [    4.193067] Bluetooth: HCI socket layer initialized
>> [    4.193108] Bluetooth: L2CAP socket layer initialized
>> [    4.193195] Bluetooth: SCO socket layer initialized
>> [    4.242342] Bluetooth: hci0: Device revision is 0
>> [    4.242435] Bluetooth: hci0: Secure boot is enabled
>> [    4.242495] Bluetooth: hci0: OTP lock is enabled
>> [    4.242533] Bluetooth: hci0: API lock is enabled
>> [    4.242570] Bluetooth: hci0: Debug lock is disabled
>> [    4.242609] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>> [    4.242657] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1
>> build 38
>> [    4.261977] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
>> [    4.855813] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [    4.855873] Bluetooth: BNEP socket layer initialized
>> [    5.819388] Bluetooth: hk: bt code = 0x001f
>> [    5.819438] Bluetooth: hci0: Failed to send firmware data (-38)
>> [    5.820069] Bluetooth: hci0: Intel reset sent to retry FW download
>> [    6.362248] Bluetooth: hci0: Device revision is 0
>> [    6.362384] Bluetooth: hci0: Secure boot is enabled
>> [    6.362439] Bluetooth: hci0: OTP lock is enabled
>> [    6.362551] Bluetooth: hci0: API lock is enabled
>> [    6.362605] Bluetooth: hci0: Debug lock is disabled
>> [    6.362660] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>> [    6.362726] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1
>> build 38
>> [    6.364508] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
>> [    9.020540] Bluetooth: hci0: Waiting for firmware download to complete
>> [    9.021443] Bluetooth: hci0: Firmware loaded in 2599136 usecs
>> [    9.022778] Bluetooth: hci0: Waiting for device to boot
>> [    9.050099] Bluetooth: hci0: Device booted in 27723 usecs
>> [    9.052633] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-
>> 0041.ddc
>> [    9.055224] Bluetooth: hci0: Applying Intel DDC parameters completed
>> [    9.060184] Bluetooth: hci0: Firmware timestamp 2020.42 buildtype 1 build
>> 15791
> 

