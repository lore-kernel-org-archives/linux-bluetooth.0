Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5C43A7FD;
	Tue, 29 Sep 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695695; cv=none; b=tn7NehEpuwILnz8dAsNiEvOwawPIFhlx9deecxarR6yaETzpPA5rrWmSdG8fl+siXoK4XQj4gWvDXNN4xAs8UdAuNqFAKD/dS0VPmHjvvGhK4gnnuh4aBHehk+DHyrM0eMGI2N7KQvfRuFcxzYk0tgy7CFCNLO5dhZgLY8AeSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695695; c=relaxed/simple;
	bh=IfteVJzGd5Jx0NvpZzTQXpxRw4r2kGCGjFw22xelhyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYubxtWDxDnXTIwr5A2X5HDfu8Gvzwe3mY3glxDoJDQz8WMrgBGpWhZ0mLxBORrGgIeR+lWa5B/H84URblzU+0lGhGTCtWW9Y5MZ6dQiGtPhkXi3WpHty8/U50Dd0tlNmFQsEIbDtdHi5c0a/fSbGx92Z8QgZWbdK6+tDDC/lLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=knW68QnD; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="knW68QnD"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hvMWF1v7Mz4660;
	Tue, 29 Sep 2026 17:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790695673;
	bh=IfteVJzGd5Jx0NvpZzTQXpxRw4r2kGCGjFw22xelhyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knW68QnDc57ZnQNhV6SBnrhNd4jbUBNYPmjA8itoFQaWPEcVJKa0HBGm0MioIsEQ6
	 IzWTD67+OYliC+lh7uazlLJGuqP3DAsD4qvXjiGvrOVHJFDTgWTvI8WwyZvqKDSGFF
	 V/5Y4NQwoPmOJmh8WUUYPpowNETa6Pm56kHwEajZzU9aeckF/jU5mOsue+g1faNy4l
	 7kvUt+7aSBAZFTvoU1q+TG8DX3gI7PQPt7f9tJYK723XhfqgMLVqDvJgHda13NOTQt
	 uoXbvuE+6NaiOggPT61PNGSrNjRhxva8jXxmHgozBuQT0TeV+DglwfE34dBFF02MnK
	 w7tNCWkLKihqQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hvMWF1B6Zz7x4X;
	Tue, 29 Sep 2026 17:27:53 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hvMWD3NQjz8sb3;
	Tue, 29 Sep 2026 17:27:52 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 682855FADA;
	Tue, 29 Sep 2026 17:27:45 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ed6e1368-3663-4d71-882d-5ca80d5a7a76@leemhuis.info>
Date: Tue, 29 Sep 2026 17:27:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] RTL8761BU 0bda:a728: removing BROKEN_EXT_SCAN fixes
 0x200c timeout
To: Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>
Cc: regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 Kamil Serwus <kserwus@gmail.com>, Junjie Cao <junjie.cao@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexej Sidorenko <alexej@sidorenko.cz>
References: 
 <CAE4bxw+ofDFVx0aTHqCrzns9oP1CRQDm_wzeyHPeMBYOhSpcuA@mail.gmail.com>
 <f322a3b2-71eb-45e7-aeaf-18ad87f938ce@leemhuis.info>
 <4f28488c-ff9e-46db-aa2a-687213c129d6@leemhuis.info>
 <CAE4bxwJEPJ26LMPstWkE26pxuC+CpM7y_0odYCdp1i=3XA=H9g@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAE4bxwJEPJ26LMPstWkE26pxuC+CpM7y_0odYCdp1i=3XA=H9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179069566614.1287661.10666960125516099784@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 682855FADA
X-NC-CID: upyztS3T5rhZpPlfCjkCZT9B7QucDa9RBHjZUBqrIBbUyQseXDQ=

On 9/26/26 13:37, Andy Tsvetinskiy wrote:
> 7.3-rc4 checked, issue still exists

Thx for checking, and sorry, I had missed that Junjie send a patch to
fix this:

Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
https://lore.kernel.org/all/20260920020227.709800-1-junjie.cao@intel.com/

You were copied. Please try that with 7.3-rc and reply with a
"Tested-by: " followed by your name and email, that would help a great deal.

Ciao, Thorsten

> пт, 25 сент. 2026 г. в 12:05, Thorsten Leemhuis <regressions@leemhuis.info>:
>>
>> On 9/18/26 15:37, Thorsten Leemhuis wrote:
>>> Lo!
>>> On 9/18/26 11:21, Andy Tsvetinskiy wrote:
>>>>
>>>>    This report concerns USB ID 0bda:a728, not 0bda:8771.
>>>>
>>>>    I have a Realtek RTL8761BUV USB Bluetooth adapter:
>>>>
>>>>    - USB ID: 0bda:a728
>>>>    - Product: Bluetooth 5.4 Radio
>>>>    - Firmware: rtl_bt/rtl8761bu_fw.bin
>>>>    - Firmware version: 0xdfc6d922
>>>>    - Running kernel: 6.18.51-1-lts
>>>>    - Distribution: Arch Linux
>>>>
>>>>    With the stock btusb driver, Bluetooth repeatedly failed with:
>>>>
>>>>        Bluetooth: hci0: command 0x200c tx timeout
>>>>        Bluetooth: hci0: Opcode 0x200c failed: -110
>>>>        Bluetooth: hci0: Unable to disable scanning: -110
>>>>        Bluetooth: hci0: Resetting usb device.
>>>>        usb 1-2.2: reset full-speed USB device
>>>>        Bluetooth: hci0: unexpected event for opcode 0x200c
>>>
>>> Thx for the report. Just replying to bring a few people into the loop
>>> that can help handling this: the Blutooth maintainers and developers
>>> which were involved in ca0583c2466174 ("Bluetooth: btusb: limit RTL8761B
>>> BROKEN_EXT_SCAN quirk to 0bda:a728") [v7.3-rc1] and 5ead2063611ae5
>>> ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
>>> [v7.2-rc1]. Ciao, Thorsten
>>
>> Hmm, seems nobody cares, so we need to go the next step: can you please
>> test if latest mainline (7.3-rc4 or later) is affected to rule out that
>> it's something specific to the stable series in question?
>>
>> Ciao, Thorsten
>>>>    The firmware was loaded successfully:
>>>>
>>>>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
>>>>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
>>>>        Bluetooth: hci0: RTL: fw version 0xdfc6d922
>>>>
>>>>    The USB autosuspend setting was not the cause:
>>>>
>>>>        /sys/bus/usb/devices/1-2.2/power/autosuspend: -1
>>>>
>>>>    The current upstream fix ca0583c24661
>>>>    ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728")
>>>>    is already present in my kernel. It sets BTUSB_BROKEN_EXT_SCAN for 0bda:a728.
>>>>
>>>>    I tested the opposite change locally in drivers/bluetooth/btusb.c:
>>>>
>>>>        - { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
>>>>        -                    BTUSB_BROKEN_EXT_SCAN },
>>>>        + { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK },
>>>>
>>>>    After rebuilding and reloading the btusb module:
>>>>
>>>>        systemctl stop bluetooth
>>>>        modprobe -r btusb
>>>>        modprobe btusb
>>>>        systemctl start bluetooth
>>>>
>>>>    Bluetooth scanning worked normally. A 20-second scan completed with:
>>>>
>>>>        Discovery started
>>>>        Discovering: yes
>>>>
>>>>    After loading the patched module, no new occurrences of the
>>>> following messages appeared:
>>>>
>>>>        Opcode 0x200c failed: -110
>>>>        Opcode 0x2042 failed
>>>>        command tx timeout
>>>>        Unable to disable scanning
>>>>        Resetting usb device
>>>>
>>>>    The patched driver is currently loaded and Bluetooth remains operational.
>>>>
>>>>    This suggests that different RTL8761BUV devices or firmware
>>>> revisions using USB ID 0bda:a728 may require different scan quirks. On
>>>> my device, keeping BTUSB_BROKEN_EXT_SCAN causes the legacy 0x200c
>>>> command to
>>>>  time out, while removing the quirk fixes the issue.
>>>>
>>>>    Relevant upstream reports:
>>>>
>>>>    https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260822141115.58815-1-kserwus@gmail.com/
>>>>
>>>>    https://bugzilla.redhat.com/show_bug.cgi?id=2521504
>>>>
>>>>    https://lkml.iu.edu/2608.2/12212.html
>>>>
>>>>    Please let me know if more logs, a full patch, or additional
>>>> testing is needed.
>>>>
>>>
>>
> 
> 

