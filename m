Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947351E53A
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713733275; cv=none; b=PxkTRigKIERUnIdKtFg1zFVnZUg9gcUnsRpmT0ZCexqsOTkmlFVGmxJWr1IaEWQF4PaCkuUqoaTCk17Sh+2V6JhGGc4zOofo/scLJmShXxQ8kuPmqZPdtIvKtttJEmsTknbQ5t6SS85qMYpHyJ9+cu028aIWyV8HwcKkw1Fbz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713733275; c=relaxed/simple;
	bh=WEzcw0bsNdbQiVJCh2cyN4ebxDXiBmsodAnyG3QSU0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NGnKsXxXy1DBZTtDz4a77Dzen3Kg59oxA6Cf7oKXTyNR0dLDIqoXdPCJ0kHW7tL4F3wGPLJTCP7Yo5BuNlMoFhCpJG/y5qq+7XmC7OIDkUAOZ8O/GQUyilZ1Hw0KRv4dFWlUNfVwq8UQELA/0fY01W78qePsjp68o6O8Zy1i08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af37f.dynamic.kabel-deutschland.de [95.90.243.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E0FEB61E5FE05;
	Sun, 21 Apr 2024 23:00:52 +0200 (CEST)
Message-ID: <8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de>
Date: Sun, 21 Apr 2024 23:00:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot introduced: v6.1.82..v6.1.83


Dear Jeremy,


Am 21.04.24 um 15:54 schrieb Jeremy Lainé:

> After upgrading my kernel to Debian's latest version (6.1.85), I
> started encountering systematic kernel BUGs at boot, making the
> bluetooth stack unusable. I initially reported this to Debian's bug
> tracker:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1069301
> 
> .. but have since confirmed that this is reproducible with vanilla
> kernels, including the latest 6.1.y version (6.1.87).

Thank you for reporting this and taking the time to pinpoint the version.

> I tried various kernel versions (straight from kernel.org) to pinpoint
> when the problem started occurring and the resultats are:
> 
> - linux 6.1.80 => OK
> - linux 6.1.82 => OK
> - linux 6.1.83 => BUG
> - linux 6.1.85 => BUG
> - linux 6.1.87 => BUG
> 
> I have included a trace below, and full system details are available
> in the Debian bug listed above. Can you suggest any other tests I can
> perform to help diagnose the origin of the problem?

Would you be so kind to go the extra mail, and bisect the commit between 
6.1.82 and 6.1.83 [1]?

> [   22.660847] list_del corruption, ffff94d9f6302000->prev is LIST_POISON2 (dead000000000122)
> [   22.660887] ------------[ cut here ]------------
> [   22.660890] kernel BUG at lib/list_debug.c:56!
> [   22.660907] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   22.660917] CPU: 10 PID: 139 Comm: kworker/u25:0 Not tainted 6.1.0-20-amd64 #1  Debian 6.1.85-1
> [   22.660929] Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.19.1 03/14/2024
> [   22.660936] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> [   22.661128] RIP: 0010:__list_del_entry_valid.cold+0x4b/0x6f
> [   22.661147] Code: fe ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 48 18 7a 9f e8 14 a1 fe ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 10 18 7a 9f e8 00 a1 fe ff <0f> 0b 48 89 fe 48 c7 c7 d8 17 7a 9f e8 ef a0 fe ff 0f 0b 48 89 fe
> [   22.661156] RSP: 0000:ffffae0e406efde0 EFLAGS: 00010246
> [   22.661164] RAX: 000000000000004e RBX: ffff94d9f6302000 RCX: 0000000000000027
> [   22.661172] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff94dfaf8a03a0
> [   22.661177] RBP: ffff94d859392000 R08: 0000000000000000 R09: ffffae0e406efc78
> [   22.661182] R10: 0000000000000003 R11: ffffffff9fed4448 R12: ffff94d859392000
> [   22.661187] R13: ffff94d859392770 R14: ffff94d858cb9800 R15: dead000000000100
> [   22.661194] FS:  0000000000000000(0000) GS:ffff94dfaf880000(0000) knlGS:0000000000000000
> [   22.661202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.661208] CR2: 00007f423c024038 CR3: 0000000799c04000 CR4: 0000000000750ee0
> [   22.661214] PKRU: 55555554
> [   22.661218] Call Trace:
> [   22.661225]  <TASK>
> [   22.661232]  ? __die_body.cold+0x1a/0x1f
> [   22.661246]  ? die+0x2a/0x50
> [   22.661257]  ? do_trap+0xc5/0x110
> [   22.661268]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661279]  ? do_error_trap+0x6a/0x90
> [   22.661289]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661298]  ? exc_invalid_op+0x4c/0x60
> [   22.661307]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661316]  ? asm_exc_invalid_op+0x16/0x20
> [   22.661328]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661337]  hci_conn_del+0x136/0x3e0 [bluetooth]
> [   22.661466]  hci_abort_conn_sync+0xaa/0x230 [bluetooth]
> [   22.661632]  ? abort_conn_sync+0x3d/0x70 [bluetooth]
> [   22.661751]  hci_cmd_sync_work+0x9f/0x150 [bluetooth]
> [   22.661915]  process_one_work+0x1c4/0x380
> [   22.661929]  worker_thread+0x4d/0x380
> [   22.661940]  ? rescuer_thread+0x3a0/0x3a0
> [   22.661950]  kthread+0xd7/0x100
> [   22.661959]  ? kthread_complete_and_exit+0x20/0x20
> [   22.661969]  ret_from_fork+0x1f/0x30
> [   22.661984]  </TASK>

You can pipe the output through `scripts/decodecode` and it should show 
more information.

[…]


Kind regards,

Paul


[1]: 
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
