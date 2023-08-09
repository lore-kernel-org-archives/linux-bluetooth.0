Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64AC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 23:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjHIXtU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIXtT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 19:49:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A710DE
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 16:49:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so5231161fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691624957; x=1692229757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwMtOee9DLPgAvOaDR9aFZnQqDDltDWLR+FX8t/fMds=;
        b=D8JrCFcNdcJ5LrfsqaSKAuwmoo6luJHDGGcSKHG4Cyp5O03x/1fI/URVP6d/3+Gd86
         Cg8W2Wce3ZIjusJxbslzVhWFXgxHVFFLPZOjTHgfcriNXWEL29H9osy1ixhnaj2Unsiv
         KF2PTn01h4CqE71jPOrqa6cKby9WxI3/Fhf8fWQ257jWGsixhRZKuGJJhmElLkBuxk64
         cItSZ6xVWBO96QJM8l1qCJKRc94TDcPZ5ypyjNqhUigAXd+XygicZC4R4TdrdoGXEF+G
         ImlGGnNVvj2Sva/6iNdaDA9NK7Unii8rncaYg+q7IeD8KdRGjyVxx0Iqp9w3e409LPMB
         SHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691624957; x=1692229757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwMtOee9DLPgAvOaDR9aFZnQqDDltDWLR+FX8t/fMds=;
        b=TsQ4txYYf8hZ8+oCFz8k7QeuKnJXbIPuHYWBfJB9BUhEDPfHx8pnElA0JylH0vRv66
         6yhJXYcwKDnpUid+gfaf0E4lxX4r6dHW05k/tHvhpeaXYR7Priq7zdAbfUJBqu5tpHy+
         TOUcSuph+EqkEWkaeox9Axz0/0TBB7ld3TS2R6nx0E+U69jbQqfisM7nLiLt7p8YVZgI
         W24YpyuuNlnDaP5DqvaBE05oLliizzd/sKiZindH8i5KQekMGBkFTqgbzu8AvNtjET/N
         I4eLxam8k6zM8+rIMkF1oRHGt9XYXvqBLKul3WqJMmfvvBRUzqdZYfm2oFKHDWiuFYFu
         VRMA==
X-Gm-Message-State: AOJu0Yxh7Uo/1RyFR61JVF6AgOOGYJ+0xEsZhb4d4pYux27+FVhKMqOt
        8+qnhNFlPwfUaxf/5DnIAxhFKZI7Vx7nIdUIwOLPmsShpbI=
X-Google-Smtp-Source: AGHT+IFiRGK7S9qOFa7ErC0BjB3YJUPVaNvwYLuGR4X++lVC5T3vbvYGHOLpdNwVtzZgc5zQNPfQuXCHmrVNvJSAkms=
X-Received: by 2002:a2e:94cf:0:b0:2b9:b067:9559 with SMTP id
 r15-20020a2e94cf000000b002b9b0679559mr503586ljh.23.1691624956568; Wed, 09 Aug
 2023 16:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
 <7b81cf669e2172b2e69d3b4fe6c9c256f5249c69.1691352503.git.pav@iki.fi>
In-Reply-To: <7b81cf669e2172b2e69d3b4fe6c9c256f5249c69.1691352503.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 16:49:04 -0700
Message-ID: <CABBYNZKVBnd62C3TCVTtmruf=eZGzZCUqnmOYP4JuM=krrgjKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Aug 6, 2023 at 2:39=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Use-after-free occurs in hci_disconnect_all_sync if a connection is
> deleted by concurrent processing of a controller event.  This can occur
> while waiting for controller events (big time window) or at other times
> (less likely).
>
> Fix the iteration in hci_disconnect_all_sync to allow hci_conn to be
> deleted at any time.
>
> UAF crash log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hc=
i_sync.c:5424) [bluetooth]
> Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124
>
> CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W          6.5.0-rc1=
+ #10
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04=
/01/2014
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x5b/0x90
>  print_report+0xcf/0x670
>  ? __virt_addr_valid+0xdd/0x160
>  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  kasan_report+0xa6/0xe0
>  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
>  hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
>  hci_cmd_sync_work+0x137/0x220 [bluetooth]
>  process_one_work+0x526/0x9d0
>  ? __pfx_process_one_work+0x10/0x10
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  ? mark_held_locks+0x1a/0x90
>  worker_thread+0x92/0x630
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x196/0x1e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  </TASK>
>
> Allocated by task 1782:
>  kasan_save_stack+0x33/0x60
>  kasan_set_track+0x25/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  hci_conn_add+0xa5/0xa80 [bluetooth]
>  hci_bind_cis+0x881/0x9b0 [bluetooth]
>  iso_connect_cis+0x121/0x520 [bluetooth]
>  iso_sock_connect+0x3f6/0x790 [bluetooth]
>  __sys_connect+0x109/0x130
>  __x64_sys_connect+0x40/0x50
>  do_syscall_64+0x60/0x90
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> Freed by task 695:
>  kasan_save_stack+0x33/0x60
>  kasan_set_track+0x25/0x30
>  kasan_save_free_info+0x2b/0x50
>  __kasan_slab_free+0x10a/0x180
>  __kmem_cache_free+0x14d/0x2e0
>  device_release+0x5d/0xf0
>  kobject_put+0xdf/0x270
>  hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
>  hci_event_packet+0x579/0x7e0 [bluetooth]
>  hci_rx_work+0x287/0xaa0 [bluetooth]
>  process_one_work+0x526/0x9d0
>  worker_thread+0x92/0x630
>  kthread+0x196/0x1e0
>  ret_from_fork+0x2c/0x50
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2: use only valid values for abort_reason, in case we fail before
>         handling all conns
>
>     This is still a bit clumsy, a separate flag indicating if connection =
was
>     aborted yet could be better.

I suspect this is caused by the links being removed when the ACL is
removed, so perhaps disconnect_all shall actually use
list_for_each_entry_safe_reverse so we disconnect the links before we
attempt to disconnect the parents. That said we still have the risk
that if there is an event in the meantime that messes up with the list
past the previous item then the whole thing is not safe, so perhaps we
should switch to hci_conn_hash_flush method and guarantee hci_conn_del
has been called.

>  net/bluetooth/hci_sync.c | 47 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 51ff682f66e0..228259f44815 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5415,16 +5415,49 @@ int hci_abort_conn_sync(struct hci_dev *hdev, str=
uct hci_conn *conn, u8 reason)
>
>  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
>  {
> -       struct hci_conn *conn, *tmp;
> -       int err;
> +       struct hci_conn *c, *conn;
> +       int err =3D 0;
>
> -       list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) =
{
> -               err =3D hci_abort_conn_sync(hdev, conn, reason);
> -               if (err)
> -                       return err;
> +       rcu_read_lock();
> +
> +       /* Any conn may be gone while waiting for events, iterate safely.
> +        * If conn is in conn_hash and we didn't abort it, it probably
> +        * has not yet been aborted.
> +        */
> +       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> +               if (c->abort_reason !=3D reason)
> +                       continue;
> +
> +               c->abort_reason =3D (reason !=3D HCI_ERROR_REMOTE_USER_TE=
RM) ?
> +                       HCI_ERROR_REMOTE_USER_TERM : HCI_ERROR_UNSPECIFIE=
D;
>         }
>
> -       return 0;
> +       do {
> +               conn =3D NULL;
> +               list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> +                       if (c->abort_reason =3D=3D reason)
> +                               continue;
> +
> +                       conn =3D c;
> +                       break;
> +               }
> +               if (!conn)
> +                       break;
> +
> +               conn->abort_reason =3D reason;
> +               hci_conn_get(conn);
> +
> +               rcu_read_unlock();
> +
> +               err =3D hci_abort_conn_sync(hdev, conn, reason);
> +               hci_conn_put(conn);
> +
> +               rcu_read_lock();
> +       } while (!err);
> +
> +       rcu_read_unlock();
> +
> +       return err;
>  }
>
>  /* This function perform power off HCI command sequence as follows:
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
