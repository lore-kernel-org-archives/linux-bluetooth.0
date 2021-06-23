Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8BC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAB860FEB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 14:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFWOnx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFWOnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 10:43:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6028C061574;
        Wed, 23 Jun 2021 07:41:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bj15so5685978qkb.11;
        Wed, 23 Jun 2021 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grMpRFSFa/Yee9hmf0XS+EbMWVihg50NgZvro2wq+xc=;
        b=S4g+emmjW3QfbSeWI0ifotqF+o05TYimfJARIYh0LtYg1Jj5NIYpt/qAXZ21fYQV6B
         502oXLVFc9rZaMkdhriGbVz7Fj7oboguSOJpIFqjk+jqzelyiOxp3zWa5JPhXkktBAOl
         5jb/MbzibcELwikH+ufMyyZ5RCqV/B4bQzwfIrvONtFZ5abeFlfv91gZLcCTUxkfnXiG
         5umJERgIJdAGS9yMUmjZArw/r1cJQ98gpPty24XhfVr5qxmpx7AYQSRUv6Hi+WbXxnnD
         5CDaMr0yKWP64miJgUCEzS1mCMoJvruQHbMH8CsF0fcRKWwqNDnkMj0U3PlvLywXlBaH
         yNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grMpRFSFa/Yee9hmf0XS+EbMWVihg50NgZvro2wq+xc=;
        b=AmlDG/NYKeX7+C6Qv89ETEJSn00AYOsuNhgbw6/ukoxMcbhbNiw0FUn/uCKOuQG8/1
         8WZ4LVDfga9gTPH1DNxCKsXg1g9b3wI/lhmOQ1yAbnQuXzKP1FYIsrC+Zi6iRjoy9Jg5
         HFn1xsCJotcd2Ri0TTXsZwliIU/U52r1Mv6E3gEWvnirSepSwdCDRxmInJ0x6dplJFHr
         VDaIcBaETlh61cjChSXZXj9qaSrb6kiNalVl+JzCdswFV9x3xOL3ZTeKnom0TRkxMBSz
         itRcWArswHznLYPbX2EzeW+hQWhD3FLFc6bFm819KSRcmJsr75sepI8+vFkL7AoBdGK5
         GexQ==
X-Gm-Message-State: AOAM531obiaFtDgBoMEDzpL9b8oaxXWp5OYxSTInm8rW1p8Kn0uFbkOm
        ZTikZ2Byo91hZhxklyl/nIJ7i01lhw/xOvessGEHtC+FWuEt7uuW
X-Google-Smtp-Source: ABdhPJwaT121xh0WhBnhBkhQxPZ2qRT6Z35kfo9SUFw2z6xPsi1u5Eb/4/Ug+ZAG+IA4BJBMH2stDLzpF7rlh2es3Jo=
X-Received: by 2002:a25:ba85:: with SMTP id s5mr12480653ybg.336.1624459290890;
 Wed, 23 Jun 2021 07:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJjojJsj9pzF4j2MVvsM-hCpvyR7OkZn232yt3MdOGnLxOiRRg@mail.gmail.com>
 <20210623083329.1455-1-hdanton@sina.com>
In-Reply-To: <20210623083329.1455-1-hdanton@sina.com>
From:   Lin Horse <kylin.formalin@gmail.com>
Date:   Wed, 23 Jun 2021 22:41:19 +0800
Message-ID: <CAJjojJstJnwjeLmOyd-7sOOOJnF3gYbCXc+VZU7qbMBzLp_sEw@mail.gmail.com>
Subject: Re: Another patch for CVE-2021-3573 without introducing lock bugs
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>, ohan.hedberg@gmail.com,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Mistry <amistry@google.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there

>
> It is good to put your patch in the mail message instead of attachment.
>

Hi Danton, thanks for the advice. I will present the patch and give
the description in the message.

>
> Yes the uaf can be fixed by taking another grab to hci dev, see below
> diff.
> >

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -762,7 +762,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
         /* Detach sockets from device */
         read_lock(&hci_sk_list.lock);
         sk_for_each(sk, &hci_sk_list.head) {
-            lock_sock(sk);
+            bh_lock_sock_nested(sk);
             if (hci_pi(sk)->hdev == hdev) {
                 hci_pi(sk)->hdev = NULL;
                 sk->sk_err = EPIPE;
@@ -771,7 +771,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)

                 hci_dev_put(hdev);
             }
-            release_sock(sk);
+            bh_unlock_sock(sk);
         }
         read_unlock(&hci_sk_list.lock);
     }

The first thing is to revert the lock replacement. By the way, I
wonder if we need to change the read_lock() here to write_lock(), as
the code between the lock indeed changes something related to the
hci_sk_list.

For the patch code in hci_sock_bound_ioctl() function, I prefer to
leave the hci_sock_ioctl() function alone. Danton changes the
lock_sock() from hci_sock_ioctl() to hci_sock_bound_ioctl() for the
serialise stuff, which I don't really get the point.

> +       /* serialise with read_lock in hci_sock_dev_event */
> +       write_lock(&hci_sk_list.lock);
> +       bh_lock_sock_nested(sk);
> +       hdev = hci_pi(sk)->hdev;
> +       if (hdev)
> +               hci_dev_hold(hdev);
> +       bh_unlock_sock(sk);
> +       write_unlock(&hci_sk_list.lock);

Even the read of hci_pi(sk)->hdev is protected like above, the
attacker can still play userfaultfd tricks to abuse this hdev object.
Check the attacker scripts in the OSS list.

Hence, I think the important thing is to add proper flag check after
the dangerous copy_from_user() functions like below.

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 88ec08978ff4..2787da8fe14a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1711,6 +1711,9 @@ int hci_get_conn_info(struct hci_dev *hdev, void
__user *arg)
        if (copy_from_user(&req, arg, sizeof(req)))
                return -EFAULT;

+       if (!test_bit(HCI_UP, &hdev->flags))
+               return -ENETDOWN;
+
        hci_dev_lock(hdev);
        conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
        if (conn) {
@@ -1737,6 +1740,9 @@ int hci_get_auth_info(struct hci_dev *hdev, void
__user *arg)
        if (copy_from_user(&req, arg, sizeof(req)))
                return -EFAULT;

+       if (!test_bit(HCI_UP, &hdev->flags))
+               return -ENETDOWN;
+
        hci_dev_lock(hdev);
        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
        if (conn)

@@ -900,6 +900,9 @@ static int hci_sock_blacklist_add(struct hci_dev
*hdev, void __user *arg)
        if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
                return -EFAULT;

+       if (!test_bit(HCI_UP, &hdev->flags))
+               return -ENETDOWN;
+
        hci_dev_lock(hdev);

        err = hci_bdaddr_list_add(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
@@ -917,6 +920,9 @@ static int hci_sock_blacklist_del(struct hci_dev
*hdev, void __user *arg)
        if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
                return -EFAULT;

+       if (!test_bit(HCI_UP, &hdev->flags))
+               return -ENETDOWN;
+
        hci_dev_lock(hdev);

        err = hci_bdaddr_list_del(&hdev->blacklist, &bdaddr, BDADDR_BREDR);

And last but not least, we patch the hci_sock_bound_ioctl() and
hci_sock_sendmsg() function to take an extra hold of the hdev. That
part is almost like Danton's code and you can check the previous added
attachment.

There are some other readings of hci_pi(sk)->hdev. One is in
hci_sock_release() and another is in hci_sock_getname(). However, I
don't think these two can be easily abused because no copy_from_user()
is called. Do we need to add hold for these functions too?

Regards
Lin Ma
