Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907054F1E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665517; cv=none; b=WcvPqbzNG1HtPvl5s9UU0jJ6is1JoUj45pJlJMnW2+/c9Uh25z0rIo1PpbS5Qe15sSoLcW866NkNDzbEuZeUUa+ya2gpfxeBopHRjKMipzYao/DOAA9an8Gf9YFTmg0edyL36vFYdXej3si/W4XeGhsYDBO02dOPQmH4vSJqPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665517; c=relaxed/simple;
	bh=YF/9VGqCR3NnRq2qiSBkKzD4drsN36p29YQjpDwOOF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWibSe4LuovNEHrESFCcV2L9dZoDOHPCk2MoDVcQhpR4BPI8Ro9IfFis2TIbrjLGL9pm5xZJ0Dzp1Km9kGKmKvz09aTv7BCscambUmGhQRAIR5PsWXNYNqJROlED3IYe88nK4tVI+B3lZImuta9RQ5cNJWlQ80errqcW2PZwoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKWp8tsq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKWp8tsq"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eb9d41d57so2044e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705665513; x=1706270313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cAlbKavRuOVyWI1tc7ET/JPkNgvFzUd+Nd5ZfFEBLDM=;
        b=KKWp8tsqbPFBTH9W1XevhpWpJZOoa12zOLjWccmVpFMwJNom4SAv2oF8PGttISiLn1
         wnMarZre/DK4aEGdd7DHOP4MNZHyQoU5FXUHQktVg+eCm1gAifVxVDYaAJx/27oo4XcQ
         OQYLt7w4We15KZ/POC/epmlDxgylQ2QNymt2Pl7F1n3V7qMRTxp2kz/GVgCsNcfKHK0K
         QQY+sRjMx+sgnPM9bl7RBVN2Izv1KPuF+hGjgnXkXsuvdQh7GrHCzF6Cvn46NQmbnfTP
         naO/rIVmyut3avzoI2e3WbcIPcaNKOdswfifpxsjp9rhJcH/nzLtfQDmMCizzi2yzRqw
         a5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665513; x=1706270313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAlbKavRuOVyWI1tc7ET/JPkNgvFzUd+Nd5ZfFEBLDM=;
        b=oxUGA5tYJrX4u47GLm2dd+odOXIdCM8g3uTbVyZthZDfGe5oNXWfuWU39pTIGvr5wR
         uK1xr/pOSfhIokjfOYCodYRkqmIjaSn4iIm6iFKEIWRoOzV/hSDXKfwAU6Xf0UHHNK4F
         ZcF7HxxbsJWHXg6tnf4X2IZ/S66HwSDBUD5lj7LSQq6I0tS6shXbr2UPGdFk7IDhvWTu
         z9k4PCKbWyeWxLAo3Dn4zIIEEVGMqP1WI9HYzVs3FCWJuAARTLY3iGnyIGobOOFwjQjC
         Vdv1cJcL3vZ9SKHRcN3j/AZrtFcaHBru4XUfZW3muHyjzshTyZ8IUgl/qKd8QcugYmqG
         fFOg==
X-Gm-Message-State: AOJu0YwleIKbWNdjLkrB0vWPxJr/vOxQV2WENVF2N8X1x6/uptIey7CR
	0hZS7dPA21cVHZJT7ygJsMNB4hB0IxrtKtRv3COAXLUcwcdyZeVpr6TeWsRgEp9Czf5T8/gxQyY
	/3VrONzxbF/dNPrN6cKYlahNucXWjLsVYM9C9FmYv1Fb99CByAI4y
X-Google-Smtp-Source: AGHT+IE+W2bcGytYq3XHpcl6zjaKwTL9fIYI9UTl4iqdV2PFW01+WLopAd2AorYGVBNhKOduK2b5DhCUZBwwbUL5g2M=
X-Received: by 2002:a19:e005:0:b0:50e:3828:d29d with SMTP id
 x5-20020a19e005000000b0050e3828d29dmr116990lfg.0.1705665513222; Fri, 19 Jan
 2024 03:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a135c0060a2260b3@google.com> <00000000000037f0f3060af9e763@google.com>
 <CACT4Y+YBGDYbhXvpEAo6iXS--QOSsUxXqkGZxOpUCuCd3CM3aQ@mail.gmail.com> <ZakvjMjMYK1HtYGt@casper.infradead.org>
In-Reply-To: <ZakvjMjMYK1HtYGt@casper.infradead.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 19 Jan 2024 12:58:21 +0100
Message-ID: <CACT4Y+YT-Y=b_oSFNCQgTeh8igSqfYQ40JHGTad9w2+uZ_JvNg@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>, 
	wzhmmmmm@gmail.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 15:02, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 18, 2024 at 11:21:34AM +0100, Dmitry Vyukov wrote:
> > On Sat, 25 Nov 2023 at 14:18, syzbot
> > <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
> > >
> > > Bluetooth: hci0: hardware error 0x00
> > > ==================================================================
> > > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > > BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> > > BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
> > > Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455
> > >
> > > CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> > > Workqueue: hci0 hci_error_reset
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> > >  kasan_report+0xd9/0x110 mm/kasan/report.c:588
> > >  check_region_inline mm/kasan/generic.c:182 [inline]
> > >  kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
> > >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > >  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> >
> > Wonder if this is fixed with:
> >
> > ida: Fix crash in ida_free when the bitmap is empty
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af73483f4e8b6f5c68c9aa63257bdd929a9c194a
> >
> > ?
>
> Should be.  The backtrace below looks like it's the same bug that got
> reported 3-4 weeks ago.

On second thought, perhaps the bluetooth stack shouldn't free invalid
ids in the first place.
It may even take these bogus ids from the wire, which would be pretty bad.

> > >  ida_free+0x218/0x2e0 lib/idr.c:511
> > >  hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
> > >  hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1183
> > >  hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2643
> > >  hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
> > >  hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
> > >  hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
> > >  process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
> > >  process_scheduled_works kernel/workqueue.c:2706 [inline]
> > >  worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
> > >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > >  </TASK>
> > > ==================================================================
> > >
> > >
> > > ---
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testing.
