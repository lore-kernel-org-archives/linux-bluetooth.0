Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C01946DA
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447473; cv=none; b=o1DhcfMScQXDvGFgb3cJF33LKlB/yVn4/7oHNPyBVM3l2CfgOV6Z8nv5hw1+t0m7z9CwM0Hme84WRmdsBToymMJBMKJWmA7mdqE1UZciZejDtKfC0jlJVwX28LlYhamu66S6RN5iu7hxtkFylisosc5RhCITvnNHBobi240FTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447473; c=relaxed/simple;
	bh=mbQ4BpyILPvtLntc/7PKsDcdxjxEwxvdohHGYqWNPso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eD3ItSH33oklIUWICBdyB5UrL9jU+8RtsvXeehmLuw41fV1Lwk7XH6IZPxx5ZV9aZleTZVSkpy1nlOGaGL/bboBVFadnbeHmaXEEH4DVc6+XcJ7InIhWyZvXFucBzFe5NbmGWrf80fiTLPHIieeIJ2FCwEGD3InJTaAEEMAOR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rothemail.net; spf=none smtp.mailfrom=rothemail.net; dkim=pass (2048-bit key) header.d=rothemail-net.20230601.gappssmtp.com header.i=@rothemail-net.20230601.gappssmtp.com header.b=FdJDXyjn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rothemail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rothemail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rothemail-net.20230601.gappssmtp.com header.i=@rothemail-net.20230601.gappssmtp.com header.b="FdJDXyjn"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so3560242276.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rothemail-net.20230601.gappssmtp.com; s=20230601; t=1729447471; x=1730052271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OOwWusk6gEaG/8hbzuWvjxkguVQUEpUcpHpEOGOhQA=;
        b=FdJDXyjnWf/jvY2vyhnkriFjU0nv+CFHlsbzhPrsoTXw76irnIl4g0jYrSwOe734+z
         D2tEWL1Gjmzpn1c8B78tEKBTNx0gx6HNz70jcPHXWJifr22FnwpN5tLkbErGVYuOLiop
         dXNs/84OYQtAI2LYY9vtFC/LwZUDW2WelsWPsLt6xop0izdy7T2RZBNB60OtWa32Vomw
         qNEWqI8mtMilfr/O1EyukPdjNRII6IDj/HC5v1mM1M+D92lZeIx8fcF0SCueFzFtY628
         C+/5LlcWQ+GZLe1pwwZMdLY/UyLwZ9NZ2ReulB08K3liNU8B/dDSToQs3ykRPmP8Zecs
         nj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729447471; x=1730052271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OOwWusk6gEaG/8hbzuWvjxkguVQUEpUcpHpEOGOhQA=;
        b=F3CGSJylhLfvMF5E5HXgqFCwIzRVyDl/RoFZV/VkGTEiF+w8IYUgF3nf6LN0HxjLAR
         zkN5M8cTq+IIqvfb7SSfiQ7XLtikfIr+a706nuvRwuDpGHNvDibq2zikILyqqZm/1V1X
         nQmANGEKCSN9Ql72FyBb5YEChhD8c5uUkMsOAWj9wfmZa5hp/mrejhv5HV1VylA5/voU
         brDrzwiN3kJ+9pH95+ocmKt8heuGEC1RMvv2Ke1xiCsU8UrLZP88hOo2LqGBiq4GglQu
         FqIoCtI+6P3fNS9JJVKvOfdjLgU96rbiMpkijCoPmGBV/1ksK2RlMmA2a0Crs1zZTcgx
         ZwYA==
X-Forwarded-Encrypted: i=1; AJvYcCUMtTkSTLFvefMznSAWnhImMARdlbfpMcwjDU9S5HILi5Oo60IhjuO4Yjk5XSXbCsk4ti0175yBR7LpARQvIzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRp3H+pM561L/7v5QI78EXWMNmNTTzP01+ITAmbH46N/1eeYw
	Qv3/HWkW6rCOB4hKKywJ+GLEMl0hUEFb/ClupUVk8M50a+JXQ0z/snK4K8aIj7xEFTfqHqmZZM8
	vu4HckO1Vd2IbzhnUTw9pnAaaP9FD4lsK9UrL2AvTAuu8RR+PBNUEoQ==
X-Google-Smtp-Source: AGHT+IF8tda2rePv5A+duyzJqGM5e/U7BomZq6sQw+zaQZl7zuF0j93HaSioMcmaiDUo0U6AiZmyGyOi0SdPfStiUpQ=
X-Received: by 2002:a05:690c:3747:b0:6e3:34b9:961d with SMTP id
 00721157ae682-6e5bfc8ce70mr82212367b3.38.1729447470821; Sun, 20 Oct 2024
 11:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicholas Roth <nicholas@rothemail.net>
Date: Sun, 20 Oct 2024 14:04:22 -0400
Message-ID: <CAD2rFCq7VAr=xVxppToAePQtNBUY2j3FNk+dXgMXDv32LHyRng@mail.gmail.com>
Subject: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And Hibernate
To: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#regzbot introduced: v6.10..v6.11

My Framework 16 laptop (Ryzen=E2=84=A2 7 7840HS + AMD Radeon=E2=84=A2 RX 77=
00S)
recently started hanging when I open the lid after resuming from
hibernation on the very-lightly-patched 6.11.4 kernel that Arch ships
as `linux`. From the error message, this appears to be a crash.

I'm compiling torvalds/linux locally and will be able to use that to
help answer follow-up questions, but I may be slow to respond as I
have a day job. The kernel I've tested so far is _very_ close to
mainline-- at https://github.com/archlinux/linux I only see ARM/fixes,
dmaengine: cirrus:, and btrfs: send:). I posted the issue at
https://community.frame.work/t/framework-16-fails-to-resume-from-hibernate/=
59297
and it appears others see this too. Note that the 6.10-6.11 range
comes from @callahad on the forums-- I can only say for sure on the
close-to-mainline kernel that this definitely affects 6.11.4.

I was not able to collect complete logs since they don't get saved to
the journal and I don't have a serial adapter on me suitable for a
kernel TTY, but with `no_console_suspend` I was able to enhance and
OCR an image (see the forums for the original), which I'm posting in
full at the end of this mail under "Partial Panic (OCR)". Highlights
include:
[ 146.054908] RIP: 0010:hci_unregister_dev+0x45/8x1f@ [bluetooth]
...
[ 146.855890) Call Trace:
[ 146.055187] ? __die_body.cold+0x19/0=C3=9727
[ 146.055122] ? die_addr+0x3c/0x60
[ 146.055134] ? exc_general_protection+0x17d/0x400
...
[ 146.855238] ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
1400000003000000474e5500314a936b2959fa34)
[ 146.055288] btusb_disconnect+0x67/0x170 [btusb
1400000003000000474e55007dd0b46154bf4bec]
...
[ 148.449222] mt7921e 8000:04:00.0: Message 00020007 (seq 4) timeout
[ 148.451497] mt7921e 0000:04:00.0: PM: dpm_run_callback();
pci_pm_restore returns -110
[ 148.454598] mt7921e 8000:04:00.0: PM: failed to restore async: error -110
[ 148.534371] mt7921e 0000:04:00.0: HW/SW Version; 8x8a188a10, Build
Time: 20240716163242a
[ 148.534371]
[ 148.912088] mt7921e 0000:04:00.0: WM Firmware Version: ____000000,
Build Time: 20240716163327

The kernel appears to be tainted with an unrelated warning.

chktaint:
$ ./kernel-chktaint.sh
Kernel is "tainted" for the following reasons:
 * kernel issued warning (#9)
For a more detailed explanation of the various taint flags see
 Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources
 or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
Raw taint value as int/string: 512/'G        W         '

Warnings:
# dmesg | grep -i warn
[    2.333170] WARNING: CPU: 10 PID: 229 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:186
dcn31_panel_cntl_construct.cold+0x1e/0x2e [amdgpu]
[    2.333967]  ? __warn.cold+0x8e/0xe8
[ 2814.691588] warning: `ThreadPoolForeg' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211

Partial Panic (OCR):
[ 146.0548891] Workqueue: async async_run_entry_fn
[ 146.054908] RIP: 0010:hci_unregister_dev+0x45/8x1f@ [bluetooth]
[ 146.054962] Code: 89 ef e8 ae 03 8b d2 f0 80 8b e9 De 00 00 08 48 89
ef e8 0e f1 8a d2 48 c7 c7 68 20 c4 c1 e8 22 52 8b d2 48 8b 43 08 48
8b 13 <48> 3b 18 0f 85 b5 c7 06 00 48 3b 5a 08 Of 85 ab c7 06 00 48 89
42
[ 146.054984] RSP: 0018: ffffbba241defcc8 EFLAGS: 00010246
[ 146.054996] RAX: dead000000000122 RBX: ffffa86a81276000 RCX: 000000000000=
0000
[ 146.055007] RDX: dead000000000100 RSI: ffffa06a81a47910 RDI: ffffffffc1c4=
2068
[ 146.055018] RBP: ffffa06a812764d0 R08: 0000000000000000 R89: ffffa06a801d=
9610
[ 146.055028] R10: ffffbba241defcd0 R11: ffffbba241defcd8 R12: ffffa06a8127=
6000
[ 146.055038] R13: ffffffffc2323278 R14: ffffffffc2323278 R15:
ffffa06a8f9f0850 146.055050] FS:
[ 146.055050] FS: 0000000000000000(0000) GS:ffffa07960000000(0000)
kn1GS:0000000000000000
[ 146.055062] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 146.055072] CR2: 0000000000000000 CR3: 000000070ba22000 CR4: 0000000000f5=
0ef0
[ 146.055083] PKRU: 55555554
[ 146.855890) Call Trace:
[ 146.055099]
[ 146.055187] ? __die_body.cold+0x19/0=C3=9727
[ 146.055122] ? die_addr+0x3c/0x60
[ 146.055134] ? exc_general_protection+0x17d/0x400
[ 146.055147] ? ep_poll_callback+0x24d/0x2a0
[ 146.055164] ? asm_exc_general_protection+0x26/0x30
[ 146.055184] ? hci_unregister_dev+0x45/0x1f@ [bluetooth
1400000003000888474e5500314a936b2959fa34]
[ 146.855238] ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
1400000003000000474e5500314a936b2959fa34)
[ 146.055288] btusb_disconnect+0x67/0x170 [btusb
1400000003000000474e55007dd0b46154bf4bec]
[ 146.055307] usb_unbind_interface+0x90/0x290
[ 146.055325] device_release_driver_internal+0x19c/0x200
[ 146.055341] usb_forced_unbind_intf+0x75/0xb0
[ 146.055354] unbind_marked_interfaces.isra.0+0x59/0=C3=9780
[ 146.055368] ? __pfx_usb_dev_restore+0x10/0x10
[ 146.055381] usb_resume+0x5a/0x60
[ 146.055392] _dp_run_callback+0x47/0x150
[ 146.055407] device_resume+0xb0/0=C3=97280
[ 146.055419] async_resume+0x1d/8x30
[ 146.055431] async_run_entry_fn+0x31/0=C3=97140
[ 146.055444] process_one_work+0x17b/0x330
[ 147.894397] [drm] ring gfx_32772.1.1 was addedmes_kiq_3.1.0 uses VM
inv eng 13 on hub 0vailable 68 20 c4 c1 e8 22 52 Bb d2 48 8b 43 08 48
8b 13 <48> 3b 18 0f
[ 147.896995] [drm] ring compute_32772.2.2 was added
[ 147.098944] [drm] ring sdma_32772.3.3 was added
[ 147.102569] [dro] ring gfx_32772.1.1 ib test pass
[ 147.186131] [drm] ring compute_32772.2.2 ib test pass
[ 147.188302] [drm] ring sdma_32772.3.3 ib test pass
[ 147.136203] usb 1-4.3: reset full-speed USB device number 8 using xhci_hc=
d
[ 147.238067] usb 1-4.3: unable to get BOS descriptor set
[ 148.449222] mt7921e 8000:04:00.0: Message 00020007 (seq 4) timeout
[ 148.451497] mt7921e 0000:04:00.0: PM: dpm_run_callback();
pci_pm_restore returns -110
[ 148.454598] mt7921e 8000:04:00.0: PM: failed to restore async: error -110
[ 148.534371] mt7921e 0000:04:00.0: HW/SW Version; 8x8a188a10, Build
Time: 20240716163242a
[ 148.534371]
[ 148.912088] mt7921e 0000:04:00.0: WM Firmware Version: ____000000,
Build Time: 20240716163327

Please let me know if I am missing anything or should do something
differently. I am new to these lists.

Thanks, all!
-Nicholas
