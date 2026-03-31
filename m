Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F7391E7F
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986475; cv=none; b=XQhonp2hNWXcxnV/33G1tNdHs7XMcbHipAcU7W7xfRQdpPvNBSHGITc26qpaeRmLS+LPPMZOZ6jRfVGsOaeSFWN6jZUlqL4iaSpmrs8ToAok7SA3RMifDHBHJ6YxTv2oB4KhOU/2EyoAika1CF5fes/psHgORX6aPbby7YPaGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986475; c=relaxed/simple;
	bh=vO2+UtJveaRrDgklz6LWihG4TATBZyDl++XdxrpJj5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGSJy0pwoBr0moudCIHq95XIlqamLud5mHSc70PNn6qTD//vpkiKE3bp3duG+p04A/NBqnEmyNOOkN9saUcUCVqV7MoPgwoSFXgNS93JRijqyymXTZdIezEdisBN9aagDJ81gfegUqPV+eOR62rPmYiOh37dRWkaL1utKrQttfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVeTdScS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVeTdScS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1755638f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774986472; x=1775591272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqoL4TUjw432Lj+b3alTgzxgihGwGfQl+XtayObkJj0=;
        b=OVeTdScSBo4IWpHEnsQuY1W5SAO/NcHXhjAyGDoYTAS3ZCglzJesIJURlOoaNmchNt
         NmYv2AmeVoCdKc5wg5cDH2bm0p/5fP4GirFgKhpXo54iLRhoVH7JnwE1A5B+t7yakwYz
         YFeSTdNtXqo4imbL7zXtq9gEYdxEEQ15vGhR2T4XmTt89xJys0OMeFIerDvZT3u4OPD+
         rcegQvqMvmOjHxDVtFCIqBY3uYQYiJlCQ8BEvXxCobD/Yb2vc3CW3h5aaXAYBX5D1kLF
         vFpWt7L438odtWImiUVLxmax59yxNd8u1q9EkazCCMq1vCsJqkDq1G8DG5DToNs5xTAp
         Pewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986472; x=1775591272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqoL4TUjw432Lj+b3alTgzxgihGwGfQl+XtayObkJj0=;
        b=UZegQojajvDndeldPl8cughEmpv/aa1pFkR8cMsoPXJY25rZxmA4mU8dJMn8qWfijQ
         MuV3nhr7JHrCB/7NuKSzv/Sh0SDNmy9rLumBPdCMwaVfx/lnzaB4esaha9Diqp2YbiK8
         7Q+8lTnfMvN4c7e5bOXKykRkccLu5W7I8n7Pcfz3vZfRR2n03kCeKyhi0d8p2KAggwn9
         yJlTWnNo8wsS2aQ5qTIfpJhSiN5WHALQrHF8gVKBhL43hyONTy8iVeHADAGezXIVjJMS
         F0yf7p9yE94by2lcJvgzn89McmWrKlhoz5LUpXQkBK7ny0j5rkoMM8vpKHcj8kFhwfJI
         EloA==
X-Forwarded-Encrypted: i=1; AJvYcCXDaYKO2WInOPFryby+uHz1pO29H9TyNB/OtGyYfYuTWhQM2WJx/5jGSqOTUthhaQRViwYQKfFUKfpIqL3yZ68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU38Usg9PfXgggaB/y2Xw63Z5OIibmrOoh/x8Dcm9Ze3sFPDWL
	EkPkFG1YYdKbFyQpXemv/6DX+fJafQMlIjw+M+a8LxO0TVeRCN2+Lk/qFbVldnI15u4=
X-Gm-Gg: ATEYQzwZd+86n49n4lQTXqxqe3XqD3747RlMcyVEfibnpwO4tHUiI9q89ONDMQfo9T+
	zpa//0O+XAfrV4UYeuEcLDUstO8Bg1QkC4t5ouIH4XhlCc3ht3hV90BxKav/WKCPwIKncpv9jfp
	Pnfcp5f5n16j5k3fmL8fe4hWFsqsn+UtMA/T1PQiJ6qsIGI4an0h5vaDVtvbiE0p8WEovuDx+GV
	KbDqXqUzNLYR1vPISbfIqk1EKEQs6D++AF7OvK38G418Bt8BZXixCBSZFytUnCZihT9UyMZok4G
	GY8BOxOUlmWqHOGXXAzdRFNVxat2PtcTK2sEe0Qk7p/CDyILz/Towl2KkMxWd+xzggIP4EzsUlE
	4m9o6tJbzFkpP6gq1pbyifL7VRQgEBPeXSdq9c4JAxEUA/snPhBapLeCMc1C5aTH/BeqK3iZG6s
	ry57sVarzFNZGYMfX8XbNA4Hqpk4UmqDBM2IO++r5ZdXNTxIVreA==
X-Received: by 2002:a05:6000:2586:b0:43d:30f:122c with SMTP id ffacd0b85a97d-43d1504d1f5mr1705188f8f.5.1774986471512;
        Tue, 31 Mar 2026 12:47:51 -0700 (PDT)
Received: from raspi.lan (85-67-117-165.pool.digikabel.hu. [85.67.117.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24707f2sm31043169f8f.26.2026.03.31.12.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:47:51 -0700 (PDT)
Date: Tue, 31 Mar 2026 21:47:49 +0200
From: Gabor Gombas <gombasgg@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Oops with 6.19.10: RIP: 0010:hci_sock_get_channel+0x5/0x20
Message-ID: <acwk5Z6AwTwE4H7D@lan>
References: <actZBr+wqcABY5mt@lan>
 <e96776d6-ce8c-4626-984e-474f3606445d@molgen.mpg.de>
 <b3a60d9e-b811-42d9-bf05-f400e1302a30@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a60d9e-b811-42d9-bf05-f400e1302a30@leemhuis.info>

On Tue, Mar 31, 2026 at 09:07:48AM +0200, Thorsten Leemhuis wrote:
> On 3/31/26 08:24, Paul Menzel wrote:
> > Am 31.03.26 um 07:17 schrieb Gabor Gombas:
> >
> > Can you reproduce the issue? If yes, it’d be a great help, if you could
> > bisect the issue.
> 
> For instructions see:
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
> or https://docs.kernel.org/admin-guide/bug-bisect.html
> 
> Checking if mainline is affected is also important (the first guide
> handles that), as that determines how this needs to be handled.

Unfortunately it's unlikely that I would have time for a bisection
before the weekend. The bug can be reproduced, I've booted 6.19.10
again, and this time hit the oops after a few minutes. The oops is
slightly different, so likely it's some kind of memory corruption. The
box in question is running Home Assistant, so it is constantly scanning
for Bluetooth devices.

I have a 6.19.8 kernel which I've built some time ago but then never
used, I've booted it now, we'll see how it fares.

Gabor

Mar 31 20:29:21 host bluetoothd[810]: Path /org/bleak/66/140584461213584 removed along with Adv Monitor app :1.101
Mar 31 20:29:21 host kernel: BUG: unable to handle page fault for address: 00000000bfaf0372
Mar 31 20:29:21 host kernel: #PF: supervisor read access in kernel mode
Mar 31 20:29:21 host kernel: #PF: error_code(0x0000) - not-present page
Mar 31 20:29:21 host kernel: PGD 0 P4D 0 
Mar 31 20:29:21 host kernel: Oops: Oops: 0000 [#1] SMP PTI
Mar 31 20:29:21 host kernel: CPU: 0 UID: 0 PID: 810 Comm: bluetoothd Not tainted 6.19.10-gg #48 PREEMPT(lazy) 
Mar 31 20:29:21 host kernel: Hardware name:  /D54250WYK, BIOS WYLPT10H.86A.0045.2017.0302.2108 03/02/2017
Mar 31 20:29:21 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
Mar 31 20:29:21 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
Mar 31 20:29:21 host kernel: RSP: 0018:ffff9d7201013ad8 EFLAGS: 00010206
Mar 31 20:29:21 host kernel: RAX: 0000000000000000 RBX: ffff93d9887bec00 RCX: 0000000000000002
Mar 31 20:29:21 host kernel: RDX: ffff93d9877fbf00 RSI: 000000000000000d RDI: 00000000bfaf0000
Mar 31 20:29:21 host kernel: RBP: ffffe64e82febc40 R08: ffffffff83b6f7b0 R09: 0000000000000002
Mar 31 20:29:21 host kernel: R10: ffff93d98bda6000 R11: ffff93d985603600 R12: ffff93d98bda6b28
Mar 31 20:29:21 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff93d98bda6b08
Mar 31 20:29:21 host kernel: FS:  00007ff6a4ff2340(0000) GS:ffff93db12797000(0000) knlGS:0000000000000000
Mar 31 20:29:21 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 31 20:29:21 host kernel: CR2: 00000000bfaf0372 CR3: 000000010bc9e006 CR4: 00000000001726f0
Mar 31 20:29:21 host kernel: Call Trace:
Mar 31 20:29:21 host kernel:  <TASK>
Mar 31 20:29:21 host kernel:  mgmt_pending_find+0x48/0xa0
Mar 31 20:29:21 host kernel:  remove_adv_monitor+0x3b/0x120
Mar 31 20:29:21 host kernel:  ? _raw_read_lock+0x13/0x40
Mar 31 20:29:21 host kernel:  hci_sock_sendmsg+0x656/0xb40
Mar 31 20:29:21 host kernel:  sock_write_iter+0x181/0x190
Mar 31 20:29:21 host kernel:  ? ____sys_sendmsg+0x2e5/0x300
Mar 31 20:29:21 host kernel:  do_iter_readv_writev+0x139/0x230
Mar 31 20:29:21 host kernel:  vfs_writev+0x120/0x3a0
Mar 31 20:29:21 host kernel:  ? vfs_read+0x222/0x350
Mar 31 20:29:21 host kernel:  ? __seccomp_filter+0x34/0x5b0
Mar 31 20:29:21 host kernel:  ? do_writev+0xde/0x110
Mar 31 20:29:21 host kernel:  do_writev+0xde/0x110
Mar 31 20:29:21 host kernel:  do_syscall_64+0x6c/0xe90
Mar 31 20:29:21 host kernel:  ? syscall_exit_work+0x13e/0x1b0
Mar 31 20:29:21 host kernel:  ? do_syscall_64+0x8a/0xe90
Mar 31 20:29:21 host kernel:  ? syscall_exit_work+0x13e/0x1b0
Mar 31 20:29:21 host kernel:  ? do_syscall_64+0x8a/0xe90
Mar 31 20:29:21 host kernel:  ? irqentry_exit+0x48/0x530
Mar 31 20:29:21 host kernel:  entry_SYSCALL_64_after_hwframe+0x71/0x79
Mar 31 20:29:21 host kernel: RIP: 0033:0x7ff6a54a0e92
Mar 31 20:29:21 host kernel: Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
Mar 31 20:29:21 host kernel: RSP: 002b:00007fff3c414010 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
Mar 31 20:29:21 host kernel: RAX: ffffffffffffffda RBX: 00007fff3c414090 RCX: 00007ff6a54a0e92
Mar 31 20:29:21 host kernel: RDX: 0000000000000001 RSI: 00007fff3c414090 RDI: 0000000000000008
Mar 31 20:29:21 host kernel: RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
Mar 31 20:29:21 host kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000559419ca6e60
Mar 31 20:29:21 host kernel: R13: 0000559419ca8f90 R14: 0000559419cc6cb0 R15: 0000000000000000
Mar 31 20:29:21 host kernel:  </TASK>
Mar 31 20:29:21 host kernel: Modules linked in: ip_set tun rfcomm 8021q algif_hash algif_skcipher af_alg bnep uinput kvm_intel iwlmvm kvm at24 irqbypass nls_cp437 regmap_i2c iwlwifi vfat mei_hdcp fat ir_rc6_decoder rc_rc6_mce n>
Mar 31 20:29:21 host kernel: CR2: 00000000bfaf0372
Mar 31 20:29:21 host kernel: ---[ end trace 0000000000000000 ]---
Mar 31 20:29:21 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
Mar 31 20:29:21 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
Mar 31 20:29:21 host kernel: RSP: 0018:ffff9d7201013ad8 EFLAGS: 00010206
Mar 31 20:29:21 host kernel: RAX: 0000000000000000 RBX: ffff93d9887bec00 RCX: 0000000000000002
Mar 31 20:29:21 host kernel: RDX: ffff93d9877fbf00 RSI: 000000000000000d RDI: 00000000bfaf0000
Mar 31 20:29:21 host kernel: RBP: ffffe64e82febc40 R08: ffffffff83b6f7b0 R09: 0000000000000002
Mar 31 20:29:21 host kernel: R10: ffff93d98bda6000 R11: ffff93d985603600 R12: ffff93d98bda6b28
Mar 31 20:29:21 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff93d98bda6b08
Mar 31 20:29:21 host kernel: FS:  00007ff6a4ff2340(0000) GS:ffff93db12797000(0000) knlGS:0000000000000000
Mar 31 20:29:21 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 31 20:29:21 host kernel: CR2: 00000000bfaf0372 CR3: 000000010bc9e006 CR4: 00000000001726f0

