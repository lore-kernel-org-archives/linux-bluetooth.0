Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025AC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43563613FA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhEYOXV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 10:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233663AbhEYOXU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 10:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D53613E1;
        Tue, 25 May 2021 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621952510;
        bh=z3lzzp3wg+6gXiNJKwEp7FgqyJAXq0aFNK9P0DVeFoI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VQgWT6qL5kmaNsCnu0FpO+/Ar2IAcGmADZdCaLmZYg9Y8edqzNluIuXF1SplgShux
         bh90ydGA76VHlasW5F9AtBmatw3D7HO+ngRT9AFQTq/P4yl4Jg80BuZwZ2vHyiW1+G
         Acjln6cZHEaCq9dANWZZ5ZCjc4N7d/9cyn85dZ0g=
Date:   Tue, 25 May 2021 16:21:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [v2] Bluetooth: fix the erroneous flush_work() order
Message-ID: <YK0H/AyoPWZwNZbu@kroah.com>
References: <20210525123902.189012-1-gregkh@linuxfoundation.org>
 <60acfd67.1c69fb81.ff72c.cc6c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60acfd67.1c69fb81.ff72c.cc6c@mx.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, May 25, 2021 at 06:36:39AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=488173
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      0.77 seconds
> GitLint                       PASS      0.12 seconds
> BuildKernel                   PASS      529.82 seconds
> TestRunner: Setup             PASS      311.54 seconds
> TestRunner: l2cap-tester      PASS      2.46 seconds
> TestRunner: bnep-tester       PASS      1.76 seconds
> TestRunner: mgmt-tester       PASS      26.34 seconds
> TestRunner: rfcomm-tester     PASS      1.97 seconds
> TestRunner: sco-tester        PASS      1.94 seconds
> TestRunner: smp-tester        PASS      2.03 seconds
> TestRunner: userchan-tester   PASS      1.92 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL - 0.77 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: fix the erroneous flush_work() order
> WARNING: Invalid email format for stable: 'stable <stable@vger.kernel.org>', prefer 'stable@vger.kernel.org'
> #26: 
> Cc: stable <stable@vger.kernel.org>
> 
> WARNING: From:/Signed-off-by: email name mismatch: 'From: linma <linma@zju.edu.cn>' != 'Signed-off-by: Lin Ma <linma@zju.edu.cn>'
> 
> total: 0 errors, 2 warnings, 0 checks, 14 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] Bluetooth: fix the erroneous flush_work() order" has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 

Do these matter enough for me to do a v3?

The first one is crazy, the second one, well, I can understand...

thanks,

greg k-h
