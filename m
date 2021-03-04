Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD34C4332B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFED64F70
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhCDTmn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhCDTmM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 14:42:12 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFADC061756
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 11:41:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h10so17773891otm.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XG5if/1ISz4cZtLblUM3u7CxRnHr3zS2IiMkkRLcbBs=;
        b=tAnmBcoD0g4L/BDgOinBvJ0+JtLMXkpR98MBn6rMLfdWB0l+Ato2CgPzgtg9xABp3b
         p79TJ1u1D4sDM3NQe3dd7xlJnZJUGAWbUQg40ip7oGijcskvqKMrhu6iV9qVeo3WZ2JI
         D9NWWJLZC56qOnxhnFKETSGTyfpu55BoZKJGR9IRADBCVFC9Ki8B7fmHPl11zSvq7qLM
         cCJTiqbVeTzIvc6RBRA6rd0l4UMBMbXLqGRVdnVrmLh0Gnp+eDEh37kXqmehKtpA2d6A
         CxbTwv5UYay1521ZacVCgwYgJg6OqCDY8kvdjjznv79vca5LamaFyxz6TH1fX2luqNQo
         fT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XG5if/1ISz4cZtLblUM3u7CxRnHr3zS2IiMkkRLcbBs=;
        b=i/H0KX3PPxKfAQojdidH3FbO9v6RnMC54xKhtbiNoJVfwA1+gYQ7VgebvMsW8iKJew
         78DC6Cz7Lgz4F+7509z1e14/cX58sXOwYun902wdziXRMyHMeIaBaUdmMZD5VomzJS2e
         2Hbqb/DKCOGUIvymZs5JjO7tI2rZUn9qZ0VwdzgjQY9QRUXHvYwz5heA1BOcz8ZT4Py9
         p+Q87dhyloeg0MNmnTZ82dQbZ/EmiHF9vAuWro2D3EZv3G/JHn/x3tV3btT5ZqWtQ4nE
         StSG907+D0oYuyOBy4H+2sqQIX3K5wC2aO8osAsCB7L2bSZT5HgcAY63UPHOfI8tRqAN
         2UFA==
X-Gm-Message-State: AOAM532dEj9rPHdRhxsnsIzOJWpBzfKnEQ/c04e2VQsIn+1aQjszehJt
        QJtNR2OCVd0J0Aovk+Cs6aarHTXOo6/XfaIpsO9rihy4VWY=
X-Google-Smtp-Source: ABdhPJyo9pLndqlqu4IR715ylgmILT0M9bnqRMma6wPh5Uehak1xRR98t5S+d8nh0xyhtOzbZEIWjarMrD5HwpPXqho=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr4794563oto.371.1614886891762;
 Thu, 04 Mar 2021 11:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20210303002944.3444644-1-luiz.dentz@gmail.com> <603f9264.1c69fb81.f6ea8.c865@mx.google.com>
In-Reply-To: <603f9264.1c69fb81.f6ea8.c865@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 11:41:20 -0800
Message-ID: <CABBYNZLnOSdFmnwQOoUAFGZd4CPZYKa8WwCSv4SxUcX+SyJehg@mail.gmail.com>
Subject: Re: [BlueZ] shared/gatt-server: Fix not properly checking for secure flags
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Mar 3, 2021 at 5:43 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=441167
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
