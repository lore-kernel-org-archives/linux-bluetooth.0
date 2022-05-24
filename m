Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 23:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiEXXmx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiEXXmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 19:42:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972F6D39A
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 16:42:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3590538pjg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLUVYqYHRnzGASa+xEa0kNbzG+5aKTi4kEy4BTKnH7Q=;
        b=KKbkzFxiYbPyTUYn+tS+VTzXMIY+fiqcQ8YitcBmyjt/9mN+RUwOrPnGUbgpSsoL1U
         BkKx3QiBmGGf5pW4ckOT0up0i+UnqmmjVSX/sfREyQBEas9ypM6YnRlmUPngGGE8h6AH
         F/oopUe7MuXlZ8IyiblAfOOl2/C1xOimx7Vc2sx8bkeuPDOd3Netl86mFC1mc8W6xazV
         PGBWSvwJeFyxDpTtcys71KKufpVPPVcKGBZY8DzannkzmovUWXAgDp7y/3l9U/PmmBE/
         eygn44v6RCiVAjBPrzzHAnC0nbK3CCr5rsTRss070PoV9Ej3b5Dji+MKh+vR6ntEJhyu
         6BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLUVYqYHRnzGASa+xEa0kNbzG+5aKTi4kEy4BTKnH7Q=;
        b=2MIj78QcDRsnyesFlYPLPxpQaaOLNUXTOq+iIiKpbSzGQap+HDykLU73CAMqrGa/EO
         jOLiCDb4P47QDhTS/GzRzjeTS+nvP/yUYe05m54YFaVBYZW/GLDuWz8a7d/Hy8AmFgJw
         ejMG07djAlHqLOTYS4t0feSR84wwEJLdN//29ODn8y7U2L3W5N6s9m/YR99xmFAmvR9O
         vMfuNzm2Dy6ta0TFEIYH814Tqhy4rDa5KRzwaMGXcYMdgA0IcnVURgzwpe3hCsbwt70p
         HgMLMbDpYkZ86+cYbUcwiS1x2krPPZHYm3JianVaPrv+Nj43JBhhPHQ+jYf15UaTxFoK
         cZng==
X-Gm-Message-State: AOAM532v5kF3M8WqYjst1BBNv+UtVc1mIOOy2jrRvwylFkNcGKxGuyRI
        7ofV7VQdLHNb33NV5gM3Jg7kb36F+Yc5oF5mJGRGLvlI
X-Google-Smtp-Source: ABdhPJxMPeWmeMbwfLWNEqQUV9K/hMNGJTrEZI7MwiGoTMmGsiiS/rqFIM3Qzt+3172vts5hcc8j/w9iI8RGe5yMqRI=
X-Received: by 2002:a17:90a:3cce:b0:1df:8f80:ef7a with SMTP id
 k14-20020a17090a3cce00b001df8f80ef7amr7286993pjd.4.1653435756728; Tue, 24 May
 2022 16:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
 <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com> <20220524142128.01acb75a@hermes.local>
In-Reply-To: <20220524142128.01acb75a@hermes.local>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 May 2022 16:42:24 -0700
Message-ID: <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stephen,

On Tue, May 24, 2022 at 2:21 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 24 May 2022 13:55:57 -0700
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> > Here is a tentative fix, I do wonder though why you were trying to set
> > the name directly and not using the likes of bluetoothctl/btmgmt?
> > bluetoothd don't seem to bother setting a shortname so it is probably
> > not reproducible with it but btmgmt does:
>
> Not me. I just forward reports from bugzilla.
> Any networking related bug reports end up going to me, and I filter/forward them.

Sorry, I guess we should forward this to Tom then.

-- 
Luiz Augusto von Dentz
