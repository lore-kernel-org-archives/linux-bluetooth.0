Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809534CFCF
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938288; cv=none; b=MxnC3x96s//tydBRhqgDGi5WZMFPwm4U0MjFuRHGhHcLm4h+SWOhIvBAsVdeCvrv4Sa7yp8HgB55JcuKIZbmN1klWu8o/HIlbwawYUjS56fl9eNDW69RTkENwfeBURsqPrIXiOjBOH+iyhtOgvsDhvH/rCuiBiia190Jlv+Ttso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938288; c=relaxed/simple;
	bh=28kdi/rbzdGcHK6YLx4nQWxfR3Qrepjzmqu8EjYmfEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KQzVhqEnT+gLiiOwf0Z7gJUpqiIVrxGE8bsUU3w9DeLZsyZQjCt8P3M9m3nV6jHiqJXn3ILdnn45AvzCzNf2deyngDcncORs8Pnyjv+6xwg1sGqnsi9zwrkfCmZkN1zOv0DsWQ/cSKvwB3sW0sN/fa8weEIm9XrOZWnifXris8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a713.dip0.t-ipconnect.de [91.19.167.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1DF7B4C4430F86;
	Tue, 31 Mar 2026 08:24:35 +0200 (CEST)
Message-ID: <e96776d6-ce8c-4626-984e-474f3606445d@molgen.mpg.de>
Date: Tue, 31 Mar 2026 08:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops with 6.19.10: RIP: 0010:hci_sock_get_channel+0x5/0x20
To: Gabor Gombas <gombasgg@gmail.com>
References: <actZBr+wqcABY5mt@lan>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <actZBr+wqcABY5mt@lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot ^introduced: v6.19.6..v6.19.10

Dear Gabor,


Thank you for your report.

Am 31.03.26 um 07:17 schrieb Gabor Gombas:

> I've upgraded to 6.19.10, and within an hour, I got the below Oops. The
> line from bluetoothd is the only syslog entry close to the oops. 6.19.6
> run fine on the same host since it was released.
> 
> Mar 30 22:00:43 host bluetoothd[807]: Path /org/bleak/65/140683142893552 removed along with Adv Monitor app :1.103
> Mar 30 22:00:43 host kernel: Oops: general protection fault, probably for non-canonical address 0xf712f8c7a288279f: 0000 [#1] SMP PTI
> Mar 30 22:00:43 host kernel: CPU: 1 UID: 0 PID: 807 Comm: bluetoothd Not tainted 6.19.10-gg #48 PREEMPT(lazy)
> Mar 30 22:00:43 host kernel: Hardware name:  /D54250WYK, BIOS WYLPT10H.86A.0045.2017.0302.2108 03/02/2017
> Mar 30 22:00:43 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
> Mar 30 22:00:43 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
> Mar 30 22:00:43 host kernel: RSP: 0018:ffffbb74c11afa68 EFLAGS: 00010206
> Mar 30 22:00:43 host kernel: RAX: 0000000000000000 RBX: ffff9c46c5ead600 RCX: 0000000000000002
> Mar 30 22:00:43 host kernel: RDX: ffff9c46c97e1f80 RSI: 000000000000000d RDI: f712f8c7a288242d
> Mar 30 22:00:43 host kernel: RBP: 0000000000000000 R08: ffffffff8296f7b0 R09: 0000000000000002
> Mar 30 22:00:43 host kernel: R10: ffff9c46cb124000 R11: ffff9c4796f88400 R12: ffff9c46cb124b28
> Mar 30 22:00:43 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff9c46cb124b08
> Mar 30 22:00:43 host kernel: FS:  00007fec5ee85340(0000) GS:ffff9c4853a17000(0000) knlGS:0000000000000000
> Mar 30 22:00:43 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 30 22:00:43 host kernel: CR2: 00007f959681a008 CR3: 0000000118f08001 CR4: 00000000001726f0
> Mar 30 22:00:43 host kernel: Call Trace:
> Mar 30 22:00:43 host kernel:  <TASK>
> Mar 30 22:00:43 host kernel:  mgmt_pending_find+0x48/0xa0
> Mar 30 22:00:43 host kernel:  remove_adv_monitor+0x3b/0x120
> Mar 30 22:00:43 host kernel:  ? _raw_read_lock+0x13/0x40
> Mar 30 22:00:43 host kernel:  hci_sock_sendmsg+0x656/0xb40
> Mar 30 22:00:43 host kernel:  sock_write_iter+0x181/0x190
> Mar 30 22:00:43 host kernel:  do_iter_readv_writev+0x139/0x230
> Mar 30 22:00:43 host kernel:  vfs_writev+0x120/0x3a0
> Mar 30 22:00:43 host kernel:  ? __seccomp_filter+0x34/0x5b0
> Mar 30 22:00:43 host kernel:  ? _copy_to_iter+0x87/0x6b0
> Mar 30 22:00:43 host kernel:  ? __seccomp_filter+0x34/0x5b0
> Mar 30 22:00:43 host kernel:  ? do_writev+0xde/0x110
> Mar 30 22:00:43 host kernel:  do_writev+0xde/0x110
> Mar 30 22:00:43 host kernel:  do_syscall_64+0x6c/0xe90
> Mar 30 22:00:43 host kernel:  ? syscall_exit_work+0x13e/0x1b0
> Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x8a/0xe90
> Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x8a/0xe90
> Mar 30 22:00:43 host kernel:  ? switch_fpu_return+0x16/0xd0
> Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x29f/0xe90
> Mar 30 22:00:43 host kernel:  ? handle_softirqs+0x13f/0x2a0
> Mar 30 22:00:43 host kernel:  ? irqentry_exit+0x48/0x530
> Mar 30 22:00:43 host kernel:  entry_SYSCALL_64_after_hwframe+0x71/0x79
> Mar 30 22:00:43 host kernel: RIP: 0033:0x7fec5f333e92
> Mar 30 22:00:43 host kernel: Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
> Mar 30 22:00:43 host kernel: RSP: 002b:00007ffc60d23590 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
> Mar 30 22:00:43 host kernel: RAX: ffffffffffffffda RBX: 00007ffc60d23610 RCX: 00007fec5f333e92
> Mar 30 22:00:43 host kernel: RDX: 0000000000000001 RSI: 00007ffc60d23610 RDI: 0000000000000008
> Mar 30 22:00:43 host kernel: RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
> Mar 30 22:00:43 host kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 000055bcb1bf7e60
> Mar 30 22:00:43 host kernel: R13: 000055bcb1bf9f90 R14: 000055bcb1c15520 R15: 0000000000000000
> Mar 30 22:00:43 host kernel:  </TASK>
> Mar 30 22:00:43 host kernel: Modules linked in: ip_set tun rfcomm 8021q algif_hash algif_skcipher af_alg bnep uinput kvm_intel iwlmvm mei_hdcp nls_cp437 kvm iwlwifi at24 vfat regmap_i2c fat irqbypass ir_rc6_decoder rc_rc6_mce n>
> Mar 30 22:00:43 host kernel: ---[ end trace 0000000000000000 ]---
> Mar 30 22:00:44 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
> Mar 30 22:00:44 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
> Mar 30 22:00:44 host kernel: RSP: 0018:ffffbb74c11afa68 EFLAGS: 00010206
> Mar 30 22:00:44 host kernel: RAX: 0000000000000000 RBX: ffff9c46c5ead600 RCX: 0000000000000002
> Mar 30 22:00:44 host kernel: RDX: ffff9c46c97e1f80 RSI: 000000000000000d RDI: f712f8c7a288242d
> Mar 30 22:00:44 host kernel: RBP: 0000000000000000 R08: ffffffff8296f7b0 R09: 0000000000000002
> Mar 30 22:00:44 host kernel: R10: ffff9c46cb124000 R11: ffff9c4796f88400 R12: ffff9c46cb124b28
> Mar 30 22:00:44 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff9c46cb124b08
> Mar 30 22:00:44 host kernel: FS:  00007fec5ee85340(0000) GS:ffff9c4853a17000(0000) knlGS:0000000000000000
> Mar 30 22:00:44 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 30 22:00:44 host kernel: CR2: 00007f959681a008 CR3: 0000000118f08001 CR4: 00000000001726f0

Can you reproduce the issue? If yes, it’d be a great help, if you could 
bisect the issue.


Kind regards,

Paul
