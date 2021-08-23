Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF6C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9F613A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 21:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHWVEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVEv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 17:04:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08276C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 14:04:08 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j13so15567042ybj.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voXXeLKlFlOLRsbMe7Mju4M35OwX86Fuz1jihyhQPTM=;
        b=Q1+kGAQjivkE1KBQILIxb9/bjS6+eVeU0OyD05rp9KgSX6M4W0aMBnD6QnTY97njIp
         hcsuA4JA0LmqeBWTQUCOShqnkcWnq9DDUs+LK1evZxeM5S730s9E1Hqm4Dn5IIMB4m79
         xLNuwQmdd9S0LpYpxUnLrMRBUOGbSyfSQrMMn4juDKEwZdEgyId/492vRsyuXNieQd26
         ZyqaI1dVvMH/gx61vwnuTi4kfXpXY4lxCK9BnYMVixwtuNjPwbtEBsnaxKlpmySPV4wT
         iPAJ2qhYqMcOrMd9Pbyh65Q8FFET6xRFtIk9CR9I3jrW3u73RHn7USXHYz1Tpnfbyz56
         fQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voXXeLKlFlOLRsbMe7Mju4M35OwX86Fuz1jihyhQPTM=;
        b=fVPKVTbqOHJSn4JvkWXmszxBoUAYDiBDMGrZMJcJbd+mFIIbM5uc077dJKHLcRiEVr
         q3j5/XYLvRZX0MkeYNHG9oZfeqQquG48vfsZwPLpOkfxHZcpAUNrCzxXWs1Q8181/xej
         bYBqiwjBkf5T181C5FzRcEicyyflzl1FQY8kRUlWHVSk130OX4q1U/XULeQk8qHjQGqX
         4eZSgDZni1GmqxMLwlMaABUaCsY670XjMbZySvPdjWMWvD7+5KY7lTOSqa5rIgK5Ie+H
         sUec12nJfZPY3bDdNtsjpCSGnaPl7GBf7nDb+0k1KEG3pj7nmsDXB2sgisohOonv7w2w
         oqpA==
X-Gm-Message-State: AOAM530JDDHYHTXnERo0N7ncGVTPIxHdzRHUuD8Ke128mjYtrahzJbyl
        KGJwwAR77ytI53r2mM9faCDW9qLnpLN+6cgtgdBcQ9cN
X-Google-Smtp-Source: ABdhPJy5ebuj+Iv3A8flhJ4PgIgE5mv34I0v52ROjTTJfB0evQOCKhyGTfl9jap2fNj5z0CehvYRyilK+fMf8YRats4=
X-Received: by 2002:a25:be02:: with SMTP id h2mr47571008ybk.91.1629752647157;
 Mon, 23 Aug 2021 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210722074208.8040-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZKmF7vODFxkDyRwFsTd933mNNB3vwVOCcxsgof_St=ORw@mail.gmail.com> <246902bb-aafa-43bf-bf7c-ff26bfed5be1@i-love.sakura.ne.jp>
In-Reply-To: <246902bb-aafa-43bf-bf7c-ff26bfed5be1@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 23 Aug 2021 14:03:56 -0700
Message-ID: <CABBYNZKcFsk1SroWcP=SVMwFAJongtVG=gc9DK=SoRLvTCOwCQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: reorganize functions from hci_sock_sendmsg()
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

On Sun, Aug 22, 2021 at 8:42 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/07/24 6:44, Luiz Augusto von Dentz wrote:
> > Hi Tetsuo,
> >
> > On Thu, Jul 22, 2021 at 12:42 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Since userfaultfd mechanism allows sleeping with kernel lock held,
> >> avoiding page fault with kernel lock held where possible will make
> >> the module more robust. This patch just brings memcpy_from_msg() calls
> >> to out of sock lock.
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >
> > Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
>
> Can this patch go to v5.15 ?

Applied, thanks. I will be sending another pull-request by the end of
this week which shall include it.

-- 
Luiz Augusto von Dentz
