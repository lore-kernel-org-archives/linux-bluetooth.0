Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0414460F01
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 18:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhHESqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbhHESqC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 14:46:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F85C061765
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 11:45:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u13so8392139lje.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1UiKg7BIMXMZwU9fqC4exfCa4oWQcgseBNAvOD5Lm4=;
        b=UCUQWj0XQt6CAWxqx1eEABIK1os7tmbpAgzhXNNDF+r4cMYPDZqhyHWqibFecHdVqo
         BQAla+GvkZ2B8DlPIgD46PF6maxq9HQY3ZNa5Xeh1T5LM3e+chPHURl1Xg4iJhuqDBiJ
         DwfQ1dyT17cNShHovH93j+r7kjxmkr/fJDXWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1UiKg7BIMXMZwU9fqC4exfCa4oWQcgseBNAvOD5Lm4=;
        b=nZzfCFS3EqbRS547CCCcFaPF6XCnnOIW5reEmyWgouNxakeST/noEb/w7e8GVSgeZn
         vPeL7ZxZsQ8Rslwbv4RAoEVCSx7Z0b2MOvmp35nwPH7CmF1l7BtFkaQW8BnOkm64XjXU
         zzw9EbbNy454Qd1wN7smO0QFzHooiEyY5kdD++4MkwLWPzln1llVd/ZoYi4/yYKVqxsK
         19ozB6uQvxqEgUwo7gfJp+IOBpiThkkyVgodrr6KjDzdewg6QJeRAGfbLW/Dqq7INBGO
         1PIR9V+IOpnTlivt5RYzywb3jz+joqSb9NRMtuyTiAY4FXWVfZmt8Oz93ou/agpqwiMq
         6cvA==
X-Gm-Message-State: AOAM533jQTF8tD1JalGVbGQ9k5wiOIM9ZA5t8H6Q8LsylE6HLtzcu4/V
        v7FxjBZkGEjXJZXrF9h65F2ZEg8SCzjpMrNrSCk=
X-Google-Smtp-Source: ABdhPJyPYxZRRB6nyIFJ2d+bV3vTXLuJLVHQkLH5AZq0dxur7VG0eP1k62JWvKa+yZ5mFdgMEF2kRA==
X-Received: by 2002:a2e:151d:: with SMTP id s29mr3946769ljd.55.1628189145918;
        Thu, 05 Aug 2021 11:45:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l13sm217247lfk.77.2021.08.05.11.45.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 11:45:45 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g30so8726401lfv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 11:45:44 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr4582122lfv.201.1628189144317;
 Thu, 05 Aug 2021 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
 <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
 <c8cf9848-1405-af75-6f05-b7b82c2619a7@i-love.sakura.ne.jp>
 <e9e2738d-78a7-1def-a86f-937951d139a7@i-love.sakura.ne.jp> <CABBYNZKTWp73VTBvU=5pJLWEUOLZyzr=yyUF5XY4vJA+j0YZ-w@mail.gmail.com>
In-Reply-To: <CABBYNZKTWp73VTBvU=5pJLWEUOLZyzr=yyUF5XY4vJA+j0YZ-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 11:45:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wij50dVyuHwWoLRVkV2S5pXAySGWfxZaswjSzqzqqzQRA@mail.gmail.com>
Message-ID: <CAHk-=wij50dVyuHwWoLRVkV2S5pXAySGWfxZaswjSzqzqqzQRA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: defer cleanup of resources in hci_unregister_dev()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 5, 2021 at 11:19 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> It doesn't apply to bluetooth-next, could you please rebase it.

If you're ok with the patch, I think it should go into 5.14 - and be
marked for stable.

The locking right now is very wrong, and causes syzbot warnings and
probably keeps people from finding other things.

And we can't just revert the incorrect locking change, because it was
a security issue.

So this should go in the current release cycle. I agree it's a bit
scary - not because I think the patch is all that complicated, but
because this area has clearly had issues and is subtle - but I'd
rather do it asap and get reports on it early than delay it further.

            Linus
