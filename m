Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65528C636C8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 06:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391CC61166
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 06:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhGRGyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 02:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGRGyt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 02:54:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31436C061762
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 23:51:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g19so22197763ybe.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkeS3d9zkV5UugREVkpK+fBURGhl+uNRLB6rfN3cNw4=;
        b=mUbuBmNSUllRTJfIDaFuOYo31S3GR32n9AMR8Epk1iVYPQQ6iEE+dti3Q4TWzKCOhx
         XbubTWKcVB2JCY9MSEWolqivFNRUwSWkwD5b2iDBIpTU1lePQjl9sOyARbQwgGV/w/iL
         /UjbWy77+2bWlPYeDrZi4+lLjqLyVdyjO1n3QX88ldAi3ouut02sQB1d8CmdJm+4bGL3
         61lbAk3nrWr2G1cHRcTcj5nA5BxdKBNvNQyCTItjgXvbWFw2a5CaPPQ/pGZ5QBy0f4Tg
         TCe3GzGnAgVCHG65uxlc93vHdn1yjXWxp5qWI4IgxD3bZ97CVBHDP+GqiPW940DVwBP/
         VIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkeS3d9zkV5UugREVkpK+fBURGhl+uNRLB6rfN3cNw4=;
        b=hxe7JnQYFIHghKWo4sSY3VDK+ZhisqFSD11sSWJjleZ5DuKnE8563dihbUIoG+NsZ+
         ZehKucX4Qz8b6coGzDps+Dgsc1fLDlslFABg3Elyj5blOUbk47+bijC83nzutqJa6xpl
         f9f5lz7YKcXhgtZ1ivk+oTHDRwEhUg03Wd2lhtHjHd7tS9zDMIocdbwdxPNr9coCL7mS
         s6vqrklr+ervHRlfZIhYsqsW/ovUDH4OVpzPi+Z3FL+5Kd8p4iBSBRdUJ/1k4vvqVpLE
         zKRK/sSjlPHPUB2itkq9eGIBPIJE7Vd9g5VnoHsZhmCA3GtcYGmNUBfjC2wHSqXabBn4
         4vIg==
X-Gm-Message-State: AOAM5333TA8V0ffufrR1SzZqTBoQpo0PsWJKw5PQtBrIY7CjoLObuhmX
        o/N7lzngrWo/Ip2Kzmq5sqWnXoS6VwgAYxE48xuTxwXO5Dg=
X-Google-Smtp-Source: ABdhPJzsxu5TvSAH7UnxJJ6PUkImAD+i6+YMuUfeDolPooOkNyZaqssm/kvpAIKyk2z7U8VzbWQ/wPbzU1hJ81z/Azs=
X-Received: by 2002:a25:7647:: with SMTP id r68mr23185462ybc.432.1626591110115;
 Sat, 17 Jul 2021 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210717000731.3836303-1-luiz.dentz@gmail.com>
 <7a0405c7-63ba-3e5c-7b22-503d7b326a11@i-love.sakura.ne.jp>
 <CABBYNZLdYXHxD47xO+TX6U=MK1RtvuAAHLYvS1vTsuk4nFQfrg@mail.gmail.com> <166a8c6d-9928-4edf-8082-111e555f5808@i-love.sakura.ne.jp>
In-Reply-To: <166a8c6d-9928-4edf-8082-111e555f5808@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 17 Jul 2021 23:51:39 -0700
Message-ID: <CABBYNZJpeRmkB6zGUVDJYTLEFvds8z_ag++vC-mT8faig31O+w@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: hci_sock: Fix calling lock_sock when handling HCI_DEV_UNREG
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Sat, Jul 17, 2021 at 11:22 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/07/18 14:16, Luiz Augusto von Dentz wrote:
> > Anyway after all these discussion Im even
> > more convinced that the real problem lies in hci_dev_get/hold, after
> > all references are usually used to prevent the objects to be freed but
> > in this case it doesn't and no locking will gonna fix that.
>
> If hci_dev_hold() calls atomic_long_add_unless(&file->f_count, 1, 0) under RCU,
> vhci_release(file) would not be called until all sockets using that hdev drops
> the reference, and hci_sock_dev_event(hdev, HCI_DEV_UNREG) no longer needs to
> traverse sockets on hci_sk_list.head list. This requires adding "struct file *" to
> "struct hci_dev". My patch keeps changes be confined to only hci_sock_dev_event().

Being confined doesn't mean that it simple, your changes are doing a
loop locking, and I also didn't touch hci_dev_hold because it would
affect all drivers but if there is a way to do it by all means we
should do it, but notice that we do need a way to cleanup if the
device is unregistered so I don't think holding the file directly
would be a good idea since it prevents release but it would also
prevent cleanup, in other words if the process which open the vhci
terminates or close, all bluetooth sockets should receive a proper
error so we cannot really change this behavior. From the brief look at
it I think we should remove the function hci_dev_free and leave
hci_dev_unregister to cleanup everything, but I'm afraid there could
be extra references that are not being cleanup properly and finding
out where could take a lot more time, well even with your suggestion
that could be a problem since we also would need to inspect every time
we hold a reference in the same manner.

-- 
Luiz Augusto von Dentz
