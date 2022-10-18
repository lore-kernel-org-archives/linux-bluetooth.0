Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJRSg2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJRSg1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 14:36:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACC9AF8D
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 11:36:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o12so15617572lfq.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zeG4ZtXz0SAXZv7+iqYkGWnJMvai+EMsde99OmQ3RfE=;
        b=j876EPzfGE/y0w4dX61e3i/pd6eM0HP9/BJrs3WXXHQAujZKVvhVGtWzEswWvylIvO
         zOYgGKQKv3Dp7sVHwu94UvAFgDXkYYY8ldAFf37fDR+2+3hJGXBneqi7AG9MoOE4lXcs
         YTEnjwb9kUgY20emhuOQtPCn9HnI1oaIg44Nfkktl8FZZ9lyZPBSVuwHGc7BzNL2IlAp
         jAeiWgC3steaZNnzEXRCYJeWXp7s+S1EHtj8LDZur1gnD1tWmyMoVduSf9u/7shiomNd
         RwbLtI3SqKp2al2uLjD8WFUZJNtD9ndORB8fIRU5nNj1EiwoDklXDEhnYMRyz2b+uPDJ
         e2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeG4ZtXz0SAXZv7+iqYkGWnJMvai+EMsde99OmQ3RfE=;
        b=jqe9X2qSqq3w6heemQd/3tpbZrFDT8lft/rPU7VETeKwP0Tr8LyxwBDg9vXgfdHSgZ
         qh29YkBGDJl5oaI8z8U162LougAFwDjrFzBTlOl2lfkQIWXT9gPWEhbZjn1fwGAvy008
         GfQOoeq5rAHprZlXzuoPNHEwfHP5OWPATinGLGU+ghuV1Nga3qQahKDFFmV8bPnqVEjH
         L87TL/3XUhUFVCpxRfcFjG71J5oZZdeYF4KhKL0yuOy6+i+NJfBgI7zhc0IXKDv9hVvL
         G7HkNgRA8P0ogtfZIi1KHdYu68V9UaO4FYFY/sZS+tj+hrTmZD3HNDhxXNk62USl7X1i
         e+zw==
X-Gm-Message-State: ACrzQf0s+NFUQHfmUM0ta77a4Vx2A3dlKHiPhjobk16acpqFagNszYuJ
        aTWe96iHjqj7TQDQsfzjrlwktnRhotYF1j4UpzEnAbvz
X-Google-Smtp-Source: AMsMyM7Xm/POucHYfMjuSefBXPmwNTOlT92q6eENFwNgIfTktgDxR4hAsPsneZljxCJJSgXASJxIMnxqIUb4nV2te1s=
X-Received: by 2002:ac2:5f56:0:b0:4a2:40f6:266c with SMTP id
 22-20020ac25f56000000b004a240f6266cmr1437959lfz.564.1666118184132; Tue, 18
 Oct 2022 11:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221018173050.581812-2-Igor.Skalkin@opensynergy.com> <634ef129.630a0220.c76d6.fb34@mx.google.com>
In-Reply-To: <634ef129.630a0220.c76d6.fb34@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Oct 2022 11:36:11 -0700
Message-ID: <CABBYNZKq=wQKs1m2jbL=EgQ+WxuTLGT7RuNmJGadhbVQKgh=cA@mail.gmail.com>
Subject: Re: virtio_bt: Fix alignment in configuration struct
To:     linux-bluetooth@vger.kernel.org
Cc:     igor375@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Igor,

On Tue, Oct 18, 2022 at 11:33 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686388
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.21 seconds
> GitLint                       PASS      0.50 seconds
> SubjectPrefix                 FAIL      0.33 seconds
> BuildKernel                   PASS      43.15 seconds
> BuildKernel32                 PASS      35.30 seconds
> Incremental Build with patchesPASS      57.19 seconds
> TestRunner: Setup             PASS      670.92 seconds
> TestRunner: l2cap-tester      PASS      19.69 seconds
> TestRunner: iso-tester        PASS      20.41 seconds
> TestRunner: bnep-tester       PASS      7.48 seconds
> TestRunner: mgmt-tester       PASS      125.55 seconds
> TestRunner: rfcomm-tester     PASS      11.91 seconds
> TestRunner: sco-tester        PASS      11.23 seconds
> TestRunner: ioctl-tester      PASS      13.98 seconds
> TestRunner: mesh-tester       PASS      10.32 seconds
> TestRunner: smp-tester        PASS      12.00 seconds
> TestRunner: userchan-tester   PASS      8.77 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.21 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> [v2,1/1] virtio_bt: Fix alignment in configuration struct\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatch: 'From: Igor Skalkin <igor375@gmail.com>' != 'Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>'

You probably need to configure your .gitconfig to match your Signed-off-by.

>
> total: 0 errors, 1 warnings, 52 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/13010854.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: SubjectPrefix - FAIL - 0.33 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
