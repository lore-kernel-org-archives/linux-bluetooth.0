Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2E1DF983;
	Mon,  6 Jan 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198874; cv=none; b=MJvksEnjniY1hT0RY4SC+P3plSFd9svbC63TWXipt7aylEvbF0LNCo56K2xiJF0wrS9GAEIgh67nmPAejn7iybgQ9ILMjmrOdg0zy7J45o2OqZQumwnBGyxBqBHZhfLFjPkhAB2X1k9WGEF3rzNKzyJHUOVu2BeTj30ekT+aI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198874; c=relaxed/simple;
	bh=UG/kQ6m/hutLfe1SPjyBt6w3LnGjjKWGp7HQ8OT+O1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmRelDG14zQRlN+fAG9Zj9aETh5ZQFCEQkIYccGGlh25wSul/pErYpqouDXuwpztrUYU1DP7RNC0DqcJgfH630Chv4KGJUBPQUeWhokQ5X41EQvbo4okh4ux2Y7u9PzD4k0n/ZJBoeXEmY3jrd6eGm1o50Ke/pxDY6KkXwCz9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc9GcAhN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc9GcAhN"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-304d760f118so34028351fa.0;
        Mon, 06 Jan 2025 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736198870; x=1736803670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfs23k40SIXXP/sXuNwPvMU4jcKltktGETzjLlAtvpI=;
        b=Tc9GcAhNw13adn1rQ0aKcOKTJ1X+FzZkPD+uSSfGpvLpCN95FZGQBsgdbX2yZLvNXz
         /U531+qFueupYwLqE3Kh8YZ4epEWwwP4HNUV5BhyFy1V7G/KzA3UDO//2HK8jKGUAAbN
         oJpPvRC8zEP3FzjToH3hrIr1cHYElWXC6SoJADzKFk0ueOo7cjWaobjoO2qjqzLPbi3j
         txjikIFSZ/S1e4BjoCAQp7MIEhnUV52QjBzlFWphbWzIFYJUm5U+ddpn2Fg7lCyyXpB0
         DIXPsigMRRzLArqzWW5VdBAgeLHrhpRjAZu97NC1hbCccO0TKxwVyhbKHvMK66EYD+9M
         dF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736198870; x=1736803670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfs23k40SIXXP/sXuNwPvMU4jcKltktGETzjLlAtvpI=;
        b=P6PaoFhYC4BsTDLoP0DLNYubLmoXGqQB75hvF9Ny79ZlEKTfAy2MLgGHJ/5CFyqiz/
         q77UwOtwlJ4BKc6WQcrqqVicVSAayCeTbBiNkVgKKhEw7OoGXfsTfhaAlc1AyLd3Px+r
         th/ArT2vKHmkeHoukShxFPGzWYekfkrk9uKo10yD2/2rxTM7QxyUuoyCdBOqmZgrRZ8t
         lff9YxEmgLlK458Ft1t8aDgA1tzc+hu0cY9PMU6XfEFEWH0tYYT2oqxCfRdvI/X4hgvB
         wYQPLheTb/0a7A/F6Zh7JY1Z8KYDkwdzLO/ykKHHnNShMyjigZb+slIeAkFJeOuJ6W0t
         989g==
X-Forwarded-Encrypted: i=1; AJvYcCUedj4g8g3ia46GjqlmSiDvv+m6pZC1Wpls0NZS8YShayXc9tlrh2/XuQ3TeHS8gTut5KZyy25iKIzyRUzu@vger.kernel.org, AJvYcCVNyUfhxvKfJ0mWD9FoR0V058udzrrD5CeRrd+m7rITty8jute0rzPkcFYWsndzQUjRX6kBeOK2T1mjDwuYg44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe98eoRTmPBvR0n5E8YLDmxPnE6vjwa7LR7lSv8IrrMJ6Or+cI
	2lHH6XuBVQ/bL7t/nqrkk7+kD/bHuBIDyJm3kmEDW1S981NJFStPhZGtjfl7pksLWbh3Rn5xsdF
	01K/EViIZMUrm4yPq/HNMqiW/nW4=
X-Gm-Gg: ASbGncvPgfFMDGPtppM3m5xi4nwo6Y9D2/OIOeDscmDm7pXl2TRZUBc/xZzARNnGxzQ
	27MCGG5z4v0Wvm/qxdgAMaBZ0YGBzdne9V/LF+/4=
X-Google-Smtp-Source: AGHT+IH9suoXzXG6d/A1BlQcLerwZhYbaTfDNhpzmxeGF9J8VRrPcVKbPz+m6hPWc47cgyJPwc/BC21TECxtM/o/Yqg=
X-Received: by 2002:a05:651c:1545:b0:300:de99:fcc6 with SMTP id
 38308e7fff4ca-304685dd8e0mr182139741fa.34.1736198869727; Mon, 06 Jan 2025
 13:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221170459.23095-1-mazin@getstate.dev>
In-Reply-To: <20241221170459.23095-1-mazin@getstate.dev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 16:27:37 -0500
Message-ID: <CABBYNZJcpgsPFsRLfyZ7iBvQC8oXRGnqOAnGY0uqMEsPD45DqQ@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: hci: Fix UAF from MGMT_OP_REMOVE_ADV_MONITOR
 during closure
To: Mazin Al Haddad <mazin@getstate.dev>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mazin,

On Sat, Dec 21, 2024 at 12:06=E2=80=AFPM Mazin Al Haddad <mazin@getstate.de=
v> wrote:
>
> When hci_dev is closing down, mgmt_power_off will free parts of the devic=
e.
> The freed memory can then be accessed when processing pending
> MGMT_OP_REMOVE_ADV_MONITOR cmds. Since submitting the command is allowed
> when it is powered off (as in previous discussions linked below), fix
> this by returning MGMT_STATUS_BUSY to pending MGMT_OP_REMOVE_ADV_MONITOR
> operations submitted as hci_dev_close_sync is running. Avoid processing
> pending cmds since doing so will lead to reacquiring the same lock. Add
> a sanity check within mgmt_remove_adv_monitor to ensure the cmd is still
> valid and exit early if not.
>
> BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0
> net/bluetooth/mgmt.c:5543
> Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961
>
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Freed by task 16022:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2338 [inline]
>  slab_free mm/slub.c:4598 [inline]
>  kfree+0x196/0x420 mm/slub.c:4746
>  mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
>  __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9550
>  hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
>  hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
>  hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
>  sock_do_ioctl+0x158/0x460 net/socket.c:1209
>  sock_ioctl+0x626/0x8e0 net/socket.c:1328
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Link: https://lore.kernel.org/lkml/20240424135903.24169-1-jlee@suse.com/
> Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D479aff51bb361ef5aa18
> Signed-off-by: Mazin Al Haddad <mazin@getstate.dev>

Missing Fixes tag, Ive been adding it myself for some time now but you
better create the practice to include it so I don't have to go find
what commit introduced the problem to then do git log -1
--pretty=3Dfixes and git commit --amend.

> ---
> Changes since v1:
>  * Change return code to ECANCELED
>  * Send out MGMT_STATUS_CANCELLED instead of MGMT_STATUS_BUSY
>  * Style fixes
>
>  net/bluetooth/hci_sync.c |  5 +++--
>  net/bluetooth/mgmt.c     | 20 ++++++++++++++++++--
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c86f4e42e69c..aa5aa3fed32d 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5197,6 +5197,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>          */
>         drain_workqueue(hdev->workqueue);
>
> +       /* flush cmd  work */
> +       flush_work(&hdev->cmd_work);

Might be a good idea to add a comment why it should be fine to flush
the command queue here, well in theory we could do immediately after
shutdown the driver since it shall no longer be processing commands,
in the other hand hdev is still considered running but perhaps that is
necessary in order to run things like hci_reset_sync but it doesn't
seem to be the case since that doesn't queue a command and instead it
send the command directly.

>         hci_dev_lock(hdev);
>
>         hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> @@ -5234,8 +5237,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>                 clear_bit(HCI_INIT, &hdev->flags);
>         }
>
> -       /* flush cmd  work */
> -       flush_work(&hdev->cmd_work);
>
>         /* Drop queues */
>         skb_queue_purge(&hdev->rx_q);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b31192d473d0..ec86ae851e56 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5519,9 +5519,17 @@ static void mgmt_remove_adv_monitor_complete(struc=
t hci_dev *hdev,
>  {
>         struct mgmt_rp_remove_adv_monitor rp;
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_cp_remove_adv_monitor *cp =3D cmd->param;
> +       struct mgmt_cp_remove_adv_monitor *cp;
> +
> +       // if executing while device is closing down, status could
> +       // be invalid as pending cmd could be removed by __mgmt_power_off
> +       // so exit early if the device was busy.

We don't use C++ style comments in bluetooth.

> +       if (status =3D=3D -ECANCELED ||
> +           cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +               return;
>
>         hci_dev_lock(hdev);
> +       cp =3D cmd->param;
>
>         rp.monitor_handle =3D cp->monitor_handle;
>
> @@ -5540,6 +5548,10 @@ static void mgmt_remove_adv_monitor_complete(struc=
t hci_dev *hdev,
>  static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data=
)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
> +
> +       if (cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +               return -ECANCELED;
> +
>         struct mgmt_cp_remove_adv_monitor *cp =3D cmd->param;
>         u16 handle =3D __le16_to_cpu(cp->monitor_handle);
>
> @@ -9544,8 +9556,12 @@ void __mgmt_power_off(struct hci_dev *hdev)
>          */
>         if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
>                 match.mgmt_status =3D MGMT_STATUS_INVALID_INDEX;
> -       else

CHECK: Unbalanced braces around else statement
#63: FILE: net/bluetooth/mgmt.c:9462:
+    else {

> +       else {
> +               match.mgmt_status =3D MGMT_STATUS_CANCELLED;
> +               mgmt_pending_foreach(MGMT_OP_REMOVE_ADV_MONITOR, hdev,
> +                                    cmd_status_rsp, &match);
>                 match.mgmt_status =3D MGMT_STATUS_NOT_POWERED;
> +       }
>
>         mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
>
>
> base-commit: 499551201b5f4fd3c0618a3e95e3d0d15ea18f31
> --
> 2.46.0
>


--=20
Luiz Augusto von Dentz
