Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501BCEEBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423827; cv=none; b=kGsbNWBDRtbNyrfKoBWDJFKkVLPDYW2apUvValpRG939cruS/JNSGMOPuH8B2xDqoweS62e+B/jXeVkZuFVJWqpx/xjn7hlS049lCarn6ra4euEIqEi+G7w/KxGOnZDch2gYslTSYG2N58LtqcryNOCEKt6EAJ2/BeAmZlo/K7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423827; c=relaxed/simple;
	bh=0VYnGWTSrXH9v30MTo9QWNevoD3n8zNPn45hPFkj3F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv40yNKm0u5MpsJMCXiT8RmMatUl9Wf7pmh7stf5NL6fFFXp2cyFjkIVQIx0hYvj3Rdhi7Sf6APbjrvTPe5Qi8EL312vGQDlFvUoaeHBRuVcSiy/kTQ9FCxZMzXBfZ6gvVGbEyHPSKg05l7MCfyXhgJaxHSbCHg1dIwR3dtHoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIyvTLRX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIyvTLRX"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-550edba125bso672692e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423823; x=1748028623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbzclFxXqbq/alBKu7cQDKI+Ygd8XghokbvhWygujj8=;
        b=VIyvTLRXfRKmUtkaoT9EDeAPi8J05wL8Ft81u7Ptx++X9JQyZ2XH+fEM19fFEyqaMg
         QoswwhKJCRhYg+sXITnZS8KG2yFbrl0JOuueclIJk2qL9ZcNV+P61AwLdY4eqf7DHYPc
         2+KeoEjLHQGaIi2Khpb0DUIOV4R10Xxp0dO6eR10I5ItbMgcqLgRAoNlncSm0JjOUOKV
         ka8VWV4Z3j5QWT6wus3z+tRsfmTs94BYFZ0O4t18DXWZkE8R07BEhUC66DPyELDxMHUj
         aWqLSqQguX2DYUwz07GLkGPfbUMx2HD5pGYvLVkWHqjX+4LAYqEMhaI9IMcJEnrRe360
         S5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423823; x=1748028623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbzclFxXqbq/alBKu7cQDKI+Ygd8XghokbvhWygujj8=;
        b=SrcycaXTzXLoCPoQ/hecZDAmsVtwV3y5JYDKxc3gt4OtRuXNE4weFaiq4xJn97oN6g
         4UTY+SbVHDrV9Nc/ZkSjBzSEzCM2uXnCYnemVg/K/98blL/iTkDmv1qMLI+knPQqxWFb
         2RobVABTBGK+Yqj4bIvuvEX9hVS5njuLAMzcjfw5UsZX7kn1qTftcwNQLHQTZMPLEi+2
         tCB1pFgPuMGzbOFmY1fibO4wm4abkULOEuRAqaS1k8+8xOV5z3PTr2LvJTVP+JUqVBsI
         X9nSP97lUynvTSwdx4mWc/DvZsp0oXSCw3+3r1V5gY0JKvFGltUpI2BUVU4OiplTS9r3
         7Bew==
X-Forwarded-Encrypted: i=1; AJvYcCXbkTpFB9V7gceP8rjTsmFnwOYbtEDqG7PTCUOzC+foi05s/TxLPvdldLoGalWMoR7jOKY9JBU/FzTRSrpwtpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wK29aKjasWO8gQ8uBxm71YCTbFSizmrG87yIhULRWrsSckkv
	45OSghiDWRGCjOEUUuHrUxu+R14hxH5c7FCFqyNm5Wfr/bCjGBevIH2tIIICtKQyXUoEDiOJH69
	Y645qdMve1/FSnXPyjENz8qMW1XjKWLf9ZvMWUro=
X-Gm-Gg: ASbGncvpVmLJTqOgbv9XuIPqNKzytXrfMa52+EYjeD5+HjpAsYyhZBkg7QNrWwK1Weq
	bBINAwF6VRTFFqlEm4Jy3A9Kzz8UuUELSWiIJRyGMMTzItCMejVl5v+ppjn4Bdus0oZ0Aa9MVhJ
	GqYk5PPq3kP169MqsD1YbPkvkkrWpY1VM=
X-Google-Smtp-Source: AGHT+IEWv1m3k1ef7dC1N0EBTx/zUDdPEc6kTWtX/2wzKtq9FXBVp1NSGKqCxMCvlIs2yfTCo62ug5MtkE7harTiCAI=
X-Received: by 2002:a05:6512:1387:b0:549:8b24:989d with SMTP id
 2adb3069b0e04-550e70f5ec7mr1540847e87.0.1747423822891; Fri, 16 May 2025
 12:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516142027.261617-1-dmantipov@yandex.ru>
In-Reply-To: <20250516142027.261617-1-dmantipov@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 May 2025 15:30:10 -0400
X-Gm-Features: AX0GCFvLUwDIYV10-JSvGCLVEpfcNhELyS_q-NnVBoeF1vu2ixuiQ0PX4f3SJrE
Message-ID: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: fix races observed when handling mgmt commands
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, May 16, 2025 at 10:21=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Looking around https://syzkaller.appspot.com/bug?extid=3Dfeb0dc579bbe30a1=
3190,
> I have a strong suspicion that this issue may be caused by racy alteratio=
ns
> of 'mgmt_pending' list of 'struct hci_dev'. Beyond the crash initially
> reported, another crashes observed when running the same reproducer are:
>
> [   37.037848][ T5951] list_del corruption, ffff88814aea2a80->next is LIS=
T_POISON1 (dead000000000100)
> [   37.038633][ T5951] ------------[ cut here ]------------
> [   37.039044][ T5951] kernel BUG at lib/list_debug.c:58!
> [   37.039447][ T5951] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [   37.040051][ T5951] CPU: 7 UID: 0 PID: 5951 Comm: kworker/u35:5 Not ta=
inted 6.15.0-rc6-00188-gfee3e843b309-dirty #45 PREEMPT(full)
> [   37.040935][ T5951] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-4.fc42 04/01/2014
> [   37.041642][ T5951] Workqueue: hci0 hci_cmd_sync_work
> [   37.042119][ T5951] RIP: 0010:__list_del_entry_valid_or_report+0x10e/0=
x190
> [   37.042672][ T5951] Code: a0 dc c1 8b 48 89 de e8 50 d6 68 fc 90 0f 0b=
 4c 89 e7 e8 75 5f 43 fd 48 c7 c7 00 dd c1 8b 48 89 de 4c 89 e9
> [   37.044135][ T5951] RSP: 0018:ffffc90004a6f958 EFLAGS: 00010246
> [   37.044700][ T5951] RAX: 000000000000004e RBX: ffff88814aea2a80 RCX: 2=
cad877deccc5c00
> [   37.045388][ T5951] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0=
000000000000000
> [   37.046091][ T5951] RBP: 0000000000000001 R08: ffff88823bfa3e93 R09: 1=
ffff110477f47d2
> [   37.046649][ T5951] R10: dffffc0000000000 R11: ffffed10477f47d3 R12: d=
ead000000000100
> [   37.047264][ T5951] R13: dffffc0000000000 R14: dead000000000100 R15: d=
ead000000000122
> [   37.047856][ T5951] FS:  0000000000000000(0000) GS:ffff8882a9847000(00=
00) knlGS:0000000000000000
> [   37.048513][ T5951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.049002][ T5951] CR2: 00007fb472fe54e4 CR3: 000000000dd38000 CR4: 0=
000000000752ef0
> [   37.049587][ T5951] PKRU: 55555554
> [   37.049862][ T5951] Call Trace:
> [   37.050110][ T5951]  <TASK>
> [   37.050335][ T5951]  mgmt_pending_remove+0x7c/0x260
> [   37.050807][ T5951]  mgmt_remove_adv_monitor_complete+0x2ff/0x540
> [   37.051268][ T5951]  ? __pfx_mgmt_remove_adv_monitor_complete+0x10/0x1=
0
> [   37.051771][ T5951]  ? hci_sock_get_channel+0xd/0x50
> [   37.052151][ T5951]  ? mgmt_pending_find+0x116/0x130
> [   37.052533][ T5951]  ? __pfx_mgmt_remove_adv_monitor_complete+0x10/0x1=
0
> [   37.053106][ T5951]  hci_cmd_sync_work+0x25e/0x3a0
> [   37.053479][ T5951]  ? process_scheduled_works+0x9ec/0x17a0
> [   37.053912][ T5951]  process_scheduled_works+0xadb/0x17a0
> [   37.054333][ T5951]  ? __pfx_process_scheduled_works+0x10/0x10
> [   37.054789][ T5951]  worker_thread+0x8a0/0xda0
> [   37.055138][ T5951]  kthread+0x70e/0x8a0
> [   37.055443][ T5951]  ? __pfx_worker_thread+0x10/0x10
> [   37.055822][ T5951]  ? __pfx_kthread+0x10/0x10
> [   37.056247][ T5951]  ? __pfx_kthread+0x10/0x10
> [   37.056620][ T5951]  ? _raw_spin_unlock_irq+0x23/0x50
> [   37.057548][ T5951]  ? lockdep_hardirqs_on+0x9c/0x150
> [   37.058497][ T5951]  ? __pfx_kthread+0x10/0x10
> [   37.058969][ T5951]  ret_from_fork+0x4b/0x80
> [   37.059322][ T5951]  ? __pfx_kthread+0x10/0x10
> [   37.059675][ T5951]  ret_from_fork_asm+0x1a/0x30
> [   37.060025][ T5951]  </TASK>
> [   37.060256][ T5951] Modules linked in:
> [   37.061223][ T5951] ---[ end trace 0000000000000000 ]---
>
> and:
>
> [   27.827336][ T7638] list_del corruption, ffff8880262d3c00->next is LIS=
T_POISON1 (dead000000000100)
> [   27.828256][ T7638] ------------[ cut here ]------------
> [   27.830257][ T7638] kernel BUG at lib/list_debug.c:58!
> [   27.831742][ T7638] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [   27.832390][ T7638] CPU: 7 UID: 0 PID: 7638 Comm: repro Not tainted 6.=
15.0-rc6-00188-gfee3e843b309 #49 PREEMPT(full)
> [   27.833245][ T7638] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-4.fc42 04/01/2014
> [   27.834006][ T7638] RIP: 0010:__list_del_entry_valid_or_report+0x10e/0=
x190
> [   27.834585][ T7638] Code: 60 dc c1 8b 48 89 de e8 50 d6 68 fc 90 0f 0b=
 4c 89 e7 e8 75 5f 43 fd 48 c7 c7 c0 dc c1 8b 48 89 de 4c 89 e9
> [   27.836215][ T7638] RSP: 0018:ffffc90006487b08 EFLAGS: 00010246
> [   27.836702][ T7638] RAX: 000000000000004e RBX: ffff8880262d3c00 RCX: 4=
548abf5fe405300
> [   27.837418][ T7638] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0=
000000000000000
> [   27.838070][ T7638] RBP: 0000000000000000 R08: ffff88823bfa3e93 R09: 1=
ffff110477f47d2
> [   27.838770][ T7638] R10: dffffc0000000000 R11: ffffed10477f47d3 R12: d=
ead000000000100
> [   27.839424][ T7638] R13: dffffc0000000000 R14: dead000000000100 R15: d=
ead000000000122
> [   27.840051][ T7638] FS:  00007fae498e16c0(0000) GS:ffff8882a9847000(00=
00) knlGS:0000000000000000
> [   27.840743][ T7638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.841259][ T7638] CR2: 0000200000000040 CR3: 000000002cf25000 CR4: 0=
000000000752ef0
> [   27.841889][ T7638] PKRU: 55555554
> [   27.842177][ T7638] Call Trace:
> [   27.842443][ T7638]  <TASK>
> [   27.842679][ T7638]  mgmt_pending_remove+0x28/0x1a0
> [   27.843201][ T7638]  mgmt_pending_foreach+0xc9/0x120
> [   27.843605][ T7638]  ? __pfx_cmd_complete_rsp+0x10/0x10
> [   27.844035][ T7638]  mgmt_index_removed+0x10d/0x2f0
> [   27.844433][ T7638]  ? __pfx_mgmt_index_removed+0x10/0x10
> [   27.844872][ T7638]  ? _raw_read_unlock+0x28/0x50
> [   27.845264][ T7638]  hci_sock_bind+0xbe9/0x1000
> [   27.845641][ T7638]  ? __pfx_hci_sock_bind+0x10/0x10
> [   27.846056][ T7638]  ? bpf_lsm_socket_bind+0x9/0x20
> [   27.846561][ T7638]  __sys_bind+0x2c3/0x3e0
> [   27.846911][ T7638]  ? __pfx___sys_bind+0x10/0x10
> [   27.847304][ T7638]  ? do_user_addr_fault+0xc8a/0x1390
> [   27.847724][ T7638]  __x64_sys_bind+0x7a/0x90
> [   27.848207][ T7638]  do_syscall_64+0xf6/0x210
> [   27.848573][ T7638]  ? exc_page_fault+0x91/0x110
> [   27.848964][ T7638]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   27.849431][ T7638] RIP: 0033:0x7fae4a1e6fa9
> [   27.849879][ T7638] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44=
 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 48
> [   27.851407][ T7638] RSP: 002b:00007fae498e0eb8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000031
> [   27.852076][ T7638] RAX: ffffffffffffffda RBX: 0000000000406208 RCX: 0=
0007fae4a1e6fa9
> [   27.852704][ T7638] RDX: 0000000000000006 RSI: 0000200000000040 RDI: 0=
000000000000004
> [   27.853335][ T7638] RBP: 0000000000406200 R08: 0000000000000001 R09: 0=
0007fae498e1cdc
> [   27.853962][ T7638] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
00000000040620c
> [   27.854681][ T7638] R13: 0000000000000016 R14: 00007ffc7a4be880 R15: 0=
0007fae498c1000
> [   27.855317][ T7638]  </TASK>
> [   27.855563][ T7638] Modules linked in:
> [   27.855909][ T7638] ---[ end trace 0000000000000000 ]---
>
> Since 'mgmt_pending' is not guarded with dedicated mutex/spinlock/etc,
> I assume that it shouldn't be altered without holding common per-device
> lock with 'hci_dev_lock(...)'. In particular, unlocked call to
> 'mgmt_index_removed()' is racy, and (all?) unlocked calls to
> 'pending_find()' most likely racy as well. This patch (hopefully)
> helps the kernel to survive running (the only?) existing reproducer,
> but there may be another weird issues around examining and/or altering
> 'mgmt_pending'. Comments are highly appreciated.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/bluetooth/hci_sock.c | 2 ++
>  net/bluetooth/mgmt.c     | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 022b86797acd..c00965ba7a81 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1304,7 +1304,9 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr *addr,
>                         goto done;
>                 }
>
> +               hci_dev_lock(hdev);
>                 mgmt_index_removed(hdev);
> +               hci_dev_unlock(hdev);
>
>                 err =3D hci_dev_open(hdev->id);
>                 if (err) {
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 46b22708dfbd..e01779cd09fd 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5396,12 +5396,14 @@ static void mgmt_remove_adv_monitor_complete(stru=
ct hci_dev *hdev,
>         struct mgmt_pending_cmd *cmd =3D data;
>         struct mgmt_cp_remove_adv_monitor *cp;
>
> -       if (status =3D=3D -ECANCELED ||
> -           cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +       if (status =3D=3D -ECANCELED)
>                 return;
>
>         hci_dev_lock(hdev);
>
> +       if (cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +               goto unlock;
> +
>         cp =3D cmd->param;
>
>         rp.monitor_handle =3D cp->monitor_handle;
> @@ -5413,6 +5415,7 @@ static void mgmt_remove_adv_monitor_complete(struct=
 hci_dev *hdev,
>                           mgmt_status(status), &rp, sizeof(rp));
>         mgmt_pending_remove(cmd);
>
> +unlock:
>         hci_dev_unlock(hdev);
>         bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
>                    rp.monitor_handle, status);
> --
> 2.49.0

It might be better to convert the list operation to use the rcu
variants so they can run in a lock free manner.

--=20
Luiz Augusto von Dentz
