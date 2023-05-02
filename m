Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F37C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 13:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjEBNvG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjEBNvF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 09:51:05 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B096D180
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=lL640IPloXYs++kSoYZcruphVBUc
        u4qgO3CLZpEqBtM=; b=s8qM+P15eP41s31rUG+wViqf151M9dbavsvD/R769s2m
        iiKP4U3dPr8JGj3TVjsZ3uw8zL3IkpGl2KWujeFzg2TL/gXz69pC2/hPhiEaxqad
        asTAinXS2BOOp0wxlvSQXYXaKgp4XV+t84pMaGPbGauYNuF4F90NOfpChpviweM=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogBnYrkyE1FkIE40Eg--.11820S2;
        Tue, 02 May 2023 21:42:18 +0800 (CST)
Date:   Tue, 2 May 2023 21:42:10 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: Bluetooth: Fix UAF in hci_conn_hash_flush again
Message-ID: <bv5sayl6675zj7st3gvure5hbldtlj5jf7ydpzvf5j67nhpnva@2eqsxajgvfrq>
References: <20230430171847.156825-1-lrh2000@pku.edu.cn>
 <644eabeb.0c0a0220.1245d.fc0b@mx.google.com>
 <rr6fty7uos26m2yh4aphn4bd4q6nrbnjhgfi4kvah7llkuvycp@gryksomvznb4>
 <CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com>
X-CM-TRANSID: 54FpogBnYrkyE1FkIE40Eg--.11820S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW5CFyDZFyUCrW8ZF1UWrg_yoW7AF47pa
        s8uryfGF40qr95Zr1UA3W0kry7Jr1DuFy2qr1xur1rJws0qr10yw45KryDtrn8Gr4vkF1Y
        vF47Wr1UKF1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AASsw
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, May 01, 2023 at 02:09:05PM -0700, Luiz Augusto von Dentz wrote:
> I guess this depends on the order the connection is added into the
> list since after applying your changes it causes the following trace
> with iso-tester:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in hci_conn_unlink
> (./include/linux/list.h:114 ./include/linux/list.h:137
> ./include/linux/rculist.h:157 net/bl
> Write of size 8 at addr ffff8880012e89d0 by task iso-tester/31

It is so weird that even though KASAN reports a critical BUG, the CI
still says that all tests are passed. I think that perhaps this is also
something we need to develop a fix. (I missed the KASAN report earlier,
sorry.)

> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc36
> 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl (./arch/x86/include/asm/irqflags.h:26
> ./arch/x86/include/asm/irqflags.h:67
> ./arch/x86/include/asm/irqflags.h:127 lib/dump_stack
> print_report (mm/kasan/report.c:320 mm/kasan/report.c:430)
> ? __virt_addr_valid (./include/linux/mmzone.h:1915
> ./include/linux/mmzone.h:2011 arch/x86/mm/physaddr.c:65)
> ? hci_conn_unlink (./include/linux/list.h:114
> ./include/linux/list.h:137 ./include/linux/rculist.h:157
> net/bluetooth/hci_conn.c:1108)
> kasan_report (mm/kasan/report.c:538)
> ? hci_conn_unlink (./include/linux/list.h:114
> ./include/linux/list.h:137 ./include/linux/rculist.h:157
> net/bluetooth/hci_conn.c:1108)
> hci_conn_unlink (./include/linux/list.h:114 ./include/linux/list.h:137
> ./include/linux/rculist.h:157 net/bluetooth/hci_conn.c:1108)
> hci_conn_del (./include/linux/instrumented.h:72
> ./include/linux/atomic/atomic-instrumented.h:27
> ./include/net/bluetooth/hci_core.h:1416 net/bl
> hci_conn_hash_flush (net/bluetooth/hci_conn.c:2479)
> hci_dev_close_sync (net/bluetooth/hci_sync.c:4943)
> hci_unregister_dev (net/bluetooth/hci_core.c:556 net/bluetooth/hci_core.c:2703)
> vhci_release (drivers/bluetooth/hci_vhci.c:670)
> __fput (fs/file_table.c:322)
> task_work_run (kernel/task_work.c:180 (discriminator 1))
> ? __pfx_task_work_run (kernel/task_work.c:147)
> ? mark_held_locks (kernel/locking/lockdep.c:4225)
> exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49
> kernel/entry/common.c:171 kernel/entry/common.c:204)
> syscall_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:299)
> do_syscall_64 (arch/x86/entry/common.c:87)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> RIP: 0033:0x7f899c2352f7
> Code: ff ef 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f
> 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d
> 00f
> All code
> ========
>    0:    ff                       (bad)
>    1:    ef                       out    %eax,(%dx)
>    2:    01 00                    add    %eax,(%rax)
>    4:    66 2e 0f 1f 84 00 00     cs nopw 0x0(%rax,%rax,1)
>    b:    00 00 00
>    e:    0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
>   13:    f3 0f 1e fa              endbr64
>   17:    64 8b 04 25 18 00 00     mov    %fs:0x18,%eax
>   1e:    00
>   1f:    85 c0                    test   %eax,%eax
>   21:    75 10                    jne    0x33
>   23:    b8 03 00 00 00           mov    $0x3,%eax
>   28:    0f 05                    syscall
>   2a:*    48                       rex.W        <-- trapping instruction
>   2b:    3d                       .byte 0x3d
>   2c:    0f                       .byte 0xf
> 
> Code starting with the faulting instruction
> ===========================================
>    0:    48                       rex.W
>    1:    3d                       .byte 0x3d
>    2:    0f                       .byte 0xf
> RSP: 002b:00007ffc785e3588 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f899c2352f7
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000561e1096d390 R09: 0000000000000030
> R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007f899c9b84b0 R14: 0000000000000000 R15: 0000561e10961890
> </TASK>

This leads to another hci_conn_unlink BUG, as resolved by the following
diff:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 70e1655a9..44d0643fc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1102,12 +1102,12 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->link)
 		return;
 
-	hci_conn_put(conn->parent);
-	conn->parent = NULL;
-
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_put(conn->parent);
+	conn->parent = NULL;
+
 	kfree(conn->link);
 	conn->link = NULL;
 }

In a word, we cannot perform list_del_rcu(&conn->link->list) after
hci_conn_put, because hci_conn_put might have already invalidated the
list entry by deallocating its list head (in conn->parent).

There are actually quite a few "problems" (I think) with
hci_conn_unlink. I tried to fix them and ended up with a patch series of
six patches (each patch is fairly small, of course), including two that
have already been submitted and the one above.

I'll submit these patches later. They have to be a patch series because
they all target one function, hci_conn_unlink. So there will be a lot of
merge conflicts if they are submitted individually. I'm not
intentionally tieing them together, so in case that any patch is
inappropriate, please let me know (I'd appreciate if you could explain
why).

> -- 
> Luiz Augusto von Dentz

Thanks,
Ruihan Li

