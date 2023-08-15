Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4ACC001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbjHOWlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbjHOWlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 18:41:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E201BCC
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:41:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703a0453fso89435311fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692139291; x=1692744091;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTYo/m/5nz3CeWZjy5QAuOhG2hzGyo5a2fLdVzrV/7s=;
        b=UZ6k+r3ACPspMyzIHPUZhxQup4mOPwdzVurJlgDyN5IIXEwkBhvun1BRmuXAcAEI1s
         YHrqggoQC1GVOThhSgG73YYSpWjiQTp2q4iiiY+wSuxjuiMb1iVcJHt3UMIzOV+UPNMJ
         rR/JCB47Emeomd4oiTnt9tjQv0h15zFls2lLHYPMzrd2SRevPOhuzC7OOkxcbq5aM6Py
         k//GTotS7Axt4C42NFdpvzb8d52xGsv+0VKR2qZ4s/ykCSwZeZjEi2isqhmDO9ESSRrw
         KCgecb68c/A4MIeUmK+Rz0mchuxInxEiBHJkyUr/+jN8/8zML3pJ3atBw6HpIYvjZW9e
         8dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692139291; x=1692744091;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTYo/m/5nz3CeWZjy5QAuOhG2hzGyo5a2fLdVzrV/7s=;
        b=D3SHXLiqCYaV++EKK0CiabBsNSotZI2xpF7kjZY7O/bMQjVWKsCVOptnGdhgzjNJ8N
         towS+gohsuvplHY2RN+F2GE8WDY4BiEvfrEVYgz/ZFItkRpe/34tn7FBlBOoTWUxZymn
         H8FootE+ugJeNHtZbSyt7m7yafeIgo3kRX2n8poWCPqwigfbazxni5ngF3Pn4Z5A3orS
         3aB4eM8EVvdoh2gQf0kTkqVeUoz2o0cz4VMZrK9E0VjkaWzHNcO1GBMsndjXJ6WoJTzj
         kH2SUEq1SW54KZVBOMicz+HehvUQD3PraoS0gBUFe53QywLL53Zl6JCi9v8ATg90BLbl
         +k6w==
X-Gm-Message-State: AOJu0YzPkr3V7f2Bj9zGbmXVHQf4QbD7jFNfnlZUuHRoWkCFY+C93JnT
        TotmmWkSi+2ibCgBMIU1BUqQskj8GCIDt9Fa1k/nSu7Wk64=
X-Google-Smtp-Source: AGHT+IHkDf6kJPbZChNh40djbYrBUwKxgSEk6eJstcSowBGJzQTTY+OYysKPd9Yx92WM78cqoEZ9J4vjzICuBZgFObw=
X-Received: by 2002:a2e:87c5:0:b0:2bb:8d70:c9e with SMTP id
 v5-20020a2e87c5000000b002bb8d700c9emr90056ljj.47.1692139290948; Tue, 15 Aug
 2023 15:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230814190101.2302448-1-luiz.dentz@gmail.com>
In-Reply-To: <20230814190101.2302448-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 15:41:18 -0700
Message-ID: <CABBYNZKLG1feOObk6gLgCEBTUVbtAwX6NYeZ6KnbjV=q_P5jbw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
To:     linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Aug 14, 2023 at 12:01=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Use-after-free can occur in hci_disconnect_all_sync if a connection is
> deleted by concurrent processing of a controller event.
>
> To prevent this the code now tries to iterate over the list backwards
> to ensure the links are cleanup before its parents, also it no longer
> relies on a cursor, instead it always uses the last element since
> hci_abort_conn_sync is guaranteed to call hci_conn_del.
>
> UAF crash log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_set_powered_sync
> (net/bluetooth/hci_sync.c:5424) [bluetooth]
> Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124
>
> CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
> 6.5.0-rc1+ #10
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.2-1.fc38 04/01/2014
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
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 55 +++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5eb30ba21370..d10a0f36b947 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5370,6 +5370,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struc=
t hci_conn *conn, u8 reason)
>  {
>         int err =3D 0;
>         u16 handle =3D conn->handle;
> +       struct hci_conn *c;
>
>         switch (conn->state) {
>         case BT_CONNECTED:
> @@ -5389,43 +5390,57 @@ int hci_abort_conn_sync(struct hci_dev *hdev, str=
uct hci_conn *conn, u8 reason)
>                 hci_dev_unlock(hdev);
>                 return 0;
>         default:
> +               hci_dev_lock(hdev);
>                 conn->state =3D BT_CLOSED;
> +               hci_disconn_cfm(conn, reason);
> +               hci_conn_del(conn);
> +               hci_dev_unlock(hdev);
>                 return 0;
>         }
>
> +       hci_dev_lock(hdev);
> +
> +       /* Check if the connection hasn't been cleanup while waiting
> +        * commands to complete.
> +        */
> +       c =3D hci_conn_hash_lookup_handle(hdev, handle);
> +       if (!c || c !=3D conn) {
> +               err =3D 0;
> +               goto unlock;
> +       }
> +
>         /* Cleanup hci_conn object if it cannot be cancelled as it
>          * likelly means the controller and host stack are out of sync
>          * or in case of LE it was still scanning so it can be cleanup
>          * safely.
>          */
> -       if (err) {
> -               struct hci_conn *c;
> -
> -               /* Check if the connection hasn't been cleanup while wait=
ing
> -                * commands to complete.
> -                */
> -               c =3D hci_conn_hash_lookup_handle(hdev, handle);
> -               if (!c || c !=3D conn)
> -                       return 0;
> -
> -               hci_dev_lock(hdev);
> -               hci_conn_failed(conn, err);
> -               hci_dev_unlock(hdev);
> -       }
> +       hci_conn_failed(conn, reason);
>
> +unlock:
> +       hci_dev_unlock(hdev);
>         return err;
>  }
>
>  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
>  {
> -       struct hci_conn *conn, *tmp;
> -       int err;
> +       struct list_head *head =3D &hdev->conn_hash.list;
> +       struct hci_conn *conn;
>
> -       list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) =
{
> -               err =3D hci_abort_conn_sync(hdev, conn, reason);
> -               if (err)
> -                       return err;
> +       rcu_read_lock();
> +       while ((conn =3D list_first_or_null_rcu(head, struct hci_conn, li=
st))) {
> +               /* Make sure the connection is not freed while unlocking =
*/
> +               conn =3D hci_conn_get(conn);
> +               rcu_read_unlock();
> +               /* Disregard possible errors since hci_conn_del shall hav=
e been
> +                * called even in case of errors had occurred since it wo=
uld
> +                * then cause hci_conn_failed to be called which calls
> +                * hci_conn_del internally.
> +                */
> +               hci_abort_conn_sync(hdev, conn, reason);
> +               hci_conn_put(conn);
> +               rcu_read_lock();
>         }
> +       rcu_read_unlock();
>
>         return 0;
>  }
> --
> 2.41.0

Any comments on this one, I actually took the time to add some tests
to iso-tester to attempt to cover scenarios where
hci_disconnect_all_sync is called whiled connecting/connected which
seems to be working with these changes.

--=20
Luiz Augusto von Dentz
