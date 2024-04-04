Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45113340F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258090; cv=none; b=RL9bvIrDngeBRTt2rYJIZcvn9/+WnRbGqsi22vPAgDNQbIVP06iTEWrESJN9/vJ0uaX+Aes1YoOWGR3kjXP+x2v6eV8E/zjlW7/SHH9vAkTB5vthkscmC+Lt+/HrgP8TkF+yUjBqaiNqyazKSqti+apkbT1o9m9zRjVpxewVKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258090; c=relaxed/simple;
	bh=5InxRozM7qCCoL7A3GDYW1R5umdr5Kooq8ghTbTRdbk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=pq0s6zsyzp4oYeiZ6jluJkzKBTQg7C40zQFIOR5OX2vjsq7xhFTri3i/r3T/y2rBrj+m3P0/HQ8KULleZ/PXXBKYeRJ0d5cyFsbYHehBsMJ2DTorAApLhdk3dQO55Vm8cXgpG/9tTU1ZheERXMCT3YIoojeSPgTc5MmUffOVOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=GD8/3lUX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="GD8/3lUX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so1036284b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712258087; x=1712862887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbF66O3k0UzwHeaOhaqXqequZ9uqXlexXgMorz4+oEA=;
        b=GD8/3lUX6dzo+clygpz05TsR1cmKooY8xfDWNJr6v+H+RFD/jP3yhNTih3+Qzmycfu
         Iw/CTkzEXXBNVmnHyr1Rs7hdAk0Bz4AnrX/7HP5kmKhtIsZd9CeXIqvDKcIMi5AUDdzQ
         SSBpBKIGRGm1AlLyjfd9eR/c1joZGW84I1JM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258087; x=1712862887;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbF66O3k0UzwHeaOhaqXqequZ9uqXlexXgMorz4+oEA=;
        b=UBxg1d44927Pxl25hqZGZX5edIm9GwnJ9W0sv0GnxlOqRr22yemjbeUNeT8Qt1hxr4
         xe2YSnygoMDXeelTM/nRD7Qdd60srbbr2/aR4Gog8ISV8MGdlo5NUNrGxbXcvcLg0oIe
         sM9CkAcJcVeKXlF3RP7+szA3OmPlRuJ5jEsrzbkLj02mM2J+UmP3hrXTRCameZseR5gu
         dyjGmDAYjAryAoHJpfvq2S+WGCUK4/1EADfmCKhYrEWFQxXuVCtJecIGTWRNYgzRXNnZ
         2EdyWXAmIX2bnyOxO+/Z6qGhw9HORiRJ9hOJvapYGnI9DGkZhQ7+vBgZJnszDJEftOVc
         MNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPi7ocKevH/Y2vPb9dy+SbaMQoyhL5XkfeoGKq8doYFrHTT0gG4YdQQzxQBb7trYdmqHg/9XrGDl188blvW1ZZmXpW4hf6EbOgRuqwNh7w
X-Gm-Message-State: AOJu0Yys52kDDCLBWa0yDcOuZ5/N63BY2SJYiMdXXcdNvl8kZZI/WiaX
	qTiOxgKTyzm/1p4TTCdJ5aDI8xeuQmWc9EwsmQiwEAt6VMQhYRuS9NP6MKqzKaCUhvPnewWOoyw
	n5w==
X-Google-Smtp-Source: AGHT+IFi2InwVa+XHVz4khnYhN6vTZ6qQQwqC3hjG+kfowtmt1zKweI+IMp70LOgUj7+iTGvDnxvGg==
X-Received: by 2002:a05:6a00:4614:b0:6ea:2501:d607 with SMTP id ko20-20020a056a00461400b006ea2501d607mr638178pfb.0.1712258087343;
        Thu, 04 Apr 2024 12:14:47 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79850000000b006e64ddfa71asm14385974pfq.170.2024.04.04.12.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:14:46 -0700 (PDT)
Message-ID: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
Date: Thu, 4 Apr 2024 12:14:46 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: QCA6390 bluetooth doesn't work after warm boot or disable/reenable
To: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey there ath11k/bluetooth folks,

I am having a pretty major problem with QCA6930 for some time (maybe a 
year or two). I have this bluetooth device:

72:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc QCA6390 
Wireless Network Adapter

This device appears to be driven by the ath11k module and others. I hope 
I am pinging the right lists.

I am using Fedora Rawhide. Fully updated yesterday. My uname reports this:

Linux braindead.localdomain 
6.9.0-0.rc2.20240402git026e680b0a08.24.fc41.x86_64 #1 SMP 
PREEMPT_DYNAMIC Tue Apr  2 17:51:18 UTC 2024 x86_64 GNU/Linux

My main bluetooth device is  a Logitech MX 3 Mac mouse that uses 
bluetooth. When bluetooth fails, so does the mouse. I have power cycle 
my laptop when that happens. I'd love to help find a fix for this.

The problem is that I cannot disable and re-enable the bluetooth on my 
system. Bluetooth also doesn't work after a warm boot. I have to power 
cycle my laptop to recover bluetooth funcitonality. I have tried the 
following:

* logging into KDE Plasma (bluetooth stops working)
* logging into GNOME (works on cold boot, fails on warm boot)

After logging into GNOME during a cold boot, I have also done "systemctl 
restart bluetooth.service". I get these journal logs during the stop;

➜  bt_kernel_bug cat journal-stop-bluetooth-service.log
Apr 04 10:14:41 braindead.localdomain NetworkManager[1120]: <info> 
[1712250881.7060] device (F0:5C:77:F2:60:FC): state change: disconnected 
-> unmanaged (reason 'removed', sys-iface-state: 'removed')
Apr 04 10:14:41 braindead.localdomain systemd[1]: Starting 
systemd-rfkill.service - Load/Save RF Kill Switch Status...
Apr 04 10:14:41 braindead.localdomain systemd[1]: Started 
systemd-rfkill.service - Load/Save RF Kill Switch Status.
Apr 04 10:14:41 braindead.localdomain audit[1]: SERVICE_START pid=1 
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Apr 04 10:14:46 braindead.localdomain systemd[1]: 
systemd-rfkill.service: Deactivated successfully.
Apr 04 10:14:46 braindead.localdomain audit[1]: SERVICE_STOP pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'

I get these journal logs during start:

Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: setting 
up ROME/QCA6390
Apr 04 10:15:05 braindead.localdomain systemd[1]: Starting 
systemd-rfkill.service - Load/Save RF Kill Switch Status...
Apr 04 10:15:05 braindead.localdomain systemd[1]: Started 
systemd-rfkill.service - Load/Save RF Kill Switch Status.
Apr 04 10:15:05 braindead.localdomain audit[1]: SERVICE_START pid=1 
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Product ID   :0x00000010
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA SOC 
Version  :0x400a0200
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA ROM 
Version  :0x00000200
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA Patch 
Version:0x00003ac0
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
controller version 0x02000200
Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Downloading qca/htbtfw20.tlv
Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to send TLV segment (-110)
Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to download patch (-110)
Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:0
Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:1
Apr 04 10:15:10 braindead.localdomain systemd[1]: 
systemd-rfkill.service: Deactivated successfully.
Apr 04 10:15:10 braindead.localdomain audit[1]: SERVICE_STOP pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:2
Apr 04 10:15:13 braindead.localdomain bluetoothd[986]: Failed to set 
mode: Authentication Failed (0x05)
Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
Apr 04 10:15:15 braindead.localdomain chronyd[1065]: Selected source 
204.17.205.8 (2.fedora.pool.ntp.org)
Apr 04 10:15:22 braindead.localdomain systemd[1687]: Created slice 
background.slice - User Background Tasks Slice.
Apr 04 10:15:22 braindead.localdomain systemd[1687]: Starting 
systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files and 
Directories...
Apr 04 10:15:22 braindead.localdomain systemd[1687]: Finished 
systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files and 
Directories.
Apr 04 10:15:38 braindead.localdomain audit: BPF prog-id=86 op=LOAD
Apr 04 10:15:38 braindead.localdomain systemd[1]: Starting 
plocate-updatedb.service - Update the plocate database...
Apr 04 10:15:41 braindead.localdomain systemd[1687]: Started 
vte-spawn-21527424-cb2d-479f-af17-22251e2b37a0.scope - VTE child process 
5144 launched by gnome-terminal-server process 4668.
Apr 04 10:15:53 braindead.localdomain systemd[1]: 
plocate-updatedb.service: Deactivated successfully.
Apr 04 10:15:53 braindead.localdomain systemd[1]: Finished 
plocate-updatedb.service - Update the plocate database.
Apr 04 10:15:53 braindead.localdomain systemd[1]: 
plocate-updatedb.service: Consumed 6.802s CPU time.
Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_START pid=1 
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=plocate-updatedb comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_STOP pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=plocate-updatedb comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Apr 04 10:15:54 braindead.localdomain audit: BPF prog-id=86 op=UNLOAD
Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
kf.idletime: Could not find any system poller plugin
Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
KIdleTime): invalid nullptr parameter
Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]: 
qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller, 
KIdleTime): invalid nullptr parameter

There's a bunch of errors in those logs starting with these two 
seemingly important lines:

Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to send TLV segment (-110)
Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to download patch (-110)

FWIW, I get similar logs after logging into KDE Plasma. I also get 
similar logs after a warm boot.

This appears to be some kind of bug in the initialization of the 
hardware. Is there any additional information I can provide to help 
troubleshoot this problem.

wt
-- 
You're more amazing than you think!
