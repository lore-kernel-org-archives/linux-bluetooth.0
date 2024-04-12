Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8A446BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951201; cv=none; b=KHd0M6HZuN+xP0BNqmrJZdio4kdr3KE0NcD9QS2lbbnaySv2beGEf5MNQ7aOCRuHnVN7/koMrl8+XLy0mXGhME1bdX+vtivPlNb7I0GuzEqYHjVoEWQtDGsXWgYEwP7EiSEcE7CE8vVzYj2JPq0dINDC+KXPVHN/9A2h5rG+o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951201; c=relaxed/simple;
	bh=0I2rRKsT/RFHSAdjLYb2DHvfPf2tKg7t+bJ6JNTkmyM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QmoRzXTc3kklZZ7HDgcotPJGl0xZZA0NprORbyeqPL3gG7ptJnGuk7nJ0/ydkHBEfbKV0pBxVyrlLrD9IVroT/52Mwqf7wM8pCkuR62lrsV75PkQY7R32NNxbTftdZaPSS9to48OFMlBAOVO1LJitxQDa30fu/TYxKtfpEHbHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=hr4NcTIj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="hr4NcTIj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1161709b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712951199; x=1713555999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M8qp/N2JinKkkNqm1DqAk69/KqQp+0SDzwBkriIPK1g=;
        b=hr4NcTIj3eFpM6SF1uwdD3JlOCXE9vouYMR7bz1fR6uTEk+OmD/wKZ0me1UDYOWvOX
         jv9EUTfiNzbB8E+Lc9dVaQe8UZOHPgMqCLdMCFQ3trf/xwbxQErt5KCJC5JseK6GlMMB
         iq1ux2ndVKsaiLkCUmWM2tkecutFBrMIWBFDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951199; x=1713555999;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8qp/N2JinKkkNqm1DqAk69/KqQp+0SDzwBkriIPK1g=;
        b=Xy+FiwCgi+nm/I677BqSwI5J6b4sN70gW1sLJ168jRs1LP/EMAKTsi8FhM/KQokd3W
         Qxtseh29qtUfjwsoXNqnIgcU4ERalmLFjIuYHdaDB2UTa/ifeczQBaOzAlwD6vGlBJ6A
         CtSHxQtXEyAo3KYJneO/lJZTl4UuH2cPoYvHHXyFkwOqoA35A3pTwnVPfHhhtvlAulBu
         bIJrtk8Vr1xRpwGoVWcdhbotDxytdN24wcz2zKbt1tZZK5mKzJSy4CXITQ+vBSh5Ag04
         XGXCnQw6yShijztbPBxWspV78UaFCLVmxDjOu31lQm4frSwpgJjEBBgpDp9559hAHQLf
         43Yg==
X-Forwarded-Encrypted: i=1; AJvYcCViZr7dKd/shTOKpBTWz3/YcXWjL3AOH/9kB7tFLeQtPBdS/7awpHaWKP+9YMsApkk/0iuZGPW7+wPwkiBEiMamCmm4g+gobqozuv6OWwfy
X-Gm-Message-State: AOJu0YyrIuH/H1uvnKHpO+rv966KnF6QWm3M2Jq22enT2yqGI6Hul/Gl
	nVLsKF63ygvF6e88VobR+ODrLobQx51sdykWQhpBuPBK8HmnW1nx+evJD+Fruw==
X-Google-Smtp-Source: AGHT+IHyRhpoQB/O9/JUOzCEbz0879nJPLeW3KrYxpjdrpG+iz0ZbDVyB2LgWENUAnmtTSs1TOZcOQ==
X-Received: by 2002:a17:903:185:b0:1e0:b87f:beb4 with SMTP id z5-20020a170903018500b001e0b87fbeb4mr4117712plg.30.1712951198725;
        Fri, 12 Apr 2024 12:46:38 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001dd69aca213sm3361881plt.270.2024.04.12.12.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:46:37 -0700 (PDT)
Message-ID: <b999d783-4912-471e-a978-6c7f0cbcd1e6@penguintechs.org>
Date: Fri, 12 Apr 2024 12:46:36 -0700
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
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
 <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
 <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
 <fca46585-c1ed-4a60-91b5-6da39a5bbdec@penguintechs.org>
 <02400664-2d23-42d3-b49b-0c59f606d298@penguintechs.org>
 <8162d6c7-d968-465e-bb8f-3c939eb8d783@penguintechs.org>
 <f7a24b54-9a1f-41f4-8706-d7199a4a84e8@penguintechs.org>
Content-Language: en-US
In-Reply-To: <f7a24b54-9a1f-41f4-8706-d7199a4a84e8@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/24 1:30 PM, Wren Turkal wrote:
> On 4/10/24 3:40 PM, Wren Turkal wrote:
>> On 4/10/24 3:00 PM, Wren Turkal wrote:
>>> +Johan since he's a former BT drivers maintainer.
>>>
>>> On 4/9/24 1:11 PM, Wren Turkal wrote:
>>>> On 4/9/24 1:03 PM, Luiz Augusto von Dentz wrote:
>>>>> 5.19 seems a little too old, imo, or has it been broken for that long,
>>>>> did you at least tried with bluetooth-next? Try contacting the people
>>>>> who actually wrote the driver.
>>>>
>>>> Sorry, I didn't answer your question. Yes, I do think it's been 
>>>> broken for longer than that, but I wanted to confirm.
>>>
>>> Okay, so I tried 6.9-rc3 and every main release 5.19-6.8.
>>>
>>> I have found the following:
>>>
>>> * older kernels (6.3 and before) seem to be far less likely to kill 
>>> on a cycling the bluetooth service.
>>> * 6.8/6.9-rcs consistently destroy bluetooth when stopping and 
>>> restarting the service
>>> * If I destroy the bluetooth service with a BT service restart in 
>>> 6.9-rc3 and warm reboot into any release back to 5.19, bluetooth does 
>>> not work
>>> * cold boot works in all cases assuming I give the laptop about 5s 
>>> between power off/on
>>
>> I just did another experiment on 6.9-rc3. I blacklisted relevant 
>> bluetooth modules and then warm booted without the blacklist. I did 
>> this for both the "bluetooth" and "btqca" modules. In both cases, I 
>> cold booted with and appropriate "module_blacklist" kernel arg. After 
>> the boot, I verified the module was not loaded. I then warm booted 
>> without the blacklist, and the bluetooth works, so bluetooth only 
>> seems to fail when the linux module code for closing the device is run 
>> before a warm boot.
> 
> And another experiment. I disabled the bluetooth.service and 
> bluetooth.target with systemctl. I then shutdown and cold booted. After 
> logging into GNOME, starting the service. Similar failures show up in 
> the kernel logs as after the failure during a warm boot:
> 
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Bluetooth 
> management interface 1.22 initialized
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: 
> src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv 
> Monitors: Failed (0x03)
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Battery Provider 
> Manager created
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: MGMT ver 1.22
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: 
> src/device.c:device_set_wake_support() Unable to set wake_support 
> without RPA resolution
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to clear 
> UUIDs: Failed (0x03)
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:17:54 braindead.localdomain wireplumber[2139]: 
> org.bluez.GattManager1.RegisterApplication() failed: 
> GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Invalid method call
> Apr 11 13:17:54 braindead.localdomain wireplumber[2139]: 
> org.bluez.GattManager1.RegisterApplication() failed: 
> GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Invalid method call
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: setting 
> up ROME/QCA6390
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM TTY 
> layer initialized
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM socket 
> layer initialized
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM ver 1.11
> 
> ... skip some logs about registering modules in the bluetoothd ...
> 
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
> Product ID   :0x00000010
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA SOC 
> Version  :0x400a0200
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA ROM 
> Version  :0x00000200
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA Patch 
> Version:0x00003ac0
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
> controller version 0x02000200
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
> Downloading qca/htbtfw20.tlv
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
> Failed to send TLV segment (-110)
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
> Failed to download patch (-110)
> Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
> power ON:0
> Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: command 
> 0xfc00 tx timeout
> Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: Reading 
> QCA version information failed (-110)
> Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
> power ON:1
> Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: command 
> 0xfc00 tx timeout
> Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: Reading 
> QCA version information failed (-110)
> Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
> power ON:2
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to set 
> mode: Authentication Failed (0x05)
> Apr 11 13:18:01 braindead.localdomain kernel: Bluetooth: hci0: command 
> 0xfc00 tx timeout
> Apr 11 13:18:01 braindead.localdomain kernel: Bluetooth: hci0: Reading 
> QCA version information failed (-110)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Too small Add 
> Device complete event
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)
> Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
> UUID: Failed (0x03)

I have captured a full log of my system since boot including debug 
messages for the hci_hca.c file. Should I attach that log to a message 
here? In general, I am not totally certain of how I should track the 
troubleshooting for this problem. Do y'all want it on the mailing list?

> 
> It looks like the firmware is failing to load. Is there some kind of 
> time limit on loading the firmware after the module is loaded?
> 
> Why would this work if I allow the service to be started on boot, but 
> not if I wait until after logging into GNOME?
> 
>>> So, I suspsect that the process of closing out the hardware may be 
>>> leaving it in a state that the reset cannot handle (and probably 
>>> never could handle).
>>>
>>> I also found that qualcomm has docs here: 
>>> https://www.qualcomm.com/products/technology/wi-fi/fastconnect/fastconnect-6800#Documentation
>>>
>>> However, I am not a member of a Qualcomm verified company (mentioned 
>>> in the doc links). Luiz, Marcel, or Johan, do you have any contacts 
>>> that might be able to help me in getting info about the technical 
>>> docs for this hardware? I would love to see if I can find any issues 
>>> in how the hardware is being reset.
>>>
>>> As an independent dev, I don't even know what it takes to get that 
>>> kind of access. I would welcome any help here. Hey Qualcomm, are you 
>>> hiring? :P
>>>
>>> wt
>>
> 

-- 
You're more amazing than you think!
