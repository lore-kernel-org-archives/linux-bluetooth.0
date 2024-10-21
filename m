Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97616156C63;
	Mon, 21 Oct 2024 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485894; cv=none; b=KQ3yCyLOZNNJAPcMQDxDdlIqHAN1/SVGkjC970GG8Ia/wipBmr/D8oBQGjMPdJtZAxzhyyCtZftG/VyZEEb/7lwQARa9xarRVxEluc9VBmSGTeMfWmQLR2cwXe8UZdt3KQf3NReMMghb0mqa9asdbWlBm6mxif6HH4EbNrI/aWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485894; c=relaxed/simple;
	bh=4KPKDfV1moAK6hPozRbiwSw8/SaJiVWuQflWwHCYQ0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiC7a2qFamyZ3kpkGwA0KNHgjDT7mp1ZKNMwaO15c3/kxJKjYC5BiyXar64la4fkqpiDke6itDVzFf9YkQ6SQo6l7Gbvw0NCONS7XBmOlzUCxm9QzIe7dGzwzXj2COKILRQ6r3fsz+/Nge/kmX0Z8OM/O7Tqvz7169RDvdSln74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sRW26mbp; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sRW26mbp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Ii8kZAdSs/I9IwUAPkaBoAxJD1NnvJAt/eTmVZUyZuM=;
	t=1729485892; x=1729917892; b=sRW26mbpCz7D1+MCfQqladmoV9VvhmB65bWWNxwgaOWW0i1
	J/7jDwIyMi03rsRxjg7haINt+zbH77QIFWPio2mxjYcZeR3Q0OcP7wgt5qG7wemUNXxTmlVYxaoIr
	X8zu4HCn1Ky/8rccMnWj0eUYgD5loKWW9T0pAXs1rNp4A+XzgLDzQrhNgkzK4E1O3FnMaNYJXVeNy
	Xmd2drH9+42DGyx9sIKF0dmTiJMJADfM3C7GHecsDsG0DcQZ/xwkfwde4CQ4cj9CTZYmXF6wOGulM
	RdzxHvz2Ghb4teSTOTzJIjdN71qUlCrrDIOdFmorx0PwtaTUmt5RK8W2xFtSmAMw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t2kHd-0007II-V5; Mon, 21 Oct 2024 06:44:46 +0200
Message-ID: <7b8ee608-f714-42dd-b029-70234880617d@leemhuis.info>
Date: Mon, 21 Oct 2024 06:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And
 Hibernate
To: Nicholas Roth <nicholas@rothemail.net>
Cc: regressions@lists.linux.dev, Marc Payne <marc.payne@mdpsys.co.uk>,
 Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Hao Qin <hao.qin@mediatek.com>
References: <CAD2rFCq7VAr=xVxppToAePQtNBUY2j3FNk+dXgMXDv32LHyRng@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAD2rFCq7VAr=xVxppToAePQtNBUY2j3FNk+dXgMXDv32LHyRng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729485892;96564334;
X-HE-SMSGID: 1t2kHd-0007II-V5

On 20.10.24 20:04, Nicholas Roth wrote:
> #regzbot introduced: v6.10..v6.11
> 
> My Framework 16 laptop (Ryzen™ 7 7840HS + AMD Radeon™ RX 7700S)
> recently started hanging when I open the lid after resuming from
> hibernation on the very-lightly-patched 6.11.4 kernel that Arch ships
> as `linux`. From the error message, this appears to be a crash.

Thx for the report. Not my area of expertise, but this a bit similar to
the symptoms that Marc Payne (now CCed) reported a while ago:
https://lore.kernel.org/linux-bluetooth/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/

Hao Qin (now CCed, too) posted a patch to fix this:
https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/

But then things apparently stalled and my inquiry for a status update
was ignored.

Nicholas, maybe wait a day or two if somebody with more expertise
replies with something more concrete. If not it might be good to check
if ccfc8948d7e4 is the culprit for you as well and/or if the patch
linked above helps.

Ciao, Thorsten

> I'm compiling torvalds/linux locally and will be able to use that to
> help answer follow-up questions, but I may be slow to respond as I
> have a day job. The kernel I've tested so far is _very_ close to
> mainline-- at https://github.com/archlinux/linux I only see ARM/fixes,
> dmaengine: cirrus:, and btrfs: send:). I posted the issue at
> https://community.frame.work/t/framework-16-fails-to-resume-from-hibernate/59297
> and it appears others see this too. Note that the 6.10-6.11 range
> comes from @callahad on the forums-- I can only say for sure on the
> close-to-mainline kernel that this definitely affects 6.11.4.
> 
> I was not able to collect complete logs since they don't get saved to
> the journal and I don't have a serial adapter on me suitable for a
> kernel TTY, but with `no_console_suspend` I was able to enhance and
> OCR an image (see the forums for the original), which I'm posting in
> full at the end of this mail under "Partial Panic (OCR)". Highlights
> include:
> [ 146.054908] RIP: 0010:hci_unregister_dev+0x45/8x1f@ [bluetooth]
> ...
> [ 146.855890) Call Trace:
> [ 146.055187] ? __die_body.cold+0x19/0×27
> [ 146.055122] ? die_addr+0x3c/0x60
> [ 146.055134] ? exc_general_protection+0x17d/0x400
> ...
> [ 146.855238] ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
> 1400000003000000474e5500314a936b2959fa34)
> [ 146.055288] btusb_disconnect+0x67/0x170 [btusb
> 1400000003000000474e55007dd0b46154bf4bec]
> ...
> [ 148.449222] mt7921e 8000:04:00.0: Message 00020007 (seq 4) timeout
> [ 148.451497] mt7921e 0000:04:00.0: PM: dpm_run_callback();
> pci_pm_restore returns -110
> [ 148.454598] mt7921e 8000:04:00.0: PM: failed to restore async: error -110
> [ 148.534371] mt7921e 0000:04:00.0: HW/SW Version; 8x8a188a10, Build
> Time: 20240716163242a
> [ 148.534371]
> [ 148.912088] mt7921e 0000:04:00.0: WM Firmware Version: ____000000,
> Build Time: 20240716163327
> 
> The kernel appears to be tainted with an unrelated warning.
> 
> chktaint:
> $ ./kernel-chktaint.sh
> Kernel is "tainted" for the following reasons:
>  * kernel issued warning (#9)
> For a more detailed explanation of the various taint flags see
>  Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources
>  or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
> Raw taint value as int/string: 512/'G        W         '
> 
> Warnings:
> # dmesg | grep -i warn
> [    2.333170] WARNING: CPU: 10 PID: 229 at
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:186
> dcn31_panel_cntl_construct.cold+0x1e/0x2e [amdgpu]
> [    2.333967]  ? __warn.cold+0x8e/0xe8
> [ 2814.691588] warning: `ThreadPoolForeg' uses wireless extensions
> which will stop working for Wi-Fi 7 hardware; use nl80211
> 
> Partial Panic (OCR):
> [ 146.0548891] Workqueue: async async_run_entry_fn
> [ 146.054908] RIP: 0010:hci_unregister_dev+0x45/8x1f@ [bluetooth]
> [ 146.054962] Code: 89 ef e8 ae 03 8b d2 f0 80 8b e9 De 00 00 08 48 89
> ef e8 0e f1 8a d2 48 c7 c7 68 20 c4 c1 e8 22 52 8b d2 48 8b 43 08 48
> 8b 13 <48> 3b 18 0f 85 b5 c7 06 00 48 3b 5a 08 Of 85 ab c7 06 00 48 89
> 42
> [ 146.054984] RSP: 0018: ffffbba241defcc8 EFLAGS: 00010246
> [ 146.054996] RAX: dead000000000122 RBX: ffffa86a81276000 RCX: 0000000000000000
> [ 146.055007] RDX: dead000000000100 RSI: ffffa06a81a47910 RDI: ffffffffc1c42068
> [ 146.055018] RBP: ffffa06a812764d0 R08: 0000000000000000 R89: ffffa06a801d9610
> [ 146.055028] R10: ffffbba241defcd0 R11: ffffbba241defcd8 R12: ffffa06a81276000
> [ 146.055038] R13: ffffffffc2323278 R14: ffffffffc2323278 R15:
> ffffa06a8f9f0850 146.055050] FS:
> [ 146.055050] FS: 0000000000000000(0000) GS:ffffa07960000000(0000)
> kn1GS:0000000000000000
> [ 146.055062] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 146.055072] CR2: 0000000000000000 CR3: 000000070ba22000 CR4: 0000000000f50ef0
> [ 146.055083] PKRU: 55555554
> [ 146.855890) Call Trace:
> [ 146.055099]
> [ 146.055187] ? __die_body.cold+0x19/0×27
> [ 146.055122] ? die_addr+0x3c/0x60
> [ 146.055134] ? exc_general_protection+0x17d/0x400
> [ 146.055147] ? ep_poll_callback+0x24d/0x2a0
> [ 146.055164] ? asm_exc_general_protection+0x26/0x30
> [ 146.055184] ? hci_unregister_dev+0x45/0x1f@ [bluetooth
> 1400000003000888474e5500314a936b2959fa34]
> [ 146.855238] ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
> 1400000003000000474e5500314a936b2959fa34)
> [ 146.055288] btusb_disconnect+0x67/0x170 [btusb
> 1400000003000000474e55007dd0b46154bf4bec]
> [ 146.055307] usb_unbind_interface+0x90/0x290
> [ 146.055325] device_release_driver_internal+0x19c/0x200
> [ 146.055341] usb_forced_unbind_intf+0x75/0xb0
> [ 146.055354] unbind_marked_interfaces.isra.0+0x59/0×80
> [ 146.055368] ? __pfx_usb_dev_restore+0x10/0x10
> [ 146.055381] usb_resume+0x5a/0x60
> [ 146.055392] _dp_run_callback+0x47/0x150
> [ 146.055407] device_resume+0xb0/0×280
> [ 146.055419] async_resume+0x1d/8x30
> [ 146.055431] async_run_entry_fn+0x31/0×140
> [ 146.055444] process_one_work+0x17b/0x330
> [ 147.894397] [drm] ring gfx_32772.1.1 was addedmes_kiq_3.1.0 uses VM
> inv eng 13 on hub 0vailable 68 20 c4 c1 e8 22 52 Bb d2 48 8b 43 08 48
> 8b 13 <48> 3b 18 0f
> [ 147.896995] [drm] ring compute_32772.2.2 was added
> [ 147.098944] [drm] ring sdma_32772.3.3 was added
> [ 147.102569] [dro] ring gfx_32772.1.1 ib test pass
> [ 147.186131] [drm] ring compute_32772.2.2 ib test pass
> [ 147.188302] [drm] ring sdma_32772.3.3 ib test pass
> [ 147.136203] usb 1-4.3: reset full-speed USB device number 8 using xhci_hcd
> [ 147.238067] usb 1-4.3: unable to get BOS descriptor set
> [ 148.449222] mt7921e 8000:04:00.0: Message 00020007 (seq 4) timeout
> [ 148.451497] mt7921e 0000:04:00.0: PM: dpm_run_callback();
> pci_pm_restore returns -110
> [ 148.454598] mt7921e 8000:04:00.0: PM: failed to restore async: error -110
> [ 148.534371] mt7921e 0000:04:00.0: HW/SW Version; 8x8a188a10, Build
> Time: 20240716163242a
> [ 148.534371]
> [ 148.912088] mt7921e 0000:04:00.0: WM Firmware Version: ____000000,
> Build Time: 20240716163327
> 
> Please let me know if I am missing anything or should do something
> differently. I am new to these lists.
> 
> Thanks, all!
> -Nicholas
> 
> 

