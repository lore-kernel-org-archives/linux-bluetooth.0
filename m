Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC798C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 16:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiGTQdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiGTQdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 12:33:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B14B4AD
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 09:33:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o7so31150763lfq.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+Skqy11VApHbDh2i1SxJXyqP7HE2KRNsZ79L4bcBco=;
        b=TFD3Vs+Q77c189rq6Mt4srcYLjLjsMP63+gHjHwShb0V/baoToJ41drmbzLfk65V0m
         sPb3uzaCK4ptrMnEg7oAFJm0vBuyLv2YRLMcwwrVIX6Rkc8P4ufVup8QOSc0BvT1Lpgp
         XGKhy0J06zGO7vKH59g8Fkc8c3OM/bxfxXubn599jaay1fb0SbEy8XyWuHb44ije4B49
         GK2yW951mzYeLEH6ZN2SionnUEAjZQ/5WjbNyMnMlRDscC8EZbgdaRnDkvoQJSflE8/Q
         HN68ZwCvcRDovkERF3h7250Ej3KmW0NUc0a49OflIBjIU5K6kxa/7cCkzvVqYUDVHQAW
         2HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+Skqy11VApHbDh2i1SxJXyqP7HE2KRNsZ79L4bcBco=;
        b=sbYIOTGsZpCbYfbd5r85uBCyDnmrWe/eBNrHIeK+H58ZnPTaHHEyy/Aga5hFCs5mY6
         gcwZ8l1ivcjIwSHkL866kopp6iGHE6Fpo+PscMbCqzDq5Zhe7cjgFwjG9l4sGI+Ry2qy
         rHU5R0ZfGZWvICk82y9kEKyhQ3Ak8kioP901h90C/YhBDOy8Zn6EMl6M1POZ5EKFbcr9
         Tv0jKiSh81UpJGZuUN7AF0qqczIVBuKYpMj8Z+fv1wzSt7zM24nyZeEIj6J7MQi6QbV+
         A9C2x9N6UmVqG/PDb2mtqHz79XeV1IZHMLsa64MMzGFSxZH45hDed1ln+CRQ79ox6HiP
         RdGw==
X-Gm-Message-State: AJIora/Y8RCcKRs27vh13lrWztGbzg22U+jp6QI07HHucgDrdo2ldjVY
        XDS4q3tFyvbdWVz8YHL5iB7Qb3F442bu+mXhDgeKF7ioR3E=
X-Google-Smtp-Source: AGRyM1vjjukvUeeaNjkIGgPNOLdWufKAjRlH4QCwD6pZnwsrHonuc4xFEovuzMyoKUogBLV3VX3tEYquBfBEU+Q8XTs=
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id
 bt33-20020a056512262100b0047fd228bdebmr19034603lfb.121.1658334787798; Wed, 20
 Jul 2022 09:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <3f1ee6737f092ae6312a7ae6079d341b81c791a5.1657670957.git.objelf@gmail.com>
 <62cf33bc.1c69fb81.78ce0.cf19@mx.google.com>
In-Reply-To: <62cf33bc.1c69fb81.78ce0.cf19@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 Jul 2022 09:32:56 -0700
Message-ID: <CABBYNZKftYwMtX6WJfcHQZKZRUKszTCmzAxREbiuLk17zv0vkw@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btusb: mediatek: fix shutdown failure during
 runtime suspend
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sean,

On Wed, Jul 13, 2022 at 2:15 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659440
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.02 seconds
> GitLint                       PASS      0.45 seconds
> SubjectPrefix                 PASS      0.33 seconds
> BuildKernel                   PASS      41.55 seconds
> BuildKernel32                 PASS      37.70 seconds
> Incremental Build with patchesPASS      49.91 seconds
> TestRunner: Setup             PASS      620.74 seconds
> TestRunner: l2cap-tester      PASS      20.09 seconds
> TestRunner: bnep-tester       PASS      7.29 seconds
> TestRunner: mgmt-tester       PASS      122.23 seconds
> TestRunner: rfcomm-tester     PASS      11.24 seconds
> TestRunner: sco-tester        PASS      10.85 seconds
> TestRunner: smp-tester        PASS      11.16 seconds
> TestRunner: userchan-tester   PASS      7.91 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Need more context to be able to merge this, why are you using
usb_autopm_get_interface/usb_autopm_put_interface and shouldn't that
be generalized if that is required to handle suspend properly?



-- 
Luiz Augusto von Dentz
