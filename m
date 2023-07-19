Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB8EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 08:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGSIpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGSIpX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 04:45:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C506172E
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso6158e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=Shfd+XwM+ukB58E8y/z8euPhlM+SvzoOTYSs6aINdGFcivqnZsETWBhPWCQIfabh1+
         ixRB7zSx6pOpNIowU2P30GYQm5Wwb97ikG+XbEaaNP+T6GL562JY0N0Ce5y2zR/pfkiF
         L/otFKwsLEHDB2Pp5lCN/TGKEZzQ9npdeY9DSXZeCDvG8yPk9SYtT4WC7wonBWJPQ+yd
         j0hsMO2acZ5Sm70zmtbKHynIg9QiwD7weWGFOkfrasA/3NWRGIFNYz46mM7fClKvuLlk
         mHAqFEuhCsm1JSKkH3qvy+iXVHkFjSIcAEm3sZvUpBe3ruQ/wSDjYccFvINIwTUfI/su
         v3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=TEqozyZKk/dl31ePkbdoSxLlNBfGFsGeO7TFkq881a8tExcrWIACzS8+/0pOof2AKC
         gq8tG8lVvCWH3iAY2zjX54EYSULDKwa0YzoedsTszPmHFuBYh+PLKxIPX/35Q6nMWXEy
         9YtDA0pMtQXmlXVdgN6AghAAUV03Y7rWBmznXKzC/kvGuQrmLquYVEh10GXWFavExePi
         n3mmFBjbPseRx/wnglhGSc7Y+lkmjzw8pb8ohloIJF5rz2EYF62HnZVlItUVbi67oqi+
         TARDs73eoAG+IkzM00+0TIkqskMSe6g8TXK6Pk5utz1gUmWVv44ehxmb7JH8b6HFQzW9
         Hgrw==
X-Gm-Message-State: ABy/qLZcR56WC29jC1O7l1H1Aqbf+HyeeOKUjhfkh+hjQ2aU18AtsxHR
        XlzWNQB2MD9zhaHNExS0ioDUirusYV01Yj6uB7OQtw==
X-Google-Smtp-Source: APBJJlHLnwRtT8dY4p/gFDWF0KgvHLNMG0seYCvYQfXnGLLU6blkTWYuxyClSv9V8XvEISNEZUh5P+X8OHVF+seMG/k=
X-Received: by 2002:a19:7018:0:b0:4f2:632d:4d61 with SMTP id
 h24-20020a197018000000b004f2632d4d61mr166153lfc.6.1689756319638; Wed, 19 Jul
 2023 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000049baa505e65e3939@google.com> <00000000000077b5650600b48ed0@google.com>
 <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <20230718124548.7b1d3196@kernel.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 19 Jul 2023 10:45:07 +0200
Message-ID: <CANp29Y6T2sKnnTGtotraCX8saAUw1kSUhS-be=3GM_t+szZ-3Q@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>,
        davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 18, 2023 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit d772781964415c63759572b917e21c4f7ec08d9f
> > Author: Jakub Kicinski <kuba@kernel.org>
> > Date:   Fri Jan 6 06:33:54 2023 +0000
> >
> >     devlink: bump the instance index directly when iterating
>
> Hm, don't think so. It's not the first issue where syzbot decided
> this commit was the resolution. I wonder what makes it special.

Judging by the bisection log, the commit fixed some "INFO: rcu
detected stall in" error that was also triggerable by the reproducer.
Though for me it's not clear how exactly -- at least the reproducer
does not seem to be interacting with devlink..

--=20
Aleksandr


>
> --
