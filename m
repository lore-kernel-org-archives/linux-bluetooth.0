Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58FEC8750
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjIGTH5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjIGTHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 15:07:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980792
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 12:07:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so23455421fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694113663; x=1694718463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNb/DfUvpvbDT29nT6zoPyLUH3gpQxxFvo1oKo6na4k=;
        b=DHd9HaQDVjYXj6e8isyBWGGdqwYj5TepXQ6eYCske3MvkNPtUtiaXxIDET3DwzAJvS
         ysDBDOuCKsBiJq0stUv7lzYx/R9YgerUEvACOOWfHUUxe/5eGo/IRRiDjXDQSNAV9Evf
         sP/39gEcLJab71CXVZFd1Oy5GYDnSp7uUGNBrHlZ5+UI5KAVhD1dchMuCRD/pdoAFe3G
         k7MS7ypNSEfwSB34e5tFUze0k3HLQQh0yNC3cDpMHeDTIKeNaQMHgo+9JYx0nG00ECC3
         ulmjZBq+ZjJ3FMC21ZoJudGVsCLuM19+VJUOI2m4qPiKgTvYk1X9spnDhuaa8fm9GphK
         9s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113663; x=1694718463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNb/DfUvpvbDT29nT6zoPyLUH3gpQxxFvo1oKo6na4k=;
        b=lklvO/9Ytjy1rGTZHHgIk6dysXLuY5xaFc2eKDlDMtp9SMkcO3wB3dmAm4SP8yPqO/
         lmNgAQbe0wXHHiedgWgi+gdiK+wsmSKz0nByRAkiLFKHHmSDdz9wzRy5uhBSgCDF2ryv
         lUiMT3C9d2Xnrp0HQKTu2v7W8QoUucoKPnfI6jpQ+nkpTrN8/bBIYgQAi6B+sAmO2Fsk
         NPZRedZ+4wUxcRCwNyx7dvCsHer2k4l2MJquWqyEQWi2v9ApNHEFEU03x4LlEwCt7qMk
         uvVaJ9QacnJgAvbGcwSBkoMv9hu6QT9yCj5ehQG9/24cY3ZOqAUw5Uq5O9niL4GCl2KK
         o7XQ==
X-Gm-Message-State: AOJu0YxdMKm6uk4iLBBpCeXngU1SWBOf+oBC2oT2dN6MOXsNaq42+um9
        zphs05AhOggW4nxmS1Pq/3fCQWJdMsNBRjy/AYE=
X-Google-Smtp-Source: AGHT+IEnetKdWfrxShcfNeDbJVNLiclQuE2RCFCABdiaiABk1YKPdR1qEDa8zYbLt4TVEH9NyU6Bk12FpBtAFOVyTP8=
X-Received: by 2002:a2e:9154:0:b0:2bc:c3ad:f41b with SMTP id
 q20-20020a2e9154000000b002bcc3adf41bmr147531ljg.2.1694113662607; Thu, 07 Sep
 2023 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230907122234.146449-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230907122234.146449-1-william.xuanziyang@huawei.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Sep 2023 12:07:30 -0700
Message-ID: <CABBYNZLiByu2BLAvQftfYGUBVcGFSZNi67vspG9Z9OxP_7Uucw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix sleeping function called from invalid
 context in hci_cmd_sync_submit()
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, jiangzp@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Sep 7, 2023 at 5:22=E2=80=AFAM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Syzbot reports a sleeping function called from invalid context problem.
>
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:580
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4440, name: kworke=
r/u5:1
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> ...
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10187
>  __mutex_lock_common kernel/locking/mutex.c:580 [inline]
>  __mutex_lock+0xee/0x1340 kernel/locking/mutex.c:747
>  hci_cmd_sync_submit+0x3f/0x340 net/bluetooth/hci_sync.c:699
>  hci_cmd_sync_queue+0x79/0xa0 net/bluetooth/hci_sync.c:739
>  hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2928
>  hci_disconnect+0xc4/0x220 net/bluetooth/hci_conn.c:258
>  hci_link_tx_to net/bluetooth/hci_core.c:3421 [inline]
>  __check_timeout net/bluetooth/hci_core.c:3567 [inline]
>  __check_timeout+0x331/0x4e0 net/bluetooth/hci_core.c:3547
>  hci_sched_le net/bluetooth/hci_core.c:3750 [inline]
>  hci_tx_work+0x818/0x1d30 net/bluetooth/hci_core.c:3828
>  process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
>  worker_thread+0x687/0x1110 kernel/workqueue.c:2751
>  kthread+0x33a/0x430 kernel/kthread.c:389
>  ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
> Use rcu_read_lock() to protect hci_conn_hash->list in hci_link_tx_to().
> rcu_read_lock() will disable preempt when CONFIG_PREEMPT_RCU is enabled.
> When it needs to abort connection, it will submit a command by
> hci_cmd_sync_submit() which has some sleeping functions like mutex_lock()
> and kmalloc(, GFP_KERNEL). That triggers the bug.
>
> Convert cmd_sync_work_lock and unregister_lock to spin_lock type and
> replace GFP_KERNEL with GFP_ATOMIC to fix the bug.

Seems like this was already fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dd606d5f4024de697167584ad5136a3e56d7debcd

> Fixes: 1857c19941c8 ("Bluetooth: hci_sync: add lock to protect HCI_UNREGI=
STER")
> Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command ex=
ecution")
> Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De7be5be00de0c3c2d782
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  include/net/bluetooth/hci_core.h |  4 ++--
>  net/bluetooth/hci_core.c         |  4 ++--
>  net/bluetooth/hci_sync.c         | 28 +++++++++++++++-------------
>  3 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e6359f7346f1..7a046a80a1ac 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -514,8 +514,8 @@ struct hci_dev {
>         struct work_struct      error_reset;
>         struct work_struct      cmd_sync_work;
>         struct list_head        cmd_sync_work_list;
> -       struct mutex            cmd_sync_work_lock;
> -       struct mutex            unregister_lock;
> +       spinlock_t              cmd_sync_work_lock;
> +       spinlock_t              unregister_lock;
>         struct work_struct      cmd_sync_cancel_work;
>         struct work_struct      reenable_adv_work;
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a5992f1b3c9b..c94bfde68228 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2716,9 +2716,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
>  {
>         BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
>
> -       mutex_lock(&hdev->unregister_lock);
> +       spin_lock(&hdev->unregister_lock);
>         hci_dev_set_flag(hdev, HCI_UNREGISTER);
> -       mutex_unlock(&hdev->unregister_lock);
> +       spin_unlock(&hdev->unregister_lock);
>
>         write_lock(&hci_dev_list_lock);
>         list_del(&hdev->list);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9b93653c6197..4356ee29cd5f 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -286,13 +286,13 @@ static void hci_cmd_sync_work(struct work_struct *w=
ork)
>         while (1) {
>                 struct hci_cmd_sync_work_entry *entry;
>
> -               mutex_lock(&hdev->cmd_sync_work_lock);
> +               spin_lock(&hdev->cmd_sync_work_lock);
>                 entry =3D list_first_entry_or_null(&hdev->cmd_sync_work_l=
ist,
>                                                  struct hci_cmd_sync_work=
_entry,
>                                                  list);
>                 if (entry)
>                         list_del(&entry->list);
> -               mutex_unlock(&hdev->cmd_sync_work_lock);
> +               spin_unlock(&hdev->cmd_sync_work_lock);
>
>                 if (!entry)
>                         break;
> @@ -629,8 +629,8 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
>  {
>         INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
>         INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
> -       mutex_init(&hdev->cmd_sync_work_lock);
> -       mutex_init(&hdev->unregister_lock);
> +       spin_lock_init(&hdev->cmd_sync_work_lock);
> +       spin_lock_init(&hdev->unregister_lock);
>
>         INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
>         INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
> @@ -646,15 +646,17 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
>         cancel_work_sync(&hdev->cmd_sync_work);
>         cancel_work_sync(&hdev->reenable_adv_work);
>
> -       mutex_lock(&hdev->cmd_sync_work_lock);
> +       spin_lock(&hdev->cmd_sync_work_lock);
>         list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, l=
ist) {
> +               list_del(&entry->list);
> +               spin_unlock(&hdev->cmd_sync_work_lock);
> +
>                 if (entry->destroy)
>                         entry->destroy(hdev, entry->data, -ECANCELED);
> -
> -               list_del(&entry->list);
>                 kfree(entry);
> +               spin_lock(&hdev->cmd_sync_work_lock);
>         }
> -       mutex_unlock(&hdev->cmd_sync_work_lock);
> +       spin_unlock(&hdev->cmd_sync_work_lock);
>  }
>
>  void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
> @@ -696,13 +698,13 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_c=
md_sync_work_func_t func,
>         struct hci_cmd_sync_work_entry *entry;
>         int err =3D 0;
>
> -       mutex_lock(&hdev->unregister_lock);
> +       spin_lock(&hdev->unregister_lock);
>         if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
>                 err =3D -ENODEV;
>                 goto unlock;
>         }
>
> -       entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> +       entry =3D kmalloc(sizeof(*entry), GFP_ATOMIC);
>         if (!entry) {
>                 err =3D -ENOMEM;
>                 goto unlock;
> @@ -711,14 +713,14 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_c=
md_sync_work_func_t func,
>         entry->data =3D data;
>         entry->destroy =3D destroy;
>
> -       mutex_lock(&hdev->cmd_sync_work_lock);
> +       spin_lock(&hdev->cmd_sync_work_lock);
>         list_add_tail(&entry->list, &hdev->cmd_sync_work_list);
> -       mutex_unlock(&hdev->cmd_sync_work_lock);
> +       spin_unlock(&hdev->cmd_sync_work_lock);
>
>         queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
>
>  unlock:
> -       mutex_unlock(&hdev->unregister_lock);
> +       spin_unlock(&hdev->unregister_lock);
>         return err;
>  }
>  EXPORT_SYMBOL(hci_cmd_sync_submit);
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
