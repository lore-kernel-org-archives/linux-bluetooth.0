Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9688BC636C8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 05:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671D7610C7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 05:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhGRFTl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhGRFTk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 01:19:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D47C061762
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 22:16:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id x192so21971665ybe.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztz7Bx0ZiwvptP/RV8vgKIGcxglbKJWAUPDl5aFHIyc=;
        b=rM2X6w9eUuwyoc8OJU3WJWIS1cxsM6ybINjg3gXtnqq5poUuzGAM0LzSK/6q8pVelz
         t7kRMbELH0+a2dhAcRQoEeyopNIEPNdKoIfqiFq/MpF/qo3U/DkUSK4R9QeuWEnBI/er
         YfLDc6OiXCA4P0V/8d/Woqu5AmJdCS7ppw8+GT1TKUSvaZtNqINDUOEuMgki1FMVYr1u
         z4jD6dIOm6pZPGcahfpRZJQ4oVIkE4e1yE4hvegwhJ/vR5eIO20P6pNOzC68ZXjV+SDM
         YYs9u4YbN2tfCihJvgXk2qmPoR6ID1tKR+dVdkr4i64uXPfsvuVC5YKcy/mGax++fTJX
         dhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztz7Bx0ZiwvptP/RV8vgKIGcxglbKJWAUPDl5aFHIyc=;
        b=GMgK0P0T5uXW7vaOUynactZGD9XF3RYRLWyb4zWSP6UKSHW8KW4t4YzhqQn2JCnPUF
         SZXKXh6K2eyvr0VnYmuE9RSHT/Cuc0CI7eaNubFN/+yFteeiWY69MXMIJFLS20/GsJy0
         bm16LxyLzk+qhzViSbhbVfZeF1WuOewm6bHHRLhr0BpRqaDJZ44Mxzr7+z+rYzcDbc5y
         hro56p3gzKxEo6yn1iWwrAjdxgcAGUPYAvJl3gbghKQH32JXYMLneqq2PkxaZehURod1
         5D1YQjDS5HOh0hDiTKMT8ft/68pfZQfG5ZovQeUvJ4FBhDCaX64EDB6xqZNTt4TF42jx
         qmXg==
X-Gm-Message-State: AOAM531JtScD2GwzkSDmePPCs68oZ3Fl2lFzqg3vm6tLT/1nl7y+flR2
        xMo5NXlo16BdJdSjgKzrwKfo9xo/WdNbgjJTzec=
X-Google-Smtp-Source: ABdhPJxkjX4x+mC2XUcvdr6OBUc21ZgV1/pfk/B1SUwu5bEPDGczxFNw5LAa3SPp1GWqxFEfy5N+H046CbKJ3YDOgKU=
X-Received: by 2002:a25:7647:: with SMTP id r68mr22852752ybc.432.1626585400781;
 Sat, 17 Jul 2021 22:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210717000731.3836303-1-luiz.dentz@gmail.com> <7a0405c7-63ba-3e5c-7b22-503d7b326a11@i-love.sakura.ne.jp>
In-Reply-To: <7a0405c7-63ba-3e5c-7b22-503d7b326a11@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 17 Jul 2021 22:16:29 -0700
Message-ID: <CABBYNZLdYXHxD47xO+TX6U=MK1RtvuAAHLYvS1vTsuk4nFQfrg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: hci_sock: Fix calling lock_sock when handling HCI_DEV_UNREG
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Sat, Jul 17, 2021 at 7:22 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Luiz Augusto von Dentz wrote:
> > This removes the reference of hci_dev to hci_pinfo since the reference
> > cannot prevent hdev to be freed hci_pinfo only keeps the index so in
> > case the device is unregistered and freed hci_dev_get will return NULL
> > thus prevent UAF.
>
> I'm not convinced that this change is safe.
>
> vhci_release() (which will call hci_unregister_dev(hdev)) is called when
> refcount to /dev/vchi dropped to 0. That is, vhci_release() might be called
> while e.g. hci_sock_bound_ioctl() is in progress.
>
> Since hci_unregister_dev(hdev) calls list_del(&hdev->list) with hci_dev_list_lock
> held for write, hci_dev_get(hci_pi(sk)->dev) which scans hci_dev_list with
> hci_dev_list_lock held for read will start returning NULL. But I think that
> this change introduces two race windows.
>
> Since hci_unregister_dev(hdev) then calls hci_sock_dev_event(hdev, HCI_DEV_UNREG)
> and finally calls ida_simple_remove(&hci_index_ida, id), subsequent
> hci_register_dev(struct hci_dev *hdev) call can re-assign the id which
> hci_pi(sk)->dev is tracking, by calling ida_simple_get() and finally calling
> list_add(&hdev->list, &hci_dev_list) with hci_dev_list_lock held for write.

We can perform a pointer comparison if that makes you happy. Anyway I
don't know if you guys have realized already but this is probably
impossible to reproduce with real hardware since the
registration/unregistration comes for other buses no memfault would
hold the thread that long for unplugging and replugging a device on
the bus, vhci is usually only used for emulation/testing/CI, not sure
who got the idea that finding vulnerabilities on our emulator would be
a great feat.

> Therefore, I think that first race window is that
>
> +       /* Commands may use copy_from_user which is unsafe while holding hdev as
> +        * it could be unregistered in the meantime.
> +        */
> +       hci_dev_put(hdev);
> +       hdev = NULL;
>
> causes hci_sock_bound_ioctl() to check flags on an intended hdev and
> e.g. hci_sock_reject_list_add() to operate on an unintended hdev.
>
> Also, even if hci_sock_bound_ioctl() and hci_sock_reject_list_add() reached
> the same hdev, I think that there still is second race window that
>
>   hci_unregister_dev() {                       hci_sock_reject_list_add() {
>                                                  hdev = hci_dev_get(hci_pi(sk)->dev);
>     write_lock(&hci_dev_list_lock);
>     list_del(&hdev->list);
>     write_unlock(&hci_dev_list_lock);
>
>     hci_sock_dev_event(hdev, HCI_DEV_UNREG);
>
>     hci_dev_lock(hdev);
>     hci_bdaddr_list_clear(&hdev->reject_list);
>     hci_dev_unlock(hdev);
>                                                  hci_dev_lock(hdev);
>                                                  err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR); // <= Adding after clear all; at least memory leak.
>                                                  hci_dev_unlock(hdev);
>                                                  hci_dev_put(hdev);
>   }
>
> . That is, an attempt to replace pointer reference with index number is racy.
>
> After all, hci_sock_dev_event(hdev, HCI_DEV_UNREG) is responsible for
> waiting for already started e.g. hci_sock_reject_list_add().

Both blocks do require hci_dev_lock, so if the second block had
acquired the lock isn't it obvious that the first won't execute until
hci_dev_unlock is complete? Anyway after all these discussion Im even
more convinced that the real problem lies in hci_dev_get/hold, after
all references are usually used to prevent the objects to be freed but
in this case it doesn't and no locking will gonna fix that.

-- 
Luiz Augusto von Dentz
