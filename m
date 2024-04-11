Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284E1B806
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867409; cv=none; b=jjDTSrqJCqKmFdMS5M0/vR0NrMLpBvv/V/qzD9ImIPvQC3E+23ptTH9DmTjIS1vOVagHU6qZiM+qzAcmwRCzs8bdL0VU3uQHa+Ybp9Eh/fPDv8+HB3IJeLxOqZgN8GC+prGU3e4YDkDklDh8G3rRSqc3MKc+Ac4DBUsRr1VCKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867409; c=relaxed/simple;
	bh=Bm3PaRE9UvcSGg7iC+afgXm5Nt3YUbj+q5Z0r64GDds=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=da0mkC2ZfvEzVL8vnVK1EiPxdwNf0FJuFCqADn90Q1WmAsD1zhp2W4kQbuj39AgfH0I+iyVInzLe3hi5J/bKmdZ4wcsH4casW3OZvxgDlWomL01WxK1YpgRvwVXmD5f07CH0XuHA60ZvKrougHVb3x7AOgivQZj7MLj8YqMtUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=kbDEUXds; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="kbDEUXds"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ece8991654so270464b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712867407; x=1713472207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kant6ExXxMhn1K+TXO6ZqixqBe/nxHRJd4hsjbsMF8Q=;
        b=kbDEUXdsxViovbOkXmnyKK1n65onNvVJyxwBmEMNftkDK9TKWnq9NabNqWFU51PCss
         3U+H4zACeSmP+EpFv9gTCua5JEkn5ewq4eTVnEETzblTFLWrs/c0a8e76CiBcTgQ3g4+
         XGOd49Cma36cs8UD5+7TPymyiv2wTMBTetIzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867407; x=1713472207;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kant6ExXxMhn1K+TXO6ZqixqBe/nxHRJd4hsjbsMF8Q=;
        b=SctCrx8C0T3PYDAToDvpbn6AQg4Kn93s1QObrLCb/SYBX+ti/lNOjnEj1JoWMYbzmD
         E9nnD6EDwULuitUe8XfLVKIaZ1H0GjnRjYbTCkOO+MRYKD39N3fi7KDA1UyT9zwkqwr6
         KAVrv4G6mM1JaXNNWxCUqUQvYg78vlGMxonSx056RnZgKoaFuW3EszI2fwgjR3D/sZso
         aCCiqyhQlWBqzgRDqWfqTT+0XrUZz/7lP1M03NvUsvFJ7Jq61/2P57SrMDdWVKgFEMX1
         Y7s+fyMXw/r2oUtSSHsmPwnfgNIBlEZ6bh9bMss/3pKa+OS4n2u80vp9Rol7359Nurtp
         KB7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGmHzRYYTf7glhdPQL1fKNEyMn35giMLHrCcKtC7AaX9gyMtT7slU1YEeOec76xM85Q1lupZPeGwFeDufYeh3FBpiadOtKwIG7xKNTS30Y
X-Gm-Message-State: AOJu0YySuPIl+Z6mKPy+48qbIwtrAOS5IQdbZXziaYXyuwo6OQr78Hjj
	6eCfRNXWIi5smL6iR5rmsEZGIJAnjrkqtRVqCWsJPuwrjcMT46RzkZYrkwn6Vg==
X-Google-Smtp-Source: AGHT+IH1rikuhNj0OquZ0S4r6mxoySZdUb7e8LauZUYkkEk1Nvrw/QkINkPPRL6SyC28CWMObjni5A==
X-Received: by 2002:a05:6a21:3993:b0:1a7:a1e6:70cb with SMTP id ad19-20020a056a21399300b001a7a1e670cbmr1324093pzc.8.1712867406535;
        Thu, 11 Apr 2024 13:30:06 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001e29c4b7bd2sm1571747plg.240.2024.04.11.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:30:06 -0700 (PDT)
Message-ID: <f7a24b54-9a1f-41f4-8706-d7199a4a84e8@penguintechs.org>
Date: Thu, 11 Apr 2024 13:30:04 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
 <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
 <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
 <fca46585-c1ed-4a60-91b5-6da39a5bbdec@penguintechs.org>
 <02400664-2d23-42d3-b49b-0c59f606d298@penguintechs.org>
 <8162d6c7-d968-465e-bb8f-3c939eb8d783@penguintechs.org>
Content-Language: en-US
In-Reply-To: <8162d6c7-d968-465e-bb8f-3c939eb8d783@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 3:40 PM, Wren Turkal wrote:
> On 4/10/24 3:00 PM, Wren Turkal wrote:
>> +Johan since he's a former BT drivers maintainer.
>>
>> On 4/9/24 1:11 PM, Wren Turkal wrote:
>>> On 4/9/24 1:03 PM, Luiz Augusto von Dentz wrote:
>>>> 5.19 seems a little too old, imo, or has it been broken for that long,
>>>> did you at least tried with bluetooth-next? Try contacting the people
>>>> who actually wrote the driver.
>>>
>>> Sorry, I didn't answer your question. Yes, I do think it's been 
>>> broken for longer than that, but I wanted to confirm.
>>
>> Okay, so I tried 6.9-rc3 and every main release 5.19-6.8.
>>
>> I have found the following:
>>
>> * older kernels (6.3 and before) seem to be far less likely to kill on 
>> a cycling the bluetooth service.
>> * 6.8/6.9-rcs consistently destroy bluetooth when stopping and 
>> restarting the service
>> * If I destroy the bluetooth service with a BT service restart in 
>> 6.9-rc3 and warm reboot into any release back to 5.19, bluetooth does 
>> not work
>> * cold boot works in all cases assuming I give the laptop about 5s 
>> between power off/on
> 
> I just did another experiment on 6.9-rc3. I blacklisted relevant 
> bluetooth modules and then warm booted without the blacklist. I did this 
> for both the "bluetooth" and "btqca" modules. In both cases, I cold 
> booted with and appropriate "module_blacklist" kernel arg. After the 
> boot, I verified the module was not loaded. I then warm booted without 
> the blacklist, and the bluetooth works, so bluetooth only seems to fail 
> when the linux module code for closing the device is run before a warm 
> boot.

And another experiment. I disabled the bluetooth.service and 
bluetooth.target with systemctl. I then shutdown and cold booted. After 
logging into GNOME, starting the service. Similar failures show up in 
the kernel logs as after the failure during a warm boot:

Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Bluetooth 
management interface 1.22 initialized
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: 
src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv 
Monitors: Failed (0x03)
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Battery Provider 
Manager created
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: MGMT ver 1.22
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: 
src/device.c:device_set_wake_support() Unable to set wake_support 
without RPA resolution
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to clear 
UUIDs: Failed (0x03)
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:17:54 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:17:54 braindead.localdomain wireplumber[2139]: 
org.bluez.GattManager1.RegisterApplication() failed: 
GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Invalid method call
Apr 11 13:17:54 braindead.localdomain wireplumber[2139]: 
org.bluez.GattManager1.RegisterApplication() failed: 
GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Invalid method call
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: setting 
up ROME/QCA6390
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM TTY 
layer initialized
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM socket 
layer initialized
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: RFCOMM ver 1.11

... skip some logs about registering modules in the bluetoothd ...

Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Product ID   :0x00000010
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA SOC 
Version  :0x400a0200
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA ROM 
Version  :0x00000200
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA Patch 
Version:0x00003ac0
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
controller version 0x02000200
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Downloading qca/htbtfw20.tlv
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to send TLV segment (-110)
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to download patch (-110)
Apr 11 13:17:54 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:0
Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 11 13:17:57 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:1
Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 11 13:17:59 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:2
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to set 
mode: Authentication Failed (0x05)
Apr 11 13:18:01 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 11 13:18:01 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Too small Add 
Device complete event
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)
Apr 11 13:18:01 braindead.localdomain bluetoothd[4408]: Failed to add 
UUID: Failed (0x03)

It looks like the firmware is failing to load. Is there some kind of 
time limit on loading the firmware after the module is loaded?

Why would this work if I allow the service to be started on boot, but 
not if I wait until after logging into GNOME?

>> So, I suspsect that the process of closing out the hardware may be 
>> leaving it in a state that the reset cannot handle (and probably never 
>> could handle).
>>
>> I also found that qualcomm has docs here: 
>> https://www.qualcomm.com/products/technology/wi-fi/fastconnect/fastconnect-6800#Documentation
>>
>> However, I am not a member of a Qualcomm verified company (mentioned 
>> in the doc links). Luiz, Marcel, or Johan, do you have any contacts 
>> that might be able to help me in getting info about the technical docs 
>> for this hardware? I would love to see if I can find any issues in how 
>> the hardware is being reset.
>>
>> As an independent dev, I don't even know what it takes to get that 
>> kind of access. I would welcome any help here. Hey Qualcomm, are you 
>> hiring? :P
>>
>> wt
> 

-- 
You're more amazing than you think!
