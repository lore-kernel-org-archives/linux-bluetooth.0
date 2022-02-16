Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiBPKYI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:24:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiBPKYH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 05:24:07 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB742069AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 02:23:54 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 410AECEDE2;
        Wed, 16 Feb 2022 11:23:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v1] Bluetooth: fix data races in smp_unregister(),
 smp_del_chan()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220216043714.22011-1-linma@zju.edu.cn>
Date:   Wed, 16 Feb 2022 11:23:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7C579AAE-EB97-4C87-9E5E-C39ACF6FF37B@holtmann.org>
References: <20220216043714.22011-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lin,

> Previous commit e04480920d1e ("Bluetooth: defer cleanup of resources
> in hci_unregister_dev()") defers all destructive actions to
> hci_release_dev() to prevent cocurrent problems like NPD, UAF.
> 
> However, there are still some exceptions that are ignored.
> 
> The smp_unregister() in hci_dev_close_sync() (previously in
> hci_dev_do_close) will release resources like the sensitive channel
> and the smp_dev objects. Consider the situations the device is detaching
> or power down while the kernel is still operating on it, the following
> data race could take place.
> 
> thread-A  hci_dev_close_sync  | thread-B  read_local_oob_ext_data
>                              |
> hci_dev_unlock()              |
> ...                           | hci_dev_lock()
> if (hdev->smp_data)           |
>  chan = hdev->smp_data       |
>                              | chan = hdev->smp_data (3)
>                              |
>  hdev->smp_data = NULL (1)   | if (!chan || !chan->data) (4)
>  ...                         |
>  smp = chan->data            | smp = chan->data
>  if (smp)                    |
>    chan->data = NULL (2)     |
>    ...                       |
>    kfree_sensitive(smp)      |
>                              | // dereference smp trigger UFA
> 
> That is, the objects hdev->smp_data and chan->data both suffer from the
> data races. In a preempt-enable kernel, the above schedule (when (3) is
> before (1) and (4) is before (2)) leads to UAF bugs. It can be
> reproduced in the latest kernel and below is part of the report:
> 
> [   49.097146] ================================================================
> [   49.097611] BUG: KASAN: use-after-free in smp_generate_oob+0x2dd/0x570
> [   49.097611] Read of size 8 at addr ffff888006528360 by task generate_oob/155
> [   49.097611]
> [   49.097611] Call Trace:
> [   49.097611]  <TASK>
> [   49.097611]  dump_stack_lvl+0x34/0x44
> [   49.097611]  print_address_description.constprop.0+0x1f/0x150
> [   49.097611]  ? smp_generate_oob+0x2dd/0x570
> [   49.097611]  ? smp_generate_oob+0x2dd/0x570
> [   49.097611]  kasan_report.cold+0x7f/0x11b
> [   49.097611]  ? smp_generate_oob+0x2dd/0x570
> [   49.097611]  smp_generate_oob+0x2dd/0x570
> [   49.097611]  read_local_oob_ext_data+0x689/0xc30
> [   49.097611]  ? hci_event_packet+0xc80/0xc80
> [   49.097611]  ? sysvec_apic_timer_interrupt+0x9b/0xc0
> [   49.097611]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [   49.097611]  ? mgmt_init_hdev+0x1c/0x240
> [   49.097611]  ? mgmt_init_hdev+0x28/0x240
> [   49.097611]  hci_sock_sendmsg+0x1880/0x1e70
> [   49.097611]  ? create_monitor_event+0x890/0x890
> [   49.097611]  ? create_monitor_event+0x890/0x890
> [   49.097611]  sock_sendmsg+0xdf/0x110
> [   49.097611]  __sys_sendto+0x19e/0x270
> [   49.097611]  ? __ia32_sys_getpeername+0xa0/0xa0
> [   49.097611]  ? kernel_fpu_begin_mask+0x1c0/0x1c0
> [   49.097611]  __x64_sys_sendto+0xd8/0x1b0
> [   49.097611]  ? syscall_exit_to_user_mode+0x1d/0x40
> [   49.097611]  do_syscall_64+0x3b/0x90
> [   49.097611]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   49.097611] RIP: 0033:0x7f5a59f51f64
> ...
> [   49.097611] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5a59f51f64
> [   49.097611] RDX: 0000000000000007 RSI: 00007f5a59d6ac70 RDI: 0000000000000006
> [   49.097611] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   49.097611] R10: 0000000000000040 R11: 0000000000000246 R12: 00007ffec26916ee
> [   49.097611] R13: 00007ffec26916ef R14: 00007f5a59d6afc0 R15: 00007f5a59d6b700
> 
> To solve these data races, this patch places the smp_unregister()
> function in the protected area by the hci_dev_lock(). That is, the
> smp_unregister() function can not be concurrently executed when
> operating functions (most of them are mgmt operations in mgmt.c) hold
> the device lock.
> 
> This patch is tested with kernel LOCK DEBUGGING enabled. The price from
> the extended holding time of the device lock is supposed to be low as the
> smp_unregister() function is fairly short and efficient.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> net/bluetooth/hci_sync.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

