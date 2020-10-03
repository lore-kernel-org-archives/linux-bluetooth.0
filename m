Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E49CC4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08004206C1
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 18:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="D1Kqkh+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgJCSLy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgJCSLy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 14:11:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848EBC0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2020 11:11:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u3so2876218pjr.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2020 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TH7fiZp1eWHMSloLv6SwCJvLezTUHxZ5PrMX/bw7ik8=;
        b=D1Kqkh+pSSc/UJ3v15JSehN4W7epH2tDtScWY+nR7eAxMblEEszvbxdyH+S20w2Ix4
         j8nOHjzbp5A8IwbWpxpHqq7wczcnovZbdxPrnGCYyNHqwKdkVcD2SQZyQEkak58tZrYN
         /etpmSl5boyTcPmitjEzmN7IRvJ2g+0qY/7bslBK/DlqaqwX1WV2815kAOY449jbpT25
         /8JUe4Is61oNZPrMJ4FE0FrbEYu3Ivs0Ud2ACJpLEPcyXrqa1s8Q1kQ9y0nYiAk+QiDY
         1nY0VyNZxRvAZeuUoz+znp5UJQ5ckAxSTGM1ZG8zbk4QMP1Kt1+m2+XRhZIU4EI4tFTM
         JWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TH7fiZp1eWHMSloLv6SwCJvLezTUHxZ5PrMX/bw7ik8=;
        b=hPPFYZjV2WkYhappehepyC+wFwABvazmetfr4CO3X3Zgs8QYzffs/xshpJaOQnp6Lr
         vEK3M7diTp6vJz+0CQvVCAZFZDLVqV2Sl4UtL9VBrN8y6+N9/eh7uWbYL97i6VnsV66z
         34q2R+I0S/03sEBj4+Gc9/Ra5FRLWthMFD9TCKVa+HcnR/bBhVuUiIWgQBOnJGDU5ohe
         Ouk87j/NXvyi215wf83xpo7ArSDhiD9wAq1o/D7RfWDnfNpzQskf9678qXgvJJmaEz8t
         YnP7COJaxugfij+9jrWosyaTg5qYIPjd6Oq/iGLQWa3iRAeFCuQRhN4qFmwx7t6Etjxt
         MCIA==
X-Gm-Message-State: AOAM532WQw9y9abju00RUerG+qGVttbgNzlroWVyPMHCGGl+hJixoLdO
        veHtAQzxsMpTVlYymhkrwVyUWNkyz7IPhfn2YMqVMyCRiskQsA==
X-Google-Smtp-Source: ABdhPJxjyYxWmmjaK6nPCSdt2FOWdTaaOmeyuvMs0hmKTKAn7DCL/qTSGyovPhoeXI/Tt3J5kvXED9SGmA9gxc3jyGA=
X-Received: by 2002:a17:90b:797:: with SMTP id l23mr8364710pjz.176.1601748713894;
 Sat, 03 Oct 2020 11:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200928192002.22733-1-machiry@cs.ucsb.edu> <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
In-Reply-To: <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
From:   Aravind Machiry <machiry@cs.ucsb.edu>
Date:   Sat, 3 Oct 2020 11:11:42 -0700
Message-ID: <CANozA0hYY6M_We73Zummfodk_g1HhWsyHiLP8Gw17rR+X89dpQ@mail.gmail.com>
Subject: Re: [BlueZ] lib: Replace malloc/memset(..0..) with malloc0
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Gentle reminder!

On Mon, Sep 28, 2020 at 12:30 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356715
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
>
