Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 05:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FF86108E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 05:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhIAFhv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:37:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33718 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbhIAFhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 01:37:50 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8980CECED;
        Wed,  1 Sep 2021 07:36:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RESEND] Bluetooth: fix use-after-free error in
 lock_sock_nested()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210901003537.415528-1-luiz.dentz@gmail.com>
Date:   Wed, 1 Sep 2021 07:36:52 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D89E06B8-8B36-494B-BD2E-21815F562E90@holtmann.org>
References: <20210901003537.415528-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> use-after-free error in lock_sock_nested is reported:
> 
> [  179.140137][ T3731] =====================================================
> [  179.142675][ T3731] BUG: KMSAN: use-after-free in lock_sock_nested+0x280/0x2c0
> [  179.145494][ T3731] CPU: 4 PID: 3731 Comm: kworker/4:2 Not tainted 5.12.0-rc6+ #54
> [  179.148432][ T3731] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [  179.151806][ T3731] Workqueue: events l2cap_chan_timeout
> [  179.152730][ T3731] Call Trace:
> [  179.153301][ T3731]  dump_stack+0x24c/0x2e0
> [  179.154063][ T3731]  kmsan_report+0xfb/0x1e0
> [  179.154855][ T3731]  __msan_warning+0x5c/0xa0
> [  179.155579][ T3731]  lock_sock_nested+0x280/0x2c0
> [  179.156436][ T3731]  ? kmsan_get_metadata+0x116/0x180
> [  179.157257][ T3731]  l2cap_sock_teardown_cb+0xb8/0x890
> [  179.158154][ T3731]  ? __msan_metadata_ptr_for_load_8+0x10/0x20
> [  179.159141][ T3731]  ? kmsan_get_metadata+0x116/0x180
> [  179.159994][ T3731]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
> [  179.160959][ T3731]  ? l2cap_sock_recv_cb+0x420/0x420
> [  179.161834][ T3731]  l2cap_chan_del+0x3e1/0x1d50
> [  179.162608][ T3731]  ? kmsan_get_metadata+0x116/0x180
> [  179.163435][ T3731]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
> [  179.164406][ T3731]  l2cap_chan_close+0xeea/0x1050
> [  179.165189][ T3731]  ? kmsan_internal_unpoison_shadow+0x42/0x70
> [  179.166180][ T3731]  l2cap_chan_timeout+0x1da/0x590
> [  179.167066][ T3731]  ? __msan_metadata_ptr_for_load_8+0x10/0x20
> [  179.168023][ T3731]  ? l2cap_chan_create+0x560/0x560
> [  179.168818][ T3731]  process_one_work+0x121d/0x1ff0
> [  179.169598][ T3731]  worker_thread+0x121b/0x2370
> [  179.170346][ T3731]  kthread+0x4ef/0x610
> [  179.171010][ T3731]  ? process_one_work+0x1ff0/0x1ff0
> [  179.171828][ T3731]  ? kthread_blkcg+0x110/0x110
> [  179.172587][ T3731]  ret_from_fork+0x1f/0x30
> [  179.173348][ T3731]
> [  179.173752][ T3731] Uninit was created at:
> [  179.174409][ T3731]  kmsan_internal_poison_shadow+0x5c/0xf0
> [  179.175373][ T3731]  kmsan_slab_free+0x76/0xc0
> [  179.176060][ T3731]  kfree+0x3a5/0x1180
> [  179.176664][ T3731]  __sk_destruct+0x8af/0xb80
> [  179.177375][ T3731]  __sk_free+0x812/0x8c0
> [  179.178032][ T3731]  sk_free+0x97/0x130
> [  179.178686][ T3731]  l2cap_sock_release+0x3d5/0x4d0
> [  179.179457][ T3731]  sock_close+0x150/0x450
> [  179.180117][ T3731]  __fput+0x6bd/0xf00
> [  179.180787][ T3731]  ____fput+0x37/0x40
> [  179.181481][ T3731]  task_work_run+0x140/0x280
> [  179.182219][ T3731]  do_exit+0xe51/0x3e60
> [  179.182930][ T3731]  do_group_exit+0x20e/0x450
> [  179.183656][ T3731]  get_signal+0x2dfb/0x38f0
> [  179.184344][ T3731]  arch_do_signal_or_restart+0xaa/0xe10
> [  179.185266][ T3731]  exit_to_user_mode_prepare+0x2d2/0x560
> [  179.186136][ T3731]  syscall_exit_to_user_mode+0x35/0x60
> [  179.186984][ T3731]  do_syscall_64+0xc5/0x140
> [  179.187681][ T3731]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  179.188604][ T3731] =====================================================
> 
> In our case, there are two Thread A and B:
> 
> Context: Thread A:              Context: Thread B:
> 
> l2cap_chan_timeout()            __se_sys_shutdown()
>  l2cap_chan_close()              l2cap_sock_shutdown()
>    l2cap_chan_del()                l2cap_chan_close()
>      l2cap_sock_teardown_cb()        l2cap_sock_teardown_cb()
> 
> Once l2cap_sock_teardown_cb() excuted, this sock will be marked as SOCK_ZAPPED,
> and can be treated as killable in l2cap_sock_kill() if sock_orphan() has
> excuted, at this time we close sock through sock_close() which end to call
> l2cap_sock_kill() like Thread C:
> 
> Context: Thread C:
> 
> sock_close()
>  l2cap_sock_release()
>    sock_orphan()
>    l2cap_sock_kill()  #free sock if refcnt is 1
> 
> If C completed, Once A or B reaches l2cap_sock_teardown_cb() again,
> use-after-free happened.
> 
> We should set chan->data to NULL if sock is destructed, for telling teardown
> operation is not allowed in l2cap_sock_teardown_cb(), and also we should
> avoid killing an already killed socket in l2cap_sock_close_cb().
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

