Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA81C4708F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 03:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E426613E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 03:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCDVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCDVv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 23:21:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93BC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jun 2021 20:20:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i4so6859672ybe.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jun 2021 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtJBBfd5RP7iP2oPG4uMPhDWXo0c0Rcr1wHYucdT8uE=;
        b=NOUhxWdeVO0vZqValuRKPuUxoJeKrB/wSjNMxMQ63MOQogB8rHREd7E2rY6is1S4+H
         OzMjpqwehtqAYWu06C/0nMiFQmfMB7hihCjaQsPXdtMiq6WZZCbbG+IDXnssnJS5KQOh
         sjbG/8YEsk4P5ov/8CVdpUx5r0r0X3AZj377pDUvZubkUl59+21lQYiaLbDHbl+6ZhsD
         Kh9DwUdWuynobe0SAR8c6QT8YGvYLKm/mLkmuy8RDgK/EVNJcjwaZ7qNcfEIaGLj6D+A
         G4zmn2UxjMDAKguJqaHlhRUiH5zRiXlf1IKWBxxYQ+2KVZte11Agrv+UkcbJPbmrxi8k
         7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtJBBfd5RP7iP2oPG4uMPhDWXo0c0Rcr1wHYucdT8uE=;
        b=FC/WhC7fFYqu/QFRS4/fZp7Ds4z7a+ESOmMrnNcleIum3aYkCiXoudPi6qMha7PItB
         tqBQ0sa5QwCqDmK1HQ5enoCLh92sIB6hT4hRGIqYDl2IZDEzazO4CD5sSMTZ4bQ/4cqA
         8xofS/vwQXrplA51gETOTNWyb+nE9OC4b8T92j7MHFT459pnSK/ZwBv6/KQ4MJxVIBnL
         t99rFwBqMPb0c09fmBggt0pVN11PMzeCGbhrTPqQBQPTcXMNPpJLiDPXu2yc+pQ90/nl
         V4EsyhWdcJVuJnGroQQDLeMQCYig0b8osDHuHwLpy2VK8Maoawzt1FjJudYFh0o7H0I8
         t9JA==
X-Gm-Message-State: AOAM531JTnpWjQu3J9zK8g5fR6li4YfMmfwiwag/+OZmMJie5PkLfmsF
        Fd/vU4RAgxfPLPJOk7QqyL/qKeQ9fD/TZLAg9E4=
X-Google-Smtp-Source: ABdhPJyY3VkEGEgsGxMDplKW3GB9Tiw0xN/DXfapVV5wIs9uflMcG0LXp3Ye6rENH/KlxJ+OhgLQFmvWc6RKJ9+mfUE=
X-Received: by 2002:a25:3406:: with SMTP id b6mr51682164yba.318.1622690403942;
 Wed, 02 Jun 2021 20:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJjojJvVPwssDxY-GcQcw0TXMzhEX4RgiNeGWowKo6mKTw13=g@mail.gmail.com>
 <CABBYNZJm+ScxVjVBcxRpUuu+9J8sgyEmrnFaVpVii0FCg3EMxw@mail.gmail.com>
In-Reply-To: <CABBYNZJm+ScxVjVBcxRpUuu+9J8sgyEmrnFaVpVii0FCg3EMxw@mail.gmail.com>
From:   Lin Horse <kylin.formalin@gmail.com>
Date:   Thu, 3 Jun 2021 11:19:52 +0800
Message-ID: <CAJjojJvtSVqw2BcWoDULEF3AqLJN6pguuJUN65PxAL70-rbATg@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in l2cap_send_cmd from l2cap_chan_timeout
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Try with the following patch:
> https://patchwork.kernel.org/project/bluetooth/patch/20210602232348.766496-1-luiz.dentz@gmail.com/

Yeah, I send this email because I have seen this wonderful patch.
However, the crash site is not exactly the same as this UAF is about
the hdev object while the discussed patch is about the l2cap_conn
object.
I will try to reproduce this one to test if it can work.

> If that doesn't work we may need to use cancel_delayed_work_sync but
> I'm not sure if that is safe to use since that blocks the context.

Agree :)

Thanks
Lin Ma
