Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6ADC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjEAVJX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAVJW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 17:09:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CCE4E
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 14:09:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4efec123b28so3999551e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682975358; x=1685567358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZWMfL1gZyfKjd2+PjEqVhASmAlLngPyRnP0OtVY6rQ=;
        b=ee30x9h6i2ufRAiYsampRymOWb/5vKjVk6Hy/86nwUBM1X1cAT90XKh0Y9bMRA19+c
         PHzuwnB0saiBQ2q3oQ3Or0RcF4J+2L7nxFN7DA9jOGYd4qK2AEmSFaK9in34jw9AvJmK
         2rSGra/CN0k50m+gUjhijqolwfhaZ+HlglzeMmC/sD0CTdWuTy8RM72dQ5S6CvjHcL9g
         1+kt2hGw4Hn3E/lDB+VCNDXh4oQCuKRkQt3wB+ZAaLor8BsudyvIoSUHlnyeFcQwEPdy
         CMzErDw5m6hSPH5Pbq5O6bKBN5oCgejXOH09CYBsVJJ7zYXfKkUc4QHJaVOGHHCcaWow
         HcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682975358; x=1685567358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZWMfL1gZyfKjd2+PjEqVhASmAlLngPyRnP0OtVY6rQ=;
        b=BFuzzvxbk98RBjDUeenLSTqVMlLQInmA4JjPT13SstuXtNujBXaCXpVzytUcJDPavV
         ISgzh8lKcS+y6Ye9s1nc4NVZJyPojoiH/VBYiIGCAK8FDLppKH8bmb3HGaH0LdUGyrWd
         aDvkdCjBrS/USoi7gg7cC1FSGFITXsSYzegNr1H/cKxEF+CkT09wpophvHtTKFDlAZcO
         InLk8/vZHyYm/e910s4DIXPd+ymABNqmGP5ftXB9s05vZ+VOwdsNWvz3NhpKnoD+CX9I
         IwcD+vbmFD6bgkpHVLDxyAb36E6X1bxTx+B6jBJNSS+avia4ulIN1Hx2/5vDNan049PQ
         OeZg==
X-Gm-Message-State: AC+VfDxA8FQfcyLB3oMZ/WceghRYL4UJJuMQCnUhyelwWQXt/A53trND
        dc+0qvXPpkIf02lfML/perIDsFFa63V/YuQZPvQ=
X-Google-Smtp-Source: ACHHUZ4X3Vy9xJPyruEWxL1zgbmUIekVqSZRTqYkzd+fK4j9VpROIiHM2n7cjVVgE6oeTZiiIU2ePAVEX1a0DOexpjo=
X-Received: by 2002:ac2:46d5:0:b0:4e7:4a3c:697 with SMTP id
 p21-20020ac246d5000000b004e74a3c0697mr4425495lfo.38.1682975358187; Mon, 01
 May 2023 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230430171847.156825-1-lrh2000@pku.edu.cn> <644eabeb.0c0a0220.1245d.fc0b@mx.google.com>
 <rr6fty7uos26m2yh4aphn4bd4q6nrbnjhgfi4kvah7llkuvycp@gryksomvznb4>
In-Reply-To: <rr6fty7uos26m2yh4aphn4bd4q6nrbnjhgfi4kvah7llkuvycp@gryksomvznb4>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 May 2023 14:09:05 -0700
Message-ID: <CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com>
Subject: Re: Bluetooth: Fix UAF in hci_conn_hash_flush again
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ruihan,

On Sun, Apr 30, 2023 at 11:23=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> wro=
te:
>
> On Sun, Apr 30, 2023 at 10:56:59AM -0700, bluez.test.bot@gmail.com wrote:
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script
> > Output:
> > Bluetooth: Fix UAF in hci_conn_hash_flush again
> > WARNING: Reported-by: should be immediately followed by Link: with a UR=
L to the report
> > #92:
> > Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D8bb72f86fc823817bc5d
> >
> > WARNING: Unknown link reference 'Closes:', use 'Link:' instead
> > #93:
> > Closes: https://syzkaller.appspot.com/bug?extid=3D8bb72f86fc823817bc5d
> >
>
> Well, CI is out of date, as the mainline has changed this from 'Link:' to
> 'Closes:' [1].
>
>  [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D44c31888098a590b8ec5ba37009e5a983f7c4b46
>
> > CHECK: Alignment should match open parenthesis
> > #163: FILE: net/bluetooth/hci_conn.c:2473:
> > +     while ((conn =3D list_first_entry_or_null(head,
> > +                             struct hci_conn, list)) !=3D NULL) {
> >
> > total: 0 errors, 2 warnings, 1 checks, 57 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > /github/workspace/src/src/13227257.patch has style problems, please rev=
iew.
> >
> > NOTE: Ignored message types: UNKNOWN_COMMIT_ID
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> Thanks,
> Ruihan Li

I guess this depends on the order the connection is added into the
list since after applying your changes it causes the following trace
with iso-tester:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in hci_conn_unlink
(./include/linux/list.h:114 ./include/linux/list.h:137
./include/linux/rculist.h:157 net/bl
Write of size 8 at addr ffff8880012e89d0 by task iso-tester/31

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc36
04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (./arch/x86/include/asm/irqflags.h:26
./arch/x86/include/asm/irqflags.h:67
./arch/x86/include/asm/irqflags.h:127 lib/dump_stack
print_report (mm/kasan/report.c:320 mm/kasan/report.c:430)
? __virt_addr_valid (./include/linux/mmzone.h:1915
./include/linux/mmzone.h:2011 arch/x86/mm/physaddr.c:65)
? hci_conn_unlink (./include/linux/list.h:114
./include/linux/list.h:137 ./include/linux/rculist.h:157
net/bluetooth/hci_conn.c:1108)
kasan_report (mm/kasan/report.c:538)
? hci_conn_unlink (./include/linux/list.h:114
./include/linux/list.h:137 ./include/linux/rculist.h:157
net/bluetooth/hci_conn.c:1108)
hci_conn_unlink (./include/linux/list.h:114 ./include/linux/list.h:137
./include/linux/rculist.h:157 net/bluetooth/hci_conn.c:1108)
hci_conn_del (./include/linux/instrumented.h:72
./include/linux/atomic/atomic-instrumented.h:27
./include/net/bluetooth/hci_core.h:1416 net/bl
hci_conn_hash_flush (net/bluetooth/hci_conn.c:2479)
hci_dev_close_sync (net/bluetooth/hci_sync.c:4943)
hci_unregister_dev (net/bluetooth/hci_core.c:556 net/bluetooth/hci_core.c:2=
703)
vhci_release (drivers/bluetooth/hci_vhci.c:670)
__fput (fs/file_table.c:322)
task_work_run (kernel/task_work.c:180 (discriminator 1))
? __pfx_task_work_run (kernel/task_work.c:147)
? mark_held_locks (kernel/locking/lockdep.c:4225)
exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49
kernel/entry/common.c:171 kernel/entry/common.c:204)
syscall_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:=
299)
do_syscall_64 (arch/x86/entry/common.c:87)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
RIP: 0033:0x7f899c2352f7
Code: ff ef 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f
1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d
00f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:    ff                       (bad)
   1:    ef                       out    %eax,(%dx)
   2:    01 00                    add    %eax,(%rax)
   4:    66 2e 0f 1f 84 00 00     cs nopw 0x0(%rax,%rax,1)
   b:    00 00 00
   e:    0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
  13:    f3 0f 1e fa              endbr64
  17:    64 8b 04 25 18 00 00     mov    %fs:0x18,%eax
  1e:    00
  1f:    85 c0                    test   %eax,%eax
  21:    75 10                    jne    0x33
  23:    b8 03 00 00 00           mov    $0x3,%eax
  28:    0f 05                    syscall
  2a:*    48                       rex.W        <-- trapping instruction
  2b:    3d                       .byte 0x3d
  2c:    0f                       .byte 0xf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:    48                       rex.W
   1:    3d                       .byte 0x3d
   2:    0f                       .byte 0xf
RSP: 002b:00007ffc785e3588 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f899c2352f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000561e1096d390 R09: 0000000000000030
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f899c9b84b0 R14: 0000000000000000 R15: 0000561e10961890
</TASK>

--=20
Luiz Augusto von Dentz
