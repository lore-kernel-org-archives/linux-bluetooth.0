Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C28EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 17:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjHKR5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKR5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 13:57:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC172D70
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:57:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b974031aeaso35214201fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691776627; x=1692381427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMy36SHI1k7V6XjQw139gMOIyDilntSUTjxz+q1RCk4=;
        b=a6lluHI+lw/vIziYVOdaHViJsWBmnYcevfgV6BI53Nq00G4X18nAPFCclRr1UzO8DY
         OPc/g0+e0s36GceqqlLjaNfp6dv3BoKqrzjwvPbHSDdGjlnYqlNW/Mz9ropb0CabTw6O
         vVwwVDUHNKhOqlz3fYJ1SPclLkeEetgZdEj0F8BkPV0rcW7r2dk4INrQ2u4Hw9U/r9GY
         sd3SmM5C6LehYYs67ZY3Ba7bO6knescbmZGT47Utk9UrtPXYuy7MbLOubca2cGk4KK3T
         C/L3NqV0uDJCjvu3yXf+K9fTG0TwyfkrxQhBa1c5GAjG/KA5BlvY/9VUmbzJDnzKRvRZ
         +tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691776627; x=1692381427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMy36SHI1k7V6XjQw139gMOIyDilntSUTjxz+q1RCk4=;
        b=ODTcKHniOtZM8OW+vaLDP3bSEInN1N5IbECXaoCYAGmRyzv2Jp05vMxwg3niX6c73r
         f9paJk66n0yQVin3ajQNN+iHuaKflLh1oJM0WaY5RUyBf40Vc3wOrjL6mKHFRNd5JBoz
         tW/bkWMsNq5JKoWdvIFZ5iF94wO4mvqrO1ERwixymeLJ6aqQtI9VjaycH28hSDQaZo0d
         mT8q1De4SoH/YkaU7S04xfnIPs/i/e4Y6CXRc4ddd7nkQ2m0kpqwTu3v5JBf5srwIKZ8
         2I1AHeq1rZPQrmKxYopZEhwlwV7Vw3yOzI7PCIPD3Ruzykz9BO3RPO5dnzUpNaPnlN5v
         vfZw==
X-Gm-Message-State: AOJu0YyzsBlfGMh5/1zx5R6w4XG5ZFEUYYHQYz/Hh6Tl1MBmkqHlpnGE
        Pw22XYHh2GYqP/o6ePesM0/uKB5Z6S8h1UwPDmUMhHVS
X-Google-Smtp-Source: AGHT+IE9Xd25KzEQRVBM0P4vAbinriwZXDwxggh3gg6lycGpAIrI0kdbZZS+Q7aiA3OFOB1R7YfCW6lPmt+GyqbALVI=
X-Received: by 2002:a2e:7412:0:b0:2b9:4418:b46e with SMTP id
 p18-20020a2e7412000000b002b94418b46emr2073850ljc.21.1691776627151; Fri, 11
 Aug 2023 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230809235622.1664227-1-luiz.dentz@gmail.com> <912e0cae83b4349c6cb91abced44e9687929d2b5.camel@iki.fi>
In-Reply-To: <912e0cae83b4349c6cb91abced44e9687929d2b5.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Aug 2023 10:56:54 -0700
Message-ID: <CABBYNZKq6NeijYQz=kyRJquiq1aCB3he43ovf2WPZpCxspoKqg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Aug 10, 2023 at 1:55=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-08-09 kello 16:56 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Use-after-free can occur in hci_disconnect_all_sync if a connection is
> > deleted by concurrent processing of a controller event.
> >
> > To prevent this the code now tries to iterate over the list backwards
> > to ensure the links are cleanup before its parents, also it no longer
> > relies on a cursor, instead it always uses the last element since
> > hci_abort_conn_sync is guaranteed to call hci_conn_del.
> >
> > UAF crash log:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in hci_set_powered_sync
> > (net/bluetooth/hci_sync.c:5424) [bluetooth]
> > Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124
> >
> > CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
> > 6.5.0-rc1+ #10
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > 1.16.2-1.fc38 04/01/2014
> > Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x5b/0x90
> >  print_report+0xcf/0x670
> >  ? __virt_addr_valid+0xdd/0x160
> >  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> >  kasan_report+0xa6/0xe0
> >  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> >  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
> >  hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> >  ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
> >  ? __pfx_lock_release+0x10/0x10
> >  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
> >  hci_cmd_sync_work+0x137/0x220 [bluetooth]
> >  process_one_work+0x526/0x9d0
> >  ? __pfx_process_one_work+0x10/0x10
> >  ? __pfx_do_raw_spin_lock+0x10/0x10
> >  ? mark_held_locks+0x1a/0x90
> >  worker_thread+0x92/0x630
> >  ? __pfx_worker_thread+0x10/0x10
> >  kthread+0x196/0x1e0
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x2c/0x50
> >  </TASK>
> >
> > Allocated by task 1782:
> >  kasan_save_stack+0x33/0x60
> >  kasan_set_track+0x25/0x30
> >  __kasan_kmalloc+0x8f/0xa0
> >  hci_conn_add+0xa5/0xa80 [bluetooth]
> >  hci_bind_cis+0x881/0x9b0 [bluetooth]
> >  iso_connect_cis+0x121/0x520 [bluetooth]
> >  iso_sock_connect+0x3f6/0x790 [bluetooth]
> >  __sys_connect+0x109/0x130
> >  __x64_sys_connect+0x40/0x50
> >  do_syscall_64+0x60/0x90
> >  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> >
> > Freed by task 695:
> >  kasan_save_stack+0x33/0x60
> >  kasan_set_track+0x25/0x30
> >  kasan_save_free_info+0x2b/0x50
> >  __kasan_slab_free+0x10a/0x180
> >  __kmem_cache_free+0x14d/0x2e0
> >  device_release+0x5d/0xf0
> >  kobject_put+0xdf/0x270
> >  hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
> >  hci_event_packet+0x579/0x7e0 [bluetooth]
> >  hci_rx_work+0x287/0xaa0 [bluetooth]
> >  process_one_work+0x526/0x9d0
> >  worker_thread+0x92/0x630
> >  kthread+0x196/0x1e0
> >  ret_from_fork+0x2c/0x50
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier"=
)
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 32fa9006f381..234da30292a4 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5429,7 +5429,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, st=
ruct hci_conn *conn, u8 reason)
> >               hci_dev_unlock(hdev);
> >               return 0;
> >       default:
> > +             hci_dev_lock(hdev);
> >               conn->state =3D BT_CLOSED;
> > +             hci_disconn_cfm(conn, reason);
> > +             hci_conn_del(conn);
> > +             hci_dev_unlock(hdev);
> >               return 0;
> >       }
>
> When powering off we do not wait for the Disconnection_Complete or
> Connection_Complete events from disconnect/cancel, but only the command
> status.
>
> In these cases it looks like hci_abort_conn_sync returns while the conn
> still exists. Then the command may get sent again. If the controller
> rejects the second disconnect/cancel command with error status then
> conn probably gets deleted on second round (kprinting errors),
> otherwise it loops here waiting until the conn goes away.
>
> LE connection cancel maybe busy-loops here forever until the connection
> completion event arrives, because of the HCI_CONN_CANCEL flag test,
> negating the point of not waiting for that event.
>
> Maybe hci_conn_abort_conn_sync should do the "if (err) { ..." cleanup
> unconditionally also when err =3D 0? This might get the state out of sync
> with controller when powering off, if the power off gets canceled after
> this. OTOH, we probably would be deleting the conns anyway when the
> connection completion events from the successful commands arrive, so
> maybe this doesn't matter and one can think it through.

Yep, I tried to address this on v2

> Tests would indeed be nice here...

Perhaps we need to update the suspend test to actually have
connections to cleanup.

> >
> > @@ -5458,13 +5462,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, s=
truct hci_conn *conn, u8 reason)
> >
> >  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
> >  {
> > -     struct hci_conn *conn, *tmp;
> > -     int err;
> > +     struct list_head *head =3D &hdev->conn_hash.list;
> >
> > -     list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) =
{
> > -             err =3D hci_abort_conn_sync(hdev, conn, reason);
> > -             if (err)
> > -                     return err;
> > +     /* Use reverse order so links are cleanup before parents */
>
> I suspect the ordering may be either way: you can have a pre-existing
> ACL connection when ISO is connected, or use something like ISO
> BT_DEFER_SETUP and then hci_connect_cis may create the ACL after ISO.
>
> In iso-tester tests it's probably the latter and with real BAP the
> former (but didn't actually check it now, too late for today).
>
> Maybe iterating the struct hci_link is OK here, it's probably still
> fairly simple.
>
> A big simplification came from having hci_abort_conn delete always and
> not bailing out from disconnect_all_sync loop on errors.
>
> > +     while (!list_empty(&hdev->conn_hash.list)) {
> > +             struct hci_conn *conn =3D list_last_entry(head, struct hc=
i_conn,
> > +                                                     list);
> > +
> > +             /* Disregard possible errors since hci_conn_del shall hav=
e been
> > +              * called even in case of errors had occurred since it wo=
uld
> > +              * then cause hci_conn_failed to be called which calls
> > +              * hci_conn_del internally.
> > +              */
> > +             hci_abort_conn_sync(hdev, conn, reason);
> >       }
>
> I think to be UAF-safe the list iteration must either hold
> rcu_read_lock and use RCU primitives, or, hold hdev->lock and use usual
> list primitives.
>
> In both cases it should take hci_conn_get to prevent concurrent
> hci_conn_del freeing the conn before hci_abort_conn_sync is finished
> accessing its fields.
>
> rcu_read_lock();
> while ((conn =3D list_first_or_null_rcu(...)) {
>         conn =3D /* one of conn->links if any, otherwise conn */
>         hci_conn_get(conn);
>         rcu_read_unlock();
>         hci_abort_conn_sync(hdev, conn, reason);
>         hci_conn_put(conn);  /* must be before rcu_read_lock */
>         rcu_read_lock();
> }
> rcu_read_unlock();
>
> or with *rcu* -> hdev->lock.
>
> Not using RCU primitives or hdev->lock is probably not safe even if
> hci_conn_del is prevented from running concurrently by future changes
> in hci_sync, because there may be concurrent list_add_rcu and you can't
> know if compiler generated concurrency safe code from the non-RCU list
> iteration primitives here.

Added something similar to v2.

> >
> >       return 0;
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
