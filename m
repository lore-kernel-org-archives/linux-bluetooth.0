Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 04:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiAFET4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiAFETz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 23:19:55 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7766AC061245
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jan 2022 20:19:55 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d1so3922009ybh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jan 2022 20:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4PT9RZrg4X7rUFKCeEirGJd/BDsWzjaKJQRIdsaUYYo=;
        b=V3iFa8gl1AHBB2ZMCJtwPu0jlCTeLDdzg8Fk6BEZXzfI9m0DSydZEHis2Yrs5De+JH
         AAfHb+EVqJr1Vp0rilhYID+RACM0t0iNIxNJHtF2q7kUaN5B0gjHVF3imeiprzX3ucZ/
         1OZN4yP9vZcHvt/9OSjMB4RUUfEJ6jMjnqHFwjzxGOyTibwieGIzRslyNe2mzhkWqIm4
         8gZgOuybYx/EmdD6d0EzUjsLy8c7Ba0qHVwDjlbiKAfHwJVnKP94iIyxqafGuxNyhHSt
         EHvzUD/x094Q8v2DmnXu9Qon3YPEGJR6wvyhAD8pPhSGVFBen1qGRuMWMGNErmspVKlr
         0dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4PT9RZrg4X7rUFKCeEirGJd/BDsWzjaKJQRIdsaUYYo=;
        b=HFAloL/l8j678KU8f75D9WqQ0OKUgjjXB8hXfyXciHQj5XLUhDmPcTZyYUVGZiN+D2
         riL0p9mQNhZQfE9FIVdbHHAkmnJL/1SZs59OFosQ0r44pVLb71Rk/8n3k0aUIlu44z/o
         Ym0Fq19HNfFphUIGb5plRjiPiPk52GgkDTQtuqT57nbFTIAvDMSg1+FYglpaHJj7yNpX
         8naF+phDU5dVQHDHcvEhO6dKp9bo0vyiBERnFT2eyY2YpNMflSV+JRvSd0VKgEsFOQOE
         lkQelhA2yp0A2Gei/WNN1LAqwiFSQOQ/yRqAhvnUOfpYS9AzrOo0CNKMTK2dNzeIZ+d1
         2NFw==
X-Gm-Message-State: AOAM532X0eCcAJfMLXruOj4SoZJeJNOdfvwwxEPBOkTtGaup+QWcicUV
        1ATtcrlXo6YS7DSyaFeAAz/Ub29Ank1vruGks+KicQNvstO7Mv6/
X-Google-Smtp-Source: ABdhPJwkQEggYYSEd8k9PiYMR7sydgm3KtmtkoJBpHWZsYm5qznl1iehOcHC9wiV7lLOzPIcSMmC4oK0gsTYV6r9Ymk=
X-Received: by 2002:a25:e705:: with SMTP id e5mr24332983ybh.618.1641442794266;
 Wed, 05 Jan 2022 20:19:54 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 5 Jan 2022 21:19:38 -0700
Message-ID: <CAJCQCtQWqBk_=Yu7SjAtg0AXoOcKWuLvv=fOh+RZiAbuqELY1w@mail.gmail.com>
Subject: 5.16.0-rc8 deadlock at rfcomm_sk_state_change
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I just experienced this soon after wake from suspend-to-ram; I haven't
noticed it previously, but a bot might have seen it before (below the
dmesg snippet).

[14646.797396] kernel: PM: resume devices took 2.975 seconds
[14646.797418] kernel: OOM killer enabled.
[14646.797426] kernel: Restarting tasks ...
[14646.822164] kernel: done.
[14646.941351] kernel: PM: suspend exit
[14646.967395] kernel: rfkill: input handler disabled
[14647.074621] kernel: e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
[14651.697550] kernel: wlp0s20f3: authenticate with f8:a0:97:6e:c7:e8
[14651.699884] kernel: wlp0s20f3: send auth to f8:a0:97:6e:c7:e8 (try 1/3)
[14651.828236] kernel: wlp0s20f3: authenticated
[14651.830313] kernel: wlp0s20f3: associate with f8:a0:97:6e:c7:e8 (try 1/3)
[14651.842846] kernel: wlp0s20f3: RX AssocResp from f8:a0:97:6e:c7:e8
(capab=0x411 status=0 aid=4)
[14651.845635] kernel: wlp0s20f3: associated
[14651.869218] kernel: wlp0s20f3: Limiting TX power to 27 (30 - 3) dBm
as advertised by f8:a0:97:6e:c7:e8
[14651.894962] kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s20f3: link
becomes ready
[14655.200461] kernel:
[14655.200468] kernel: ======================================================
[14655.200470] kernel: WARNING: possible circular locking dependency detected
[14655.200472] kernel: 5.16.0-0.rc8.55.fc36.x86_64+debug #1 Not tainted
[14655.200475] kernel: ------------------------------------------------------
[14655.200476] kernel: krfcommd/1358 is trying to acquire lock:
[14655.200479] kernel: ffff9e662103d130
(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:
rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[14655.200494] kernel:
                       but task is already holding lock:
[14655.200495] kernel: ffff9e672a54bb40 (&d->lock){+.+.}-{3:3}, at:
__rfcomm_dlc_close+0x88/0x230 [rfcomm]
[14655.200506] kernel:
                       which lock already depends on the new lock.
[14655.200508] kernel:
                       the existing dependency chain (in reverse order) is:
[14655.200509] kernel:
                       -> #2 (&d->lock){+.+.}-{3:3}:
[14655.200515] kernel:        __mutex_lock+0x93/0x910
[14655.200521] kernel:        __rfcomm_dlc_close+0x88/0x230 [rfcomm]
[14655.200527] kernel:        rfcomm_run+0x765/0x1820 [rfcomm]
[14655.200533] kernel:        kthread+0x17a/0x1a0
[14655.200538] kernel:        ret_from_fork+0x1f/0x30
[14655.200543] kernel:
                       -> #1 (rfcomm_mutex){+.+.}-{3:3}:
[14655.200548] kernel:        __mutex_lock+0x93/0x910
[14655.200551] kernel:        rfcomm_dlc_open+0x31/0x350 [rfcomm]
[14655.200557] kernel:        rfcomm_sock_connect+0xd3/0x130 [rfcomm]
[14655.200564] kernel:        __sys_connect+0x9f/0xd0
[14655.200569] kernel:        __x64_sys_connect+0x14/0x20
[14655.200573] kernel:        do_syscall_64+0x38/0x90
[14655.200578] kernel:        entry_SYSCALL_64_after_hwframe+0x44/0xae
[14655.200581] kernel:
                       -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
[14655.200586] kernel:        __lock_acquire+0x11c7/0x1de0
[14655.200590] kernel:        lock_acquire+0xd3/0x2f0
[14655.200593] kernel:        lock_sock_nested+0x2e/0x80
[14655.200597] kernel:        rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[14655.200603] kernel:        __rfcomm_dlc_close+0xa2/0x230 [rfcomm]
[14655.200609] kernel:        rfcomm_run+0x765/0x1820 [rfcomm]
[14655.200615] kernel:        kthread+0x17a/0x1a0
[14655.200618] kernel:        ret_from_fork+0x1f/0x30
[14655.200622] kernel:
                       other info that might help us debug this:
[14655.200624] kernel: Chain exists of:
                         sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM -->
rfcomm_mutex --> &d->lock
[14655.200630] kernel:  Possible unsafe locking scenario:
[14655.200632] kernel:        CPU0                    CPU1
[14655.200633] kernel:        ----                    ----
[14655.200635] kernel:   lock(&d->lock);
[14655.200638] kernel:                                lock(rfcomm_mutex);
[14655.200640] kernel:                                lock(&d->lock);
[14655.200643] kernel:   lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
[14655.200646] kernel:
                        *** DEADLOCK ***
[14655.200648] kernel: 2 locks held by krfcommd/1358:
[14655.200650] kernel:  #0: ffffffffc141d130
(rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_run+0x135/0x1820 [rfcomm]
[14655.200661] kernel:  #1: ffff9e672a54bb40 (&d->lock){+.+.}-{3:3},
at: __rfcomm_dlc_close+0x88/0x230 [rfcomm]
[14655.200671] kernel:
                       stack backtrace:
[14655.200673] kernel: CPU: 3 PID: 1358 Comm: krfcommd Not tainted
5.16.0-0.rc8.55.fc36.x86_64+debug #1
[14655.200677] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
BIOS N2HET64W (1.47 ) 07/19/2021
[14655.200680] kernel: Call Trace:
[14655.200682] kernel:  <TASK>
[14655.200686] kernel:  dump_stack_lvl+0x59/0x73
[14655.200692] kernel:  check_noncircular+0xdf/0x100
[14655.200699] kernel:  __lock_acquire+0x11c7/0x1de0
[14655.200706] kernel:  lock_acquire+0xd3/0x2f0
[14655.200710] kernel:  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[14655.200719] kernel:  ? __rfcomm_dlc_close+0x88/0x230 [rfcomm]
[14655.200728] kernel:  lock_sock_nested+0x2e/0x80
[14655.200731] kernel:  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[14655.200737] kernel:  rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[14655.200744] kernel:  __rfcomm_dlc_close+0xa2/0x230 [rfcomm]
[14655.200752] kernel:  rfcomm_run+0x765/0x1820 [rfcomm]
[14655.200762] kernel:  ? __init_waitqueue_head+0x60/0x60
[14655.200768] kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
[14655.200772] kernel:  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[14655.200780] kernel:  kthread+0x17a/0x1a0
[14655.200783] kernel:  ? set_kthread_struct+0x40/0x40
[14655.200788] kernel:  ret_from_fork+0x1f/0x30
[14655.200796] kernel:  </TASK>

Looks similar to one a bot reported against 5.14.0[syzbot] possible
deadlock in rfcomm_sk_state_change
https://www.spinics.net/lists/linux-bluetooth/msg94142.html

Downstream bug has complete dmesg attached.
https://bugzilla.redhat.com/show_bug.cgi?id=2037601

-- 
Chris Murphy
