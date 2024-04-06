Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8ED3032A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435377; cv=none; b=F0Vrd3eJvVyyez3LVM2HWAWs6F4ijjaGlxFf8hHcWv6976SBqYcEQmVk9CdYDoD7Bjl19F06ahEpbgK/m9aQR2CII/QWamsoysFNiEib73s76Vm9PTMXOLb6KVbKyilZ/BQcvHHWmC/dF1mLr+vQuaS3bcWJcTi4Cxn+w/BRwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435377; c=relaxed/simple;
	bh=MULS1SqUZ0d1XQN/BWoIIY0UDchCWMGnXlaadk4KqsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nnxDxqdb5gCiOIVubZx+D9dccZCSYS3cg5cE/GtLq9XDHBKxbePnrMmnC8BZtnwLfMQTsZfl083zESCCnxXPjJrxapt8VC9yY7S95Au9Dazc7c9JqkMA/QqwRxJNcFHyoe4rZDaaFnPDq2+k1lwX3KDnrFUByUb7E4Iy0vMG6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Le+gbqBJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Le+gbqBJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso65959b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Apr 2024 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712435375; x=1713040175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uk8FYlfmNAM1gjbXoeE/XnZN4uaHowi6e6TvC6rlVGE=;
        b=Le+gbqBJ/nxKHzBRh5BXFxnUt7vnFTMhbeSdbbl1w/eYQU6pgyLpRQ6DgUw9q3oADB
         OiP90MLHjMv7CCurNXW58BjW3isZCROEZqtlG/Kef1debPZ/epyPdY0uM5tawgHsCsb0
         RdVFQ1zpZevoQfuMWWavZgWolr4BBzHY28IFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712435375; x=1713040175;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk8FYlfmNAM1gjbXoeE/XnZN4uaHowi6e6TvC6rlVGE=;
        b=r9NZbK6zHYRQklm2NoB3I4K4FywIHIniuQTuwqeUmJ5KAPZGBY0M1loILqX0ypRXvW
         +sorV6H9gF+PZqiZY4AUsfLgrxExhzFwGmIakzVyeo9rYVMGMPP/Ljmrs+y67L8O11Qz
         13t9POKf8ljA9/qgbRstQQwn5IUKoP+IuOXx6zXwsSZBj8B9WG7F2hXEfPaI7d7y+bKU
         zdVtoseHvfBWXOm9v1ZNOBgEwjSyyQO3M+rH+rOXYHuHhH2K3f7rls/yFafGcUI0/2BL
         sUdtq7NjVzt6Li91COUAPJ8XE1Wbe+dsmf+3aCiNyHD+3HETVke65npvYQC7gegzAhmn
         et6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJesesDMxlQPjMGVixSZKfe1ADYiQloTU+Zq5bD8nmrEcFa9d+ty5Hh4EKO+mNYcSr51uGqPBYTZg/AB5Co/FRtpWa/3pw7FySFXYmFb8h
X-Gm-Message-State: AOJu0YzMbxVbV2fluCXTavOqL/aDGSZFo1XChsfM95aqDboSul3zvmA7
	+rQJt4cugGXud71F+zYuhDq/yrReaZTbRR5KIynzljtknKMC+PRjpjJAWtoa0g==
X-Google-Smtp-Source: AGHT+IG/C1qIDLsNK9YKdY6ZacZXCktHySFVi73eYJeD84jpKyozn+YjzvC1Tpcxh2/iifOxnydpag==
X-Received: by 2002:a05:6a20:7fa2:b0:1a3:6f13:b11b with SMTP id d34-20020a056a207fa200b001a36f13b11bmr6819904pzj.4.1712435374872;
        Sat, 06 Apr 2024 13:29:34 -0700 (PDT)
Received: from [172.16.102.235] (c-98-45-34-39.hsd1.ca.comcast.net. [98.45.34.39])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e694719fa0sm1684541pfb.147.2024.04.06.13.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 13:29:34 -0700 (PDT)
Message-ID: <43820685-4960-4801-bd5d-f1b5e41ec033@penguintechs.org>
Date: Sat, 6 Apr 2024 13:29:33 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
To: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Ben Young Tae Kim <ytkim@qca.qualcomm.com>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
In-Reply-To: <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Ben Young Tae Kim, current maintainer of btqca

On 4/6/24 1:27 PM, Wren Turkal wrote:
> +Kalle Valo since you have the same laptop
> 
> On 4/6/24 1:16 PM, Wren Turkal wrote:
>> Sorry for the double send on the original message. I am still hoping 
>> to get some help. I have added additional info below.
>>
>> On 4/4/24 12:14 PM, Wren Turkal wrote:
>>> Hey there ath11k/bluetooth folks,
>>>
>>> I am having a pretty major problem with QCA6930 for some time (maybe 
>>> a year or two). I have this bluetooth device:
>>>
>>> 72:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc QCA6390 
>>> Wireless Network Adapter
>>>
>>> This device appears to be driven by the ath11k module and others. I 
>>> hope I am pinging the right lists.
>>>
>>> I am using Fedora Rawhide. Fully updated yesterday. My uname reports 
>>> this:
>>>
>>> Linux braindead.localdomain 
>>> 6.9.0-0.rc2.20240402git026e680b0a08.24.fc41.x86_64 #1 SMP 
>>> PREEMPT_DYNAMIC Tue Apr  2 17:51:18 UTC 2024 x86_64 GNU/Linux
>>
>> Updated today. Here's the new uname:
>>
>> Linux braindead.localdomain 
>> 6.9.0-0.rc2.20240405git8cb4a9a82b21.27.fc41.x86_64 #1 SMP 
>> PREEMPT_DYNAMIC Fri Apr  5 16:48:07 UTC 2024 x86_64 GNU/Linux
>>
>> I also noticed a new version of bluez. Here is the RPM package 
>> version: bluez-5.73-3.fc41.x86_64
>>
>>> My main bluetooth device is  a Logitech MX 3 Mac mouse that uses 
>>> bluetooth. When bluetooth fails, so does the mouse. I have power 
>>> cycle my laptop when that happens. I'd love to help find a fix for this.
>>>
>>> The problem is that I cannot disable and re-enable the bluetooth on 
>>> my system. Bluetooth also doesn't work after a warm boot. I have to 
>>> power cycle my laptop to recover bluetooth funcitonality. I have 
>>> tried the following:
>>>
>>> * logging into KDE Plasma (bluetooth stops working)
>>> * logging into GNOME (works on cold boot, fails on warm boot)
>>
>> I did notice that the mouse seems to work in Plasma until a few sec 
>> after I see the background image appears. I suspect that Plasma is 
>> disabling and reenabling the bluetooth where Gnome does not do that.
>>
>>> After logging into GNOME during a cold boot, I have also done 
>>> "systemctl restart bluetooth.service". I get these journal logs 
>>> during the stop;
>>>
>>> ➜  bt_kernel_bug cat journal-stop-bluetooth-service.log
>>> Apr 04 10:14:41 braindead.localdomain NetworkManager[1120]: <info> 
>>> [1712250881.7060] device (F0:5C:77:F2:60:FC): state change: 
>>> disconnected -> unmanaged (reason 'removed', sys-iface-state: 'removed')
>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Starting 
>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Started 
>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
>>> Apr 04 10:14:41 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=systemd-rfkill comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>> Apr 04 10:14:46 braindead.localdomain systemd[1]: 
>>> systemd-rfkill.service: Deactivated successfully.
>>> Apr 04 10:14:46 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=systemd-rfkill comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>>
>>> I get these journal logs during start:
>>>
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: 
>>> setting up ROME/QCA6390
>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Starting 
>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Started 
>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
>>> Apr 04 10:15:05 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=systemd-rfkill comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Product ID   :0x00000010
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> SOC Version  :0x400a0200
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> ROM Version  :0x00000200
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Patch Version:0x00003ac0
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> controller version 0x02000200
>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Downloading qca/htbtfw20.tlv
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Failed to send TLV segment (-110)
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Failed to download patch (-110)
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>> BT power ON:0
>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: 
>>> command 0xfc00 tx timeout
>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: 
>>> Reading QCA version information failed (-110)
>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>> BT power ON:1
>>> Apr 04 10:15:10 braindead.localdomain systemd[1]: 
>>> systemd-rfkill.service: Deactivated successfully.
>>> Apr 04 10:15:10 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=systemd-rfkill comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: 
>>> command 0xfc00 tx timeout
>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: 
>>> Reading QCA version information failed (-110)
>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>> BT power ON:2
>>> Apr 04 10:15:13 braindead.localdomain bluetoothd[986]: Failed to set 
>>> mode: Authentication Failed (0x05)
>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: 
>>> command 0xfc00 tx timeout
>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: 
>>> Reading QCA version information failed (-110)
>>> Apr 04 10:15:15 braindead.localdomain chronyd[1065]: Selected source 
>>> 204.17.205.8 (2.fedora.pool.ntp.org)
>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Created slice 
>>> background.slice - User Background Tasks Slice.
>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Starting 
>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files 
>>> and Directories...
>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Finished 
>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files 
>>> and Directories.
>>> Apr 04 10:15:38 braindead.localdomain audit: BPF prog-id=86 op=LOAD
>>> Apr 04 10:15:38 braindead.localdomain systemd[1]: Starting 
>>> plocate-updatedb.service - Update the plocate database...
>>> Apr 04 10:15:41 braindead.localdomain systemd[1687]: Started 
>>> vte-spawn-21527424-cb2d-479f-af17-22251e2b37a0.scope - VTE child 
>>> process 5144 launched by gnome-terminal-server process 4668.
>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: 
>>> plocate-updatedb.service: Deactivated successfully.
>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: Finished 
>>> plocate-updatedb.service - Update the plocate database.
>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: 
>>> plocate-updatedb.service: Consumed 6.802s CPU time.
>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=plocate-updatedb comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
>>> msg='unit=plocate-updatedb comm="systemd" 
>>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>> Apr 04 10:15:54 braindead.localdomain audit: BPF prog-id=86 op=UNLOAD
>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>> kf.idletime: Could not find any system poller plugin
>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
>>> KIdleTime): invalid nullptr parameter
>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
>>> KIdleTime): invalid nullptr parameter
>>>
>>> There's a bunch of errors in those logs starting with these two 
>>> seemingly important lines:
>>>
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Failed to send TLV segment (-110)
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>> Failed to download patch (-110)
>>
>> Logs are mostly unchanges when restarting the bluetooth service after 
>> a cold boot with the bluetooth originally working.
>>
>>> FWIW, I get similar logs after logging into KDE Plasma. I also get 
>>> similar logs after a warm boot.
>>>
>>> This appears to be some kind of bug in the initialization of the 
>>> hardware. Is there any additional information I can provide to help 
>>> troubleshoot this problem.
>>
>> I will also say that the bluetooth appears to work throught a 
>> suspend/resume cycle as long as I don't restart the bluetooth service.
>>
>> Oh, and my laptop is a Dell 9310 if that helps.
> 
> Kalle, I noticed that you reported having a Dell 9310 in 2021 in a 
> message on this very mailing list. Do you happen to still have that 
> laptop? If so, so you still test on that laptop at all? I am curious if 
> it is having the same issue I am experiencing?
> 
>> Is there any other info I could collect that might be useful?
>>
>> I'm pretty new to troubleshooting a problem like this and would be 
>> happy to have any advice anyone might want to share.
>>
>> Thanks,
>> wt
>>
> 

-- 
You're more amazing than you think!
