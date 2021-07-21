Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB5BC636C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 18:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4683A61245
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 18:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhGURus (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGURuq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 13:50:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2DC061575;
        Wed, 21 Jul 2021 11:31:21 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p22so4562592yba.7;
        Wed, 21 Jul 2021 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KTE4uS5d06Y9ZVzPnKQMR2mBVjNhNjPjsvjQXNcyr10=;
        b=RNw+d3qYyvb/ZW+4Cm29FdQBPPx4Hyl5/oThWyOQvixpr8NWQS7TCBl0vsiOfB/OmY
         M/8HXpQhoKOH1W6dysmIhusNZucPQmadAUAIZATYtMYto7T64HfunS8S7tlAXk03Gh+6
         CNi2tdOICqv1At5h/QLNaExqXOcf5vRabYOJcJ29xlvR6Au5JpQORG6X2NbCVEKh9yIo
         mp0FN3Vum2lRHiRd3uRqAgwZxqnZHQuM7qr/a4/VHxvRhZv8d6SorakKokQ52De1pBlw
         nJ+DBQ+MirPp0bcvRPv7HQB5MDYSXZozXPl15XXvgboK2LCLX5eoAMTCtcCPVNIyHx+N
         2ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KTE4uS5d06Y9ZVzPnKQMR2mBVjNhNjPjsvjQXNcyr10=;
        b=EhMr79vrcwbVNIyXaOSNb5gaIIFPd/z/k/OY40s1Ehpw4tFhOR+zVEZ8Mc3mCNQC64
         bLSLy4ZglqBGsE0hdhSXH3LfEr6yRM/pDGy1eAvIkQwaBIgKeARDjhnbK8IqQCJhVIUI
         lybIBqkImQP7VHoHK9NFWOVqvX2HWC9M41ZLmDdCUeqEqIaJCGL3FBSzbsCJm1Xr6x+Q
         iCOy7nbrglKx2iz9Zy7OAdz5oTJX6j9oy6lYPKKigxOL4fBAg3RmsMa2bSAwaBdAefIP
         42jymf6eLm3rXwPt44s7HcS+JS2TaunHPS4FrE6yAZSV/hoikXS35AyZ/eLuv0Fls75z
         +1aQ==
X-Gm-Message-State: AOAM533lbWjp8u0I12BuhqwWlHdFV98benF+Xj5zPYVtfkvAwt7L0tQF
        qHvfCyMX3Cq0Rg9MytxsMHIBF2RYLr0QNJDLtdM=
X-Google-Smtp-Source: ABdhPJwwDcOydNE8B5DrFavMNkAaTZwcqFXs9pmp3uVucbVaklb08+Y/SSSWkTri3pTUC8WaFH/9lw5s/eS+H+yIHtU=
X-Received: by 2002:a25:be02:: with SMTP id h2mr49133394ybk.91.1626892279628;
 Wed, 21 Jul 2021 11:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2107131924280.8253@cbobk.fhfr.pm> <nycvar.YFH.7.76.2107212026050.8253@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2107212026050.8253@cbobk.fhfr.pm>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Jul 2021 11:31:08 -0700
Message-ID: <CABBYNZ+mXqKx_gF=F80Y-vz7F-ysLGHYLaKT+fxze4tu1_1S3w@mail.gmail.com>
Subject: Re: Two issues caused by commit e305509e678b3 ("Bluetooth: use
 correct lock to prevent UAF of hdev object")
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jiri,

On Wed, Jul 21, 2021 at 11:26 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 13 Jul 2021, Jiri Kosina wrote:
>
> > Hi,
> >
> > commit e305509e678b3 ("Bluetooth: use correct lock to prevent UAF of hd=
ev
> > object") has two issues, and I believe it should be reverted for 5.14
> > final. Could you please elaborate what is the exact UAF scenario the pa=
tch
> > is fixing? It's rather hard to deduce from the very short changelog, bu=
t
> > it's pretty obvious that it creates at least two issues.
>
> Marcel, Johan, Luiz, any thoughts on this please? Thanks.

We are looking into it.

> >
> >
> >
> > (1) it introduces a possibility of deadlock between hci_sock_dev_event(=
)
> >    and hci_sock_sendmsg().
> >
> > Namely:
> >
> > - hci_sock_sendmsg(HCI_CHANNEL_LOGGING) acquires lock_sock(sk) and then
> >   calls into hci_logging_frame() -> hci_send_to_channel() which in turn
> >   acquires hci_sk_list.lock
> >
> > - after the mentioned commit, hci_sock_dev_event() first acquires
> >   hci_sk_list.lock before doing lock_sock(sk) on each of the sockets it
> >   iterates through, creating the reverse dependency
> >
> >
> > Please find the full lockdep report below for reference.
> >
> > (2) it causes sleeping function to be called from atomic context, becau=
se
> >    it's not allowed to sleep after acquiring read_lock(), which is exac=
tly
> >    what this patch does (lock_sock() is sleepable). Report below as wel=
l.
> >
> >
> >
> >
> >
> >
> >  BUG: sleeping function called from invalid context at net/core/sock.c:=
3100
> >  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 448, name: kwor=
ker/0:5
> >  6 locks held by kworker/0:5/448:
> >   #0: ffff89e947fb4338 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: pro=
cess_one_work+0x1c2/0x5e0
> >   #1: ffffadef40973e78 ((work_completion)(&hub->events)){+.+.}-{0:0}, a=
t: process_one_work+0x1c2/0x5e0
> >   #2: ffff89e946998a20 (&dev->mutex){....}-{3:3}, at: hub_event+0x6a/0x=
d50 [usbcore]
> >   #3: ffff89e950828a20 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x=
54/0x270 [usbcore]
> >   #4: ffff89e9504e71a8 (&dev->mutex){....}-{3:3}, at: device_release_dr=
iver_internal+0x1a/0x1d0
> >   #5: ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev=
_event+0x12b/0x1e0 [bluetooth]
> >  CPU: 0 PID: 448 Comm: kworker/0:5 Not tainted 5.14.0-rc1-00003-g7fef2e=
df7cc7 #15
> >  Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/=
31/2017
> >  Workqueue: usb_hub_wq hub_event [usbcore]
> >  Call Trace:
> >   dump_stack_lvl+0x56/0x6c
> >   ___might_sleep+0x1b6/0x210
> >   lock_sock_nested+0x29/0xa0
> >   hci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >   hci_unregister_dev+0xd2/0x350 [bluetooth]
> >   btusb_disconnect+0x63/0x150 [btusb]
> >   usb_unbind_interface+0x79/0x260 [usbcore]
> >   device_release_driver_internal+0xf7/0x1d0
> >   bus_remove_device+0xef/0x160
> >   device_del+0x1ac/0x430
> >   ? usb_remove_ep_devs+0x1b/0x30 [usbcore]
> >   usb_disable_device+0x8d/0x1a0 [usbcore]
> >   usb_disconnect+0xc1/0x270 [usbcore]
> >   ? hub_event+0x4b0/0xd50 [usbcore]
> >   hub_port_connect+0x82/0xa20 [usbcore]
> >   ? __mutex_unlock_slowpath+0x43/0x2b0
> >   hub_event+0x4c4/0xd50 [usbcore]
> >   ? lock_is_held_type+0xb4/0x120
> >   process_one_work+0x244/0x5e0
> >   worker_thread+0x3c/0x390
> >   ? process_one_work+0x5e0/0x5e0
> >   kthread+0x133/0x160
> >   ? set_kthread_struct+0x40/0x40
> >   ret_from_fork+0x22/0x30
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  WARNING: possible circular locking dependency detected
> >  5.14.0-rc1-00003-g7fef2edf7cc7 #15 Tainted: G        W
> >  ------------------------------------------------------
> >  kworker/0:5/448 is trying to acquire lock:
> >  ffff89e950647920 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: h=
ci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >
> >  but task is already holding lock:
> >  ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_even=
t+0x12b/0x1e0 [bluetooth]
> >
> >  which lock already depends on the new lock.
> >
> >
> >  the existing dependency chain (in reverse order) is:
> >
> >  -> #1 (hci_sk_list.lock){++++}-{2:2}:
> >         _raw_read_lock+0x38/0x70
> >  systemd-sysv-generator[1254]: stat() failed on /etc/init.d/jexec, igno=
ring: No such file or directory
> >         hci_send_to_channel+0x22/0x50 [bluetooth]
> >         hci_sock_sendmsg+0xa2b/0xa40 [bluetooth]
> >         sock_sendmsg+0x5b/0x60
> >         ____sys_sendmsg+0x1ed/0x250
> >  systemd-sysv-generator[1254]: SysV service '/etc/init.d/tpfand' lacks =
a native systemd unit file. Automatically generating a unit file for compat=
ibility. Please update package to include a native systemd unit file, in or=
der to make it more safe and robust.
> >         ___sys_sendmsg+0x88/0xd0
> >         __sys_sendmsg+0x5e/0xa0
> >         do_syscall_64+0x3a/0xb0
> >  systemd-sysv-generator[1254]: SysV service '/etc/init.d/boot.local' la=
cks a native systemd unit file. Automatically generating a unit file for co=
mpatibility. Please update package to include a native systemd unit file, i=
n order to make it more safe and robust.
> >         entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> >  -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}:
> >         __lock_acquire+0x124a/0x1680
> >         lock_acquire+0x278/0x300
> >         lock_sock_nested+0x72/0xa0
> >         hci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >         hci_unregister_dev+0xd2/0x350 [bluetooth]
> >         btusb_disconnect+0x63/0x150 [btusb]
> >         usb_unbind_interface+0x79/0x260 [usbcore]
> >         device_release_driver_internal+0xf7/0x1d0
> >         bus_remove_device+0xef/0x160
> >         device_del+0x1ac/0x430
> >         usb_disable_device+0x8d/0x1a0 [usbcore]
> >         usb_disconnect+0xc1/0x270 [usbcore]
> >         hub_port_connect+0x82/0xa20 [usbcore]
> >         hub_event+0x4c4/0xd50 [usbcore]
> >         process_one_work+0x244/0x5e0
> >         worker_thread+0x3c/0x390
> >         kthread+0x133/0x160
> >         ret_from_fork+0x22/0x30
> >
> >  other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(hci_sk_list.lock);
> >                                 lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
> >                                 lock(hci_sk_list.lock);
> >    lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
> >
> >   *** DEADLOCK ***
> >
> >  6 locks held by kworker/0:5/448:
> >   #0: ffff89e947fb4338 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: pro=
cess_one_work+0x1c2/0x5e0
> >   #1: ffffadef40973e78 ((work_completion)(&hub->events)){+.+.}-{0:0}, a=
t: process_one_work+0x1c2/0x5e0
> >   #2: ffff89e946998a20 (&dev->mutex){....}-{3:3}, at: hub_event+0x6a/0x=
d50 [usbcore]
> >   #3: ffff89e950828a20 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x=
54/0x270 [usbcore]
> >   #4: ffff89e9504e71a8 (&dev->mutex){....}-{3:3}, at: device_release_dr=
iver_internal+0x1a/0x1d0
> >   #5: ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev=
_event+0x12b/0x1e0 [bluetooth]
> >
> >  stack backtrace:
> >  CPU: 0 PID: 448 Comm: kworker/0:5 Tainted: G        W         5.14.0-r=
c1-00003-g7fef2edf7cc7 #15
> >  Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/=
31/2017
> >  Workqueue: usb_hub_wq hub_event [usbcore]
> >  Call Trace:
> >   dump_stack_lvl+0x56/0x6c
> >   check_noncircular+0x105/0x120
> >   ? stack_trace_save+0x4b/0x70
> >   ? save_trace+0x3d/0x340
> >   ? __lock_acquire+0x124a/0x1680
> >   __lock_acquire+0x124a/0x1680
> >   lock_acquire+0x278/0x300
> >   ? hci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >   ? lock_release+0x15a/0x2a0
> >   lock_sock_nested+0x72/0xa0
> >   ? hci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >   hci_sock_dev_event+0x156/0x1e0 [bluetooth]
> >   hci_unregister_dev+0xd2/0x350 [bluetooth]
> >   btusb_disconnect+0x63/0x150 [btusb]
> >   usb_unbind_interface+0x79/0x260 [usbcore]
> >   device_release_driver_internal+0xf7/0x1d0
> >   bus_remove_device+0xef/0x160
> >   device_del+0x1ac/0x430
> >   ? usb_remove_ep_devs+0x1b/0x30 [usbcore]
> >   usb_disable_device+0x8d/0x1a0 [usbcore]
> >   usb_disconnect+0xc1/0x270 [usbcore]
> >   ? hub_event+0x4b0/0xd50 [usbcore]
> >   hub_port_connect+0x82/0xa20 [usbcore]
> >   ? __mutex_unlock_slowpath+0x43/0x2b0
> >   hub_event+0x4c4/0xd50 [usbcore]
> >   ? lock_is_held_type+0xb4/0x120
> >   process_one_work+0x244/0x5e0
> >   worker_thread+0x3c/0x390
> >   ? process_one_work+0x5e0/0x5e0
> >   kthread+0x133/0x160
> >   ? set_kthread_struct+0x40/0x40
> >   ret_from_fork+0x22/0x30
> >
> >
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
>
> --
> Jiri Kosina
> SUSE Labs
>


--=20
Luiz Augusto von Dentz
