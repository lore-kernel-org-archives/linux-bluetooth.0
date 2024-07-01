Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFA16EB71;
	Mon,  1 Jul 2024 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864381; cv=none; b=Qj0oXEepy2kkBH4WLvPqOZb0cns/C8gHto1rM1xpPSfMXlupOM05icctkvMYvbjxgWyVN0bpNj27J+JN23WwmLR3RqLq/8jT+QyRmxS+ShPozDYFaKLl5v3r26YCniWhKjic9bFpvvW+v9UUkjtjB890Ik13YOsHPlj7MtAj4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864381; c=relaxed/simple;
	bh=rAfXZmgjqQZ6yCslgC27f7mLa5nM92q8J1F98F1viig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMaK2N9ESobGH3eTU8yraRKbpdSBKVlll1L1W7JoXJREJcimwMGUF4ExCRgKv0Xoq5B+3Y87++KlrNLRvUMn9xQEOYo/KNMQVPH0QP7PTsIRGAUAETYZpgCRO/KSUDPjXvU39WCx83NHlO7zKqxDZS7Ie+Z8GvwTm9EteSbgXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPoLAnhf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPoLAnhf"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so40132491fa.3;
        Mon, 01 Jul 2024 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719864377; x=1720469177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFu6Pow9sriRUuA53GMY+Q+0dhmTNKy093brVQlRXCI=;
        b=FPoLAnhf2LA7+idlTTX35ZFBx5HuhiPv57yz03NL8dlmB7XqeZms3zaxd6wOIeTLIb
         uCaYWzLyMq33cG7WWBv24+FQsGqHSsvIcNIn8cykCgQ4KuxLbDTnjshvj4fncqGwWnBI
         Ehfyfn7elLR1AdorUS7zn7mIekLrGwDDIOidqfQ/7PiXrBwSAvEH5ODEEIn7iBkO8jW+
         FMeBwIJpeydIGiz3k7vefSDJKw1ZdiILtXwFj4q56W0qE0lLgnBU2S+HvMsi8z2WE0ot
         zOk5OE/khxI3xvLZgqJHIDeicQu0LqNxeZsoUxOC/lRF/STbaW27VR6AIUCyinDI9cAS
         QSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864377; x=1720469177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFu6Pow9sriRUuA53GMY+Q+0dhmTNKy093brVQlRXCI=;
        b=nq55llfIKiU/OjmEpgZZweArqJblZeOzQt4wIyUL0+YPj6WoR9OpdlCUEXF0eXWXyO
         JZ/q78OH3bAJ7l59ly4IJD6xs8A89qKhjWvgrHZ0vnhyzJJnEnLeP4IPuQpEnsNvFWU+
         UbG4NbtNaOzNVy6CUv8leg30gNoUzk0XY/nRFc5hH+yBML8jCjSShTIMGdusc6jwp9SD
         VQB/qjpNmVcQQam1o7HIKDY9TkurBM48DDxVGjp6TiqgJtOgXhm5xqj+CY2un980AObl
         wPLFcEirakTSqI/gfh28iUSGt/FSf88FZhfjREeUwRibgBw9Ro2TuXy6XpU4+sdICrC6
         GfYg==
X-Forwarded-Encrypted: i=1; AJvYcCVACC4Mjgi1RmzfR3uQwX2cHH1FUEtaLlTv2bSaad8b3qVUBLol1zgDOUSiPVdiiwwHj0+9XnaORuluRbm76SzGNrtHoHYalaEHlGa91rDZ22NxaX3JvHVmN/F2Q+6gP07+uCzY4dDVQ1zMnELP
X-Gm-Message-State: AOJu0Yz5hXwIk8MORTrTYjQ9IahNhNzERpCbqZqbVodGE52CNmIL88OJ
	usJEeUKtm67M9kLbpOqCbyztwt6wnbeK8ygPGrjaXb8Y6r7C0T2T+Hau3IYp67itjjau2ZWYNB5
	BQtzFoECvlugYYTeGTYBVbTRbRQvbVLGB
X-Google-Smtp-Source: AGHT+IEhDeciKHac9Q8IeCN4WwtuufzE5ubSH7ExHDMWeRUF5RNZaXHWp7rQ9UZwpauWqq4K91doks7giGMQlOf0Yyw=
X-Received: by 2002:a05:651c:54a:b0:2ec:5172:dbbc with SMTP id
 38308e7fff4ca-2ee5e37e7acmr56588901fa.5.1719864376887; Mon, 01 Jul 2024
 13:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701194531.97576-2-yskelg@gmail.com>
In-Reply-To: <20240701194531.97576-2-yskelg@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jul 2024 16:06:04 -0400
Message-ID: <CABBYNZLL0uYpgqSpQ+75mkZ194UTx+ojv-WreBKX52+EyQJ+Hw@mail.gmail.com>
Subject: Re: [PATCH] hci: fix double free in hci_req_sync
To: Yunseong Kim <yskelg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Austin Kim <austindh.kim@gmail.com>, Yeoreum Yun <ppbuk5246@gmail.com>, 
	MichelleJin <shjy180909@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 1, 2024 at 3:45=E2=80=AFPM Yunseong Kim <yskelg@gmail.com> wrot=
e:
>
> The approach taken to address the 'CVE-2024-35978' introduced another
> double-free vulnerability. commit 45d355a926ab
> ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
>
> 'hdev->req_skb' double free scenario:
>
>  cpu1                        cpu2
>  =3D=3D=3D=3D                        =3D=3D=3D=3D
>  sock_ioctl
>  sock_do_ioctl
>  hci_sock_ioctl
>  hci_dev_cmd
>  hci_req_sync

hci_req_sync is no longer called from hci_dev_cmd:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D6851d11d389ceb00c1220b267b9a04f54dbc4573

And I'm in process of removing hci_request.c completely.

>  __hci_req_sync              hci_rx_work
>  kfree_skb(hdev->req_skb)    hci_event_packet
>  (sleep)                     hci_req_sync_complete
>   \__ Longer times,          kfree_skb(hdev->req_skb)
>       reproduce well         hdev->req_skb =3D NULL
>
> The longer cpu1 sleep in '__hci_req_sync', the more reproducible it is.
> We've tested it by inserting the 'msleep()' function, and it's frequently
> at 1000ms, and It has been consistently reproducible at 2000ms.
>
> We confirmed the detection with various workloads that cause CPU1 to slee=
p.
> The call trace below is one of the KASAN has seen.
>
> Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in skb_release_data+0x7d8/0x8a0 home/para=
n/linux/net/core/skbuff.c:1119
> Write of size 1 at addr ffff00000947d3fe by task syz-executor.2/2010
>
> CPU: 1 PID: 2010 Comm: syz-executor.2 Not tainted
> 6.10.0-rc4-00217-g35bb670d65fc-dirty #22 Hardware name: linux,dummy-virt =
(DT)
> Call trace:
>  dump_backtrace+0x318/0x348 home/paran/linux/arch/arm64/kernel/stacktrace=
.c:317
>  show_stack+0x4c/0x80 home/paran/linux/arch/arm64/kernel/stacktrace.c:324
>  __dump_stack home/paran/linux/lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x214/0x328 home/paran/linux/lib/dump_stack.c:114
>  print_address_description home/paran/linux/mm/kasan/report.c:377 [inline=
]
>  print_report+0x2ac/0x948 home/paran/linux/mm/kasan/report.c:488
>  kasan_report+0xc8/0x148 home/paran/linux/mm/kasan/report.c:601
>  __asan_report_store1_noabort+0x44/0x60 home/paran/linux/mm/kasan/report_=
generic.c:383
>  skb_release_data+0x7d8/0x8a0 home/paran/linux/net/core/skbuff.c:1119
>  skb_release_all+0x80/0xe0 home/paran/linux/net/core/skbuff.c:1173
>  __kfree_skb home/paran/linux/net/core/skbuff.c:1187 [inline]
>  kfree_skb_reason+0x138/0x3a8 home/paran/linux/net/core/skbuff.c:1223
>  __hci_req_sync+0x404/0x948 [bluetooth]
>  hci_req_sync+0xc0/0x138 [bluetooth]
>  hci_dev_cmd+0x33c/0xc18 [bluetooth]
>  hci_sock_ioctl+0x800/0xb68 [bluetooth]
>  sock_do_ioctl+0xfc/0x2e0 home/paran/linux/net/socket.c:1222
>  sock_ioctl+0x62c/0xab0 home/paran/linux/net/socket.c:1341
>  vfs_ioctl+0x90/0x140 home/paran/linux/fs/ioctl.c:51
>  __do_sys_ioctl home/paran/linux/fs/ioctl.c:907 [inline]
>  __se_sys_ioctl home/paran/linux/fs/ioctl.c:893 [inline]
>  __arm64_sys_ioctl+0x218/0x268 home/paran/linux/fs/ioctl.c:893
>  __invoke_syscall home/paran/linux/arch/arm64/kernel/syscall.c:34 [inline=
]
>  invoke_syscall+0xdc/0x460 home/paran/linux/arch/arm64/kernel/syscall.c:4=
8
>  el0_svc_common.constprop.0+0x2d4/0x3e8 home/paran/linux/arch/arm64/kerne=
l/syscall.c:133
>  do_el0_svc+0x60/0x98 home/paran/linux/arch/arm64/kernel/syscall.c:152
>  el0_svc+0xc4/0x240 home/paran/linux/arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x120/0x130 home/paran/linux/arch/arm64/kernel/entr=
y-common.c:730
>  el0t_64_sync+0x190/0x198 home/paran/linux/arch/arm64/kernel/entry.S:598
>
> Allocated by task 577:
>  kasan_save_stack+0x48/0x90 home/paran/linux/mm/kasan/common.c:47
>  kasan_save_track+0x38/0x60 home/paran/linux/mm/kasan/common.c:68
>  kasan_save_alloc_info+0x64/0xc0 home/paran/linux/mm/kasan/generic.c:565
>  unpoison_slab_object home/paran/linux/mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x100/0x110 home/paran/linux/mm/kasan/common.c:338
>  kasan_slab_alloc home/paran/linux/./include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook home/paran/linux/mm/slub.c:3941 [inline]
>  slab_alloc_node home/paran/linux/mm/slub.c:4001 [inline]
>  kmem_cache_alloc_noprof+0x2e8/0x630 home/paran/linux/mm/slub.c:4008
>  skb_clone+0x1a4/0x4d0 home/paran/linux/net/core/skbuff.c:2052
>  hci_cmd_work+0x78c/0x868 [bluetooth]
>  process_one_work home/paran/linux/kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0x9fc/0x1d98 home/paran/linux/kernel/workqueue.c=
:3312
>  worker_thread+0x57c/0xf98 home/paran/linux/kernel/workqueue.c:3393
>  kthread+0x3c8/0x478 home/paran/linux/kernel/kthread.c:389
>  ret_from_fork+0x10/0x20 home/paran/linux/arch/arm64/kernel/entry.S:860
>
> Freed by task 577:
>  kasan_save_stack+0x48/0x90 home/paran/linux/mm/kasan/common.c:47
>  kasan_save_track+0x38/0x60 home/paran/linux/mm/kasan/common.c:68
>  kasan_save_free_info+0x64/0xf0 home/paran/linux/mm/kasan/generic.c:579
>  poison_slab_object+0x168/0x270 home/paran/linux/mm/kasan/common.c:240
>  __kasan_slab_free+0x34/0xa0 home/paran/linux/mm/kasan/common.c:256
>  kasan_slab_free home/paran/linux/./include/linux/kasan.h:184 [inline]
>  slab_free_hook home/paran/linux/mm/slub.c:2196 [inline]
>  slab_free home/paran/linux/mm/slub.c:4437 [inline]
>  kmem_cache_free+0x20c/0x670 home/paran/linux/mm/slub.c:4512
>  kfree_skbmem+0x2b0/0x390 home/paran/linux/net/core/skbuff.c:1131
>  __kfree_skb home/paran/linux/net/core/skbuff.c:1188 [inline]
>  kfree_skb_reason+0x14c/0x3a8 home/paran/linux/net/core/skbuff.c:1223
>  hci_req_sync_complete+0x114/0x308 [bluetooth]
>  hci_event_packet+0xa10/0x12a0 [bluetooth]
>  hci_rx_work+0x4d8/0xa80 [bluetooth]
>  process_one_work home/paran/linux/kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0x9fc/0x1d98 home/paran/linux/kernel/workqueue.c=
:3312
>  worker_thread+0x57c/0xf98 home/paran/linux/kernel/workqueue.c:3393
>  kthread+0x3c8/0x478 home/paran/linux/kernel/kthread.c:389
>  ret_from_fork+0x10/0x20 home/paran/linux/arch/arm64/kernel/entry.S:860
>
> The buggy address belongs to the object at ffff00000947d380
>  which belongs to the cache skbuff_head_cache of size 232
> The buggy address is located 126 bytes inside of
>  freed 232-byte region [ffff00000947d380, ffff00000947d468)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4947=
c
> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff0000222a73b1
> flags: 0x3fffe0000000040(head|node=3D0|zone=3D0|lastcpupid=3D0x1ffff)
> page_type: 0xffffefff(slab)
> raw: 03fffe0000000040 ffff0000133a41c0 fffffdffc0e3a090 fffffdffc1069290
> raw: 0000000000000000 0000000000120012 00000001ffffefff ffff0000222a73b1
> head: 03fffe0000000040 ffff0000133a41c0 fffffdffc0e3a090 fffffdffc1069290
> head: 0000000000000000 0000000000120012 00000001ffffefff ffff0000222a73b1
> head: 03fffe0000000001 fffffdffc0251f01 ffffffffffffffff 0000000000000000
> head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff00000947d280: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>  ffff00000947d300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff00000947d380: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                                 ^
>  ffff00000947d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>  ffff00000947d480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We considered using the "hci_req_sync_lock" mutex, but concluded it
> wasn't a good solution due to the increased sleep intervals causing
> this issue. Instead, we introduced a spinlock member on 'struct hci_dev'.
>
> Since applying our patch, we have repeatedly run the same tests in
> the syzkaller without encountering any issues.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/?id=3D89a32741f4217856066c198a4a7267bcdd1edd67
> Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_complete=
()")
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         |  1 +
>  net/bluetooth/hci_request.c      |  6 ++----
>  net/bluetooth/hci_request.h      |  9 +++++++++
>  net/bluetooth/hci_sync.c         | 13 +++----------
>  5 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index c43716edf205..8b95061f063b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -519,6 +519,7 @@ struct hci_dev {
>         struct sk_buff          *recv_event;
>
>         struct mutex            req_lock;
> +       spinlock_t              req_skb_lock;
>         wait_queue_head_t       req_wait_q;
>         __u32                   req_status;
>         __u32                   req_result;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index dd3b0f501018..138a6b19894d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2572,6 +2572,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>
>         mutex_init(&hdev->lock);
>         mutex_init(&hdev->req_lock);
> +       spin_lock_init(&hdev->req_skb_lock);
>
>         ida_init(&hdev->unset_handle_ida);
>
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index efea25eb56ce..6a109c1ad359 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -106,8 +106,7 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 r=
esult, u16 opcode,
>                 hdev->req_result =3D result;
>                 hdev->req_status =3D HCI_REQ_DONE;
>                 if (skb) {
> -                       kfree_skb(hdev->req_skb);
> -                       hdev->req_skb =3D skb_get(skb);
> +                       hci_req_skb_release_and_set(hdev, skb_get(skb));
>                 }
>                 wake_up_interruptible(&hdev->req_wait_q);
>         }
> @@ -181,8 +180,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(=
struct hci_request *req,
>                 break;
>         }
>
> -       kfree_skb(hdev->req_skb);
> -       hdev->req_skb =3D NULL;
> +       hci_req_skb_release_and_set(hdev, NULL);
>         hdev->req_status =3D hdev->req_result =3D 0;
>
>         bt_dev_dbg(hdev, "end: err %d", err);
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index c91f2838f542..6526c78443bc 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -28,6 +28,15 @@
>
>  #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
>  #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
> +#define hci_req_skb_release_and_set(hdev, val)         \
> +({                                                     \
> +       if (hdev->req_skb) {                            \
> +               spin_lock(&hdev->req_skb_lock);         \
> +               kfree_skb(hdev->req_skb);               \
> +               hdev->req_skb =3D val;                    \
> +               spin_unlock(&hdev->req_skb_lock);       \
> +       }                                               \
> +})
>
>  struct hci_request {
>         struct hci_dev          *hdev;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a8a7d2b36870..25c8d858c82e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -33,8 +33,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev,=
 u8 result, u16 opcode,
>         hdev->req_status =3D HCI_REQ_DONE;
>
>         /* Free the request command so it is not used as response */
> -       kfree_skb(hdev->req_skb);
> -       hdev->req_skb =3D NULL;

This doesn't even apply upstream

> +       hci_req_skb_release_and_set(hdev, NULL);
>
>         if (skb) {
>                 struct sock *sk =3D hci_skb_sk(skb);
> @@ -4935,10 +4934,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>                         hdev->sent_cmd =3D NULL;
>                 }
>
> -               if (hdev->req_skb) {
> -                       kfree_skb(hdev->req_skb);
> -                       hdev->req_skb =3D NULL;
> -               }
> +               hci_req_skb_release_and_set(hdev, NULL);
>
>                 clear_bit(HCI_RUNNING, &hdev->flags);
>                 hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
> @@ -5100,10 +5096,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>         }
>
>         /* Drop last request */
> -       if (hdev->req_skb) {
> -               kfree_skb(hdev->req_skb);
> -               hdev->req_skb =3D NULL;
> -       }
> +       hci_req_skb_release_and_set(hdev, NULL);
>
>         clear_bit(HCI_RUNNING, &hdev->flags);
>         hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz
