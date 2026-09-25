Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18836E489;
	Fri, 25 Sep 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327133; cv=none; b=tfrl8EBHezjU9lkCYBa4c29IpG6PRC0/CS8E9vqrpU7aLP9+s1rfQDMARnAoB+gwvyp8ocB5reVlGrHzjvpwOVZJgxarHaH/IHTpT+unVtFbTCHIoDiPEL/6dGH7nxu+wqf2NszR96o0585Rpv/PLgaXrcO59HntGdg+R2dQU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327133; c=relaxed/simple;
	bh=oqdY50+Ua1sm0dA0riA3XKlPkPf5jSVWn6/Ar3bjEu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pk2UIvNyGBxBYT57oq9VvOIChhh1mNW446JDx1UncyVkjAEGr0B39v/j6rZRLXRoAxQeUUsWvHpkg5R3xxj3wW7TgVMF+I70fGEanCdVtQkvwpisYzGasL7cf5zs0UwBZk/CWWY8JF0IzpMb3PtTEbJq582oi3Xksx+16Lek93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iYRuMxE0; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iYRuMxE0"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hrlCh6fxjz8lHj;
	Fri, 25 Sep 2026 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790327120;
	bh=oqdY50+Ua1sm0dA0riA3XKlPkPf5jSVWn6/Ar3bjEu0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iYRuMxE0dV3cH+aUbVbxRfHsi0LAhWaU2Dj04PEF6IxobPWJO4tyfDOXPdj1liJMf
	 ZDkYbgmB8/bKO+g31oTJ3QkPJE83vQcu4ogJTcxTHai9dQbov5XWk6W7ifUHODIivW
	 WgQGZtHBhR3cG/cGPv2X0Z1ljahgNKggLH+hAJp3t/DzB8q6nAYnd4Q+yrGsMaHHrs
	 vZoo4YrSEr9ln1WmboqBh1H2lKl8RAq+xjjsoZFN3bYq0UDjHC2QOdzGegap8o4M4M
	 Nv/6Qll3nfqHd8jZRE3UB+Symmw2GoU8dj64HTb8Y75FW/aMm+rPwsqQwfaqUnY8xd
	 NG4q0MfRwEp6g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hrlCh5xndz8lDL;
	Fri, 25 Sep 2026 09:05:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hrlCd4gTDz8tfB;
	Fri, 25 Sep 2026 11:05:17 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DCA7A5F8CC;
	Fri, 25 Sep 2026 11:05:16 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4f28488c-ff9e-46db-aa2a-687213c129d6@leemhuis.info>
Date: Fri, 25 Sep 2026 11:05:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] RTL8761BU 0bda:a728: removing BROKEN_EXT_SCAN fixes
 0x200c timeout
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>
Cc: regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 Kamil Serwus <kserwus@gmail.com>, Junjie Cao <junjie.cao@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexej Sidorenko <alexej@sidorenko.cz>
References: 
 <CAE4bxw+ofDFVx0aTHqCrzns9oP1CRQDm_wzeyHPeMBYOhSpcuA@mail.gmail.com>
 <f322a3b2-71eb-45e7-aeaf-18ad87f938ce@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <f322a3b2-71eb-45e7-aeaf-18ad87f938ce@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179032711737.4193479.59443090121703576@mxe9fb.netcup.net>
X-NC-CID: VoNGq77+MfkMVWhdao7Mfl8yZM1MwjyjeQ/z56srSUi0NsajOO4=

On 9/18/26 15:37, Thorsten Leemhuis wrote:
> Lo!
> On 9/18/26 11:21, Andy Tsvetinskiy wrote:
>>
>>    This report concerns USB ID 0bda:a728, not 0bda:8771.
>>
>>    I have a Realtek RTL8761BUV USB Bluetooth adapter:
>>
>>    - USB ID: 0bda:a728
>>    - Product: Bluetooth 5.4 Radio
>>    - Firmware: rtl_bt/rtl8761bu_fw.bin
>>    - Firmware version: 0xdfc6d922
>>    - Running kernel: 6.18.51-1-lts
>>    - Distribution: Arch Linux
>>
>>    With the stock btusb driver, Bluetooth repeatedly failed with:
>>
>>        Bluetooth: hci0: command 0x200c tx timeout
>>        Bluetooth: hci0: Opcode 0x200c failed: -110
>>        Bluetooth: hci0: Unable to disable scanning: -110
>>        Bluetooth: hci0: Resetting usb device.
>>        usb 1-2.2: reset full-speed USB device
>>        Bluetooth: hci0: unexpected event for opcode 0x200c
> 
> Thx for the report. Just replying to bring a few people into the loop
> that can help handling this: the Blutooth maintainers and developers
> which were involved in ca0583c2466174 ("Bluetooth: btusb: limit RTL8761B
> BROKEN_EXT_SCAN quirk to 0bda:a728") [v7.3-rc1] and 5ead2063611ae5
> ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
> [v7.2-rc1]. Ciao, Thorsten

Hmm, seems nobody cares, so we need to go the next step: can you please
test if latest mainline (7.3-rc4 or later) is affected to rule out that
it's something specific to the stable series in question?

Ciao, Thorsten
>>    The firmware was loaded successfully:
>>
>>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
>>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
>>        Bluetooth: hci0: RTL: fw version 0xdfc6d922
>>
>>    The USB autosuspend setting was not the cause:
>>
>>        /sys/bus/usb/devices/1-2.2/power/autosuspend: -1
>>
>>    The current upstream fix ca0583c24661
>>    ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728")
>>    is already present in my kernel. It sets BTUSB_BROKEN_EXT_SCAN for 0bda:a728.
>>
>>    I tested the opposite change locally in drivers/bluetooth/btusb.c:
>>
>>        - { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
>>        -                    BTUSB_BROKEN_EXT_SCAN },
>>        + { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK },
>>
>>    After rebuilding and reloading the btusb module:
>>
>>        systemctl stop bluetooth
>>        modprobe -r btusb
>>        modprobe btusb
>>        systemctl start bluetooth
>>
>>    Bluetooth scanning worked normally. A 20-second scan completed with:
>>
>>        Discovery started
>>        Discovering: yes
>>
>>    After loading the patched module, no new occurrences of the
>> following messages appeared:
>>
>>        Opcode 0x200c failed: -110
>>        Opcode 0x2042 failed
>>        command tx timeout
>>        Unable to disable scanning
>>        Resetting usb device
>>
>>    The patched driver is currently loaded and Bluetooth remains operational.
>>
>>    This suggests that different RTL8761BUV devices or firmware
>> revisions using USB ID 0bda:a728 may require different scan quirks. On
>> my device, keeping BTUSB_BROKEN_EXT_SCAN causes the legacy 0x200c
>> command to
>>  time out, while removing the quirk fixes the issue.
>>
>>    Relevant upstream reports:
>>
>>    https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260822141115.58815-1-kserwus@gmail.com/
>>
>>    https://bugzilla.redhat.com/show_bug.cgi?id=2521504
>>
>>    https://lkml.iu.edu/2608.2/12212.html
>>
>>    Please let me know if more logs, a full patch, or additional
>> testing is needed.
>>
> 

