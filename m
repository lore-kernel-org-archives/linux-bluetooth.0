Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3136C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjFIRUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjFIRUC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 13:20:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E593E4A
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 10:20:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b227fdda27so7780881fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686331199; x=1688923199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnU3anG80AicYI/RwR+Cq7jwJ7hAItCS7gLGsa0DROI=;
        b=lHue0IF7RFlP8MUncZ6dCDv8IkyvaQdJnS+ZeJnSBtjYR4i5qqA6qQ2X6N2zV4EnpT
         I+uVhafRyYKE9XY6DLDy6FltLROFn6PU6Rvo4MpaVHWG1zzHQBo3AuFgu+KSTn3WrI/P
         rQaM0wWWzYOWFZe774MDV7v4s/xo7yMVL5vbCo8rlTKm+Bb5+XaIqWet7mS3vDpv23vh
         IWmruq46lWlXeK6do6nckNla87u68izn08GzRDgjLlk/ZsNQq1EpdzCo9nRxrSwMZPGT
         ooVpPQeKHco4mPtVZIZmPQ9pc8dhG0KfaxFSzoUcgnyCpuzqfMFduOHi0JZQClAx+LCr
         iJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331199; x=1688923199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnU3anG80AicYI/RwR+Cq7jwJ7hAItCS7gLGsa0DROI=;
        b=i+PauleGYLiwid+0OgrpV5nEmqGcke0h3rMWiCkslSTWGQ9dpNnfMwg9cjLIzgOz10
         DcSC8xJprc785EfSuC4WFdimi7jwsLYrCw8+DbQQ2SZ7SiRJO/rMAHRSg4ssK0jdpHLL
         GlUkwAwqNUukBDTT0p/BWsjgn6Macrj8wx5s345peHykAtwida5rPQDiCtGgYMX0U574
         6AGVwf6ChQ6pdckEQGPEd0X2eQzKRsF1UFK57KyTOy3ktOh4lv/E+S6AnPj1GcHJXaMj
         Or3YcS4DJMDECBRrLzdKvlqvDTUNdUWa37tD1UYT0UHPDb0tSlXGjVIM3wAzJfrGLvlS
         jIjQ==
X-Gm-Message-State: AC+VfDy5hGQU+cfwpHctoMJHwPnvALqVRk3GjfkblNSK1U4eyErbWBTA
        bFGbhhD0TEVVnJJ3IH8569c20Hxu0vQYTgc46DXx+AEm
X-Google-Smtp-Source: ACHHUZ7J8lBZ2JmyjKMzvOpFwoYeG7Wi4XPMbyrwwjC8I7FkshOS1SKNkfeKK+ELbD9IIJQZUGF50lgWUqTZ8EGDvE8=
X-Received: by 2002:a2e:b113:0:b0:2b2:621:2e60 with SMTP id
 p19-20020a2eb113000000b002b206212e60mr2043191ljl.3.1686331198284; Fri, 09 Jun
 2023 10:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686252492.git.pav@iki.fi> <b723c232c6fd1f90e49b147180420d1856fb907d.1686252492.git.pav@iki.fi>
In-Reply-To: <b723c232c6fd1f90e49b147180420d1856fb907d.1686252492.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 9 Jun 2023 10:19:45 -0700
Message-ID: <CABBYNZJ_EsU6Nd25cs122bYJwN3v3pUAg_UgoT4O-O0MJUAvcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_sync: iterate over hci_conn_params safely
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli.

On Thu, Jun 8, 2023 at 2:10=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> hci_update_accept_list_sync iterates over hdev->pend_le_conns and
> hdev->pend_le_reports, and waits for controller events in the loop body,
> without holding hdev lock.
>
> Meanwhile, these lists and the items may be modified e.g. by
> le_scan_cleanup.  This can invalidate the list cursor in the ongoing
> iterations, resulting to invalid behavior (eg use-after-free).
>
> hdev lock should be held when operating on these lists, but it cannot be
> held in the loop bodies here as they block. The loops are in hci_sync,
> so at most one loop runs at a time (per hdev).
>
> Fix this by doing the iteration in a safe way vs. list mutation, and
> copy data to avoid locking. Add hci_conn_params.add_pending flag to
> track which items are left.
>
> Lock also around hci_pend_le_action_lookup there.
>
> This fixes the following, which can be triggered at least by changing
> hci_le_set_cig_params to always return false, and running BlueZ
> iso-tester, which causes connections to be created and dropped fast:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync (net/blue=
tooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.=
c:2841)
> Read of size 8 at addr ffff888001265018 by task kworker/u3:0/32
>
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04=
/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
> <TASK>
> dump_stack_lvl (./arch/x86/include/asm/irqflags.h:134 lib/dump_stack.c:10=
7)
> print_report (mm/kasan/report.c:320 mm/kasan/report.c:430)
> ? __virt_addr_valid (./include/linux/mmzone.h:1915 ./include/linux/mmzone=
.h:2011 arch/x86/mm/physaddr.c:65)
> ? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetoo=
th/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> kasan_report (mm/kasan/report.c:538)
> ? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetoo=
th/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth=
/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
> ? __pfx_hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2780)
> ? mutex_lock (kernel/locking/mutex.c:282)
> ? __pfx_mutex_lock (kernel/locking/mutex.c:282)
> ? __pfx_mutex_unlock (kernel/locking/mutex.c:538)
> ? __pfx_update_passive_scan_sync (net/bluetooth/hci_sync.c:2861)
> hci_cmd_sync_work (net/bluetooth/hci_sync.c:306)
> process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.c:=
2399)
> worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
> ? __pfx_worker_thread (kernel/workqueue.c:2480)
> kthread (kernel/kthread.c:376)
> ? __pfx_kthread (kernel/kthread.c:331)
> ret_from_fork (arch/x86/entry/entry_64.S:314)
> </TASK>
>
> Allocated by task 31:
> kasan_save_stack (mm/kasan/common.c:46)
> kasan_set_track (mm/kasan/common.c:52)
> __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
> hci_conn_params_add (./include/linux/slab.h:580 ./include/linux/slab.h:72=
0 net/bluetooth/hci_core.c:2277)
> hci_connect_le_scan (net/bluetooth/hci_conn.c:1419 net/bluetooth/hci_conn=
.c:1589)
> hci_connect_cis (net/bluetooth/hci_conn.c:2266)
> iso_connect_cis (net/bluetooth/iso.c:390)
> iso_sock_connect (net/bluetooth/iso.c:899)
> __sys_connect (net/socket.c:2003 net/socket.c:2020)
> __x64_sys_connect (net/socket.c:2027)
> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>
> Freed by task 15:
> kasan_save_stack (mm/kasan/common.c:46)
> kasan_set_track (mm/kasan/common.c:52)
> kasan_save_free_info (mm/kasan/generic.c:523)
> __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/c=
ommon.c:244)
> __kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3800)
> hci_conn_params_del (net/bluetooth/hci_core.c:2323)
> le_scan_cleanup (net/bluetooth/hci_conn.c:202)
> process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.c:=
2399)
> worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
> kthread (kernel/kthread.c:376)
> ret_from_fork (arch/x86/entry/entry_64.S:314)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue=
 set 3")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     It might be that even more of hci_passive_scan_sync and the routines =
it
>     calls should hold hdev->lock, but don't know that right now.
>
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_sync.c         | 81 ++++++++++++++++++++++++++++----
>  2 files changed, 74 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 683666ea210c..e79b3831fcf3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -822,6 +822,7 @@ struct hci_conn_params {
>
>         struct hci_conn *conn;
>         bool explicit_connect;
> +       bool add_pending;
>         hci_conn_flags_t flags;
>         u8  privacy_mode;
>  };
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 97da5bcaa904..e6fde15dc9ca 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2160,15 +2160,23 @@ static int hci_le_del_accept_list_sync(struct hci=
_dev *hdev,
>         return 0;
>  }
>
> +struct conn_params {
> +       bdaddr_t addr;
> +       u8 addr_type;
> +       hci_conn_flags_t flags;
> +       u8 privacy_mode;
> +};
> +
>  /* Adds connection to resolve list if needed.
>   * Setting params to NULL programs local hdev->irk
>   */
>  static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> -                                       struct hci_conn_params *params)
> +                                       struct conn_params *params)
>  {
>         struct hci_cp_le_add_to_resolv_list cp;
>         struct smp_irk *irk;
>         struct bdaddr_list_with_irk *entry;
> +       struct hci_conn_params *hparams;
>
>         if (!use_ll_privacy(hdev))
>                 return 0;
> @@ -2203,6 +2211,13 @@ static int hci_le_add_resolve_list_sync(struct hci=
_dev *hdev,
>         /* Default privacy mode is always Network */
>         params->privacy_mode =3D HCI_NETWORK_PRIVACY;
>
> +       hci_dev_lock(hdev);
> +       hparams =3D hci_conn_params_lookup(hdev, &params->addr,
> +                                        params->addr_type);
> +       if (hparams)
> +               hparams->privacy_mode =3D HCI_NETWORK_PRIVACY;
> +       hci_dev_unlock(hdev);
> +
>  done:
>         if (hci_dev_test_flag(hdev, HCI_PRIVACY))
>                 memcpy(cp.local_irk, hdev->irk, 16);
> @@ -2215,7 +2230,7 @@ static int hci_le_add_resolve_list_sync(struct hci_=
dev *hdev,
>
>  /* Set Device Privacy Mode. */
>  static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> -                                       struct hci_conn_params *params)
> +                                       struct conn_params *params)
>  {
>         struct hci_cp_le_set_privacy_mode cp;
>         struct smp_irk *irk;
> @@ -2249,7 +2264,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_=
dev *hdev,
>   * properly set the privacy mode.
>   */
>  static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> -                                      struct hci_conn_params *params,
> +                                      struct conn_params *params,
>                                        u8 *num_entries)
>  {
>         struct hci_cp_le_add_to_accept_list cp;
> @@ -2447,6 +2462,37 @@ struct sk_buff *hci_read_local_oob_data_sync(struc=
t hci_dev *hdev,
>         return __hci_cmd_sync_sk(hdev, opcode, 0, NULL, 0, HCI_CMD_TIMEOU=
T, sk);
>  }
>
> +static void conn_params_iter_init(struct list_head *list)
> +{
> +       struct hci_conn_params *params;
> +
> +       list_for_each_entry(params, list, action)
> +               params->add_pending =3D true;
> +}
> +
> +static bool conn_params_iter_next(struct list_head *list,
> +                                 struct conn_params *item)
> +{
> +       struct hci_conn_params *params;
> +
> +       /* Must hold hdev lock. Not reentrant. Mutating list is allowed. =
*/
> +
> +       list_for_each_entry(params, list, action) {
> +               if (!params->add_pending)
> +                       continue;
> +
> +               memcpy(&item->addr, &params->addr, sizeof(params->addr));
> +               item->addr_type =3D params->addr_type;
> +               item->privacy_mode =3D params->privacy_mode;
> +               item->flags =3D params->flags;
> +
> +               params->add_pending =3D false;
> +               return true;
> +       }
> +
> +       return false;
> +}

I wonder if we shouldn't take the approach of hci_lookup_connect_le
though, it uses rcu_read_lock + list_for_each_entry_rcu which seems to
be more efficient than having a dedicated lock to protect the list.

>  /* Device must not be scanning when updating the accept list.
>   *
>   * Update is done using the following sequence:
> @@ -2466,7 +2512,7 @@ struct sk_buff *hci_read_local_oob_data_sync(struct=
 hci_dev *hdev,
>   */
>  static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
>  {
> -       struct hci_conn_params *params;
> +       struct conn_params params;
>         struct bdaddr_list *b, *t;
>         u8 num_entries =3D 0;
>         bool pend_conn, pend_report;
> @@ -2494,6 +2540,8 @@ static u8 hci_update_accept_list_sync(struct hci_de=
v *hdev)
>                 goto done;
>         }
>
> +       hci_dev_lock(hdev);
> +
>         /* Go through the current accept list programmed into the
>          * controller one by one and check if that address is connected o=
r is
>          * still in the list of pending connections or list of devices to
> @@ -2515,8 +2563,10 @@ static u8 hci_update_accept_list_sync(struct hci_d=
ev *hdev)
>                  * remove it from the acceptlist.
>                  */
>                 if (!pend_conn && !pend_report) {
> +                       hci_dev_unlock(hdev);
>                         hci_le_del_accept_list_sync(hdev, &b->bdaddr,
>                                                     b->bdaddr_type);
> +                       hci_dev_lock(hdev);
>                         continue;
>                 }
>
> @@ -2532,23 +2582,38 @@ static u8 hci_update_accept_list_sync(struct hci_=
dev *hdev)
>          * available accept list entries in the controller, then
>          * just abort and return filer policy value to not use the
>          * accept list.
> +        *
> +        * The list may be mutated at any time outside hdev lock,
> +        * so use special iteration with copies.
>          */
> -       list_for_each_entry(params, &hdev->pend_le_conns, action) {
> -               err =3D hci_le_add_accept_list_sync(hdev, params, &num_en=
tries);
> +
> +       conn_params_iter_init(&hdev->pend_le_conns);
> +
> +       while (conn_params_iter_next(&hdev->pend_le_conns, &params)) {
> +               hci_dev_unlock(hdev);
> +               err =3D hci_le_add_accept_list_sync(hdev, &params, &num_e=
ntries);
>                 if (err)
>                         goto done;
> +               hci_dev_lock(hdev);
>         }
>
>         /* After adding all new pending connections, walk through
>          * the list of pending reports and also add these to the
>          * accept list if there is still space. Abort if space runs out.
>          */
> -       list_for_each_entry(params, &hdev->pend_le_reports, action) {
> -               err =3D hci_le_add_accept_list_sync(hdev, params, &num_en=
tries);
> +
> +       conn_params_iter_init(&hdev->pend_le_reports);
> +
> +       while (conn_params_iter_next(&hdev->pend_le_reports, &params)) {
> +               hci_dev_unlock(hdev);
> +               err =3D hci_le_add_accept_list_sync(hdev, &params, &num_e=
ntries);
>                 if (err)
>                         goto done;
> +               hci_dev_lock(hdev);
>         }
>
> +       hci_dev_unlock(hdev);
> +
>         /* Use the allowlist unless the following conditions are all true=
:
>          * - We are not currently suspending
>          * - There are 1 or more ADV monitors registered and it's not off=
loaded
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
