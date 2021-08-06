Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F23BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E4560BD3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbhHFHSy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbhHFHSy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 03:18:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6382C061799
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 00:18:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c3so7836648ilh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfXhjKpSCetGLLmH2wYSMbPYpbDKNCyV0HNRYyDMQeA=;
        b=HIqw9q6X5vyWEvkesEX5PjXRQM7ZTPej9g4yoakHyG9UUz9ZBim9nm2/15AqQwjYbp
         FtLwFHfS7IuNoFwdgnAIGGIyI8drUyaEYoJ0wwedxxz4/wsxqNrAD+2RiKbI1AXYgzTz
         HU7n7gdfF8E0WkfKempmVH+MvIVnLNUdDDeiDt8CyoVaWyTAzI43z8wxQw532biv1uEP
         tMg8757wAA1hzr8cexj2ijuu8Jk9dxtGyhDmzDIEoxOMDFSGp8ZbKm2aGx90wawj3Gsa
         hvjhMUYXqgsXgMX7Lc3AHP243i/srho+LQddDkpdGGOEgyNM6Mj8eBcvTjfieCNG97xY
         GlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfXhjKpSCetGLLmH2wYSMbPYpbDKNCyV0HNRYyDMQeA=;
        b=ZjKCsFll/yQV7EW8g5sTCLCN/Dx8OSPM+CptoICqJKTbGiwGD16IKQr08E96Vp4CCq
         fKMgE02EjauSBn5gY+g+jKpEsx90NjyEvn2U2zBUFI/BdMqRFNa8SWezx6vT+cEuz0cI
         BkwHRyqrkAEqqk0GNjCi55sygJMSwz7HDeXo8yEEZ5LIys4eHEGzrcmgk+gBhpWZvJTM
         JNTthOAIKiJx2I//BUb4VJl1koKIrJqdeRPMcXmYgoRfHwhCzVFlMrIr5CZ/Hb3tjKVY
         7XYWRmreRYfjbOkcloRzLGlYWnjZyVkLpPO8ZF58HnnbKJnptaHOSxdxw6Ir50pTDWuc
         9TTw==
X-Gm-Message-State: AOAM53365lzmGSFs1AL77iBXjtWN15Mv6BR5SPEKZwNEMudg4iHk6M9N
        q6gWrEguMPHHt69Zju1wd/CMXm6oflc+aOHac0uMFg==
X-Google-Smtp-Source: ABdhPJzDCVLK5V7LZPwSnnK3Ot1kGmgymxUIyCMxFioYlPkMkJkf6Zof5u9E1YTx97xz6BpltLo57X22iVIcj1sQcu0=
X-Received: by 2002:a92:d3d2:: with SMTP id c18mr360857ilh.192.1628234317999;
 Fri, 06 Aug 2021 00:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <2c40741c-8c8f-a105-1846-aa1ed15a6c7e@gnuweeb.org>
 <20210804085651.2452-1-hdanton@sina.com> <80e24ed7-a34a-7fac-c709-06ccad6d2612@gnuweeb.org>
In-Reply-To: <80e24ed7-a34a-7fac-c709-06ccad6d2612@gnuweeb.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Fri, 6 Aug 2021 17:18:25 +1000
Message-ID: <CAATStaMjeyzU3Gj7D-Q1zGMdioC5ENoXbf4QB9Rmw8TCWRiagg@mail.gmail.com>
Subject: Re: WARNING: possible circular locking dependency detected (hci_sock_dev_event+0x17d/0x1f0)
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Hillf Danton <hdanton@sina.com>, Lin Ma <linma@zju.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 4 Aug 2021 at 21:43, Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> See the original report here:
> https://lore.kernel.org/lkml/2c40741c-8c8f-a105-1846-aa1ed15a6c7e@gnuweeb.org/
>
> On 8/4/21 3:56 PM, Hillf Danton wrote:
> > On Mon, 2 Aug 2021 20:17:02 +0700 Ammar Faizi wrote:
> >> Hi everyone,
> >>
> >> I found a potential deadlock at hci_sock_dev_event.
> >
> > Thanks for your report.
> >
> > Can you try and see if reverting e305509e678b3a4af2b3cfd410f409f7cdaabb52
> > ("Bluetooth: use correct lock to prevent UAF of hdev object") is a cure.
> >
>
> Hi Hillf,
>
> Thank you for your response.
>
> Here is what I have tried:
> 1. Reverted e305509e678b3a4af2b3cfd410f409f7cdaabb52.
> 2. Compile and install reverted version.
> 3. Rebooted 5.14.0-rc3 (c7d102232649, before revert) and try to
> reproduce again. At this point I am able to reproduce it.
> 4. Booted 5.14.0-rc3 (the reverted version). The deadlock warning is
> gone after reverting it. No more deadlock warning.

Can you try patching in
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=58ce6d5b271ab25fb2056f84a8e5546945eb5fc9
and see if that fixes it.

>
> ------------------------------------------------------------
> [ 51207ee38ab65db86554655300a912e8c661525e is my local revert. ]
> Revert diff:
> ammarfaizi2@integral:~/project/now/linux$ git diff
> c7d102232649226a69dddd58a4942cf13cff4f7c
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index b04a5a02ecf3..590467345c5f 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -762,7 +762,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
>                 /* Detach sockets from device */
>                 read_lock(&hci_sk_list.lock);
>                 sk_for_each(sk, &hci_sk_list.head) {
> -                       lock_sock(sk);
> +                       bh_lock_sock_nested(sk);
>                         if (hci_pi(sk)->hdev == hdev) {
>                                 hci_pi(sk)->hdev = NULL;
>                                 sk->sk_err = EPIPE;
> @@ -771,7 +771,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
>
>                                 hci_dev_put(hdev);
>                         }
> -                       release_sock(sk);
> +                       bh_unlock_sock(sk);
>                 }
>                 read_unlock(&hci_sk_list.lock);
>         }
> ammarfaizi2@integral:~/project/now/linux$
> ------------------------------------------------------------
>
> Summary:
> Reverting e305509e678b3a4af2b3cfd410f409f7cdaabb52 is a cure.
>
> Although it fixes the deadlock, there is probably something still goes
> wrong regarding "prevent UAF" as the commit message says.
>
> Will anyone create a patch for this?
> I want to be the tester, I am new at kernel development and want to
> start contributing, so please guide me :)
>
> I also attached dmesg log before and after revert if you want to see the
> full log.
>
> Adding Lin as the author of e305509e678b3a4af2b3cfd410f409f7cdaabb52 to
> CC list...
>
>
> --
> Ammar
>


-- 
Anand K. Mistry
Software Engineer
Google Australia
