Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C21D5158
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688934; cv=none; b=IDL+kK3La8h0vDgT8A9fyLpY4j9YI5x3NiE+DkpXDKjO/aTVMLL5kosy2qshMJtzq6cSx6kV4k+prjks+FE74OSpOLnrTYvVf8ZOEFtqx0o0e3cQd4pndfr98rXwOJYiMVqrezxFgcONx3SPJOwBKuTiWx7rDCi7mArftnej7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688934; c=relaxed/simple;
	bh=FFrMLawfAsjZms4r/DV2EroqE4AUfP6dw10+4NvmhNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoDm4L4Ww89XRbSbvBUQlMvMA7sYIfTErVCJcCza5aV3XbWD+WU+BosBSGsFQUNdnN+DyoHsQ8eBVbV5ae+AKlTql0V2IxNQiFmYwvMjedTi3mGEw2scKIuG0l902r/TPe+jDVFibukLgTJul0Uf5/moW9kyl1uMfLqTLW8IfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXC30ah+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXC30ah+"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so16615311fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688930; x=1732293730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKtgeZL0lI9SBbjAgSXnzBUljs3N5w5ZflMC60zo8c0=;
        b=IXC30ah+SeqfeCKV9MfZxjY28VNOoeJR0uCwB05SSckpjNEnypR/Ds13NwP8voAHKr
         fgYG8A/zTexxfuu8kWTWKQ8+fyXMK6DnO6J44yS471odGObs4kOXkPbxPJTRMY4g/2vl
         NwmDfQ+EWryGBBMFdGa8NYhcjIXcIdWeHkVtxt0bSqV8y8lF/9HgTtbigXoW/fFETU8Q
         /WCzsncFqDurYDx8/3ElQGpRlcC7Y6VP0YIhwMVXrr1xu5OcGcDkSB8adL9CqDnPoXbX
         u5AU/XoHFWnzuwlHIu6EthgkALT1e886fEfyJutNZ5D9l594rm6aZ137Vo94uzzlFUv7
         TyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688930; x=1732293730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKtgeZL0lI9SBbjAgSXnzBUljs3N5w5ZflMC60zo8c0=;
        b=S9d8lO1oxlbYXCz+e6zCCW9p3uxpPx6AdxpFQQ1K3nXnuFH8Qe1iBAaqZD1mBiaWTj
         3yKujfC+VF8Su9SEhoYDKlloeDpwdQrxO6k2UYayBUUcQghjfqe3YV+yBg06CYi2Ri6W
         wOA+x4nin01w2eZ/BvuuXm90CM/sDgkddiIFT85DKx82JHCKNj6TEQwS8K1cDcyq8iXy
         a0gWkZDoV9KPqT8UyIAyq6Mi/CFVc0x+N/cT9hFz12/Lmved/ZQKqlBfnzv4dHBZptcX
         927Tk8BCXwMPUdcrqUQwgu4gyN/tOeOFrOXJwb8Urrr2Iql/PV+H078DuvyG4E+yqZMU
         3R+A==
X-Gm-Message-State: AOJu0YxZTz5e1ElzfIXKStbHtV6ctZ8ra23nJCzVMRxD1LHyYXltfbyS
	Q7oIab7IR8Ta3jdmOnJxJAQaG4U8H0hJy9PkGg5Xkz2n5x/DEnY7+mOpUupCivjQXehI4lPoCsK
	/mit00obDBBWnE3zjyr6BcEiSd8zDcsSv
X-Google-Smtp-Source: AGHT+IEdfU4iWGnvIGiYFkABAK9ZRemxdZ8TB7vsi3ZnuWeL0r0qs9Sm90sO8Wj47f9IemhkA4YPFAzDLgWXDfSguj8=
X-Received: by 2002:a05:651c:245:b0:2fb:4f2e:5be7 with SMTP id
 38308e7fff4ca-2ff6096b5cbmr21281981fa.24.1731688929451; Fri, 15 Nov 2024
 08:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115155941.2118683-1-luiz.dentz@gmail.com>
In-Reply-To: <20241115155941.2118683-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Nov 2024 11:41:57 -0500
Message-ID: <CABBYNZLatZOTP3B68PPdm0E7y-t4qAzCDmaB8vxKZu-o3ncmgQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Nov 15, 2024 at 10:59=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following crash:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetoo=
th/mgmt.c:1353
> Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54
>
> CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller=
-01155-gf723224742fc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
> q kasan_report+0x143/0x180 mm/kasan/report.c:601
>  set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 5247:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
>  mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
>  set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
>  hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
>  hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  sock_write_iter+0x2dd/0x400 net/socket.c:1160
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5246:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kfree+0x149/0x360 mm/slub.c:4598
>  settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
>  mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
>  __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
>  hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
>  hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
>  hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
>  sock_do_ioctl+0x158/0x460 net/socket.c:1222
>  sock_ioctl+0x629/0x8e0 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83gv
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D03d6270b6425df1605bf
> Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1f6d083682b8..6a26c1ea0d04 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1441,6 +1441,10 @@ static void settings_rsp(struct mgmt_pending_cmd *=
cmd, void *data)
>                 sock_hold(match->sk);
>         }
>
> +       /* dequeue cmd_sync entries using cmd as data as that is about to=
 be
> +        * removed/freed.
> +        */
> +       hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
>         mgmt_pending_free(cmd);
>  }
>
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz
