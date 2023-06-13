Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F389BEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjFMTjK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFMTjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 15:39:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4619A
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 12:39:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so6607307e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686685145; x=1689277145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51aztI65vqOPJfgUy49KImCPe7pwyfoL9X4mEpb9ARI=;
        b=lj9NW+W8Dh7l5E+axkDRl/j/Q71mek/UuSubLvF4srTkUd6/ZkA0LEl3QJtAGWMJGW
         sKBZcYVvQjxoRI9pIx64q2sl/BiN4dEY7yo0I60tBC4yYm0MPVRAHbutrp/cQ+hWhH84
         QQOvK5rQG0QIUAMTUwt7i+hURUfkcLCPVlkHU1rxgXy4qSgmLepSROqipvzh31TiFinE
         Jqv4kWBA7BvazzjFZaosDzJpo4/7CrDDTpY5ghdCTrS2B+jCBuo9ka9GXGMEa3o/foFu
         kk7fPXzMxmshNL2Qh4tO5mEzgEchw/42JaOH0VMpy2+7QqhmXI1zAt14c0vmOroW77S/
         iezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685145; x=1689277145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51aztI65vqOPJfgUy49KImCPe7pwyfoL9X4mEpb9ARI=;
        b=EfaK6l4/xJ62xBE3sRjd/YKcn36NkNDTm0FhKFfIGfvLk+DFCOSnHbSQ8qBWU9PWt9
         BsceT/v4wIE4cJwFZQramve56Q7FG25cCAYynRnV0i5r/PhLY+sim0fbyj06QHWkaMOW
         y7qHl49HdZr4kUpmbz6OUCyXLwzcZzQkJfVttPcdFI7CT9eKnZMpbQjoNlGstdhctLS7
         xgzSCxjIc8qg+XS1mu8kDsAkkRadfBv/TU/fh3ZD7tsa5LbeJrnqB/rBEUAbJ/qqCcgD
         0Y6oGwCeLsAnJCjefQV9Mpze772lTyyGZ0+G+RWsn2YecWpRF1OWmI+rBjmSsaxxZndL
         q8JQ==
X-Gm-Message-State: AC+VfDx7VY8BNc8qqu+4Pa7Tp7Ft58U5sPHcMyq7fyszqimv34I7l1w8
        IuegFW2Wr52No+SuY6YaaxDtRz/WW5OFjTug2Y4n/nTbZSbYfFF/DJw=
X-Google-Smtp-Source: ACHHUZ4BW474iUAFsEJsI/eOdrB+Re1A/863glaMHSVQHRbEtBqA0pU6GkItNoBRAeT0KNZ3cOV0blWz5ph6cFeTpL8=
X-Received: by 2002:a2e:910e:0:b0:2a8:bd1f:a377 with SMTP id
 m14-20020a2e910e000000b002a8bd1fa377mr5449030ljg.20.1686685144125; Tue, 13
 Jun 2023 12:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686589290.git.pav@iki.fi> <d579997e06d68153a5630aba1ee9f2854d8b0cb4.1686589290.git.pav@iki.fi>
 <CABBYNZ+B-5xz8BLB31KOEUhA7jWWfsMQmDF+YgPXrP1O0Ox1Ng@mail.gmail.com>
In-Reply-To: <CABBYNZ+B-5xz8BLB31KOEUhA7jWWfsMQmDF+YgPXrP1O0Ox1Ng@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Jun 2023 12:38:51 -0700
Message-ID: <CABBYNZLTRxA6G7SFP88oZr+ty35mq5Q4NKNfYeNexwxNhkkj_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: use RCU for hci_conn_params and iterate
 safely in hci_sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Tue, Jun 13, 2023 at 12:04=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Tue, Jun 13, 2023 at 11:17=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >
> > hci_update_accept_list_sync iterates over hdev->pend_le_conns and
> > hdev->pend_le_reports, and waits for controller events in the loop body=
,
> > without holding hdev lock.
> >
> > Meanwhile, these lists and the items may be modified e.g. by
> > le_scan_cleanup.  This can invalidate the list cursor in the ongoing
> > iterations, resulting to invalid behavior (eg use-after-free).
> >
> > Use RCU for the hci_conn_params action lists. Since the loop bodies in
> > hci_sync block and we cannot use RCU for the whole loop, add
> > hci_conn_params.add_pending to keep track which items are left. Copy
> > data to avoid needing lock on hci_conn_params. Only the flags field is
> > written from elsewhere, so READ_ONCE/WRITE_ONCE should guarantee we rea=
d
> > valid values.
> >
> > Free params everywhere with hci_conn_params_free so the cleanup is
> > guaranteed to be done properly.
> >
> > This fixes the following, which can be triggered at least by changing
> > hci_le_set_cig_params to always return false, and running BlueZ
> > iso-tester, which causes connections to be created and dropped fast:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync (net/bl=
uetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_syn=
c.c:2841)
> > Read of size 8 at addr ffff888001265018 by task kworker/u3:0/32
> >
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 =
04/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> > <TASK>
> > dump_stack_lvl (./arch/x86/include/asm/irqflags.h:134 lib/dump_stack.c:=
107)
> > print_report (mm/kasan/report.c:320 mm/kasan/report.c:430)
> > ? __virt_addr_valid (./include/linux/mmzone.h:1915 ./include/linux/mmzo=
ne.h:2011 arch/x86/mm/physaddr.c:65)
> > ? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluet=
ooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> > kasan_report (mm/kasan/report.c:538)
> > ? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluet=
ooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> > hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetoo=
th/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> > ? __pfx_hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2780)
> > ? mutex_lock (kernel/locking/mutex.c:282)
> > ? __pfx_mutex_lock (kernel/locking/mutex.c:282)
> > ? __pfx_mutex_unlock (kernel/locking/mutex.c:538)
> > ? __pfx_update_passive_scan_sync (net/bluetooth/hci_sync.c:2861)
> > hci_cmd_sync_work (net/bluetooth/hci_sync.c:306)
> > process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.=
c:2399)
> > worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
> > ? __pfx_worker_thread (kernel/workqueue.c:2480)
> > kthread (kernel/kthread.c:376)
> > ? __pfx_kthread (kernel/kthread.c:331)
> > ret_from_fork (arch/x86/entry/entry_64.S:314)
> > </TASK>
> >
> > Allocated by task 31:
> > kasan_save_stack (mm/kasan/common.c:46)
> > kasan_set_track (mm/kasan/common.c:52)
> > __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
> > hci_conn_params_add (./include/linux/slab.h:580 ./include/linux/slab.h:=
720 net/bluetooth/hci_core.c:2277)
> > hci_connect_le_scan (net/bluetooth/hci_conn.c:1419 net/bluetooth/hci_co=
nn.c:1589)
> > hci_connect_cis (net/bluetooth/hci_conn.c:2266)
> > iso_connect_cis (net/bluetooth/iso.c:390)
> > iso_sock_connect (net/bluetooth/iso.c:899)
> > __sys_connect (net/socket.c:2003 net/socket.c:2020)
> > __x64_sys_connect (net/socket.c:2027)
> > do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> >
> > Freed by task 15:
> > kasan_save_stack (mm/kasan/common.c:46)
> > kasan_set_track (mm/kasan/common.c:52)
> > kasan_save_free_info (mm/kasan/generic.c:523)
> > __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan=
/common.c:244)
> > __kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3800)
> > hci_conn_params_del (net/bluetooth/hci_core.c:2323)
> > le_scan_cleanup (net/bluetooth/hci_conn.c:202)
> > process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.=
c:2399)
> > worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
> > kthread (kernel/kthread.c:376)
> > ret_from_fork (arch/x86/entry/entry_64.S:314)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_que=
ue set 3")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >
> > Notes:
> >     v2: use RCU
>
> Really nice work.
>
> >  include/net/bluetooth/hci_core.h |  5 ++
> >  net/bluetooth/hci_conn.c         |  9 ++--
> >  net/bluetooth/hci_core.c         | 34 +++++++++---
> >  net/bluetooth/hci_event.c        | 12 ++---
> >  net/bluetooth/hci_sync.c         | 93 ++++++++++++++++++++++++++++----
> >  net/bluetooth/mgmt.c             | 30 +++++------
> >  6 files changed, 141 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 683666ea210c..8c6ac6d29c62 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -822,6 +822,8 @@ struct hci_conn_params {
> >
> >         struct hci_conn *conn;
> >         bool explicit_connect;
> > +       /* Accessed without hdev->lock: */
> > +       bool add_pending;
>
> That is the only part that Im a little uncorfortable with, are we
> doing this because we can't do use the cmd_sync while holding RCU
> lock? In that case couldn't we perhaps update the list? Also we could
> perhaps add it as a flag rather than a separated field.
>
> >         hci_conn_flags_t flags;
> >         u8  privacy_mode;
> >  };
> > @@ -1605,6 +1607,9 @@ struct hci_conn_params *hci_conn_params_add(struc=
t hci_dev *hdev,
> >                                             bdaddr_t *addr, u8 addr_typ=
e);
> >  void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr=
_type);
> >  void hci_conn_params_clear_disabled(struct hci_dev *hdev);
> > +void hci_conn_params_free(struct hci_conn_params *param);
> > +void hci_conn_params_set_pending(struct hci_conn_params *param,
> > +                                struct list_head *list);
> >
> >  struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *li=
st,
> >                                                   bdaddr_t *addr,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 7d4941e6dbdf..ae9a35d1405b 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -118,7 +118,7 @@ static void hci_connect_le_scan_cleanup(struct hci_=
conn *conn, u8 status)
> >          */
> >         params->explicit_connect =3D false;
> >
> > -       list_del_init(&params->action);
> > +       hci_conn_params_set_pending(params, NULL);
> >
> >         switch (params->auto_connect) {
> >         case HCI_AUTO_CONN_EXPLICIT:
> > @@ -127,10 +127,10 @@ static void hci_connect_le_scan_cleanup(struct hc=
i_conn *conn, u8 status)
> >                 return;
> >         case HCI_AUTO_CONN_DIRECT:
> >         case HCI_AUTO_CONN_ALWAYS:
> > -               list_add(&params->action, &hdev->pend_le_conns);
> > +               hci_conn_params_set_pending(params, &hdev->pend_le_conn=
s);
> >                 break;
> >         case HCI_AUTO_CONN_REPORT:
> > -               list_add(&params->action, &hdev->pend_le_reports);
> > +               hci_conn_params_set_pending(params, &hdev->pend_le_repo=
rts);
> >                 break;
> >         default:
> >                 break;
> > @@ -1435,8 +1435,7 @@ static int hci_explicit_conn_params_set(struct hc=
i_dev *hdev,
> >         if (params->auto_connect =3D=3D HCI_AUTO_CONN_DISABLED ||
> >             params->auto_connect =3D=3D HCI_AUTO_CONN_REPORT ||
> >             params->auto_connect =3D=3D HCI_AUTO_CONN_EXPLICIT) {
> > -               list_del_init(&params->action);
> > -               list_add(&params->action, &hdev->pend_le_conns);
> > +               hci_conn_params_set_pending(params, &hdev->pend_le_conn=
s);
>
> Id just follow the name convention e.g. hci_conn_params_list_add,
> hci_conn_params_list_del, etc.
>
> >         }
> >
> >         params->explicit_connect =3D true;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 48917c68358d..7992a61fe1fd 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2249,21 +2249,41 @@ struct hci_conn_params *hci_conn_params_lookup(=
struct hci_dev *hdev,
> >         return NULL;
> >  }
> >
> > -/* This function requires the caller holds hdev->lock */
> > +/* This function requires the caller holds hdev->lock or rcu_read_lock=
 */
> >  struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *li=
st,
> >                                                   bdaddr_t *addr, u8 ad=
dr_type)
> >  {
> >         struct hci_conn_params *param;
> >
> > -       list_for_each_entry(param, list, action) {
> > +       rcu_read_lock();
> > +
> > +       list_for_each_entry_rcu(param, list, action) {
> >                 if (bacmp(&param->addr, addr) =3D=3D 0 &&
> > -                   param->addr_type =3D=3D addr_type)
> > +                   param->addr_type =3D=3D addr_type) {
> > +                       rcu_read_unlock();
> >                         return param;
> > +               }
> >         }
> >
> > +       rcu_read_unlock();
> > +
> >         return NULL;
> >  }
> >
> > +/* This function requires the caller holds hdev->lock */
> > +void hci_conn_params_set_pending(struct hci_conn_params *param,
> > +                                struct list_head *list)
> > +{
> > +       if (!list_empty(&param->action)) {
> > +               list_del_rcu(&param->action);
> > +               synchronize_rcu();
> > +               INIT_LIST_HEAD(&param->action);
> > +       }
> > +
> > +       if (list)
> > +               list_add_rcu(&param->action, list);
> > +}
> > +
> >  /* This function requires the caller holds hdev->lock */
> >  struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
> >                                             bdaddr_t *addr, u8 addr_typ=
e)
> > @@ -2297,14 +2317,15 @@ struct hci_conn_params *hci_conn_params_add(str=
uct hci_dev *hdev,
> >         return params;
> >  }
> >
> > -static void hci_conn_params_free(struct hci_conn_params *params)
> > +void hci_conn_params_free(struct hci_conn_params *params)
> >  {
> > +       hci_conn_params_set_pending(params, NULL);
> > +
> >         if (params->conn) {
> >                 hci_conn_drop(params->conn);
> >                 hci_conn_put(params->conn);
> >         }
> >
> > -       list_del(&params->action);
> >         list_del(&params->list);
> >         kfree(params);
> >  }
> > @@ -2342,8 +2363,7 @@ void hci_conn_params_clear_disabled(struct hci_de=
v *hdev)
> >                         continue;
> >                 }
> >
> > -               list_del(&params->list);
> > -               kfree(params);
> > +               hci_conn_params_free(params);
> >         }
> >
> >         BT_DBG("All LE disabled connection parameters were removed");
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 7c199f7361f7..8187c9f827fa 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1564,7 +1564,7 @@ static u8 hci_cc_le_set_privacy_mode(struct hci_d=
ev *hdev, void *data,
> >
> >         params =3D hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr=
_type);
> >         if (params)
> > -               params->privacy_mode =3D cp->mode;
> > +               WRITE_ONCE(params->privacy_mode, cp->mode);
> >
> >         hci_dev_unlock(hdev);
> >
> > @@ -2804,8 +2804,8 @@ static void hci_cs_disconnect(struct hci_dev *hde=
v, u8 status)
> >
> >                 case HCI_AUTO_CONN_DIRECT:
> >                 case HCI_AUTO_CONN_ALWAYS:
> > -                       list_del_init(&params->action);
> > -                       list_add(&params->action, &hdev->pend_le_conns)=
;
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_conn=
s);
> >                         break;
> >
> >                 default:
> > @@ -3423,8 +3423,8 @@ static void hci_disconn_complete_evt(struct hci_d=
ev *hdev, void *data,
> >
> >                 case HCI_AUTO_CONN_DIRECT:
> >                 case HCI_AUTO_CONN_ALWAYS:
> > -                       list_del_init(&params->action);
> > -                       list_add(&params->action, &hdev->pend_le_conns)=
;
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_conn=
s);
> >                         hci_update_passive_scan(hdev);
> >                         break;
> >
> > @@ -5972,7 +5972,7 @@ static void le_conn_complete_evt(struct hci_dev *=
hdev, u8 status,
> >         params =3D hci_pend_le_action_lookup(&hdev->pend_le_conns, &con=
n->dst,
> >                                            conn->dst_type);
> >         if (params) {
> > -               list_del_init(&params->action);
> > +               hci_conn_params_set_pending(params, NULL);
> >                 if (params->conn) {
> >                         hci_conn_drop(params->conn);
> >                         hci_conn_put(params->conn);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 97da5bcaa904..da12e286ee64 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -2160,15 +2160,23 @@ static int hci_le_del_accept_list_sync(struct h=
ci_dev *hdev,
> >         return 0;
> >  }
> >
> > +struct conn_params {
> > +       bdaddr_t addr;
> > +       u8 addr_type;
> > +       hci_conn_flags_t flags;
> > +       u8 privacy_mode;
> > +};
> > +
> >  /* Adds connection to resolve list if needed.
> >   * Setting params to NULL programs local hdev->irk
> >   */
> >  static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> > -                                       struct hci_conn_params *params)
> > +                                       struct conn_params *params)
> >  {
> >         struct hci_cp_le_add_to_resolv_list cp;
> >         struct smp_irk *irk;
> >         struct bdaddr_list_with_irk *entry;
> > +       struct hci_conn_params *p;
> >
> >         if (!use_ll_privacy(hdev))
> >                 return 0;
> > @@ -2203,6 +2211,16 @@ static int hci_le_add_resolve_list_sync(struct h=
ci_dev *hdev,
> >         /* Default privacy mode is always Network */
> >         params->privacy_mode =3D HCI_NETWORK_PRIVACY;
> >
> > +       rcu_read_lock();
> > +       p =3D hci_pend_le_action_lookup(&hdev->pend_le_conns,
> > +                                     &params->addr, params->addr_type)=
;
> > +       if (!p)
> > +               p =3D hci_pend_le_action_lookup(&hdev->pend_le_reports,
> > +                                             &params->addr, params->ad=
dr_type);
> > +       if (p)
> > +               WRITE_ONCE(p->privacy_mode, HCI_NETWORK_PRIVACY);
> > +       rcu_read_unlock();
> > +
> >  done:
> >         if (hci_dev_test_flag(hdev, HCI_PRIVACY))
> >                 memcpy(cp.local_irk, hdev->irk, 16);
> > @@ -2215,7 +2233,7 @@ static int hci_le_add_resolve_list_sync(struct hc=
i_dev *hdev,
> >
> >  /* Set Device Privacy Mode. */
> >  static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> > -                                       struct hci_conn_params *params)
> > +                                       struct conn_params *params)
> >  {
> >         struct hci_cp_le_set_privacy_mode cp;
> >         struct smp_irk *irk;
> > @@ -2240,6 +2258,8 @@ static int hci_le_set_privacy_mode_sync(struct hc=
i_dev *hdev,
> >         bacpy(&cp.bdaddr, &irk->bdaddr);
> >         cp.mode =3D HCI_DEVICE_PRIVACY;
> >
> > +       /* Note: params->privacy_mode is not updated since it is a copy=
 */
> > +
> >         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PRIVACY_MODE,
> >                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >  }
> > @@ -2249,7 +2269,7 @@ static int hci_le_set_privacy_mode_sync(struct hc=
i_dev *hdev,
> >   * properly set the privacy mode.
> >   */
> >  static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> > -                                      struct hci_conn_params *params,
> > +                                      struct conn_params *params,
> >                                        u8 *num_entries)
> >  {
> >         struct hci_cp_le_add_to_accept_list cp;
> > @@ -2447,6 +2467,51 @@ struct sk_buff *hci_read_local_oob_data_sync(str=
uct hci_dev *hdev,
> >         return __hci_cmd_sync_sk(hdev, opcode, 0, NULL, 0, HCI_CMD_TIME=
OUT, sk);
> >  }
> >
> > +static void conn_params_add_iter_init(struct list_head *list)
> > +{
> > +       struct hci_conn_params *params;
> > +
> > +       rcu_read_lock();
> > +
> > +       list_for_each_entry_rcu(params, list, action)
> > +               params->add_pending =3D true;
> > +
> > +       rcu_read_unlock();
> > +}
> > +
> > +static bool conn_params_add_iter_next(struct list_head *list,
> > +                                     struct conn_params *item)
> > +{
> > +       struct hci_conn_params *params;
> > +
> > +       rcu_read_lock();
> > +
> > +       list_for_each_entry_rcu(params, list, action) {
> > +               if (!params->add_pending)
> > +                       continue;
> > +
> > +               /* No hdev->lock, but: addr, addr_type are immutable.
> > +                * privacy_mode is only written by us or in
> > +                * hci_cc_le_set_privacy_mode that we wait for.
> > +                * We should be idempotent so MGMT updating flags
> > +                * while we are processing is OK.
> > +                */
> > +               bacpy(&item->addr, &params->addr);
> > +               item->addr_type =3D params->addr_type;
> > +               item->flags =3D READ_ONCE(params->flags);
> > +               item->privacy_mode =3D READ_ONCE(params->privacy_mode);
> > +
> > +               params->add_pending =3D false;
> > +
> > +               rcu_read_unlock();
> > +               return true;
> > +       }
> > +
> > +       rcu_read_unlock();
> > +
> > +       return false;
> > +}
> > +
> >  /* Device must not be scanning when updating the accept list.
> >   *
> >   * Update is done using the following sequence:
> > @@ -2466,7 +2531,7 @@ struct sk_buff *hci_read_local_oob_data_sync(stru=
ct hci_dev *hdev,
> >   */
> >  static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
> >  {
> > -       struct hci_conn_params *params;
> > +       struct conn_params params;
> >         struct bdaddr_list *b, *t;
> >         u8 num_entries =3D 0;
> >         bool pend_conn, pend_report;
> > @@ -2504,6 +2569,7 @@ static u8 hci_update_accept_list_sync(struct hci_=
dev *hdev)
> >                 if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr=
_type))
> >                         continue;
> >
> > +               /* Pointers not dereferenced, no locks needed */
> >                 pend_conn =3D hci_pend_le_action_lookup(&hdev->pend_le_=
conns,
> >                                                       &b->bdaddr,
> >                                                       b->bdaddr_type);
> > @@ -2532,9 +2598,15 @@ static u8 hci_update_accept_list_sync(struct hci=
_dev *hdev)
> >          * available accept list entries in the controller, then
> >          * just abort and return filer policy value to not use the
> >          * accept list.
> > +        *
> > +        * The list and params may be mutated while we wait for events,
> > +        * so use special iteration with copies.
> >          */
> > -       list_for_each_entry(params, &hdev->pend_le_conns, action) {
> > -               err =3D hci_le_add_accept_list_sync(hdev, params, &num_=
entries);
> > +
> > +       conn_params_add_iter_init(&hdev->pend_le_conns);
> > +
> > +       while (conn_params_add_iter_next(&hdev->pend_le_conns, &params)=
) {
> > +               err =3D hci_le_add_accept_list_sync(hdev, &params, &num=
_entries);
> >                 if (err)
> >                         goto done;

Perhaps we should be using list_for_each_entry_continue_rcu instead of
creating our own version of it? Or at least use it internally on
iter_next, anyway I think what we are after is some way to do
rcu_unlock add_to_list rcu_lock on a loop.

> >         }
> > @@ -2543,8 +2615,11 @@ static u8 hci_update_accept_list_sync(struct hci=
_dev *hdev)
> >          * the list of pending reports and also add these to the
> >          * accept list if there is still space. Abort if space runs out=
.
> >          */
> > -       list_for_each_entry(params, &hdev->pend_le_reports, action) {
> > -               err =3D hci_le_add_accept_list_sync(hdev, params, &num_=
entries);
> > +
> > +       conn_params_add_iter_init(&hdev->pend_le_reports);
> > +
> > +       while (conn_params_add_iter_next(&hdev->pend_le_reports, &param=
s)) {
> > +               err =3D hci_le_add_accept_list_sync(hdev, &params, &num=
_entries);
> >                 if (err)
> >                         goto done;
> >         }
> > @@ -4837,12 +4912,12 @@ static void hci_pend_le_actions_clear(struct hc=
i_dev *hdev)
> >         struct hci_conn_params *p;
> >
> >         list_for_each_entry(p, &hdev->le_conn_params, list) {
> > +               hci_conn_params_set_pending(p, NULL);
> >                 if (p->conn) {
> >                         hci_conn_drop(p->conn);
> >                         hci_conn_put(p->conn);
> >                         p->conn =3D NULL;
> >                 }
> > -               list_del_init(&p->action);
> >         }
> >
> >         BT_DBG("All LE pending actions cleared");
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 61c8e1b8f3b0..b35b1c685b86 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -1303,15 +1303,15 @@ static void restart_le_actions(struct hci_dev *=
hdev)
> >                 /* Needed for AUTO_OFF case where might not "really"
> >                  * have been powered off.
> >                  */
> > -               list_del_init(&p->action);
> > +               hci_conn_params_set_pending(p, NULL);
> >
> >                 switch (p->auto_connect) {
> >                 case HCI_AUTO_CONN_DIRECT:
> >                 case HCI_AUTO_CONN_ALWAYS:
> > -                       list_add(&p->action, &hdev->pend_le_conns);
> > +                       hci_conn_params_set_pending(p, &hdev->pend_le_c=
onns);
> >                         break;
> >                 case HCI_AUTO_CONN_REPORT:
> > -                       list_add(&p->action, &hdev->pend_le_reports);
> > +                       hci_conn_params_set_pending(p, &hdev->pend_le_r=
eports);
> >                         break;
> >                 default:
> >                         break;
> > @@ -5175,7 +5175,7 @@ static int set_device_flags(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
> >                 goto unlock;
> >         }
> >
> > -       params->flags =3D current_flags;
> > +       WRITE_ONCE(params->flags, current_flags);
> >         status =3D MGMT_STATUS_SUCCESS;
> >
> >         /* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
> > @@ -7586,7 +7586,7 @@ static int hci_conn_params_set(struct hci_dev *hd=
ev, bdaddr_t *addr,
> >         if (params->auto_connect =3D=3D auto_connect)
> >                 return 0;
> >
> > -       list_del_init(&params->action);
> > +       hci_conn_params_set_pending(params, NULL);
> >
> >         switch (auto_connect) {
> >         case HCI_AUTO_CONN_DISABLED:
> > @@ -7595,18 +7595,22 @@ static int hci_conn_params_set(struct hci_dev *=
hdev, bdaddr_t *addr,
> >                  * connect to device, keep connecting.
> >                  */
> >                 if (params->explicit_connect)
> > -                       list_add(&params->action, &hdev->pend_le_conns)=
;
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_conn=
s);
> >                 break;
> >         case HCI_AUTO_CONN_REPORT:
> >                 if (params->explicit_connect)
> > -                       list_add(&params->action, &hdev->pend_le_conns)=
;
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_conn=
s);
> >                 else
> > -                       list_add(&params->action, &hdev->pend_le_report=
s);
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_repo=
rts);
> >                 break;
> >         case HCI_AUTO_CONN_DIRECT:
> >         case HCI_AUTO_CONN_ALWAYS:
> >                 if (!is_connected(hdev, addr, addr_type))
> > -                       list_add(&params->action, &hdev->pend_le_conns)=
;
> > +                       hci_conn_params_set_pending(params,
> > +                                                   &hdev->pend_le_conn=
s);
> >                 break;
> >         }
> >
> > @@ -7829,9 +7833,7 @@ static int remove_device(struct sock *sk, struct =
hci_dev *hdev,
> >                         goto unlock;
> >                 }
> >
> > -               list_del(&params->action);
> > -               list_del(&params->list);
> > -               kfree(params);
> > +               hci_conn_params_free(params);
> >
> >                 device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.typ=
e);
> >         } else {
> > @@ -7862,9 +7864,7 @@ static int remove_device(struct sock *sk, struct =
hci_dev *hdev,
> >                                 p->auto_connect =3D HCI_AUTO_CONN_EXPLI=
CIT;
> >                                 continue;
> >                         }
> > -                       list_del(&p->action);
> > -                       list_del(&p->list);
> > -                       kfree(p);
> > +                       hci_conn_params_free(p);
> >                 }
> >
> >                 bt_dev_dbg(hdev, "All LE connection parameters were rem=
oved");
> > --
> > 2.40.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
