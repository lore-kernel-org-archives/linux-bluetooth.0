Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E248156C44
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692394; cv=none; b=nhbgVA9u0wT2j/TAgQmUrP0EdJrPQ2vmjnzViCtta2+VpAGAlyUj24pOsQxalW0qRb8MnIylzlLGR0F0ZAsrG3U1PK45nZYpxt2KATSfHoaiNwWHaFuTA/QJ9rNqKxIbXecNawisSCVJKYRITc1FPLzLvMtIKUQnXdE6trS6xH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692394; c=relaxed/simple;
	bh=NDasQPMzMaW0UI+jCCLFj8GUoRsV13vXEj2ofGe4mB4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EUlaq/wJxx1ZkYnf4hy8bvF8R9PG45zt5qBjLQxjL9DsCew8e3A9QEj3LHw+PaRJiaIAEm6Ur7m4EMCmCXy5Vh7QmxdOzLaTEg0mPgNs2flKg5GwJUfIf9gMs9+dkkj88GWcjz6Su73Yg/Ik6M3lwwNtispGnrBDZWCtSardLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=CHu5gSWA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="CHu5gSWA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so1726612a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712692391; x=1713297191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I1VrLcfT3JuR18SqF8hq8jOCuxceprqgGwOZl371VI=;
        b=CHu5gSWACsjMLEkjcBcdCEDAdjenmUb8vStBCuediKe5i5vQ5KYi0VHagORPMqRW1g
         gVaBzhuzbxZVAQ2+DRq/RESz8tYvmSB2ZZSiDsjUQN+2a/1ovXe4liFKCI2bFeMIUsaE
         uo5WAWnEDxQUpp5FCjmTvm0jObymLkFzF1MIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692391; x=1713297191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I1VrLcfT3JuR18SqF8hq8jOCuxceprqgGwOZl371VI=;
        b=AB2RzjXf0Ftijo65G/smVLHOdLJvZ5oRp/KkZKFFTvh8ABqYtAVVP0fl23HBM9ynmz
         QlXMBVHGHKbVccV0FHOJiI+RHbAx7Q1w/buSmbbmlhwAqKEKOHoT3v4j5qf7pqlMrWBa
         EPFD3m96ocGrPdqx6QW0J4ADJqKgwWppfNa2R+xAGotCLVu2BoHFIrfupS7DoOjdVGks
         K/eX/dJt33uzfokj9Mw5auCO3jFxJ33DTF5PDkXXalRjAQG/ptq1nivOIfV2tiOYcKjO
         ed8SV3+15PRPuqeTJrjLUfzh6DUEcR/SJXIi+cOkxQVRRQEsKKMGJk0KtO1vJS1M2Y/y
         /J+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTUr5ydO/60xfwm9LrYV/jXkwycM2Sn0idF6d4JxjSGVL/xtf9ZHBdflrRFvo70bSyO3huo7L3O6smLthClI7G79xH7lsAP7CM6WHiaASX
X-Gm-Message-State: AOJu0Yy0YHDuXOgiK76qDE2l8zdNZrdLhb0G2lHHFSAVKUKg7PgKNRAq
	p7jJw9UFn2IVuYb/nsmLRIK1KQ0aXqoQRTFh3O3P06H6CdpgbOtrWh79D0reF9cri99g78IWml8
	jhA==
X-Google-Smtp-Source: AGHT+IHSOjE4fEu4bRv6+Iy27WGZOHyEONpMVUtQIUezXIkwFcZX5pktsXW+kR017MdHRm+nDL4GHQ==
X-Received: by 2002:a17:90b:4d83:b0:2a5:3aec:fdef with SMTP id oj3-20020a17090b4d8300b002a53aecfdefmr562133pjb.47.1712692391251;
        Tue, 09 Apr 2024 12:53:11 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090a7d1400b002a53b9cf356sm3421706pjl.0.2024.04.09.12.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:53:10 -0700 (PDT)
Message-ID: <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
Date: Tue, 9 Apr 2024 12:53:08 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
From: Wren Turkal <wt@penguintechs.org>
To: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
Content-Language: en-US
In-Reply-To: <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 12:49 PM, Wren Turkal wrote:
> +Marcel Holtmann <marcel@holtmann.org>
> +Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> 
> Added maintainers identified from the get_maintainer.pl script in the 
> kernel repo. Hoping to get some ideas for next steps.
> 
> More contextual info below:
> 
> On 4/6/24 1:27 PM, Wren Turkal wrote:
>> +Kalle Valo since you have the same laptop
>>
>> On 4/6/24 1:16 PM, Wren Turkal wrote:
>>> Sorry for the double send on the original message. I am still hoping 
>>> to get some help. I have added additional info below.
>>>
>>> On 4/4/24 12:14 PM, Wren Turkal wrote:
>>>> Hey there ath11k/bluetooth folks,
>>>>
>>>> I am having a pretty major problem with QCA6930 for some time (maybe 
>>>> a year or two). I have this bluetooth device:
>>>>
>>>> 72:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc QCA6390 
>>>> Wireless Network Adapter
>>>>
>>>> This device appears to be driven by the ath11k module and others. I 
>>>> hope I am pinging the right lists.
>>>>
>>>> I am using Fedora Rawhide. Fully updated yesterday. My uname reports 
>>>> this:
>>>>
>>>> Linux braindead.localdomain 
>>>> 6.9.0-0.rc2.20240402git026e680b0a08.24.fc41.x86_64 #1 SMP 
>>>> PREEMPT_DYNAMIC Tue Apr  2 17:51:18 UTC 2024 x86_64 GNU/Linux
>>>
>>> Updated today. Here's the new uname:
>>>
>>> Linux braindead.localdomain 
>>> 6.9.0-0.rc2.20240405git8cb4a9a82b21.27.fc41.x86_64 #1 SMP 
>>> PREEMPT_DYNAMIC Fri Apr  5 16:48:07 UTC 2024 x86_64 GNU/Linux
> 
> I looked at the current mainline kernel code. I found the following.
> 
> I found that there was a patch authored by Zijun Hu that was supposed to 
> address a warm reboot issue on QCA6390 here: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/hci_qca.c?h=v6.9-rc3&id=7e7bbddd029b644f00f0ffbfbc485ed71977d0d5
> 
> The same code path from the above patch is now slightly different 
> because another patch authored by Krzysztof Kozlowski, namely: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/hci_qca.c?h=v6.9-rc3&id=272970be3dabd24cbe50e393ffee8f04aec3b9a8
> 
> I also see a few fixed over time in the btqca.c file. I wonder if any of 
> these are related.
> 
> Unfortunately, none of these changes were made recently.
> 
> Does anyone have an suggestions for next steps?

I am trying to build kernels as old as 5.19 to start a bisect. I have 
been unsuccessful due to compiler warnings (presumably from newer 
version of gcc than were used at the time those kernels were released. 
Is there any secret sauce to getting these older kernels to build with 
newer gccs?

>>>
>>> I also noticed a new version of bluez. Here is the RPM package 
>>> version: bluez-5.73-3.fc41.x86_64
>>>
>>>> My main bluetooth device is  a Logitech MX 3 Mac mouse that uses 
>>>> bluetooth. When bluetooth fails, so does the mouse. I have power 
>>>> cycle my laptop when that happens. I'd love to help find a fix for 
>>>> this.
>>>>
>>>> The problem is that I cannot disable and re-enable the bluetooth on 
>>>> my system. Bluetooth also doesn't work after a warm boot. I have to 
>>>> power cycle my laptop to recover bluetooth funcitonality. I have 
>>>> tried the following:
>>>>
>>>> * logging into KDE Plasma (bluetooth stops working)
>>>> * logging into GNOME (works on cold boot, fails on warm boot)
>>>
>>> I did notice that the mouse seems to work in Plasma until a few sec 
>>> after I see the background image appears. I suspect that Plasma is 
>>> disabling and reenabling the bluetooth where Gnome does not do that.
>>>
>>>> After logging into GNOME during a cold boot, I have also done 
>>>> "systemctl restart bluetooth.service". I get these journal logs 
>>>> during the stop;
>>>>
>>>> ➜  bt_kernel_bug cat journal-stop-bluetooth-service.log
>>>> Apr 04 10:14:41 braindead.localdomain NetworkManager[1120]: <info> 
>>>> [1712250881.7060] device (F0:5C:77:F2:60:FC): state change: 
>>>> disconnected -> unmanaged (reason 'removed', sys-iface-state: 
>>>> 'removed')
>>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Starting 
>>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
>>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Started 
>>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
>>>> Apr 04 10:14:41 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=systemd-rfkill 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>> Apr 04 10:14:46 braindead.localdomain systemd[1]: 
>>>> systemd-rfkill.service: Deactivated successfully.
>>>> Apr 04 10:14:46 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=systemd-rfkill 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>>
>>>> I get these journal logs during start:
>>>>
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> setting up ROME/QCA6390
>>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Starting 
>>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
>>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Started 
>>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
>>>> Apr 04 10:15:05 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=systemd-rfkill 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Product ID   :0x00000010
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> SOC Version  :0x400a0200
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> ROM Version  :0x00000200
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Patch Version:0x00003ac0
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> controller version 0x02000200
>>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Downloading qca/htbtfw20.tlv
>>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Failed to send TLV segment (-110)
>>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Failed to download patch (-110)
>>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>>> BT power ON:0
>>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> command 0xfc00 tx timeout
>>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> Reading QCA version information failed (-110)
>>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>>> BT power ON:1
>>>> Apr 04 10:15:10 braindead.localdomain systemd[1]: 
>>>> systemd-rfkill.service: Deactivated successfully.
>>>> Apr 04 10:15:10 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=systemd-rfkill 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> command 0xfc00 tx timeout
>>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> Reading QCA version information failed (-110)
>>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: Retry 
>>>> BT power ON:2
>>>> Apr 04 10:15:13 braindead.localdomain bluetoothd[986]: Failed to set 
>>>> mode: Authentication Failed (0x05)
>>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> command 0xfc00 tx timeout
>>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: 
>>>> Reading QCA version information failed (-110)
>>>> Apr 04 10:15:15 braindead.localdomain chronyd[1065]: Selected source 
>>>> 204.17.205.8 (2.fedora.pool.ntp.org)
>>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Created slice 
>>>> background.slice - User Background Tasks Slice.
>>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Starting 
>>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files 
>>>> and Directories...
>>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Finished 
>>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files 
>>>> and Directories.
>>>> Apr 04 10:15:38 braindead.localdomain audit: BPF prog-id=86 op=LOAD
>>>> Apr 04 10:15:38 braindead.localdomain systemd[1]: Starting 
>>>> plocate-updatedb.service - Update the plocate database...
>>>> Apr 04 10:15:41 braindead.localdomain systemd[1687]: Started 
>>>> vte-spawn-21527424-cb2d-479f-af17-22251e2b37a0.scope - VTE child 
>>>> process 5144 launched by gnome-terminal-server process 4668.
>>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: 
>>>> plocate-updatedb.service: Deactivated successfully.
>>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: Finished 
>>>> plocate-updatedb.service - Update the plocate database.
>>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: 
>>>> plocate-updatedb.service: Consumed 6.802s CPU time.
>>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_START pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=plocate-updatedb 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_STOP pid=1 
>>>> uid=0 auid=4294967295 ses=4294967295 
>>>> subj=system_u:system_r:init_t:s0 msg='unit=plocate-updatedb 
>>>> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
>>>> terminal=? res=success'
>>>> Apr 04 10:15:54 braindead.localdomain audit: BPF prog-id=86 op=UNLOAD
>>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>>> kf.idletime: Could not find any system poller plugin
>>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
>>>> KIdleTime): invalid nullptr parameter
>>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
>>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
>>>> KIdleTime): invalid nullptr parameter
>>>>
>>>> There's a bunch of errors in those logs starting with these two 
>>>> seemingly important lines:
>>>>
>>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Failed to send TLV segment (-110)
>>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
>>>> Failed to download patch (-110)
>>>
>>> Logs are mostly unchanges when restarting the bluetooth service after 
>>> a cold boot with the bluetooth originally working.
>>>
>>>> FWIW, I get similar logs after logging into KDE Plasma. I also get 
>>>> similar logs after a warm boot.
>>>>
>>>> This appears to be some kind of bug in the initialization of the 
>>>> hardware. Is there any additional information I can provide to help 
>>>> troubleshoot this problem.
>>>
>>> I will also say that the bluetooth appears to work throught a 
>>> suspend/resume cycle as long as I don't restart the bluetooth service.
>>>
>>> Oh, and my laptop is a Dell 9310 if that helps.
>>
>> Kalle, I noticed that you reported having a Dell 9310 in 2021 in a 
>> message on this very mailing list. Do you happen to still have that 
>> laptop? If so, so you still test on that laptop at all? I am curious 
>> if it is having the same issue I am experiencing?
>>
>>> Is there any other info I could collect that might be useful?
>>>
>>> I'm pretty new to troubleshooting a problem like this and would be 
>>> happy to have any advice anyone might want to share.
>>>
>>> Thanks,
>>> wt
>>>
>>
> 

-- 
You're more amazing than you think!
