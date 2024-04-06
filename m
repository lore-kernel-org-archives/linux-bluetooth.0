Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FC1FDD
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712436660; cv=none; b=ifTnhB8klKmWz34b45vofhuPtcr0SfaITTE3Jbma8RF2KIR64arlGO2KW77IMydgGmd1BXgN1dfnXIQhKXfp2dyk4hSH1be1sM7INMtTaRWj/BhfBfro1SkdgSfG41YX+Un6hbxbWlLVhMByXn/BZJO+LW1aQKA5bIbO4wkVmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712436660; c=relaxed/simple;
	bh=c2fWp/iF3PaB5Qn0+YMkAshIHswOqlCh0s/qE0GzHvE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Y7jGhLmOllTyr3VBhLmqw5qZJqNt01UUFPdfzQVO4+t60xzQvfpN3+dRDIqkr4pLIuFiUiQuu25DCTJ2Jk5qqZwT+XpcThA2qg6O9Lgfk4BaT1UjeXRileYtzTVoTvDw1k+KtAUWFGIW/eRhtV9rfQwurLqDKxEwaFFx2yQ8LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=PVQGQuU2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="PVQGQuU2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so967197a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Apr 2024 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712436657; x=1713041457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwcLv+IoUPZ+WLmS6saJqvPRqplpWnxkGgPT2zfuETA=;
        b=PVQGQuU2LktVB9kZH73JjqX1f5odpuNZ8yO4NAZcxAlgnLClCVRt0YuaGMfJLBlEuK
         csKXf+JRhEBeGMQ73zkxoDgjjROeet4InRt6WhskSSdA8+vxw1is03btCzI1NLkypdOd
         Ll/vEFkkBBAVTsWG0nj+0iFT1S61vCXL+x1/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712436657; x=1713041457;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwcLv+IoUPZ+WLmS6saJqvPRqplpWnxkGgPT2zfuETA=;
        b=mg2BAcmaVoRMdjXHTExjdgp/ujaYqx/qFgJOSm34/RqNI+ecaUumkByinVAdOGdEyY
         eQFFYXMDX1gzf7IZv+PAYyYpEQRHJsdp/4XOsDkMcdf5xWJMDaprGw5/wHrCgYr96Ksc
         ka1NqcGSqUpNUmIGQgVxAiHZIAJZXzTxcX5QxWPFQFeTK2SMCy2jqHjcfhQqlfVV4al5
         U0TDS4sVY2aYABXZgyfg6ykNKDZL85BSSQiWPKuOGXYyYrrNOnw8jRJl29y6QGBG0qkt
         VJ1N0wHqGVSndH/n1MHjpNLBapavAxthVKdw3fUO3dmAE2rsVf19f+RbgBde7eHQPuDg
         I8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVhS3RbX8+wIC2EnsEtHHMOl4p9zFoc03MslitW7Epd1ltkgPUBHLhjUSA5lJA7KSEGdx6vTSbOID//Pgegu9MbCrNZ5fLIU9C+5/C3DmXb
X-Gm-Message-State: AOJu0Yw9BW8ZjD3LJt1m/+tNdquuNNq6NvaCfBlPCLojatb67Z9R/lW5
	zHE2GcMSzPFiz92go76EBaMizOwQstahK4N0HenA9hOX9WIthmDwoAbHluuI9A==
X-Google-Smtp-Source: AGHT+IHAjqnm/E14vScRpdXFO0XJsAynw8VjOBnh8YAJUwN7kAz3sko1Pz8YcauDgoD8sGaZOAf8uA==
X-Received: by 2002:a17:902:bd43:b0:1e2:61c9:85de with SMTP id b3-20020a170902bd4300b001e261c985demr4795927plx.4.1712436657411;
        Sat, 06 Apr 2024 13:50:57 -0700 (PDT)
Received: from [172.16.102.235] (c-98-45-34-39.hsd1.ca.comcast.net. [98.45.34.39])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ae28600b002a0187d84f0sm3593602pjz.20.2024.04.06.13.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 13:50:56 -0700 (PDT)
Message-ID: <64cfac06-d9d8-4a69-9bd7-3a38fe03b5d8@penguintechs.org>
Date: Sat, 6 Apr 2024 13:50:55 -0700
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
 <43820685-4960-4801-bd5d-f1b5e41ec033@penguintechs.org>
In-Reply-To: <43820685-4960-4801-bd5d-f1b5e41ec033@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/6/24 1:29 PM, Wren Turkal wrote:
> +Ben Young Tae Kim, current maintainer of btqca
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

I narrowed down how to cause the bad logs a bit, if I do the following:

1. stop the bluetooth service
2. unload the hci_uart and btqca modules
3. restart the bluetooth service
4. reload those modules

I get these log messages:

Apr 06 13:42:43 braindead.localdomain sudo[11047]:       wt : TTY=pts/0 
; PWD=/home/wt ; USER=root ; COMMAND=/usr/sbin/modprobe hci_uart
Apr 06 13:42:43 braindead.localdomain audit[11047]: USER_CMD pid=11047 
uid=1000 auid=1000 ses=3 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
msg='cwd="/home/wt" cmd=6D>
Apr 06 13:42:43 braindead.localdomain audit[11047]: CRED_REFR pid=11047 
uid=1000 auid=1000 ses=3 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
msg='op=PAM:setcred grant>
Apr 06 13:42:43 braindead.localdomain sudo[11047]: 
pam_unix(sudo:session): session opened for user root(uid=0) by wt(uid=1000)
Apr 06 13:42:43 braindead.localdomain audit[11047]: USER_START pid=11047 
uid=1000 auid=1000 ses=3 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
msg='op=PAM:session_open>
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART driver 
ver 2.3
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol H4 registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol BCSP registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol LL registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol ATH3K registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol Three-wire (H5) registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol Intel registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol Broadcom registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol QCA registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol AG6XX registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol Marvell registered
Apr 06 13:42:43 braindead.localdomain kernel: Bluetooth: hci0: setting 
up ROME/QCA6390
Apr 06 13:42:43 braindead.localdomain sudo[11047]: 
pam_unix(sudo:session): session closed for user root
Apr 06 13:42:43 braindead.localdomain audit[11047]: USER_END pid=11047 
uid=1000 auid=1000 ses=3 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
msg='op=PAM:session_close >
Apr 06 13:42:43 braindead.localdomain audit[11047]: CRED_DISP pid=11047 
uid=1000 auid=1000 ses=3 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
msg='op=PAM:setcred grant>
Apr 06 13:42:43 braindead.localdomain systemd[1666]: Reached target 
bluetooth.target - Bluetooth.
Apr 06 13:42:43 braindead.localdomain systemd[1]: Starting 
systemd-rfkill.service - Load/Save RF Kill Switch Status...
Apr 06 13:42:43 braindead.localdomain systemd[1]: Reached target 
bluetooth.target - Bluetooth Support.
Apr 06 13:42:43 braindead.localdomain systemd[1]: Started 
systemd-rfkill.service - Load/Save RF Kill Switch Status.
Apr 06 13:42:43 braindead.localdomain audit[1]: SERVICE_START pid=1 
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe>
Apr 06 13:42:45 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 06 13:42:45 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 06 13:42:45 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:0
Apr 06 13:42:48 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 06 13:42:48 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 06 13:42:48 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:1
Apr 06 13:42:48 braindead.localdomain systemd[1]: 
systemd-rfkill.service: Deactivated successfully.
Apr 06 13:42:48 braindead.localdomain audit[1]: SERVICE_STOP pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe=>

Do any of y'all see anything that helps?

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
