Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2A3EA98
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473312; cv=none; b=GX0HgmTGRipYtMw8owIh5AuS1aKvjXXyMUWSNevJHXI3baETUN4iAIo5/e6ZQxCTRi+8j/FlahrgZi1Hsq5ERFtd9bykbI35Gixn1jRoDmz5rKXSYW2U6K12diR+vPV4PAJseuA/qTmdk/1jGpQe65BtC0hDO/XgUZrgpEmPYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473312; c=relaxed/simple;
	bh=Zz+o/LDGqTSztdvSL3+oz10JtZH/jc4qzMhuHAGd0ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPMkzMw+h4A3SIsPYOOe+geD7cd34p49pQfhaY0NO6f7WX2FxOP/UEVRlmMdlC9C3E35j3Efb1sisCjrJ4CfpQE2hrL8K9bb/6ygRp7HnORzqkoeaSzRxrAAFHqrrMO5kzzGTPjuq98rkVDmUq7FStMDSQ0Nq6YxWrSlmOxZ+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJf1FFY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJf1FFY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so21202581fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730473308; x=1731078108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vub5KUQpmiSwTfKjyJVVnGv+W9QJr+Nq10XirqsaTAs=;
        b=XQJf1FFYnpraSVIuDk8ZFQboEkuDFl2Tmuv7ovVJMk0lN6bvqIgNfWYdzgaLthomvB
         suGxMgE/EIlz6IjJGrTC8K9cQsODHijRzsVZW7I3gMH7T1p6K9YarjfN+jSAP4wGy/xL
         ID0MxzUdFYPuV8Lhzt5eSIJjTG0KPWvI+RfFubrRJ5Fdg9kEYTVL8X8+r6xW+5LYfuFU
         UvdKI5Zco/5UdFalQ0cro7WsHQ/4CF/9hf7nX6ytKlH/LWBldXiIJwdsOf3mtcRC1Mht
         FT6NCIYOpr/95XLlhDI46lQ+17d4gCOlxGg4SDCbJT9dNRI9aiE7e0Eg71pnYbLdQ/e/
         2yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473308; x=1731078108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vub5KUQpmiSwTfKjyJVVnGv+W9QJr+Nq10XirqsaTAs=;
        b=RwSeDKRgbr7Eo1Y3qirbckq/EMFVwVAlz52fDBp+J/VGks58KjIDXuoHwsn2rOez0E
         di8bQPESo21NBB7TAZlM428oZrbqVx8aLnFAATMxWQ4CjHQpdFUYpPIT+mhKlLEJat5t
         7PkVXW0oJT281NiTe6mzkDXCiZVEU5zVBSD4As0dikwhvbHGrNBLctz+mabwAAfbjpvv
         TK18GMuvxPXUZepmI/QSERmuh2+kr3trjBNfSpUEfSDfLVkeJ+z/iP0tWifWeMKkL2G0
         1dmb/ELJutUn51qjX7BNP9uImFm4mkRJgKy0E/aEraimzycbuNSosGiqPagsUuuPq4RP
         1xug==
X-Forwarded-Encrypted: i=1; AJvYcCX5XHxn0/aK9D4/hdEsYeJUBllI1ZxfBc2k1FSIYPiw2WLAHR1/A09ZhDe1c7r3SLojYSDocWAwnfLoAfn20O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxmpDEIpkJcGAa2I+rVsrWUa1g6LSd+yNy4oYnddp3XsdnTjh
	RL6BN3/+4PMdEkDFFu1lxhAFldL2LpUw0qNQ8VwSGgXk5KBbojK6cgFdEJ3D8DA5Y5zi3Ua/SEE
	zlBmWPCzLrAuH31RNJ7oVW1PyD1c=
X-Google-Smtp-Source: AGHT+IFHVyTHkH2Dgj0ai60KygQ+mHogz2weILiWNeS3q+5QrRy9t20lE9pg8M09PUlLcmNn1JIBkgOZn8I7hLxahog=
X-Received: by 2002:a05:651c:507:b0:2fc:a347:6d90 with SMTP id
 38308e7fff4ca-2fcbdfe2dcbmr112598571fa.27.1730473307563; Fri, 01 Nov 2024
 08:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru>
In-Reply-To: <20241101114410.234311-1-dmantipov@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Nov 2024 11:01:34 -0400
Message-ID: <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Nov 1, 2024 at 7:44=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
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
> In 'hci_conn_del_sysfs()', 'device_unregister()' may be called when
> an underlying (kobject) reference counter is greater than 1. This
> means that reparenting (happened when the device is actually freed)
> is delayed and, during that delay, parent controller device (hciX)
> may be deleted. Since the latter may create a dangling pointer to
> freed parent, avoid that scenario by reparenting to NULL explicitly.
>
> Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6cf5652d3df49fae2e3f
> Fixes: a85fb91e3d72 ("Bluetooth: Fix double free in hci_conn_cleanup")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: reparent per-connection 'struct device' explicitly
> ---
>  net/bluetooth/hci_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 367e32fe30eb..80ac537fa500 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -73,6 +73,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
>                 return;
>         }
>
> +       device_move(&conn->dev, NULL, DPM_ORDER_DEV_LAST);
> +
>         while (1) {
>                 struct device *dev;
>
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz
