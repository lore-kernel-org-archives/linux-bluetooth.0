Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319C1DDD6
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605797; cv=none; b=UPxMoYuCpNBEDEQ0FH2V2+ymb8PJCxRMG49YMUJcWcpQ4NT0M+tgcWsATAyWOKJAhrHyfUFBiS9OgLM5fcmlgWkDHZgeLD3JSlzlciPqUCgMLpNKE4aWbDuyPoBB1jxnGi+EVYKbc97Bwncwva80xcuF2JfwVdgpE8ZrlQ34eQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605797; c=relaxed/simple;
	bh=kgNm355uHtJAbGgMSVlUYAJhGXudvhE6+R81hQqFrp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bV6Ht5ypDl0TvdgDowJtd20h7VlhB2ksgLys0BlAF6IoEVPSMk/+3LeBQUxxSdf+9n8jfJlL0CtzPbN1wxrxG9iCmgpFDRlqkrB15yZJ28va2sese9kTVRDLvpxap/fr5VhEQQr5UwmQU9a3ynP01MGUlAYuWremreUpVSynsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=bsiN+6Xx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="bsiN+6Xx"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so1244793b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712605794; x=1713210594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ABkw0n+kT0MUIyt8vFQsVmH5MKBmnK69dGxayslQsI=;
        b=bsiN+6Xx7RLZxAnhAhEM1CRCGLLzljpFu5sZYWpvJazk7jiPUz7HMwIpeKNm7rctin
         yWfnXrxERibQJS51aTwHC/h3Vz6UtfKMv4hKu3raW4Jc4mRdyGE3d5qBeS3bDtvRhu+7
         st23oshjqZDLkjsSUmObC9z28+DU51N4SZNnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605794; x=1713210594;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ABkw0n+kT0MUIyt8vFQsVmH5MKBmnK69dGxayslQsI=;
        b=PbpbkvNgkierwYVNA0ubXQgNqJloXKKqnuHVGYRqNxPldR5RfdhGaOSzWyqLMP5zuG
         +ptZrE62mTji92fmdXprgQQ/2LQeMAKBxbFTKYsFdfwlYY0om+JC+5YOXhZpK++5Rz8A
         7rDwv5g0FAe+rSF5p2nGG7WEK85LXenattn9oJudRSDMrENlol/M67dIYiDa3ZAXwuJj
         dXEUHbFeUK6nQvfC3edsMeJMZfvfHoeDFeEpHJoXhHQT0KdLLWRZzJjAKO0yMlZeG7L8
         IYLzwyMSWnJwFXvuSRaOfKK+BVOpBjCMywnfatJa+O78hiLHehWrn/l5NICaMJdmduD/
         RDUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCoUvF3ukvnZunlVJ+Y/iQ9OhU50oQl7Pvfn6yPA6XJRIdGpTwXxGnPUoJw+xuFLL92So/Hrc3yvQ+KXJ5p0iUl14mQuxJAkYzvkSRqMnW
X-Gm-Message-State: AOJu0YxPdPwMjieGP1PCqWYJe7YYqpWBRtdmJ8sDQJRpSnHadn2FzYuH
	+KIFXNxWXusEWq4VnjFn4fgnSRAsSrRohI1V4oI0lO6SVNosEhd74rutgLc8RQ==
X-Google-Smtp-Source: AGHT+IE/FKbIpteF5IIBqtHUuyhiLNvy1EUBvQu8lE5mUTzamtt6rRH0Y/H5IDfyS1mxxOWmYBz6gg==
X-Received: by 2002:aa7:8893:0:b0:6e5:faca:3683 with SMTP id z19-20020aa78893000000b006e5faca3683mr12094916pfe.26.1712605792189;
        Mon, 08 Apr 2024 12:49:52 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79e46000000b006ed059cdf02sm5989195pfq.116.2024.04.08.12.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:49:51 -0700 (PDT)
Message-ID: <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
Date: Mon, 8 Apr 2024 12:49:50 -0700
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
 Kalle Valo <kvalo@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
In-Reply-To: <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Marcel Holtmann <marcel@holtmann.org>
+Luiz Augusto von Dentz <luiz.dentz@gmail.com>

Added maintainers identified from the get_maintainer.pl script in the 
kernel repo. Hoping to get some ideas for next steps.

More contextual info below:

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

I looked at the current mainline kernel code. I found the following.

I found that there was a patch authored by Zijun Hu that was supposed to 
address a warm reboot issue on QCA6390 here: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/hci_qca.c?h=v6.9-rc3&id=7e7bbddd029b644f00f0ffbfbc485ed71977d0d5

The same code path from the above patch is now slightly different 
because another patch authored by Krzysztof Kozlowski, namely: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/hci_qca.c?h=v6.9-rc3&id=272970be3dabd24cbe50e393ffee8f04aec3b9a8

I also see a few fixed over time in the btqca.c file. I wonder if any of 
these are related.

Unfortunately, none of these changes were made recently.

Does anyone have an suggestions for next steps?

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
