Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F713BC11;
	Thu, 26 Sep 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342195; cv=none; b=a755NwDDivvq3cyngKb2NrGP+bNqtVJoYt7ybZmz/PfmSQnfV+pEnLQ5OCvML8S+Vy6YV+YRTe4CYjiAXl8fx9FqhWeO5IVR+7RliITm0Xa94Fff5FmWbSKkK0pER/Sm8q1/HkoQY6magMoR6E3SwZtzT+6vb6TypegLKFB3u5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342195; c=relaxed/simple;
	bh=pk/P/5qmHYgYFz0QQQn31LwXMdr9MudwggZtnAxrVYo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Eh+gViu2qJ5+WYq0Y7MpIob34zAQz7jjbeig09v+WlO/Wuey6pXEXav2qTIypk6g2eiz2N0lPvte5vq0IckaNYbIXXtDEt254/Xj5MVenfg+AGYLo0fdTGPgNlXbfm8t1bK1krVARtV5LGIJqGWuxsi95HEFSyTchVdeW+CRehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=R3cC1iMX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="R3cC1iMX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Sk1qeLgXXM6AC5oAWDYBwAZg2uKdYyvjfRrN5/35w/c=; t=1727342193;
	x=1727774193; b=R3cC1iMXHG2KrMOHJmh1yDPqmcvgIwHqcQ9ql0D6PnL56EJLU6xV6NVbZFG32
	k+C27DvcF3M0q67M5uZeb/tAPFD/b0Tdn18gNj0tLxrW4WP5mcj7ngM2cfmvwN48yWqcf3HqXywzW
	K+HXJP1i81MAsa5opDr3T6Q/voAEmy8Jf/IX1b6Pl9QeWEmcSahBPImGyoduC2ecHUdEzOHKVhSOD
	dFjSvamXx9V+VRoMmduCWNxtLUBFwj5+w/z9FoCdfxMyalymP6pEP7QSE7cEVxozlYNV1tJXrfH3s
	sAc5WOKpRP1BuHDD977i7FscMHEBOvhQDuCbNGpjPDgh08jS4g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stkbv-0000TY-G3; Thu, 26 Sep 2024 11:16:31 +0200
Message-ID: <af319b4c-2417-4f2f-85d0-e72d1c4fb2ac@leemhuis.info>
Date: Thu, 26 Sep 2024 11:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Christian Casteyde <casteyde.christian@free.fr>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] NULL dereference pointer in Bluetooth at boot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727342193;91566a06;
X-HE-SMSGID: 1stkbv-0000TY-G3

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about a regression in bugzilla.kernel.org apparently
related to the bluetooth code. As many (most?) kernel developers don't
keep an eye on the bug tracker, I decided to write this mail. To quote
from https://bugzilla.kernel.org/show_bug.cgi?id=219294 :

> Since Kernel 6.11 compiled from vanilla source, I get occasionnaly an Oops at boot on my Lenovo Slim 5.
> This is a regression.
> 
> Kernel 6.11 / Slackware 64 (Slackware 15 + recent Mesa).
> AMD 7840HS 16Go
> When the problem occurs, the boot doesn't finish, but I got the following in syslog:
> Sep 19 19:57:15 latile dnsmasq[924]: no servers found in /etc/dnsmasq.d/dnsmasq-resolv.conf, will retry
> Sep 20 22:22:29 latile kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP18.SATA], AE_NOT_FOUND (20240322/dswload2-162)
> Sep 20 22:22:29 latile kernel: ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20240322/psobject-220)
> Sep 20 22:22:29 latile kernel: ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.GPP6.WLAN._S0W], AE_ALREADY_EXISTS (20240322/dswload2-32
> 6)
> Sep 20 22:22:29 latile kernel: ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20240322/psobject-220)
> Sep 20 22:22:31 latile kernel: i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> Sep 20 22:22:34 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> Sep 20 22:22:37 latile kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
> Sep 20 22:22:37 latile kernel: #PF: supervisor read access in kernel mode
> Sep 20 22:22:37 latile kernel: #PF: error_code(0x0000) - not-present page
> Sep 20 22:22:37 latile kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> Sep 20 22:22:37 latile kernel: CPU: 2 UID: 0 PID: 153 Comm: kworker/2:1 Not tainted 6.11.0 #1
> Sep 20 22:22:37 latile kernel: Hardware name: LENOVO 82Y9/LNVNB161216, BIOS M3CN42WW 01/11/2024
> Sep 20 22:22:37 latile kernel: Workqueue: pm pm_runtime_work
> Sep 20 22:22:37 latile kernel: RIP: 0010:btusb_suspend+0x14/0x1b0
> Sep 20 22:22:37 latile kernel: Code: e4 10 00 83 80 d4 0a 00 00 01 eb db 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 48 8b 9f 
> c8 00 00 00 <48> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
> Sep 20 22:22:37 latile kernel: RSP: 0018:ffffbf1280b67ca0 EFLAGS: 00010206
> Sep 20 22:22:37 latile kernel: RAX: ffffffffa62de3b0 RBX: 0000000000000000 RCX: 0000000000000002
> Sep 20 22:22:37 latile kernel: RDX: 0000000000000003 RSI: 0000000000000402 RDI: ffff9bcc85e17000
> Sep 20 22:22:37 latile kernel: RBP: ffff9bcc85e17000 R08: ffff9bcc8930e800 R09: ffff9bcc85e174b0
> Sep 20 22:22:37 latile kernel: R10: 0000000000000003 R11: 0000000000000063 R12: 0000000000000402
> Sep 20 22:22:37 latile kernel: R13: 0000000000000003 R14: 0000000000000000 R15: ffff9bcc8930e800
> Sep 20 22:22:37 latile kernel: FS:  0000000000000000(0000) GS:ffff9bcfae480000(0000) knlGS:0000000000000000
> Sep 20 22:22:37 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Sep 20 22:22:37 latile kernel: CR2: 0000000000000000 CR3: 000000035f82a000 CR4: 0000000000750ef0
> Sep 20 22:22:37 latile kernel: PKRU: 55555554
> Sep 20 22:22:37 latile kernel: Call Trace:
> Sep 20 22:22:37 latile kernel:  <TASK>
> Sep 20 22:22:37 latile kernel:  ? __die+0x23/0x70
> Sep 20 22:22:37 latile kernel:  ? page_fault_oops+0x159/0x520
> Sep 20 22:22:37 latile kernel:  ? exc_page_fault+0x404/0x740
> Sep 20 22:22:37 latile kernel:  ? asm_exc_page_fault+0x26/0x30
> Sep 20 22:22:37 latile kernel:  ? btusb_isoc_tx_complete+0x60/0x60
> Sep 20 22:22:37 latile kernel:  ? btusb_suspend+0x14/0x1b0
> Sep 20 22:22:37 latile kernel:  usb_suspend_both+0x94/0x280
> Sep 20 22:22:37 latile kernel:  usb_runtime_suspend+0x2e/0x70
> Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
> Sep 20 22:22:37 latile kernel:  __rpm_callback+0x41/0x170
> Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
> Sep 20 22:22:37 latile kernel:  rpm_callback+0x55/0x60
> Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
> Sep 20 22:22:37 latile kernel:  rpm_suspend+0xe8/0x5e0
> Sep 20 22:22:37 latile kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Sep 20 22:22:37 latile last message buffered 1 times
> Sep 20 22:22:37 latile kernel:  ? finish_task_switch.isra.0+0x96/0x2a0
> Sep 20 22:22:37 latile kernel:  __pm_runtime_suspend+0x3c/0xd0
> Sep 20 22:22:37 latile kernel:  ? usb_runtime_resume+0x20/0x20
> Sep 20 22:22:37 latile kernel:  usb_runtime_idle+0x35/0x40
> Sep 20 22:22:37 latile kernel:  rpm_idle+0xbd/0x270
> Sep 20 22:22:37 latile kernel:  pm_runtime_work+0x84/0xb0
> Sep 20 22:22:37 latile kernel:  process_one_work+0x16d/0x380
> Sep 20 22:22:37 latile kernel:  worker_thread+0x2cb/0x3e0
> Sep 20 22:22:37 latile kernel:  ? _raw_spin_lock_irqsave+0x1b/0x50
> Sep 20 22:22:37 latile kernel:  ? cancel_delayed_work_sync+0x80/0x80
> Sep 20 22:22:37 latile kernel:  kthread+0xde/0x110
> Sep 20 22:22:37 latile kernel:  ? kthread_park+0x90/0x90
> Sep 20 22:22:37 latile kernel:  ret_from_fork+0x31/0x50
> Sep 20 22:22:37 latile kernel:  ? kthread_park+0x90/0x90
> Sep 20 22:22:37 latile kernel:  ret_from_fork_asm+0x11/0x20
> Sep 20 22:22:37 latile kernel:  </TASK>
> Sep 20 22:22:37 latile kernel: Modules linked in:
> Sep 20 22:22:37 latile kernel: CR2: 0000000000000000
> Sep 20 22:22:37 latile kernel: ---[ end trace 0000000000000000 ]---
> Sep 20 22:22:37 latile kernel: RIP: 0010:btusb_suspend+0x14/0x1b0
> Sep 20 22:22:37 latile kernel: Code: e4 10 00 83 80 d4 0a 00 00 01 eb db 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 48 8b 9f c8 00 00 00 <48> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
> Sep 20 22:22:37 latile kernel: RSP: 0018:ffffbf1280b67ca0 EFLAGS: 00010206
> Sep 20 22:22:37 latile kernel: RAX: ffffffffa62de3b0 RBX: 0000000000000000 RCX: 0000000000000002
> Sep 20 22:22:37 latile kernel: RDX: 0000000000000003 RSI: 0000000000000402 RDI: ffff9bcc85e17000
> Sep 20 22:22:37 latile kernel: RBP: ffff9bcc85e17000 R08: ffff9bcc8930e800 R09: ffff9bcc85e174b0
> Sep 20 22:22:37 latile kernel: R10: 0000000000000003 R11: 0000000000000063 R12: 0000000000000402
> Sep 20 22:22:37 latile kernel: R13: 0000000000000003 R14: 0000000000000000 R15: ffff9bcc8930e800
> Sep 20 22:22:37 latile kernel: FS:  0000000000000000(0000) GS:ffff9bcfae480000(0000) knlGS:0000000000000000
> Sep 20 22:22:37 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Sep 20 22:22:37 latile kernel: CR2: 0000000000000000 CR3: 000000035f82a000 CR4: 0000000000750ef0
> Sep 20 22:22:37 latile kernel: PKRU: 55555554
> [...]

See the ticket for more details and another oops. Reporter is CCed.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.10..v6.11
#regzbot from: Christian Casteyde <casteyde.christian@free.fr>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219294
#regzbot title: net: bluetooth: NULL dereference pointer in Bluetooth at
boot
#regzbot ignore-activity
