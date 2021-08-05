Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72515C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAA160EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbhHES7o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhHES7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 14:59:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97DBC061765
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 11:59:28 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z18so10697623ybg.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HX+fCs1ChmCe5rrg/UHyLAPlfDvZLlkS69G8xb69ZX8=;
        b=qx4+IONOOAQPQE7Jjr/qohPAOJYWNhuMq2/IxKOcfzAELZ5H+Kho611jtyggElX3qy
         oKfH1U0Vn7GiZgpoI/6TqgR/l0TktAG7GX7HETZM4KXR/45eAe1sDWVA2JxR3kFj6Rj9
         rZsWw42qn09EKkOekdWvIW32gPzo3OdC9DnoPVRdq9IV478EXYcoDqlDI8rP6K7P4qPO
         SgWOMHeGZ90uaZRvrL+fICw1LZp9V41+1XuSpZGx1Uto9ufzLZ82owZpQAT/LbLDnT8R
         HQeAeCR/xKQs3AnduNue/lIG2qDlZvHl9JLwwtDvHJEO810EFGyorOMDiCtepb5+rILg
         DiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HX+fCs1ChmCe5rrg/UHyLAPlfDvZLlkS69G8xb69ZX8=;
        b=Xr75YJ9nef+CVbZx0H7DVNHrgVzXMxeiOHNCwFpZsKKI8G33HYtWMIX9OtKpqJEWqV
         fxZpKz0o+5YxYvToRjJNcG619kf1SI1GW8HLaXECsHnC77ZaQFmbX6MzFyQRiKPFh5Zx
         G2WMKJxGU2FE68WFIsXoRnnLU+iOsP9Dl/8TbwnAdaNuzZ5j4iVKesD8lDwsx/hoqhVv
         ZsVX5+5qr/GDpkfyktaX8gKxYG6q2zX34Niy+IdZN4sUZK5zlSjKlZrwNC/6/alxgUFT
         zKYtFKrgQv/KpPoPxgviQqikE4fGSKHkdTA7Kztcjauph8vtWYTooahw3MGOEmWMozKf
         66Ag==
X-Gm-Message-State: AOAM531yXBINWswesj7d/9tcWc4+8PkrrHLlbqFiO0T/pHMQ7m/MZ6qm
        9Ijz2cv4zcoO+kDt5nNRMnMLqvBraSZXntXt3aE=
X-Google-Smtp-Source: ABdhPJyZZHdyZ0MAE1KBs6napnFAASJO0eAl4ygiLTRdQpR8aZwv2XEIf7DLY0LUBU3QzdF2vh7CW644lqrLMhrtaK8=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr978225ybh.222.1628189968078;
 Thu, 05 Aug 2021 11:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
 <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
 <c8cf9848-1405-af75-6f05-b7b82c2619a7@i-love.sakura.ne.jp>
 <e9e2738d-78a7-1def-a86f-937951d139a7@i-love.sakura.ne.jp>
 <CABBYNZKTWp73VTBvU=5pJLWEUOLZyzr=yyUF5XY4vJA+j0YZ-w@mail.gmail.com> <CAHk-=wij50dVyuHwWoLRVkV2S5pXAySGWfxZaswjSzqzqqzQRA@mail.gmail.com>
In-Reply-To: <CAHk-=wij50dVyuHwWoLRVkV2S5pXAySGWfxZaswjSzqzqqzQRA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Aug 2021 11:59:17 -0700
Message-ID: <CABBYNZL-7-XD1=YVgA0M70Gu+8go1CDfFWmXpGOLt9hCvxnC3A@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: defer cleanup of resources in hci_unregister_dev()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

On Thu, Aug 5, 2021 at 11:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 5, 2021 at 11:19 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > It doesn't apply to bluetooth-next, could you please rebase it.
>
> If you're ok with the patch, I think it should go into 5.14 - and be
> marked for stable.
>
> The locking right now is very wrong, and causes syzbot warnings and
> probably keeps people from finding other things.
>
> And we can't just revert the incorrect locking change, because it was
> a security issue.
>
> So this should go in the current release cycle. I agree it's a bit
> scary - not because I think the patch is all that complicated, but
> because this area has clearly had issues and is subtle - but I'd
> rather do it asap and get reports on it early than delay it further.

Alright so we are skipping bluetooth-next then, I thought of using
bluetooth-next for further testing these changes but I agree this
should go into 5.14 so Im fine if you take it straight to your tree:

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


-- 
Luiz Augusto von Dentz
