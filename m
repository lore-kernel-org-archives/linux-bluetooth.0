Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B09C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHKXRd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjHKXRb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 19:17:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F110F5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 16:17:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so39687971fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691795849; x=1692400649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI8OU/jKGuUXal4qej+0ERivXtz2dZs3wG+Oaqsjvd4=;
        b=N9ecR6+WfEOt8riZiN4m/wN7Xo6E9TVldIizaOOSwzZt51IDCuLN759LPDRLNjJBby
         Xk51OePbvKHiNURJFx19zRJqMHDRXOGdYSjZb9ddtSaUVKmJ6XvL1sebSqXN1K6j5clo
         wvaZDXuwg/a5nOFhHPaWQABt36kbuqQ3aBkiOa5piuamv1rtfess4y6PRWNmAHIlEWsP
         CkrnnCBYVZxTHWJ7PqDxCjduKfmovzJbVtyqkOZ86f36S1aa1eojBLssFgWG8bXIOhAf
         7UWpK8fzl6/VGJZ1yFrM1O7yXRVOlZnjnxr8VAgJmElFUtcg5UpUby++s3+R38bR0L84
         zKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795849; x=1692400649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI8OU/jKGuUXal4qej+0ERivXtz2dZs3wG+Oaqsjvd4=;
        b=TVjLJd6GCD46ZU1fijV4rsyjdIs4b2ffofM3/XLO9XjONYDtPe4z8deNxURLUaqFOP
         LxgPF8iMkMK1WyX/T99yDu7AWVGdLUfJ6oaATW1aZgJYLVGNKVgFztBkKT8jwR4d9/aR
         OTHqoE4rZXZUnmIhZv5OeJ7CO0jIVMhZN73yJmMD4ET70jqjYPxETRyQ5BDyQJLC+kF4
         lCidebF39B2gqW8hxWza/9MkxyXSSxZKaCiL5XbHVrs72n+LuN0FAwN0tSef561m3x/0
         EQ8zTxDQyUxMU1D2Z78YjSKUkUHEoRjpwHqUUUUwwWYaTP2TsCUqv6Li2jax8afNLPBY
         2MEw==
X-Gm-Message-State: AOJu0YyuUEMinBLsXgjT1blZXaborPRpfQFU1mq5DR2M1Qn+lIxD3+3o
        HxIwsbV2pV/q7luBD1ofqMcmeGPxFISobo5zXOcEur9R
X-Google-Smtp-Source: AGHT+IGHxyq4XGHG0i0FMI6cl07tT/b88gurQTJ43IqrJNlsz6N25HhM+SjsnmWXT0z72EwfowjS7nK1pTHp6mF31FQ=
X-Received: by 2002:a2e:950e:0:b0:2b6:e2aa:8fbc with SMTP id
 f14-20020a2e950e000000b002b6e2aa8fbcmr2377752ljh.8.1691795848865; Fri, 11 Aug
 2023 16:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230811174633.1818931-1-luiz.dentz@gmail.com> <874dac566d39d0c33bec6ca96b9ecdf3780bf401.camel@iki.fi>
In-Reply-To: <874dac566d39d0c33bec6ca96b9ecdf3780bf401.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Aug 2023 16:17:16 -0700
Message-ID: <CABBYNZL8HpX1d8A0ALw3G=aN=9OTgQh+Sgkb8hvcMpZC-KN0Kw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Aug 11, 2023 at 4:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> pe, 2023-08-11 kello 10:46 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Use-after-free can occur in hci_disconnect_all_sync if a connection is
> > deleted by concurrent processing of a controller event.
> >
> > To prevent this the code now tries to iterate over the list backwards
> > to ensure the links are cleanup before its parents, also it no longer
> > relies on a cursor, instead it always uses the last element since
> > hci_abort_conn_sync is guaranteed to call hci_conn_del.
>
> This v2 patch seems to be same as v1. Is it the right one?
>
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
> > index 5eb30ba21370..c2fa6690c84c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5389,7 +5389,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, st=
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
> >
> > @@ -5418,13 +5422,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, s=
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
> >
> >       return 0;
>
> --
> Pauli Virtanen

Must have sent the wrong one, let's see if I got it right on v3.


--=20
Luiz Augusto von Dentz
