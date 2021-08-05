Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA9CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED40610FB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbhHESTY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhHESTW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 14:19:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C24C061765
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 11:19:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z18so10507538ybg.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wREldZKXdu+dATcJCHruhyDNYEy5XP0w17/1lUzIzfA=;
        b=mhgK92xiGek2NvK7zoPalc4hdsLkrdGbAPzTMTXAHfzv+aS6O9eh3N0VE1WrdrvlDH
         vFUY29Qu94QRt8GFlYAei6RVz8gajTuqkjdqgQVxJC7TKXpEl/WdxvAQcaQpjgIjgRTP
         pYkmRPwGjyA3EokbDQOwtXHb+ZGUeR98ZTFi90OhxV1zs+JE5MOQaJQfb+OA3/jMNHZ7
         AypH3+K6b7kkdZviE6k1qEM4U5eNRs/Nvn+vg1hiXK+GbI47XzfM/KNVyjz4vLrNV5i8
         nI2wp4kzcZUW0rG8jU3TxGNTAmxj2Q1kyLVDnDdN+RW5EonnDcJNpdaZJbd640FGKJkd
         dp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wREldZKXdu+dATcJCHruhyDNYEy5XP0w17/1lUzIzfA=;
        b=Tm8rhGm37EdORqOEMzvZ9N0rj31O0MQ72+i4YIEfZDu35LUERa41shJt0TP49+HEy1
         nbGMj1nVZ9UCuUjG490WIwv/ECi7ywYGXG0d4d15zBtjS1kAb18T4n2gzNaMHedOOJia
         J57o+ZN8T37Qh45cacPTqM88TlF78X6CZlfXTr9EAJ6IU/P2dURm/8rU4ly+WyV8tRVJ
         aJwyi5hgtYJS1LTAk86XWZPVqTvIvvpvxGjWhKQGxFX+T0VF5OSQ23e2IAa2q6ZMKQBp
         K9j7ZmydRKUMs5JK91av3n0fFqwbD1yRWNHtAUFXkHWIsB7K+SPOROlFtIQz69LJmjCo
         DpWg==
X-Gm-Message-State: AOAM533wFftEHNQHAURicX7frbrLKQA3jvPNnzVk4/yURtqvQjZTEQJa
        cupfE+mTHMJThTK6nXsW9x7ugDduo46qS4CyFwyWqUGS
X-Google-Smtp-Source: ABdhPJyIAyiN1GPIMqNIvketSHm5V81/gQF8SX0XPj0254RsyxA/zmW/895JN3dxuiPfbwd7jCX3lmSf1zUR9NjrvdM=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr7770611ybg.347.1628187546430;
 Thu, 05 Aug 2021 11:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
 <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
 <c8cf9848-1405-af75-6f05-b7b82c2619a7@i-love.sakura.ne.jp> <e9e2738d-78a7-1def-a86f-937951d139a7@i-love.sakura.ne.jp>
In-Reply-To: <e9e2738d-78a7-1def-a86f-937951d139a7@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Aug 2021 11:18:55 -0700
Message-ID: <CABBYNZKTWp73VTBvU=5pJLWEUOLZyzr=yyUF5XY4vJA+j0YZ-w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: defer cleanup of resources in hci_unregister_dev()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Wed, Aug 4, 2021 at 3:27 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is hitting might_sleep() warning at hci_sock_dev_event()
> due to calling lock_sock() with rw spinlock held [1].
>
> It seems that history of this locking problem is a trial and error.
>
> Commit b40df5743ee8aed8 ("[PATCH] bluetooth: fix socket locking in
> hci_sock_dev_event()") in 2.6.21-rc4 changed bh_lock_sock() to lock_sock()
> as an attempt to fix lockdep warning.
>
> Then, commit 4ce61d1c7a8ef4c1 ("[BLUETOOTH]: Fix locking in
> hci_sock_dev_event().") in 2.6.22-rc2 changed lock_sock() to
> local_bh_disable() + bh_lock_sock_nested() as an attempt to fix
> sleep in atomic context warning.
>
> Then, commit 4b5dd696f81b210c ("Bluetooth: Remove local_bh_disable() from
> hci_sock.c") in 3.3-rc1 removed local_bh_disable().
>
> Then, commit e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF
> of hdev object") in 5.13-rc5 again changed bh_lock_sock_nested() to
> lock_sock() as an attempt to fix CVE-2021-3573.
>
> This difficulty comes from current implementation that
> hci_sock_dev_event(HCI_DEV_UNREG) is responsible for dropping all
> references from sockets because hci_unregister_dev() immediately reclaims
> resources as soon as returning from hci_sock_dev_event(HCI_DEV_UNREG).
> But the history suggests that hci_sock_dev_event(HCI_DEV_UNREG) was not
> doing what it should do.
>
> Therefore, instead of trying to detach sockets from device, let's accept
> not detaching sockets from device at hci_sock_dev_event(HCI_DEV_UNREG),
> by moving actual cleanup of resources from hci_unregister_dev() to
> hci_cleanup_dev() which is called by bt_host_release() when all references
> to this unregistered device (which is a kobject) are gone.
>
> Since hci_sock_dev_event(HCI_DEV_UNREG) no longer resets hci_pi(sk)->hdev,
> we need to check whether this device was unregistered and return an error
> based on HCI_UNREGISTER flag. There might be subtle behavioral difference
> in "monitor the hdev" functionality; please report if you found something
> went wrong due to this patch.
>
> Link: https://syzkaller.appspot.com/bug?extid=a5df189917e79d5e59c9 [1]
> Reported-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF of hdev object")
> ---
> v4: Don't touch "monitor the hdev" functions.
>
> v3: Unexport hci_unregister_dev because only bt_host_release calls it
>     and both hci_core.o and hci_sysfs.o are combined into bluetooth.o.
>
>     Rename hci_release_dev to hci_cleanup_dev and call it only when
>     HCI_UNREGISTER was set, for syzbot
>     <syzbot+47c6d0efbb7fe2f7a5b8@syzkaller.appspotmail.com> is reporting
>     that bt_host_release might be called without hci_register_dev and
>     hci_unregister_dev.
>
>     Return -EPIPE instead of 0 if HCI_UNREGISTER was set, in order to
>     make sure that userspace finds that the device was unregistred.
>
> v2: Add hci_release_dev and make bt_host_release call it instead of making
>     bt_host_release public.
>
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 16 +++++------
>  net/bluetooth/hci_sock.c         | 49 +++++++++++++++++++++-----------
>  net/bluetooth/hci_sysfs.c        |  3 ++
>  4 files changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a53e94459ecd..db4312e44d47 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1230,6 +1230,7 @@ struct hci_dev *hci_alloc_dev(void);
>  void hci_free_dev(struct hci_dev *hdev);
>  int hci_register_dev(struct hci_dev *hdev);
>  void hci_unregister_dev(struct hci_dev *hdev);
> +void hci_cleanup_dev(struct hci_dev *hdev);
>  int hci_suspend_dev(struct hci_dev *hdev);
>  int hci_resume_dev(struct hci_dev *hdev);
>  int hci_reset_dev(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2560ed2f144d..e1a545c8a69f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3996,14 +3996,10 @@ EXPORT_SYMBOL(hci_register_dev);
>  /* Unregister HCI device */
>  void hci_unregister_dev(struct hci_dev *hdev)
>  {
> -       int id;
> -
>         BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
>
>         hci_dev_set_flag(hdev, HCI_UNREGISTER);
>
> -       id = hdev->id;
> -
>         write_lock(&hci_dev_list_lock);
>         list_del(&hdev->list);
>         write_unlock(&hci_dev_list_lock);
> @@ -4038,7 +4034,14 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         }
>
>         device_del(&hdev->dev);
> +       /* Actual cleanup is deferred until hci_cleanup_dev(). */
> +       hci_dev_put(hdev);
> +}
> +EXPORT_SYMBOL(hci_unregister_dev);
>
> +/* Cleanup HCI device */
> +void hci_cleanup_dev(struct hci_dev *hdev)
> +{
>         debugfs_remove_recursive(hdev->debugfs);
>         kfree_const(hdev->hw_info);
>         kfree_const(hdev->fw_info);
> @@ -4063,11 +4066,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         hci_blocked_keys_clear(hdev);
>         hci_dev_unlock(hdev);
>
> -       hci_dev_put(hdev);
> -
> -       ida_simple_remove(&hci_index_ida, id);
> +       ida_simple_remove(&hci_index_ida, hdev->id);
>  }
> -EXPORT_SYMBOL(hci_unregister_dev);
>
>  /* Suspend HCI device */
>  int hci_suspend_dev(struct hci_dev *hdev)
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index b04a5a02ecf3..f1128c2134f0 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -59,6 +59,17 @@ struct hci_pinfo {
>         char              comm[TASK_COMM_LEN];
>  };
>
> +static struct hci_dev *hci_hdev_from_sock(struct sock *sk)
> +{
> +       struct hci_dev *hdev = hci_pi(sk)->hdev;
> +
> +       if (!hdev)
> +               return ERR_PTR(-EBADFD);
> +       if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
> +               return ERR_PTR(-EPIPE);
> +       return hdev;
> +}
> +
>  void hci_sock_set_flag(struct sock *sk, int nr)
>  {
>         set_bit(nr, &hci_pi(sk)->flags);
> @@ -759,19 +770,13 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
>         if (event == HCI_DEV_UNREG) {
>                 struct sock *sk;
>
> -               /* Detach sockets from device */
> +               /* Wake up sockets using this dead device */
>                 read_lock(&hci_sk_list.lock);
>                 sk_for_each(sk, &hci_sk_list.head) {
> -                       lock_sock(sk);
>                         if (hci_pi(sk)->hdev == hdev) {
> -                               hci_pi(sk)->hdev = NULL;
>                                 sk->sk_err = EPIPE;
> -                               sk->sk_state = BT_OPEN;
>                                 sk->sk_state_change(sk);
> -
> -                               hci_dev_put(hdev);
>                         }
> -                       release_sock(sk);
>                 }
>                 read_unlock(&hci_sk_list.lock);
>         }
> @@ -930,10 +935,10 @@ static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
>  static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
>                                 unsigned long arg)
>  {
> -       struct hci_dev *hdev = hci_pi(sk)->hdev;
> +       struct hci_dev *hdev = hci_hdev_from_sock(sk);
>
> -       if (!hdev)
> -               return -EBADFD;
> +       if (IS_ERR(hdev))
> +               return PTR_ERR(hdev);
>
>         if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
>                 return -EBUSY;
> @@ -1103,6 +1108,18 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
>
>         lock_sock(sk);
>
> +       /* Allow detaching from dead device and attaching to alive device, if
> +        * the caller wants to re-bind (instead of close) this socket in
> +        * response to hci_sock_dev_event(HCI_DEV_UNREG) notification.
> +        */
> +       hdev = hci_pi(sk)->hdev;
> +       if (hdev && hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
> +               hci_pi(sk)->hdev = NULL;
> +               sk->sk_state = BT_OPEN;
> +               hci_dev_put(hdev);
> +       }
> +       hdev = NULL;
> +
>         if (sk->sk_state == BT_BOUND) {
>                 err = -EALREADY;
>                 goto done;
> @@ -1379,9 +1396,9 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
>
>         lock_sock(sk);
>
> -       hdev = hci_pi(sk)->hdev;
> -       if (!hdev) {
> -               err = -EBADFD;
> +       hdev = hci_hdev_from_sock(sk);
> +       if (IS_ERR(hdev)) {
> +               err = PTR_ERR(hdev);
>                 goto done;
>         }
>
> @@ -1743,9 +1760,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>                 goto done;
>         }
>
> -       hdev = hci_pi(sk)->hdev;
> -       if (!hdev) {
> -               err = -EBADFD;
> +       hdev = hci_hdev_from_sock(sk);
> +       if (IS_ERR(hdev)) {
> +               err = PTR_ERR(hdev);
>                 goto done;
>         }
>
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 9874844a95a9..b69d88b88d2e 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -83,6 +83,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
>  static void bt_host_release(struct device *dev)
>  {
>         struct hci_dev *hdev = to_hci_dev(dev);
> +
> +       if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
> +               hci_cleanup_dev(hdev);
>         kfree(hdev);
>         module_put(THIS_MODULE);
>  }
> --
> 2.18.4

It doesn't apply to bluetooth-next, could you please rebase it.


-- 
Luiz Augusto von Dentz
