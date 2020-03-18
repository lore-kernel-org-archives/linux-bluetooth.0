Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E3C5ACDA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618EB2076D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmMiRfPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCRMlx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:41:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52873 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCRMlw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 08:41:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 11so3174772wmo.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyuIk5ru+vxMQ+luek8J7yWtiEyJHc8Og658+Ky+1FU=;
        b=jmMiRfPrn0mWadSDoBmcsi2cKioTKejLUjsdXCnYjD60bCmPM8D1p4zhyk1PFnrYLz
         enBPJ5VYHVx2JQ74Uptgt9zxdbWxhmi581vkG12yHAEAdcdOZExWhOOt3AVvwsxA8RhB
         tOs3A5HsPEfmVzrb9Oe4XFQ2HeBhGLAnZXf5/1muLQtzVjdJjpe+z74aZhH702T4wN1v
         cV03bQh0x3Qvq53r6+4+wqLEzdICsx4RgH/qMYfUmIsFhA6pPQ34VJgmz0avJK6QDkTo
         IPywcJ0YACrIpiIWEzg+2J3wnie1QZzZD0wpeynf0SNtpV2u93nfRR7zFfX+MALf6441
         hXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyuIk5ru+vxMQ+luek8J7yWtiEyJHc8Og658+Ky+1FU=;
        b=MuwG3kmo1JfrqWefR0uujWHJ+gWPoqyrnSI0Z7RgXsvdXDzIm5tlqU0iasNm1zk4EZ
         ka/UFDk7U7xJTwg1EBgU/0+LpHLMDW9LC9I4oA5wVvJKW7fq0Vxwc5kbq+ivkKPKfBW7
         yBe37EGqDm7LntFWGV3Kp6icQEeoxFohr+Oo623ENHLj0usoHDFYMq1ZSOqxVKOlMq9F
         Wat0YFwVAK3xsAcbPdxsKtMgtAss1fYXFjV5pYSU0AJyZBWHj0P3cO+Avp2AujRRwaPQ
         u+TsT9I/gZ0aUICy9XpBPYi9Cooqakep++CrZtQY9Xa6WLOc3wfBaNPRXhsoMdNLzhRW
         YPOQ==
X-Gm-Message-State: ANhLgQ1J1pnbuxThcVugvviG8E7VfQXfcAwkyFsxQTc5uUKmvYZy4cMj
        1JcQTJGvoktK0We1teciCaCKjhorV+inFwJrAezIhg==
X-Google-Smtp-Source: ADFU+vspu/C6Avt/tND+kap7M/lZ/oTSqRK+EaaP9XgfYPMKJVlAwBXEjr0+crvlEzYdwMP39lnTgbOZ2iROy36Yc1w=
X-Received: by 2002:a1c:456:: with SMTP id 83mr5135955wme.54.1584535310089;
 Wed, 18 Mar 2020 05:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
 <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
 <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com> <14E46BF4-0688-4A0B-AE84-46C4426C5E9A@holtmann.org>
In-Reply-To: <14E46BF4-0688-4A0B-AE84-46C4426C5E9A@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 18 Mar 2020 20:41:38 +0800
Message-ID: <CAJQfnxELMMDa6nbxRUrW46VjEBj6Txfeym62PKi+R3iXHKU0CQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> > I see, we shutdown the socket immediately since the socket API itself
> > don't seem to have a concept of disconnect syscall not sure if other
> > values could be passed to shutdown second parameter to indicate we
> > want to actually wait it to be disconnected.

I don't think the second parameter matters, I tried every possible
valid values and intr_watch_cb is still called without waiting for the
response.

>
> in a blocking synchronous system call world we have SO_LINGER for that. In the world of asynchronous IO handling (what we do), we need to check what is the right way of handling this.
>

I spot this piece of code [1] which utilizes getsockopt to query
socket connection information from the kernel space to the user space.
We can use a similar method to query whether (sk->sk_state ==
BT_CLOSED), which is only true when we get the response.
What do you think?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/l2cap_sock.c#n476
