Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB052E413
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934284; cv=none; b=u8dQPWZzcSbtq3pP3jlDUt4JlDcAE66FQd5gcO3IeMwG8Rv8HSAWBm890+opPGqfdFbmcS5izIs81EtYJDfXd3YbKXHo7kv3VZNwhyhv8x2sgBNxoCC//324t2jiRnqcACNJCn90s6sMXGkLkElBZqJ7J0prgpWA7+QYc5oy0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934284; c=relaxed/simple;
	bh=SJgEzo7Sati9WmZYIOmoAYQA3/wGDsZPh3DEL7XFTOE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FaqVUwetJkpdDujak9PIQsZm1ws1ohgBYWq8QbB/XHK7b42nHoBoEELShDa57UpvnqNsD5YgpWNkh7IUMCBtJ634Usf8dDhV6U53qwc0c8RaXcuWXfJqKzfiGtOLpSUbV/pt9nbujnoTke18g9stKBJazcp4GNxUCQV+RvjkmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/l59l73; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/l59l73"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439d8df7620so3664325f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774934281; x=1775539081; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhY6e4V3+/orkoCbvnEiC76W8rjIXcaivhpCwKre8Ng=;
        b=B/l59l73jEir2zgwMPiJOdE1x7iXBOqIic+my4oarzcZ235PtX6XQD8JreXHCN2HTV
         keot80yDB2TpROrg9XhzK0JMoU/yBZDJsgvxPtB3ezkIzS0EZja5cXNQDKoIkoGY14NT
         n4w0eZUlbpwLwVVD8eeeUeaAb3AkBOSyFWYRb2uJSq9C1HnCD0pqVzjiNN2m08ODN2Wy
         JitsvJADgQpRon4V/iFXGK26GjCdMUFliyRmcWMTAbEdWco3+rH2uB/FRSQEkYjmB5+9
         GDuQ1/bMhEjc4UV0R1kGN2Rla6/k/VtfcGwSohRpP/P9nkizUSeuuC9N2iW1lB6oYx/7
         Glhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774934281; x=1775539081;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhY6e4V3+/orkoCbvnEiC76W8rjIXcaivhpCwKre8Ng=;
        b=RNZlHa21qckLnJ4SlLJ3afWwOzJElKQ9t+QvsB2kPibALOiv5++6Wp647HNEfjFVHs
         IhQZe7c2d05adHRTXk5F3jwgXtWLujp9VZ2FOUuGft7GWikAzNMbfG0Os8HeHbSKdUWv
         9pfEyhLjRXcNcoUTCmAGDf9WtB6Kr9ZMbtaIsSBjFyyQQTzkT1IVE5eNMaoD3oWyl4JM
         +FlRJD0VRPWiivdkncTowz+5fI9esTeYAyBlDT77yRvUk4KXrvzIJWgHGV38Qa4zjQUr
         ax2raZk4kzJ3F0KHoUeRAnf5XrzMNAsa6d34HoOn7EKkSAPs6T2L8cN0iTyN44Fqwg+F
         Z6WA==
X-Gm-Message-State: AOJu0YxUFfGIMwS/QiyYNSVchwuKb6BildCF1jo6qWkDQ7JFAE6050gm
	k2Hh/ZldWDEwDiJG4ivtvxTKI8AT3uH9KIjkTXZ6R7yiJ4JIoBT1xDA/B1H37IPh
X-Gm-Gg: ATEYQzxEWIE0ePM3ipEA2hJESoFzGciByQQLmvhWO0UM4MZE8qZwwGG+qrmSUS6Pf0a
	mWisc4KMpWsp0IP5cf9j3rlPsi31gVPCKbK0j3Nhj/HtpdenypQ99ii9U5i96KccMs4Qapkc5sa
	ukVP1kpiFRzzngjfbbG/VxzDkPkbr1CWCgm4MJ7YJFj2YAaxxiH3FHK9WwWxJ5MWehdhL4GsZCQ
	+KwBQyG4yfgABH/K09uEcpYhT+EZ7iD+K+6jg5xJe4c6lzcsA5Wsk1EKEO4VGID53jg44RLZj3t
	IjQ1lzEXK7Py7o6mn6LzOa7KDKjJ3zPHl55QJYBugcm+gH8jlDF/ms6kfaUauaALD/QpMvUzYT6
	Ydr4eOMMKcFSJRHR7V1SoiXbQ5k7taJkjdJYdrKy/DNigqvIgHMFTzf4VbeoBXabJReM3oBoqn+
	hUZwSqelDOEmX4cZl8ROseyCD291W9ycl9WlmIPdXLiHiBp8rJpzA9bbgfqy+5
X-Received: by 2002:a05:6000:3101:b0:43c:f247:4792 with SMTP id ffacd0b85a97d-43cf2474972mr20060581f8f.12.1774934280426;
        Mon, 30 Mar 2026 22:18:00 -0700 (PDT)
Received: from raspi.lan (85-67-117-165.pool.digikabel.hu. [85.67.117.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm24022035f8f.25.2026.03.30.22.18.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:18:00 -0700 (PDT)
Date: Tue, 31 Mar 2026 07:17:58 +0200
From: Gabor Gombas <gombasgg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Oops with 6.19.10
Message-ID: <actZBr+wqcABY5mt@lan>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've upgraded to 6.19.10, and within an hour, I got the below Oops. The
line from bluetoothd is the only syslog entry close to the oops. 6.19.6
run fine on the same host since it was released.

Mar 30 22:00:43 host bluetoothd[807]: Path /org/bleak/65/140683142893552 removed along with Adv Monitor app :1.103
Mar 30 22:00:43 host kernel: Oops: general protection fault, probably for non-canonical address 0xf712f8c7a288279f: 0000 [#1] SMP PTI
Mar 30 22:00:43 host kernel: CPU: 1 UID: 0 PID: 807 Comm: bluetoothd Not tainted 6.19.10-gg #48 PREEMPT(lazy) 
Mar 30 22:00:43 host kernel: Hardware name:  /D54250WYK, BIOS WYLPT10H.86A.0045.2017.0302.2108 03/02/2017
Mar 30 22:00:43 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
Mar 30 22:00:43 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
Mar 30 22:00:43 host kernel: RSP: 0018:ffffbb74c11afa68 EFLAGS: 00010206
Mar 30 22:00:43 host kernel: RAX: 0000000000000000 RBX: ffff9c46c5ead600 RCX: 0000000000000002
Mar 30 22:00:43 host kernel: RDX: ffff9c46c97e1f80 RSI: 000000000000000d RDI: f712f8c7a288242d
Mar 30 22:00:43 host kernel: RBP: 0000000000000000 R08: ffffffff8296f7b0 R09: 0000000000000002
Mar 30 22:00:43 host kernel: R10: ffff9c46cb124000 R11: ffff9c4796f88400 R12: ffff9c46cb124b28
Mar 30 22:00:43 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff9c46cb124b08
Mar 30 22:00:43 host kernel: FS:  00007fec5ee85340(0000) GS:ffff9c4853a17000(0000) knlGS:0000000000000000
Mar 30 22:00:43 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 30 22:00:43 host kernel: CR2: 00007f959681a008 CR3: 0000000118f08001 CR4: 00000000001726f0
Mar 30 22:00:43 host kernel: Call Trace:
Mar 30 22:00:43 host kernel:  <TASK>
Mar 30 22:00:43 host kernel:  mgmt_pending_find+0x48/0xa0
Mar 30 22:00:43 host kernel:  remove_adv_monitor+0x3b/0x120
Mar 30 22:00:43 host kernel:  ? _raw_read_lock+0x13/0x40
Mar 30 22:00:43 host kernel:  hci_sock_sendmsg+0x656/0xb40
Mar 30 22:00:43 host kernel:  sock_write_iter+0x181/0x190
Mar 30 22:00:43 host kernel:  do_iter_readv_writev+0x139/0x230
Mar 30 22:00:43 host kernel:  vfs_writev+0x120/0x3a0
Mar 30 22:00:43 host kernel:  ? __seccomp_filter+0x34/0x5b0
Mar 30 22:00:43 host kernel:  ? _copy_to_iter+0x87/0x6b0
Mar 30 22:00:43 host kernel:  ? __seccomp_filter+0x34/0x5b0
Mar 30 22:00:43 host kernel:  ? do_writev+0xde/0x110
Mar 30 22:00:43 host kernel:  do_writev+0xde/0x110
Mar 30 22:00:43 host kernel:  do_syscall_64+0x6c/0xe90
Mar 30 22:00:43 host kernel:  ? syscall_exit_work+0x13e/0x1b0
Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x8a/0xe90
Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x8a/0xe90
Mar 30 22:00:43 host kernel:  ? switch_fpu_return+0x16/0xd0
Mar 30 22:00:43 host kernel:  ? do_syscall_64+0x29f/0xe90
Mar 30 22:00:43 host kernel:  ? handle_softirqs+0x13f/0x2a0
Mar 30 22:00:43 host kernel:  ? irqentry_exit+0x48/0x530
Mar 30 22:00:43 host kernel:  entry_SYSCALL_64_after_hwframe+0x71/0x79
Mar 30 22:00:43 host kernel: RIP: 0033:0x7fec5f333e92
Mar 30 22:00:43 host kernel: Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
Mar 30 22:00:43 host kernel: RSP: 002b:00007ffc60d23590 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
Mar 30 22:00:43 host kernel: RAX: ffffffffffffffda RBX: 00007ffc60d23610 RCX: 00007fec5f333e92
Mar 30 22:00:43 host kernel: RDX: 0000000000000001 RSI: 00007ffc60d23610 RDI: 0000000000000008
Mar 30 22:00:43 host kernel: RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
Mar 30 22:00:43 host kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 000055bcb1bf7e60
Mar 30 22:00:43 host kernel: R13: 000055bcb1bf9f90 R14: 000055bcb1c15520 R15: 0000000000000000
Mar 30 22:00:43 host kernel:  </TASK>
Mar 30 22:00:43 host kernel: Modules linked in: ip_set tun rfcomm 8021q algif_hash algif_skcipher af_alg bnep uinput kvm_intel iwlmvm mei_hdcp nls_cp437 kvm iwlwifi at24 vfat regmap_i2c fat irqbypass ir_rc6_decoder rc_rc6_mce n>
Mar 30 22:00:43 host kernel: ---[ end trace 0000000000000000 ]---
Mar 30 22:00:44 host kernel: RIP: 0010:hci_sock_get_channel+0x5/0x20
Mar 30 22:00:44 host kernel: Code: 0f a3 b7 78 03 00 00 0f 92 c0 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <0f> b7 87 72 03 00 00 c3 cc cc cc cc 0f 1f 40 00 66 66 2e 0f 1f 84
Mar 30 22:00:44 host kernel: RSP: 0018:ffffbb74c11afa68 EFLAGS: 00010206
Mar 30 22:00:44 host kernel: RAX: 0000000000000000 RBX: ffff9c46c5ead600 RCX: 0000000000000002
Mar 30 22:00:44 host kernel: RDX: ffff9c46c97e1f80 RSI: 000000000000000d RDI: f712f8c7a288242d
Mar 30 22:00:44 host kernel: RBP: 0000000000000000 R08: ffffffff8296f7b0 R09: 0000000000000002
Mar 30 22:00:44 host kernel: R10: ffff9c46cb124000 R11: ffff9c4796f88400 R12: ffff9c46cb124b28
Mar 30 22:00:44 host kernel: R13: 0000000000000003 R14: 000000000000000d R15: ffff9c46cb124b08
Mar 30 22:00:44 host kernel: FS:  00007fec5ee85340(0000) GS:ffff9c4853a17000(0000) knlGS:0000000000000000
Mar 30 22:00:44 host kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 30 22:00:44 host kernel: CR2: 00007f959681a008 CR3: 0000000118f08001 CR4: 00000000001726f0

Regards,
Gabor
