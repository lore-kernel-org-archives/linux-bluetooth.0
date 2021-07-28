Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C60C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D4560F6B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 02:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhG1Cve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1Cvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 22:51:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B8C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 19:51:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gn26so2138341ejc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qYDMs2XTON7ybP+Shj+uBDG328o8Zqfjwf23OOzdTY=;
        b=YSVHuDLc0WZaVrJhoF3EPZU+1q9OplniUvW3dhy3MEwv15E0Hwv0IR3Zjqul1pJHly
         ezlFzuYrtCVZ+NNqWKo7TnpbYj1eS3Vob1GBM/zHX5lYOBnQSD8EXY5hftKdM1y+/PDt
         P1fe201a5IzZbshVOJcRJqlk0m080RItEDsh/8vdPQA4oPxQ8SJVNGYcCgO8Nn2lAcf7
         yItaVP4me4a9Zg5qXHvJz4OrC8HJt7vnqKz3iWowRLA0uUkFKO29RaavlY5dU/uYRM45
         masF3rK6ow5Vh/Sp3EKlHKWJJdSil3GQ2PMxPhugu4fmdDVmaCfmC58RWAUi/ld+SKUK
         +2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qYDMs2XTON7ybP+Shj+uBDG328o8Zqfjwf23OOzdTY=;
        b=mos/aLMKt/Ju8dd0WibSglZuLEt6U67HXIslRbeoskT8cuput4Ytd9vSWnL3rqKCLB
         qHQn4124vHoE5GC5kR0hk36rQInu126kLB/VzkVYqrkyeQ187/TJOgTUI3Jz4Zv7+t1s
         43xeBTSvCLwZ+feP3Cds00fWZ0mJ2sDh05J9UTjtmWlk7EnF5xkWRnVtquSgG1LAwe23
         n2aWKXINyPe8/Z/MoXsOC9FEyoDxWOqkX/SHPJaCa1fBMHtJoo0WrkEVoCJ4FqCIsyD+
         Oamizvl1QnxxKd3gXqCvCzyY+csAa3WdKbv4WwiKV2+UZSh6xW2WOVM+BzeN1OulUeYS
         ZgKQ==
X-Gm-Message-State: AOAM5335shRboRzgIUd+iR0LrgOmLDQLM4b2UpbX7B29KZWr6xApUHhp
        s143t7KjE299XmSYs4i1l181LgWUfhaaxcy1Z5Bt0g==
X-Google-Smtp-Source: ABdhPJxs1E0tefRni/yZpNZaekHsW4o1zmI/QVlqoNrRwz9qQm4X+vWL3SzzQzcSAdBuYMnDkAnDd85b+M/L9AepRq0=
X-Received: by 2002:a17:906:8a98:: with SMTP id mu24mr13389735ejc.404.1627440690910;
 Tue, 27 Jul 2021 19:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
 <CABBYNZJkvaeuMJLKXueoLKq7hXBskxYSPbGujHEj72=qfF4+DQ@mail.gmail.com> <CAPHZWUeCGeu+gpYkfhMUKxXGMPZY0ZeKTpHDO-QcCvhwarR0dw@mail.gmail.com>
In-Reply-To: <CAPHZWUeCGeu+gpYkfhMUKxXGMPZY0ZeKTpHDO-QcCvhwarR0dw@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 28 Jul 2021 10:51:20 +0800
Message-ID: <CAPHZWUc0wHLVTSFGzEYWjE-3f4JyKyXtYem+wBm11K3kxn3pQw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt-db: fix service in range check
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> > >                 if (svc_start < foreach_data->start ||
> > >                                       svc_start > foreach_data->end)
> > >                         return;
After discussing with Archie, if we understand you correctly, we think
this early return can be removed.
Let's say the searched range is 5-9 and the service is 1-14, then we
should consider the service is in range.
If we want to keep the early return, svc_start > foreach_data->end is
already checked a few lines before, so this check is redundant.
