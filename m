Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A916C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0964F40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCRXBQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCRXAw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 19:00:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD483C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 16:00:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a8so2751891oic.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiXC1B2YBlSfIpdXKw3jNC+QjJ/tsZ2LUr0TsUpQVE8=;
        b=dhDAfN163oeI5c4Udm4nyOedoA8M6YwWoLI6x99Q6pccybcPB8vs59mX4Ab53oOFBm
         d4M181W5w2WzQwbO3zse9l6KGqBPuVdVhJ3VFEymt6UaHDuzmKQA5fFfvAnT8clYLLfH
         mtbVnA/7zzcE6Tvzy0G8GSpDkUHFOXj6siZsPWFxikBKj0XNVmHffoq5i/hQw1QGfRSg
         GlyxgS5I88lqMx/125crLfxQaHLYz5ePRBZuDDFeUt1XhntNiXjU/sCqREH/o0Oi8NPC
         zTrhluI51TTY/9cnmdiazj14KyxO42n0gJ4LHPfURAaQxojcoIoE0t/oxQk6Fy1O66po
         +lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiXC1B2YBlSfIpdXKw3jNC+QjJ/tsZ2LUr0TsUpQVE8=;
        b=Lfm+FvWucesMdEYl4Og3Fi/sAlQuoTyZv3AReTQMIS5oWh3rKljsiDoCQ5o8nx63kY
         3/hdP7XWWc6K3BvM4NIJFEthCbc2qC3fu70d1Bka/5xGfZ8pbGxNtfVok4n+m8mmxmnW
         T67io4OnzpT9jmGcLd09Ko4FqO701RGhve+pUxPpDUcD1+a7+L94pMpy6FnatBYmyizb
         5tY47473Hw/EqFMBU/LrGNbhUwHkY13dQRjZiIlRKefTbaQvtQh3cERrBPWuuVRlYuXP
         zHfyNImsqNwKPqepApySO4FjH7o8OaGZvzCN9RY6O2pg65aSOcJIiIigxQVSn5t1oYSf
         nAzw==
X-Gm-Message-State: AOAM53123/0NmkZua7iHk+W84QgdoNj+3QfeCl91JY7m+7rbDsBdKw/2
        Rhj4PIx08zKhzZCRklowgbtNl7gkfVJEa2BN1x0khnZrZn0=
X-Google-Smtp-Source: ABdhPJyftXEpAhCu7dQCuak92ivYQmT5gEJeeobRNQarmqf5BCIvW4lmNvZgOfbSmwEERETY7Lq8BYASsbeaNv3HWNk=
X-Received: by 2002:aca:b645:: with SMTP id g66mr4677661oif.64.1616108450969;
 Thu, 18 Mar 2021 16:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210318204640.424409-1-hj.tedd.an@gmail.com> <6053c750.1c69fb81.2f7f1.e27e@mx.google.com>
In-Reply-To: <6053c750.1c69fb81.2f7f1.e27e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Mar 2021 16:00:40 -0700
Message-ID: <CABBYNZLZExSZtj6o_RYstf8OY4SzM+p3jfCRxNKK4GMYa_FwEA@mail.gmail.com>
Subject: Re: [BlueZ,v2] tools/mgmt-tester: Fix for scan response in read adv
 feature command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     hj.tedd.an@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Mar 18, 2021 at 2:37 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=451087
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - FAIL
> Output:
> tools/mgmt-tester: Fix for scan response in read adv feature command
> 6: B3 Line contains hard tab characters (\t): " Read Advertising Features - Success 1 (No instance)     Failed"
> 7: B3 Line contains hard tab characters (\t): " Read Advertising Features - Success 2 (One instance)    Failed"
> 8: B3 Line contains hard tab characters (\t): " Read Ext Advertising Features - Success 3 (PHY flags)   Failed"
>
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
