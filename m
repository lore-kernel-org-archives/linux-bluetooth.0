Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F94FC343;
	Fri, 18 Sep 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738729; cv=none; b=M6gLXBY5z+7OKNU9k02rFj1DemKLqN2KZ8mX0SZ0ZBIjk2Nubc0xrpL8zMFnRgI2sQAQ7NtnLEYla1wwSLQyWRQcpdRo/xCWg+uoTHPPIUHIXv720KhTaH6J8D673U3H5GWJpaaX5CTRU3aPy4KTVfulcJ+vpXGPPr7qa8WbQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738729; c=relaxed/simple;
	bh=NSGPR63vm0J21dwn5r1enKuzdn3dCG4YKJPLYpM64W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFoP2V7uLvvNlseT7j68T+ECogibR/n5gY5Ji9HoR+/VZJLmbzfZY+IBGvXkeMtjvsQRlGgnmH+0PQBXjQGKQKkU0ChJIbaqdZjqL+lWmR8rFSJ0iHlGfwSs+it5/gOWmeNaZueefq1qazpKR6O6cCY+wRu3Vsz3Dok0+9Z5nDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HW+OE7NR; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HW+OE7NR"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hmYcN1gwTz87cq;
	Fri, 18 Sep 2026 15:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789738724;
	bh=NSGPR63vm0J21dwn5r1enKuzdn3dCG4YKJPLYpM64W8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HW+OE7NRUKVex6wzHEF3IQTF86Pm+OWJotfW/8EBhztiEcpPSe0QZnBjVbXTtdl60
	 BWd9B/DO/3HiiCAI4dB/LGmJEPmSVb3f46lkkj0u0dbLZxY5kBBcFhRZWC/fSoqLtD
	 ylHfmj2tlAQUjwRWp229sCJ/47+p2NR38zKOFv07cH+WKFvJBB2RrlERKJw9s7JIVC
	 vZo2ijWwyMzYHu/6u/Q9/Qws+KnYzi485QNnv9H30juGLbOt7JEVa3x53ZFNV1pCZj
	 O9iWgt3P6eV0XUc7C05InzdA+9M7MVUnF6Jov/6fm1pcQvpNtnShLnKE2sj5F1KhhL
	 hQq37qPtD9qaw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hmYb34b8Jz8DFZ;
	Fri, 18 Sep 2026 15:37:35 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hmYb243hHz8sZP;
	Fri, 18 Sep 2026 15:37:34 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CAC7F5FA16;
	Fri, 18 Sep 2026 15:37:33 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f322a3b2-71eb-45e7-aeaf-18ad87f938ce@leemhuis.info>
Date: Fri, 18 Sep 2026 15:37:32 +0200
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAE4bxw+ofDFVx0aTHqCrzns9oP1CRQDm_wzeyHPeMBYOhSpcuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178973865431.1866550.16469531839496829366@mxe9fb.netcup.net>
X-NC-CID: bpcrAflHt8zdY5QrWqS0S4zUNqIX10pwqepvi9WfE/OjxMyZz1A=

Lo!

On 9/18/26 11:21, Andy Tsvetinskiy wrote:
> 
>    This report concerns USB ID 0bda:a728, not 0bda:8771.
> 
>    I have a Realtek RTL8761BUV USB Bluetooth adapter:
> 
>    - USB ID: 0bda:a728
>    - Product: Bluetooth 5.4 Radio
>    - Firmware: rtl_bt/rtl8761bu_fw.bin
>    - Firmware version: 0xdfc6d922
>    - Running kernel: 6.18.51-1-lts
>    - Distribution: Arch Linux
> 
>    With the stock btusb driver, Bluetooth repeatedly failed with:
> 
>        Bluetooth: hci0: command 0x200c tx timeout
>        Bluetooth: hci0: Opcode 0x200c failed: -110
>        Bluetooth: hci0: Unable to disable scanning: -110
>        Bluetooth: hci0: Resetting usb device.
>        usb 1-2.2: reset full-speed USB device
>        Bluetooth: hci0: unexpected event for opcode 0x200c

Thx for the report. Just replying to bring a few people into the loop
that can help handling this: the Blutooth maintainers and developers
which were involved in ca0583c2466174 ("Bluetooth: btusb: limit RTL8761B
BROKEN_EXT_SCAN quirk to 0bda:a728") [v7.3-rc1] and 5ead2063611ae5
("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
[v7.2-rc1]. Ciao, Thorsten

>    The firmware was loaded successfully:
> 
>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
>        Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
>        Bluetooth: hci0: RTL: fw version 0xdfc6d922
> 
>    The USB autosuspend setting was not the cause:
> 
>        /sys/bus/usb/devices/1-2.2/power/autosuspend: -1
> 
>    The current upstream fix ca0583c24661
>    ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728")
>    is already present in my kernel. It sets BTUSB_BROKEN_EXT_SCAN for 0bda:a728.
> 
>    I tested the opposite change locally in drivers/bluetooth/btusb.c:
> 
>        - { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
>        -                    BTUSB_BROKEN_EXT_SCAN },
>        + { USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK },
> 
>    After rebuilding and reloading the btusb module:
> 
>        systemctl stop bluetooth
>        modprobe -r btusb
>        modprobe btusb
>        systemctl start bluetooth
> 
>    Bluetooth scanning worked normally. A 20-second scan completed with:
> 
>        Discovery started
>        Discovering: yes
> 
>    After loading the patched module, no new occurrences of the
> following messages appeared:
> 
>        Opcode 0x200c failed: -110
>        Opcode 0x2042 failed
>        command tx timeout
>        Unable to disable scanning
>        Resetting usb device
> 
>    The patched driver is currently loaded and Bluetooth remains operational.
> 
>    This suggests that different RTL8761BUV devices or firmware
> revisions using USB ID 0bda:a728 may require different scan quirks. On
> my device, keeping BTUSB_BROKEN_EXT_SCAN causes the legacy 0x200c
> command to
>  time out, while removing the quirk fixes the issue.
> 
>    Relevant upstream reports:
> 
>    https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260822141115.58815-1-kserwus@gmail.com/
> 
>    https://bugzilla.redhat.com/show_bug.cgi?id=2521504
> 
>    https://lkml.iu.edu/2608.2/12212.html
> 
>    Please let me know if more logs, a full patch, or additional
> testing is needed.
> 

