Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A37C12002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B920D6120C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhGURhb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhGURh3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 13:37:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544BC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 11:18:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i18so4457868yba.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGqZrz0YEABNs0LpSkP9pTVxlbJFBT9c0tb0DVX5a2w=;
        b=SyjBP/9WlS2KE/P/Asuu8ZrQbXhMLcErlNORul3tsUJQV5L3UMaI6HAYLlhkPqqOJX
         SpMnyfXOlpFV758hcIHjhDLUIka7xjd3hbWP1bLKrC6QIjISKMwpIErxEx2TzD+P3T9z
         9FpuFy9Eu5AbjotAiwrdKEdZ2WTUMzwHAWLEkZ8pckkUf2G4EDoepUftsMbf+B5e4WsN
         QhRX5H7t72u2qiBuwqin+vICPP0b/EECM3y8VkEKaDXrO0J48jkFoEAppzyLL//FDKtU
         kksO55hfxv2Mn3AKBM8RoC1bRyNVL9Kk7RdsWRoBL+bsGPNFvzUJKk83rTapL/QVwHl9
         F1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGqZrz0YEABNs0LpSkP9pTVxlbJFBT9c0tb0DVX5a2w=;
        b=GaIRnnMAOd0inL/V7M+OTH5OpbLPckPV5WrBhFp9y2NuAVMO68Ed044BmBNdOQ3ToA
         IHtTxdccc2okxSDRXTiOnns6YWpAmq7Zdt9EMZNcKXz/tvHife39fv/uxZhwj+aryaD/
         RNP1OlZ3qKamAAPix2rsQgNKdIp8864jBc1MQWV9JnuwzStH0so9NwntPKZX5bhdMTvJ
         JLNLRDjm3lkdlD2RG3Xpx69EewsTDGSk2kigwnae3/QOUGSjJ1Uif+1D8htrQSher8e5
         J1C4348/lzO9ZI1b1LCe5PnGqmBAp3b0+3fCzyRy59SokwEruyUr6xpuYeZVLjhUKmiv
         7IHQ==
X-Gm-Message-State: AOAM532+hdRyoe2iXYt5XuLYVfKIzuLA2XEujSXqE4e2rb9iHPhUFELC
        SXqyHo9KTvfWc9SNTqacQ+WmlE17p9lM4P414io=
X-Google-Smtp-Source: ABdhPJzRlmr4fHmLuAWfkUi/2/dt3qSgmaYhtKjp7Pyvat+NhEiy2aNkAprOIf15BzZkaPsRVX2MVOKQBSBObJ+vh0A=
X-Received: by 2002:a25:b741:: with SMTP id e1mr48076895ybm.347.1626891483395;
 Wed, 21 Jul 2021 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Jul 2021 11:17:52 -0700
Message-ID: <CABBYNZLt=fJTtdj9qvC22GkF_uYFe59D2bS3u61K14=Gq43Qbw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Tue, Jul 20, 2021 at 3:49 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since userfaultfd mechanism allows sleeping with kernel lock held,
> avoiding page fault with kernel lock held where possible will make
> the module more robust. This patch just brings copy_{from,to}_user()
> calls to out of hdev lock and sock lock.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/net/bluetooth/hci_core.h |   3 +-
>  net/bluetooth/hci_conn.c         |  50 +---------
>  net/bluetooth/hci_sock.c         | 165 ++++++++++++++++++++-----------
>  3 files changed, 108 insertions(+), 110 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a53e94459ecd..d9e55682b908 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1261,8 +1261,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg);
>  int hci_get_dev_list(void __user *arg);
>  int hci_get_dev_info(void __user *arg);
>  int hci_get_conn_list(void __user *arg);
> -int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
> -int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
> +u32 get_link_mode(struct hci_conn *conn);
>  int hci_inquiry(void __user *arg);
>
>  struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 2b5059a56cda..41af11fadb74 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1626,7 +1626,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
>         hci_dev_unlock(hdev);
>  }
>
> -static u32 get_link_mode(struct hci_conn *conn)
> +u32 get_link_mode(struct hci_conn *conn)
>  {
>         u32 link_mode = 0;
>
> @@ -1701,54 +1701,6 @@ int hci_get_conn_list(void __user *arg)
>         return err ? -EFAULT : 0;
>  }
>
> -int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
> -{
> -       struct hci_conn_info_req req;
> -       struct hci_conn_info ci;
> -       struct hci_conn *conn;
> -       char __user *ptr = arg + sizeof(req);
> -
> -       if (copy_from_user(&req, arg, sizeof(req)))
> -               return -EFAULT;
> -
> -       hci_dev_lock(hdev);
> -       conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
> -       if (conn) {
> -               bacpy(&ci.bdaddr, &conn->dst);
> -               ci.handle = conn->handle;
> -               ci.type  = conn->type;
> -               ci.out   = conn->out;
> -               ci.state = conn->state;
> -               ci.link_mode = get_link_mode(conn);
> -       }
> -       hci_dev_unlock(hdev);
> -
> -       if (!conn)
> -               return -ENOENT;
> -
> -       return copy_to_user(ptr, &ci, sizeof(ci)) ? -EFAULT : 0;
> -}
> -
> -int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
> -{
> -       struct hci_auth_info_req req;
> -       struct hci_conn *conn;
> -
> -       if (copy_from_user(&req, arg, sizeof(req)))
> -               return -EFAULT;
> -
> -       hci_dev_lock(hdev);
> -       conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
> -       if (conn)
> -               req.type = conn->auth_type;
> -       hci_dev_unlock(hdev);
> -
> -       if (!conn)
> -               return -ENOENT;
> -
> -       return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
> -}
> -
>  struct hci_chan *hci_chan_create(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev = conn->hdev;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index b04a5a02ecf3..ff78b79ee09d 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -892,82 +892,136 @@ static int hci_sock_release(struct socket *sock)
>         return 0;
>  }
>
> -static int hci_sock_reject_list_add(struct hci_dev *hdev, void __user *arg)
> +static int hci_sock_reject_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  {
> -       bdaddr_t bdaddr;
> -       int err;
> -
> -       if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
> -               return -EFAULT;
> -
> -       hci_dev_lock(hdev);
> -
> -       err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
> -
> -       hci_dev_unlock(hdev);
> -
> -       return err;
> +       return hci_bdaddr_list_add(&hdev->reject_list, bdaddr, BDADDR_BREDR);
>  }
>
> -static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
> +static int hci_sock_reject_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  {
> -       bdaddr_t bdaddr;
> -       int err;
> -
> -       if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
> -               return -EFAULT;
> -
> -       hci_dev_lock(hdev);
> +       return hci_bdaddr_list_del(&hdev->reject_list, bdaddr, BDADDR_BREDR);
> +}
>
> -       err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
> +static int hci_get_conn_info(struct hci_dev *hdev, struct hci_conn_info_req *req,
> +                            struct hci_conn_info *ci)
> +{
> +       struct hci_conn *conn;
> +
> +       conn = hci_conn_hash_lookup_ba(hdev, req->type, &req->bdaddr);
> +       if (!conn)
> +               return -ENOENT;
> +       bacpy(&ci->bdaddr, &conn->dst);
> +       ci->handle = conn->handle;
> +       ci->type  = conn->type;
> +       ci->out   = conn->out;
> +       ci->state = conn->state;
> +       ci->link_mode = get_link_mode(conn);
> +       return 0;
> +}
>
> -       hci_dev_unlock(hdev);
> +static int hci_get_auth_info(struct hci_dev *hdev, struct hci_auth_info_req *req)
> +{
> +       struct hci_conn *conn;
>
> -       return err;
> +       conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req->bdaddr);
> +       if (!conn)
> +               return -ENOENT;
> +       req->type = conn->auth_type;
> +       return 0;
>  }
>
>  /* Ioctls that require bound socket */
> -static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
> -                               unsigned long arg)
> +static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>  {
> -       struct hci_dev *hdev = hci_pi(sk)->hdev;
> +       struct hci_dev *hdev;
> +       union {
> +               bdaddr_t bdaddr;
> +               struct hci_conn_info_req conn_req;
> +               struct hci_auth_info_req auth_req;
> +       } u;
> +       struct hci_conn_info ci;
> +       int err = 0;
>
> -       if (!hdev)
> -               return -EBADFD;
> +       if (cmd == HCIBLOCKADDR || cmd == HCIUNBLOCKADDR) {
> +               if (copy_from_user(&u.bdaddr, arg, sizeof(u.bdaddr)))
> +                       err = -EFAULT;
> +       } else if (cmd == HCIGETCONNINFO) {
> +               if (copy_from_user(&u.conn_req, arg, sizeof(u.conn_req)))
> +                       err = -EFAULT;
> +       } else if (cmd == HCIGETAUTHINFO) {
> +               if (copy_from_user(&u.auth_req, arg, sizeof(u.auth_req)))
> +                       err = -EFAULT;
> +       }
>
> -       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
> -               return -EBUSY;
> +       lock_sock(sk);
>
> -       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> -               return -EOPNOTSUPP;
> +       hdev = hci_pi(sk)->hdev;
> +       if (!hdev) {
> +               err = -EBADFD;
> +               goto out;
> +       }
>
> -       if (hdev->dev_type != HCI_PRIMARY)
> -               return -EOPNOTSUPP;
> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +               err = -EBUSY;
> +               goto out;
> +       }
>
> +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
> +               err = -EOPNOTSUPP;
> +               goto out;
> +       }
> +
> +       if (hdev->dev_type != HCI_PRIMARY) {
> +               err = -EOPNOTSUPP;
> +               goto out;
> +       }
> +
> +       hci_dev_lock(hdev);

I think it would have been cleaner if we have dedicated functions for
each command like I did in my patch:

https://patchwork.kernel.org/project/bluetooth/patch/20210717000731.3836303-1-luiz.dentz@gmail.com/

That way it is simpler to protect the likes of
copy_from_user/copy_to_user, etc, even if we have to some checks
duplicated on each function we can have a helper function to checks
the flags, etc.

>         switch (cmd) {
>         case HCISETRAW:
>                 if (!capable(CAP_NET_ADMIN))
> -                       return -EPERM;
> -               return -EOPNOTSUPP;
> -
> +                       err = -EPERM;
> +               else
> +                       err = -EOPNOTSUPP;
> +               break;
>         case HCIGETCONNINFO:
> -               return hci_get_conn_info(hdev, (void __user *)arg);
> -
> +               if (!err)
> +                       err = hci_get_conn_info(hdev, &u.conn_req, &ci);
> +               break;
>         case HCIGETAUTHINFO:
> -               return hci_get_auth_info(hdev, (void __user *)arg);
> -
> +               if (!err)
> +                       err = hci_get_auth_info(hdev, &u.auth_req);
> +               break;
>         case HCIBLOCKADDR:
>                 if (!capable(CAP_NET_ADMIN))
> -                       return -EPERM;
> -               return hci_sock_reject_list_add(hdev, (void __user *)arg);
> -
> +                       err = -EPERM;
> +               else if (!err)
> +                       err = hci_sock_reject_list_add(hdev, &u.bdaddr);
> +               break;
>         case HCIUNBLOCKADDR:
>                 if (!capable(CAP_NET_ADMIN))
> -                       return -EPERM;
> -               return hci_sock_reject_list_del(hdev, (void __user *)arg);
> +                       err = -EPERM;
> +               else if (!err)
> +                       err = hci_sock_reject_list_del(hdev, &u.bdaddr);
> +               break;
> +       default:
> +               err = -ENOIOCTLCMD;
>         }
> +       hci_dev_unlock(hdev);
> +
> + out:
> +       release_sock(sk);
>
> -       return -ENOIOCTLCMD;
> +       if (!err) {
> +               if (cmd == HCIGETCONNINFO) {
> +                       if (copy_to_user(arg + sizeof(u.conn_req), &ci, sizeof(ci)))
> +                               err = -EFAULT;
> +               } else if (cmd == HCIGETAUTHINFO) {
> +                       if (copy_to_user(arg, &u.auth_req, sizeof(u.auth_req)))
> +                               err = -EFAULT;
> +               }
> +       }
> +       return err;
>  }
>
>  static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
> @@ -975,15 +1029,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
>  {
>         void __user *argp = (void __user *)arg;
>         struct sock *sk = sock->sk;
> -       int err;
>
>         BT_DBG("cmd %x arg %lx", cmd, arg);
>
>         lock_sock(sk);
>
>         if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
> -               err = -EBADFD;
> -               goto done;
> +               release_sock(sk);
> +               return -EBADFD;
>         }
>
>         /* When calling an ioctl on an unbound raw socket, then ensure
> @@ -1055,13 +1108,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
>                 return hci_inquiry(argp);
>         }
>
> -       lock_sock(sk);
> -
> -       err = hci_sock_bound_ioctl(sk, cmd, arg);
> -
> -done:
> -       release_sock(sk);
> -       return err;
> +       return hci_sock_bound_ioctl(sk, cmd, (void __user *)arg);
>  }
>
>  #ifdef CONFIG_COMPAT
> --
> 2.18.4
>


-- 
Luiz Augusto von Dentz
