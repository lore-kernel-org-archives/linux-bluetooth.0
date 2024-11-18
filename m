Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C61A265E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945893; cv=none; b=awAK8DOw3jYbiTE95Jlqo5dt6j/hxKiCvk/SRZnKEBypVOV58poQpbKamGk5RJVDCJvk1fBmRoaB7JNHiwLRWAhf1aJFzYnmzc9kTyJmkgWQUi6fhMYvP1djuOsNreNR85HQZMIF5XmnzD1nt4bozkLvZeJp3TTxjalRKC14Q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945893; c=relaxed/simple;
	bh=j/0f+wHu9TRlM9ADtn8AO9uza0FkzoO5OqDgjnK9/RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuDd9GWLGbN6mTPJLIpKuV6cJlJJC8d7dNOY6fOtIChxlrpZq0tPH1P8dqXmoOBJwTTkbaywmngj1fObC4Jhb9uxMnAyGq/+0qCbHL9GsdkXVG/fYOmxVBoXStwpC7dJA7OP2EC6qfuMfPIT6YlUW1Ojlx5VYMOQSO775o6bxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlo197sb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlo197sb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so29029941fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945889; x=1732550689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E98TrVcaopVna87I2SoJdGPQoTel+WMsPobpr/pCcTM=;
        b=hlo197sb2v+mSn/EvGKK31OrGVlepyZufq05z797wh/3pRfh4HfxsFzjPjiDyrXQD8
         OhCSTAZen1GifSMVL3j+oWfNeoVEL34jLxr0QSn+XYiVPUII9QqzFcE+iiO3q9Sdq0A4
         sAbAeim573Rwqw07HycsK81UJ+sgyb7TAA7o6x8CyuEg1XDu25/meWhwcnKlrmGAzGkq
         yAeguGMgF6pm4sgIfjkadzwcj5b9nkpPxGmYOwuTpMTw6N9Cm4ANO7c7yi27G2dwpbwT
         cezxeSbZRHT5bqIbAOAi7qVLuhGlFXIor9qIDgKjYJUd3yJ5aEcJUh/BZPVenVgbXetr
         OUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945889; x=1732550689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E98TrVcaopVna87I2SoJdGPQoTel+WMsPobpr/pCcTM=;
        b=WaOOVxq9GVxx3xnUbUPd0y4vHaOhETCdEYoOoVuvZ77cvvA6lzy2B7IBg8zvScY4iY
         88SMaisatfFoyTH+BWxr/xJ0sWAItHsRPX6ivW7FTgdhB80AOzBDiOmDMQEBKSvCSS8t
         dKY7IPvNrQeLF+qioWscjjBZJBpNt64vLPEaeTlSt48dOdYQ+NxjgZB1mbA5Uj85vovr
         HO5L+tJGgJWCib57c4TlihanuZelPXmnJT3jFK0Kr6b5N8qZaUPS/QhSWbjprmn6SuUu
         KgxsoJhsj0jBKBKSnx5OGoD5OpAcRQ3KQ/fIKAVSiCOnHxXGZP7zU42L5hB9E9y0QrWS
         qJwg==
X-Gm-Message-State: AOJu0YzJbd9bxO3G3wIsxZg2NvnS/oOz1jH/oDWb0pKiUtxFzhEb3wGY
	Vcugl8IbZfL2nL8Y9OWHa0m60kt9k8yy/OAtRG/lceblr0XJtiiiu1bIe/8ynigjMsiIkBHLHHN
	v28NXMGsOFhseOVbUjEvUxRIqLOlAHQ==
X-Google-Smtp-Source: AGHT+IGnCGw45m8NASBVrjxFehT9MzPzilUiBhNWc3OnItbodvC8JqlSqTVBedLUfOyCqxfzDKobNcvzvnL9HzeG+Xk=
X-Received: by 2002:a2e:a5c3:0:b0:2f7:6653:8046 with SMTP id
 38308e7fff4ca-2ff6070e543mr63032711fa.25.1731945888590; Mon, 18 Nov 2024
 08:04:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118153642.2604036-1-luiz.dentz@gmail.com>
In-Reply-To: <20241118153642.2604036-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Nov 2024 11:04:36 -0500
Message-ID: <CABBYNZ+jcHzVhzLXeU9GYJuFO-PgT=vfYq1+RrGkgyRA9AeU1A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Nov 18, 2024 at 10:36=E2=80=AFAM Luiz Augusto von Dentz
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
>  net/bluetooth/mgmt.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1f6d083682b8..3ec79c69b0ee 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1351,7 +1351,13 @@ static void mgmt_set_powered_complete(struct hci_d=
ev *hdev, void *data, int err)
>  static int set_powered_sync(struct hci_dev *hdev, void *data)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_mode *cp =3D cmd->param;
> +       struct mgmt_mode *cp;
> +
> +       /* Make sure cmd still outstanding. */
> +       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> +               return -ECANCELED;
> +
> +       cp =3D cmd->param;
>
>         BT_DBG("%s", hdev->name);
>
> @@ -1432,6 +1438,11 @@ static void settings_rsp(struct mgmt_pending_cmd *=
cmd, void *data)
>  {
>         struct cmd_lookup *match =3D data;
>
> +       /* dequeue cmd_sync entries using cmd as data as that is about to=
 be
> +        * removed/freed.
> +        */
> +       hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
> +
>         send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
>
>         list_del(&cmd->list);
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz
