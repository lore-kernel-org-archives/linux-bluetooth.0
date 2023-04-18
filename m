Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987BC77B71
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 05:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDRFAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRFAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 01:00:30 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 22:00:28 PDT
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89F3595
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681794028; x=1713330028;
  h=mime-version:from:date:message-id:subject:to;
  bh=98Q2lIKGXj/TGphoJQ26QVEniVJlpkDOfi8A6jvyOYU=;
  b=jme8RJHygVEFy5R5mBRtYqYZqU2//0i1/JEmH9Pgm8LS5n3rxFIQLEGT
   ueiyUBYqw6jJPI155k8833BnBvI+UoCj8tbpwfTjHocvkikIJBzTQO2X9
   Aj/Fvcu71bGJ9Bp88lmxKHl1QLlTAyo4DpuYTptmBaIuW7McgSU1mhHgk
   be+H+T+ALWGIJfwk23c88HRB3L7dFa+Z4/1BsXIylDHWTTrjglGDkUEyF
   5QI+zltnrR2lUAoUGn/xz/vHVqfV/zpBBma3KNpXzTJQ8Cqftue7/SU3Y
   V9c5uYm1WUPzVhNjrWTqZXsiBht2aZiPkqvA6uSH7X+v6teUu32nB40lR
   Q==;
Received: from mail-wm1-f70.google.com ([209.85.128.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 21:59:25 -0700
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f087e4a13eso6715315e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681793963; x=1684385963;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WO/9DwG7mN10zw1Wsfz7OasLpMvXhn/ybdShM4ePvbg=;
        b=wj6GQ1s4SgTCWv0CHvxU8LO8yABWm+VnChKGS3jwmESuFqfGe/zkBvXYk4YqShp+LM
         JUqu7vIQaWnGGPQ87duhhSvxcoWguQNRU2Bb4TC4uwJ65ExUp+Rn5C7I/vGVZNokI8XE
         WUQQE3aDrehAc/9BSJwJteP4Ahv34tVZRf3VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681793963; x=1684385963;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO/9DwG7mN10zw1Wsfz7OasLpMvXhn/ybdShM4ePvbg=;
        b=R4PoBZVA/dNy3RSJ8bToNayI3+rgqFngsMW+/RJqbGvYpsbbQNBrH/0hgMDhTgEu5/
         jMgWUfkPOmBtEJq3orYvYKfc0EknEJzmBzCDuYGILgCX78A+0pYeDsURlUvkP/uqWva3
         oh+I8NvtTRfBKsB0m5mooTXbgv86tuYiDVCUPTW7LhdC2O67WibZCR11vQjMEN0u4bTJ
         I4Czck0mTBZHHBExyxaJNsiqFsfocquOCR1lCXZ7xM0fvGETVVnFolte+B6Xy+hAzLsS
         SOhvFYNl3rqjBlB/3d34RKqEhGInSclIVEhuImF7c9BFDmaJ/n5tvkLJ+fL4ddrl6ZUO
         TOOw==
X-Gm-Message-State: AAQBX9dYYH94RseZVxUdbUNR2BafMjWOijrT2rHX+3/ASHiit2NFww6z
        CunDKDfwgDkmvv++7KRPRIt+C/hBGXyxeE3csi0J3c95x7n0vlcD0KHGMMvBRB1H5v0rhsSLu2d
        BDn7Eu+mr5G2qpn3LrwJspZ9Tps5mzYRPkhH/5eCDKDobWrE9I4NN2bn7
X-Received: by 2002:adf:ee86:0:b0:2f5:fbe5:bb1c with SMTP id b6-20020adfee86000000b002f5fbe5bb1cmr841610wro.63.1681793963333;
        Mon, 17 Apr 2023 21:59:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPjWSAfJLf/Il143EKEgyc3ZQ+0vGEJZbFk49zxFaL8teYJxnS4znmbHqDafxpzBJuLL5OqZDv+9HQkDiEA9A=
X-Received: by 2002:adf:ee86:0:b0:2f5:fbe5:bb1c with SMTP id
 b6-20020adfee86000000b002f5fbe5bb1cmr841604wro.63.1681793963031; Mon, 17 Apr
 2023 21:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 21:59:12 -0700
Message-ID: <CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com>
Subject: BUG: general protection fault in hci_uart_tty_ioctl
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

We found the following issue using syzkaller on Linux v6.2.0.

In function `hci_uart_tty_ioctl`, there is a race condition
between HCIUARTSETPROTO and HCIUARTGETPROTO.
HCI_UART_PROTO_SET is set before `hu->proto` is set.
Thus it may dereference a null pointer.

The full report including the Syzkaller reproducer & C reproducer:
https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb

The brief report is below:

Syzkaller hit 'general protection fault in hci_uart_tty_ioctl' bug.

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8770 Comm: syz-executor.0 Not tainted 6.2.0 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:hci_uart_tty_ioctl+0x244/0xc20 drivers/bluetooth/hci_ldisc.c:774
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cf 08 00 00 48 8b 9b
b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <0f> b6
04 02 84 c0 74 08 3c 03 0f 8e 5f 08 00 00 44 8b 23 e9 14 ff
RSP: 0018:ffffc900022a7d10 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8710057c
RDX: 0000000000000000 RSI: ffff888046df8000 RDI: ffff88801cf510b8
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed10039ea204
R10: ffff88801cf5101f R11: ffffed10039ea203 R12: ffff8880204eb000
R13: 0000000000000000 R14: ffffffffffffffe7 R15: 00000000800401c0
FS:  00007f203e7dd700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005587ec7f32d8 CR3: 000000004629e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tty_ioctl+0xac0/0x1420 drivers/tty/tty_io.c:2784
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x198/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f203f0902fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f203e7dcc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f203f1bc020 RCX: 00007f203f0902fd
RDX: 0000000000000000 RSI: 00000000800455c9 RDI: 0000000000000003
RBP: 00007f203f0fec89 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee4615aef R14: 00007ffee4615ca0 R15: 00007f203e7dcdc0
 </TASK>
