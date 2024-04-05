Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C612E5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295015; cv=none; b=kWgOYkGNxZFF/H+qWqclEUKCrsMpnURK8wa+rYao5YLOzgXYe2zZnDvGRp5So2FCqfkFkZi7d0e1f62YLvoeNv9Lq7ZH0OiHn+mbweHhDDApY+NYtrcgtHwZAx9+QT8chUTBv23Zc1IQA70PmZtbq67mtHu5HyCLHCqbgg3hKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295015; c=relaxed/simple;
	bh=zyFe5VhmGrKQnKl59ttF8ZJwwueyj+OOzr177dpEUC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=izCRgMdsDQL0eiTbTKm9EM3u0o2I3QTNgmlP3JmyKpLdZk802fonx4bbIQEjyPT05gng1YRJe/FJR9VyTVRFdbwvZxP2Mg1dpIl+eCrTaUl/5UcgabdVKHEBZBOUmMKMz0QncTP+URbcVE6CCLdrVLHuzcOx6pjAN1pdKQSTp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=MYjxU/wG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="MYjxU/wG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so683752b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712295012; x=1712899812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:to:references:reply-to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B4gKtTR2mIkkB6wOyXq930MVO/NM+M9GCBrLaZEr33c=;
        b=MYjxU/wGv7Vu0MnAavqupz5NVjss1nnrNsrkboI0AAj2TJn2/9WoQv9jbx+MSwuzPa
         L7XJOI3ua4NHoSaDPJor382yLlG8RkNmKK/FAIaaqLKlrwBIi1euDN6MxwH3VfEFB4rf
         fMRLEaFLOrPqNN2OsYij7TwaS1RNO5ndG+VyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295012; x=1712899812;
        h=content-transfer-encoding:in-reply-to:to:references:reply-to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4gKtTR2mIkkB6wOyXq930MVO/NM+M9GCBrLaZEr33c=;
        b=C87hyywhm1fBxlrOnC7kpwNygAtViA3/BCeTPrLzyWJH4umXSai7l/b+IJONfjdZ1E
         9ZcV7SV0iaJ7rBZWTZas2GU7cU66xPVGyIm5CG969oYP5O5pDR2WVX6hI+2Mnf0Hjlcv
         +nLScN/8HEpFEpB1Jm0FYDZiDY+GFcruov3qOs2YHBo5Zia9zFxNof1217hbtve/yICk
         0pQoGywWqUjJ9gwuZAH/5hSt01CnL0wpmj3k+odHhp0edoFoOwspwMB4zUace1JY68/U
         rE75Zv451pIjVGGbv6vZKKnbeCvyGwnHkLqpf/uStv4FUDBOiVtmq89b/53ZtBsEkRvl
         XMHA==
X-Gm-Message-State: AOJu0Yw2npaBs5LSXJFNqndu3elK58GQuTt82mLiD45fDpHrKKrKpn/t
	jinSy/wE3NoDzruL80G10dPDP+uAh/u0THXPVtdUCMrROXHP/sIoRotxbQwg7iR8LzTa9lfovqQ
	FtsqX
X-Google-Smtp-Source: AGHT+IFiU9+ukp5VZtMkRIMYuTZTzg6fOBZAfES881+y9QgBW00bsr0ToRfO9LJR6TZxRso/J1TI/A==
X-Received: by 2002:a05:6a00:93a8:b0:6e7:1ce6:a2f5 with SMTP id ka40-20020a056a0093a800b006e71ce6a2f5mr1993839pfb.17.1712295011985;
        Thu, 04 Apr 2024 22:30:11 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b006e664031f10sm617847pff.51.2024.04.04.22.30.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 22:30:11 -0700 (PDT)
Message-ID: <2007a602-fad6-41a4-b625-a3884812c1af@penguintechs.org>
Date: Thu, 4 Apr 2024 22:30:11 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: QCA6390 bluetooth doesn't work after warm boot or disable/reenable
Content-Language: en-US
Reply-To: Wren Turkal <wt@penguintechs.org>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
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
