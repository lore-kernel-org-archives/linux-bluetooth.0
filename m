Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A3CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 19:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0314F61050
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhHETcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhHETcz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 15:32:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E996C061765
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 12:32:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e5so8573191ljp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjFG4/UQqJpNvAv5hTtilr5OcRia/Lj0VNs2aHSgNa8=;
        b=PKhM4wKz6MZMRwHN7b17DXXuTw3PAuJksMpMCFUTOuNa0m9ZjKSVRYvcQvzb+82z4F
         /NdgP0kO3qYxWQtzozQ0DeAoCRoqkcd6MTvO47HJ3myXeTmSHPU6rtHJZPIGAESQWU6H
         JsFOseBgb7YaquD3vm2oFq4ewd6wIxTj2BMhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjFG4/UQqJpNvAv5hTtilr5OcRia/Lj0VNs2aHSgNa8=;
        b=ewsd4H4KHFlzuhN0n2lH9Ci1SLaxfFHos79ZIiE4HiN/IdxYh04KMClzALhlxBagsr
         fo6itL2oBhVMaiOhsWU74f9DCN2RZdHi0U6S09tmtuO8Ghf1jVH5UCh4ukcVXjffPkKo
         yrUDizNoOpa3errf4EtTucCc9ZVvVayIGi09PAdDDXGiSThX5ZQQxafMSCufI6wT30oF
         /VWQh9ov7W8w9GrauF7c0jGCpDKEwDm/svL8HncnmQkOW7j09GnT3f8a/GqhCI8+e4Ye
         dhK3n7HOZTCfROWPdPY9tLGWA7/qoS91YsfFNGsD+8w4V3U33s2v0ChEAz9s0nQVD2DZ
         9Q3g==
X-Gm-Message-State: AOAM531pEa6Fs8z275LKRPWENewDCgbQgz/3P+ngdMfq3YCeran7vsPW
        4t9V1DIQ12X1G2FG2Iltru3rUtPIWDKvp5rGTUU=
X-Google-Smtp-Source: ABdhPJwltHa8w2FV//5c7TgnGWtTKf2TBC8DPI+HB8quaeO0DgEK+Nwr+AHyJ8/Chh4+prm49v9NLg==
X-Received: by 2002:a2e:834e:: with SMTP id l14mr4123002ljh.458.1628191958847;
        Thu, 05 Aug 2021 12:32:38 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y7sm601571lfs.28.2021.08.05.12.32.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 12:32:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h9so8577196ljq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 12:32:37 -0700 (PDT)
X-Received: by 2002:a2e:944c:: with SMTP id o12mr4066497ljh.411.1628191957736;
 Thu, 05 Aug 2021 12:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
 <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
 <c8cf9848-1405-af75-6f05-b7b82c2619a7@i-love.sakura.ne.jp>
 <e9e2738d-78a7-1def-a86f-937951d139a7@i-love.sakura.ne.jp>
 <CABBYNZKTWp73VTBvU=5pJLWEUOLZyzr=yyUF5XY4vJA+j0YZ-w@mail.gmail.com>
 <CAHk-=wij50dVyuHwWoLRVkV2S5pXAySGWfxZaswjSzqzqqzQRA@mail.gmail.com> <CABBYNZL-7-XD1=YVgA0M70Gu+8go1CDfFWmXpGOLt9hCvxnC3A@mail.gmail.com>
In-Reply-To: <CABBYNZL-7-XD1=YVgA0M70Gu+8go1CDfFWmXpGOLt9hCvxnC3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 12:32:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHQ_ey86DJrSNsOm3kj9fR3Tp-yP4oA3i2hdoXRX4sRw@mail.gmail.com>
Message-ID: <CAHk-=wiHQ_ey86DJrSNsOm3kj9fR3Tp-yP4oA3i2hdoXRX4sRw@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 11:59 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Alright so we are skipping bluetooth-next then, I thought of using
> bluetooth-next for further testing these changes but I agree this
> should go into 5.14 so Im fine if you take it straight to your tree:

Turned your sign-off into an acked-by, since the patch came directly
from Tetsuo to me, but it's commit e04480920d1e ("Bluetooth: defer
cleanup of resources in hci_unregister_dev()") in my tree now.

Let's hope this closes the issue, but keep our ears to the ground in
case something pops up.

Tetsuo, thanks for driving this.

                 Linus
