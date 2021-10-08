Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D160FE3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbhJHVmQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbhJHVmP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 17:42:15 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFFC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 14:40:19 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l22so9569717vsq.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xuW6G4lp4XAe3klxT7l9/J9vDhXT2U7BADelxkJyoM=;
        b=fDo3ClDAoQmGigdHChZcgeArdxazh6s9b7Tw59LsGEEK/iHi4sykgXW6OMq2dxRLPk
         GmIYil2+QRXGtSLAV0dw/oiZvDCzpfBTBeSiOmGQUT20FKDol/OSUMHUCPX2XViJkVfv
         6c996OqX+SxeuOd36dSb59wPvDNzcZ7FntD9xW8Try9BOy6LVLn/de10LBKx77KAC8OG
         nkCesdAH/r1R8gmkIW4JiHhNpqDTxd7khoTum+mmzo1R8aVYiOg+i6d43b/2DB0bRiD1
         Sj34uNsyiNod8JFlwfQlKh0iAkTDfVXrKYnM0k2mfP96rDJYgI9EJPVODfQOvfwm5D3l
         XTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xuW6G4lp4XAe3klxT7l9/J9vDhXT2U7BADelxkJyoM=;
        b=nYCEOMSkoW2MmnjfUIXofcEMKPn5Sh6Bu13Ul/Uvzc6DAyqAM+l1xrDRL2q5tqsl49
         qERQiHZGSsLKsWQJzRtSgkmvdUz+nJU6jOndiuyxzUgELCfvusL/nBsKEQgTDR0LC5hw
         p7TlygQWg/qdUTPuqMI6Q445uGwaB/cxOXa+8YgcV6uDzc167u9mtEZBmzD8Fr3bOgvR
         1Jxsd6APbspV3RMs2Gh6VSIqf9NswkgAXqMWgp7ZW3dLKZ7aa7GVkiS4VgzxOpOU2lDt
         P6bi5KqPXKR0AmyJ3+tIRLP9Qmm3TE9P8DEEOnBMfyymBwis+SIT4l2KCk94fP3jJv3n
         wZWg==
X-Gm-Message-State: AOAM532hBf4P+IUN9Wc4uuHqj8bQtEy3pJ5l61+Q1MWyQurhOKPktzLE
        Y6iMOlgynUzJ1eXiqT9yFQNjQPzogYltR/mXoV1m3wwX
X-Google-Smtp-Source: ABdhPJw2IvOf1wnTv9Fqqhuw4JwaD1yeC3yVhlexRz3j187SEcN70U48nQt/bGJ83X6i8I5Jp93MMKH/qSgFs8YMEdY=
X-Received: by 2002:a05:6102:3593:: with SMTP id h19mr14082706vsu.23.1633729216484;
 Fri, 08 Oct 2021 14:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211008193628.39347-1-hj.tedd.an@gmail.com> <6160a1b5.1c69fb81.114d8.18b4@mx.google.com>
In-Reply-To: <6160a1b5.1c69fb81.114d8.18b4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 8 Oct 2021 14:40:05 -0700
Message-ID: <CABBYNZJPkcjLvHznoqA+cfjZNLV0zd1ytqFTf8Qn+Lvd+Ha8Bw@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/3] doc/tester-config: Enable Runtime Debugging Feature
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Oct 8, 2021 at 12:55 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=560147
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      4.39 seconds
> GitLint                       PASS      2.75 seconds
> Prep - Setup ELL              PASS      40.26 seconds
> Build - Prep                  PASS      0.45 seconds
> Build - Configure             PASS      7.46 seconds
> Build - Make                  PASS      174.06 seconds
> Make Check                    PASS      9.00 seconds
> Make Distcheck                PASS      211.98 seconds
> Build w/ext ELL - Configure   PASS      7.81 seconds
> Build w/ext ELL - Make        PASS      162.27 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
