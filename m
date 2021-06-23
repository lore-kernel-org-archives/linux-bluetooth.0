Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A206AC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C82961360
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWW3R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWW3R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 18:29:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:26:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x1so5453658qkp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RA3qzQG+SB41+eFSbHAqhUBgs8jITPj9EqjqtaF4JI=;
        b=KjmWu5KIPnhX7KRigiNgCGmACpPdi3y/twoFI7QheaLy3urFGrNqC8h9/up0Iz337z
         PkSIqJt8nnXyvfeLpyhOqAc22O7DWuC/4q35Hd2gvRv8vgEzrpvgxeH/87K9HHL8mAMV
         BUdz27VrLlUivWscAAhv6T8dwyVIT/5/rrjrk2dSrBKGf4c4NvMoRVtjAVmcAFH5EpBD
         UwqkrV4Mk+zdNMSV8GJDNh/HKt1Mq2MXQzuskyN6OGCfy399qB/Wy7E2mukwBd1iiXsE
         ddSWseLm5xcw0NDVMdiojlT4rnR0V+Fpu8nsn/j3sPvzvvJG1qeXPXZH68V9IxJmxVbg
         JGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RA3qzQG+SB41+eFSbHAqhUBgs8jITPj9EqjqtaF4JI=;
        b=OiN0IvCXAcoCy0uSIDlr0zXr9PPRraAAuubsM3+LAIDBLnRHd2VYDT9z/PQE2RFZOr
         IHzlaKTv/RYfqTRW/Yfev5D3OhV614ZnciY6v6BfAuW1f4UCC3mYrh1xipwpQIFuIi2J
         0Th9fss+RcShImdyCJM6FRnrRw8sF0iR48WAVa2BH/FKWDK6HkOo2f6BU0iIGijJ6Aqz
         8ICLiLEnJiF0Yzg4V+0fJXN1e010uDPY3EHkHc2L2bPdXxBMfUMY8ekayUS9oK9cDTxH
         YgtQcN1kbk1RVlPLAjNwlbwFMobrI7uvWMemk8xf7q2xmEqjEddpl/rfp5Mqy53XcQxS
         +9IA==
X-Gm-Message-State: AOAM530Un9lkQiluXDpsi6BqW+macAr+vwhpg6IZ9mUfUiN5ZdRGwAT+
        /mzi7XpglpVMQwATHQD2B7EyBGYnHxy0Uzt+bRE=
X-Google-Smtp-Source: ABdhPJwMgcSvviEqnmZ5i0DNAowwef4lDYj1hDhUMNUV6Ky4xYbGgYr2Ah+TJn+lr7mMU9+89f2Ukxn33BhdIWTd9ow=
X-Received: by 2002:a25:be02:: with SMTP id h2mr464797ybk.91.1624487217254;
 Wed, 23 Jun 2021 15:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAG17S_ND46_G0bC00T5K7zhEUE6e9Etab5Re-YrSnsAdqwTp4Q@mail.gmail.com>
 <CAG17S_NcPuvXefSV3Lhb0gjLZWMvTqBbQLSvjY_uKpJvisEFBQ@mail.gmail.com>
In-Reply-To: <CAG17S_NcPuvXefSV3Lhb0gjLZWMvTqBbQLSvjY_uKpJvisEFBQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jun 2021 15:26:46 -0700
Message-ID: <CABBYNZ+irGCqD8JnotVdaTt0c=xVfGomNJu4zct5t098Ahn9Aw@mail.gmail.com>
Subject: Re: Keyboard paring failures, still
To:     KeithG <ys3al35l@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Keith,

On Wed, Jun 23, 2021 at 5:17 AM KeithG <ys3al35l@gmail.com> wrote:
>
> recently upgraded to 5.59 and still cannot pair a keyboard. I posted
> again to https://github.com/bluez/bluez/issues/55. If I can perform
> more diagnostics, please advise. I would really like to be able to
> pair and use a keyboard with my RPi. If it is a driver issue, please
> help me point it out so it can be fixed there. If it is bluez, please
> let me know how I can help.

The problem is on pairing, and since it is connecting over
classic/BR-EDR the whole process is handled by your controller, so I
guess you will need to figure out why it is not pairing when using
this method.

-- 
Luiz Augusto von Dentz
