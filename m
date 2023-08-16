Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F1C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbjHPR76 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjHPR7a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 13:59:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B4E2710
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 10:59:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so104132431fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692208767; x=1692813567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnLNOjmBd2V5Ifs6OmlfMVpo6cDeS2hF5Q3p6tyyYkY=;
        b=nM/9lZyBGj5Cs0wpe/rMXrguwYiYpc3Yhy5Yl1zUWuKG+UoH2XTzEulrDt+z0Ftx9U
         jKgtQbfGIBGqurrbNdloVaIJR3z+AIHo4wNbxD64LeEJSEjGMq1XX4AABQbYswX0ndMK
         wN50FiPF+mYsvTwwWxVY7NV0+d48l0QNGjt5iiC9ym0VfXZ+bo7ezgpuT01a4iG9zisA
         FzeJtqmnS9r+dXqmMmnWJe43uW7xJb+o3wM1Ck/fmx3armimGBEQKz4J2x9ohKGZs2i3
         ze+Yt34M3VGrTDj8wn0MrsE7nyD5CrtbLyvkvKcmmJwlT27glDmhUQbRxTTmEn8dUOhj
         JcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208767; x=1692813567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnLNOjmBd2V5Ifs6OmlfMVpo6cDeS2hF5Q3p6tyyYkY=;
        b=QVGH1no5CHzPhKBlRB4zPyu/twEqcZ8rQr80jWda2Zv7QYYFcB7zEiFRY+B9kZJT3c
         UnzCC1qO2F62iMXDXniOpKNs2Hlff8oRdFZJsJYpXOLhY5QAE5mzhbHTqGOF0Xisyg8W
         3D/juFSin+PFWfqzN86Lstg7hjcEQen8IHuevJ05RGwGQdljnoyn8zreX038mDa+2Guq
         Qw2m9hnWy9aNfR6BUxT55L+ScWf/GbjxJ7MJKk0wNoY/qPBmQ8UCEXVkzrvv1S3wc9p5
         fokI2pj703m3C/ICc0KJF4za1iO3kbhOPESC9uMpFvdRBtOw8ubsJWk5lFvVNOBLY6B/
         JojQ==
X-Gm-Message-State: AOJu0YwaOadIfBYBFa1l0CJIBvJ2FKDOuKYRVtRyAkYhGOl0ewKnpm2B
        PdTrz2zyNPr1NwwxOwBSv5Lj1C0e0bVnJmJyv4k+Sf8H
X-Google-Smtp-Source: AGHT+IEZPkpyNungVuHzAYrDXW5AUvQ8sCHnXnuPssuLp2uLPg2fJ28mYg973WV/xq04Nbq5Xm2TZQVWvpk/vgdIWRA=
X-Received: by 2002:a2e:9b84:0:b0:2b9:48f1:b195 with SMTP id
 z4-20020a2e9b84000000b002b948f1b195mr1903738lji.44.1692208766717; Wed, 16 Aug
 2023 10:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230814190101.2302448-1-luiz.dentz@gmail.com>
 <CABBYNZKLG1feOObk6gLgCEBTUVbtAwX6NYeZ6KnbjV=q_P5jbw@mail.gmail.com> <2a4c09ee380565c4b00f1c7bd0e0425fa6c1e668.camel@iki.fi>
In-Reply-To: <2a4c09ee380565c4b00f1c7bd0e0425fa6c1e668.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Aug 2023 10:59:14 -0700
Message-ID: <CABBYNZJWHXhDKqjsuRkTC+vQVrroH6OT2P=K-FkDHWK+ZYMWww@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Aug 16, 2023 at 10:54=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2023-08-15 kello 15:41 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, Aug 14, 2023 at 12:01=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > Use-after-free can occur in hci_disconnect_all_sync if a connection i=
s
> > > deleted by concurrent processing of a controller event.
> > >
> > > To prevent this the code now tries to iterate over the list backwards
> > > to ensure the links are cleanup before its parents, also it no longer
> > > relies on a cursor, instead it always uses the last element since
> > > hci_abort_conn_sync is guaranteed to call hci_conn_del.
> > >
> > > UAF crash log:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in hci_set_powered_sync
> > > (net/bluetooth/hci_sync.c:5424) [bluetooth]
> > > Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124
> > >
> > > CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
> > > 6.5.0-rc1+ #10
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > 1.16.2-1.fc38 04/01/2014
> > > Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x5b/0x90
> > >  print_report+0xcf/0x670
> > >  ? __virt_addr_valid+0xdd/0x160
> > >  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> > >  kasan_report+0xa6/0xe0
> > >  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> > >  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
> > >  hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
> > >  ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
> > >  hci_cmd_sync_work+0x137/0x220 [bluetooth]
> > >  process_one_work+0x526/0x9d0
> > >  ? __pfx_process_one_work+0x10/0x10
> > >  ? __pfx_do_raw_spin_lock+0x10/0x10
> > >  ? mark_held_locks+0x1a/0x90
> > >  worker_thread+0x92/0x630
> > >  ? __pfx_worker_thread+0x10/0x10
> > >  kthread+0x196/0x1e0
> > >  ? __pfx_kthread+0x10/0x10
> > >  ret_from_fork+0x2c/0x50
> > >  </TASK>
> > >
> > > Allocated by task 1782:
> > >  kasan_save_stack+0x33/0x60
> > >  kasan_set_track+0x25/0x30
> > >  __kasan_kmalloc+0x8f/0xa0
> > >  hci_conn_add+0xa5/0xa80 [bluetooth]
> > >  hci_bind_cis+0x881/0x9b0 [bluetooth]
> > >  iso_connect_cis+0x121/0x520 [bluetooth]
> > >  iso_sock_connect+0x3f6/0x790 [bluetooth]
> > >  __sys_connect+0x109/0x130
> > >  __x64_sys_connect+0x40/0x50
> > >  do_syscall_64+0x60/0x90
> > >  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > >
> > > Freed by task 695:
> > >  kasan_save_stack+0x33/0x60
> > >  kasan_set_track+0x25/0x30
> > >  kasan_save_free_info+0x2b/0x50
> > >  __kasan_slab_free+0x10a/0x180
> > >  __kmem_cache_free+0x14d/0x2e0
> > >  device_release+0x5d/0xf0
> > >  kobject_put+0xdf/0x270
> > >  hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
> > >  hci_event_packet+0x579/0x7e0 [bluetooth]
> > >  hci_rx_work+0x287/0xaa0 [bluetooth]
> > >  process_one_work+0x526/0x9d0
> > >  worker_thread+0x92/0x630
> > >  kthread+0x196/0x1e0
> > >  ret_from_fork+0x2c/0x50
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifie=
r")
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/hci_sync.c | 55 +++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 35 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 5eb30ba21370..d10a0f36b947 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -5370,6 +5370,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, s=
truct hci_conn *conn, u8 reason)
> > >  {
> > >         int err =3D 0;
> > >         u16 handle =3D conn->handle;
> > > +       struct hci_conn *c;
> > >
> > >         switch (conn->state) {
> > >         case BT_CONNECTED:
> > > @@ -5389,43 +5390,57 @@ int hci_abort_conn_sync(struct hci_dev *hdev,=
 struct hci_conn *conn, u8 reason)
> > >                 hci_dev_unlock(hdev);
> > >                 return 0;
> > >         default:
> > > +               hci_dev_lock(hdev);
> > >                 conn->state =3D BT_CLOSED;
> > > +               hci_disconn_cfm(conn, reason);
> > > +               hci_conn_del(conn);
> > > +               hci_dev_unlock(hdev);
> > >                 return 0;
> > >         }
> > >
> > > +       hci_dev_lock(hdev);
> > > +
> > > +       /* Check if the connection hasn't been cleanup while waiting
> > > +        * commands to complete.
> > > +        */
> > > +       c =3D hci_conn_hash_lookup_handle(hdev, handle);
> > > +       if (!c || c !=3D conn) {
> > > +               err =3D 0;
> > > +               goto unlock;
> > > +       }
> > > +
> > >         /* Cleanup hci_conn object if it cannot be cancelled as it
> > >          * likelly means the controller and host stack are out of syn=
c
> > >          * or in case of LE it was still scanning so it can be cleanu=
p
> > >          * safely.
> > >          */
> > > -       if (err) {
> > > -               struct hci_conn *c;
> > > -
> > > -               /* Check if the connection hasn't been cleanup while =
waiting
> > > -                * commands to complete.
> > > -                */
> > > -               c =3D hci_conn_hash_lookup_handle(hdev, handle);
> > > -               if (!c || c !=3D conn)
> > > -                       return 0;
> > > -
> > > -               hci_dev_lock(hdev);
> > > -               hci_conn_failed(conn, err);
> > > -               hci_dev_unlock(hdev);
> > > -       }
> > > +       hci_conn_failed(conn, reason);
> > >
> > > +unlock:
> > > +       hci_dev_unlock(hdev);
> > >         return err;
> > >  }
> > >
> > >  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
> > >  {
> > > -       struct hci_conn *conn, *tmp;
> > > -       int err;
> > > +       struct list_head *head =3D &hdev->conn_hash.list;
> > > +       struct hci_conn *conn;
> > >
> > > -       list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, li=
st) {
> > > -               err =3D hci_abort_conn_sync(hdev, conn, reason);
> > > -               if (err)
> > > -                       return err;
> > > +       rcu_read_lock();
> > > +       while ((conn =3D list_first_or_null_rcu(head, struct hci_conn=
, list))) {
> > > +               /* Make sure the connection is not freed while unlock=
ing */
> > > +               conn =3D hci_conn_get(conn);
> > > +               rcu_read_unlock();
> > > +               /* Disregard possible errors since hci_conn_del shall=
 have been
> > > +                * called even in case of errors had occurred since i=
t would
> > > +                * then cause hci_conn_failed to be called which call=
s
> > > +                * hci_conn_del internally.
> > > +                */
> > > +               hci_abort_conn_sync(hdev, conn, reason);
> > > +               hci_conn_put(conn);
> > > +               rcu_read_lock();
> > >         }
> > > +       rcu_read_unlock();
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.41.0
> >
> > Any comments on this one, I actually took the time to add some tests
> > to iso-tester to attempt to cover scenarios where
> > hci_disconnect_all_sync is called whiled connecting/connected which
> > seems to be working with these changes.
> >
>
> I don't have further comments. I tested it on the load that previously
> generated KASAN crashes, and haven't seen any so far.

Great, I will push these changes then.

> I guess the only question was if deleting conns in hdev->req_workqueue
> could trigger some crash in hdev->workqueue processing not protected by
> locks/refcount, but don't know a scenario how this would occur right
> now.

Yeah, let's keep monitoring and perhaps add more tests to try and
reproduce different scenarios.


--=20
Luiz Augusto von Dentz
