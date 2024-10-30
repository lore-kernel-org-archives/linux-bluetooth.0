Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063171F4726
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300402; cv=none; b=or8QYofaRxQ+EjSqfydWgOPLUpSc2KdbKmkptdxiLf870DSyRPOVTUrpO3wpyeSv4tKHx6AdKxkKvxx1SXcdmHZ6KKpvVDsduc+VVJaV+7Oc1nqa9ad6DzXoKGMklMzks4VPRONHrLObTBkWNAMa6Ux5xzUEadqvA0FMrTN+U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300402; c=relaxed/simple;
	bh=vroh2UDmZIyefrqresCvGI295Itt1+rYa5dKgzXBJeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNUwiYVny0JzgP4bVclk73o2rhgtayuoWu+mrQXo5+hggVzYMkrPswSo3AZ8zhymjAqUPklVFcglQdVcSJOt/1BI/V6XQC1VMwp4i6pWg9W8de168nLbB9tk4JAP2o86e+PHH+wogvz8dvES9OtjEcxVY2O8Mhj7hgg3UmJdP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJdZFcT4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJdZFcT4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so4882497a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300399; x=1730905199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEWth2PLsElnigL7gkZ09SV+8UL7Hc7rkx96cmw7SFs=;
        b=lJdZFcT4dIlMJSQGgb64KvR0V5wxtmltnQRftF+NxTTuyt52sVDLZ0IzScdieZ0ocw
         hmK5yCo4BoGLaHVLT0fHiwnCJvm1L3pZyXXwk+x/iYYQ0RjT4xIeVDg+maJ/1QyJzdKe
         gC3b2rcG/wW/+TLPDHZuvnBthp1/xdX9PD8VLHFzRDTVOABHY3zt5dq4GgffkjTPFKxe
         zX3hl5WoFc6Tp0ILlRpWmNpBdhEV2POyHeBAAADSk/JEZLmW4b7AyOUjKUE8xRGe2PgZ
         XUoM+vb7bw1qXKdJdM0dRr2gKAe3GALwb9KpAlHvNbPLAxvzLy9zl2MzkDGd4314IjXV
         0zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300399; x=1730905199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEWth2PLsElnigL7gkZ09SV+8UL7Hc7rkx96cmw7SFs=;
        b=G/2hHSXAl1afws2oZGKzKRM7EnJNXDRIi4IOz99ikenR28Kcdhi7KUCu/QQJ7jsNZ7
         xr3vyVW3xDFKVSEv8XofPs4WwL1/afSAWZpIEKEIwe79Gtu2yEHNusFeb5fJb9FchdBn
         jkuLQuvBb45855GQJibsuzQOKKJPG8RGK8DmIUimqzE5bFq6G7cwW9O3/dZg03yxpy9j
         8q4P7+31Je3aWYZfTeaM5MEWVzqnKK4V1a0ltdLY6Nr3JSZalPjgkdPUBWLzGt/Aq/+V
         CHdDz+kXVj3Qt+wP8bFZVBBzb2Uj3k+UXXEbKiawERz3vLrKKUFjlCuKKzohjr1HwpbU
         G3tg==
X-Forwarded-Encrypted: i=1; AJvYcCXg3NnkaalqyFAnbwyezp6o759LpmD2BJRAAT7FIWk2/PXpyYrqrF4unasbbHrsNqATxF1P8Z6W78vbAcKkjyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXz4vWlH7TGwm4tqNSqdipJsktcgG1/TcDeBFgTT+MnyaWF2V
	ad47/y/EkvLCnZ/vtmpipRupfaQ3l3NREFTP0bkvSl4RA27h3XfPLDIYKNyJ+xovc/eA0xJD4dY
	xDES/mWlZNZ30jf2+zKr4MvKJrpo=
X-Google-Smtp-Source: AGHT+IGI1u2dvA5is5B5b0/Df5mcP6KcGM+a0pmRPBPOvJCpLbDHgXiwEQE/3PtbFkSrzK90ZdDIOXd+dDs/guWArPM=
X-Received: by 2002:a17:90b:1c86:b0:2e2:b41b:8544 with SMTP id
 98e67ed59e1d1-2e8f108640dmr17473989a91.21.1730300397777; Wed, 30 Oct 2024
 07:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025114018.574041-1-dmantipov@yandex.ru>
In-Reply-To: <20241025114018.574041-1-dmantipov@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 10:59:42 -0400
Message-ID: <CABBYNZJEF62z1kwiUGq4vy8wyBgcmse49+hCQ9w92WfLx0hrrg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Oct 25, 2024 at 7:40=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Syzbot has reported the following KASAN splat:
>
> BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
> Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980
>
> CPU: 0 UID: 0 PID: 4980 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-00161-g=
ae90f6a6170d #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40=
 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x100/0x190
>  ? device_for_each_child+0x18f/0x1a0
>  print_report+0x13a/0x4cb
>  ? __virt_addr_valid+0x5e/0x590
>  ? __phys_addr+0xc6/0x150
>  ? device_for_each_child+0x18f/0x1a0
>  kasan_report+0xda/0x110
>  ? device_for_each_child+0x18f/0x1a0
>  ? __pfx_dev_memalloc_noio+0x10/0x10
>  device_for_each_child+0x18f/0x1a0
>  ? __pfx_device_for_each_child+0x10/0x10
>  pm_runtime_set_memalloc_noio+0xf2/0x180
>  netdev_unregister_kobject+0x1ed/0x270
>  unregister_netdevice_many_notify+0x123c/0x1d80
>  ? __mutex_trylock_common+0xde/0x250
>  ? __pfx_unregister_netdevice_many_notify+0x10/0x10
>  ? trace_contention_end+0xe6/0x140
>  ? __mutex_lock+0x4e7/0x8f0
>  ? __pfx_lock_acquire.part.0+0x10/0x10
>  ? rcu_is_watching+0x12/0xc0
>  ? unregister_netdev+0x12/0x30
>  unregister_netdevice_queue+0x30d/0x3f0
>  ? __pfx_unregister_netdevice_queue+0x10/0x10
>  ? __pfx_down_write+0x10/0x10
>  unregister_netdev+0x1c/0x30
>  bnep_session+0x1fb3/0x2ab0
>  ? __pfx_bnep_session+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_woken_wake_function+0x10/0x10
>  ? __kthread_parkme+0x132/0x200
>  ? __pfx_bnep_session+0x10/0x10
>  ? kthread+0x13a/0x370
>  ? __pfx_bnep_session+0x10/0x10
>  kthread+0x2b7/0x370
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x48/0x80
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 4974:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kmalloc_noprof+0x1d1/0x440
>  hci_alloc_dev_priv+0x1d/0x2820
>  __vhci_create_device+0xef/0x7d0
>  vhci_write+0x2c7/0x480
>  vfs_write+0x6a0/0xfc0
>  ksys_write+0x12f/0x260
>  do_syscall_64+0xc7/0x250
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 4979:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x4f/0x70
>  kfree+0x141/0x490
>  hci_release_dev+0x4d9/0x600
>  bt_host_release+0x6a/0xb0
>  device_release+0xa4/0x240
>  kobject_put+0x1ec/0x5a0
>  put_device+0x1f/0x30
>  vhci_release+0x81/0xf0
>  __fput+0x3f6/0xb30
>  task_work_run+0x151/0x250
>  do_exit+0xa79/0x2c30
>  do_group_exit+0xd5/0x2a0
>  get_signal+0x1fcd/0x2210
>  arch_do_signal_or_restart+0x93/0x780
>  syscall_exit_to_user_mode+0x140/0x290
>  do_syscall_64+0xd4/0x250
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this by doing 'device_del()' later and immediately before
> freeing its 'struct hci_dev' container. Otherwise the former
> might race against 'unregister_netdev()' innards called when
> 'bnep_session()' is going to terminate.
>
> Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6cf5652d3df49fae2e3f
> Fixes: bdc3e0f1d201 ("Bluetooth: Move device_add handling into hci_regist=
er_dev")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/bluetooth/hci_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 96d097b21d13..f1195b110495 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2716,7 +2716,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
>                 rfkill_destroy(hdev->rfkill);
>         }
>
> -       device_del(&hdev->dev);
>         /* Actual cleanup is deferred until hci_release_dev(). */
>         hci_dev_put(hdev);
>  }
> @@ -2756,6 +2755,8 @@ void hci_release_dev(struct hci_dev *hdev)
>         kfree_skb(hdev->sent_cmd);
>         kfree_skb(hdev->req_skb);
>         kfree_skb(hdev->recv_event);
> +
> +       device_del(&hdev->dev);

This actually doesn't work, we depend on device_del for
hci_release_dev to be called, so as the result hdev are never freed
with this change.

>         kfree(hdev);
>  }
>  EXPORT_SYMBOL(hci_release_dev);
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz
