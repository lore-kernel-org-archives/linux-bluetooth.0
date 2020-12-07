Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21537C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22EC23428
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLGTL1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgLGTL1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05362C061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 11:10:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id b9so10225246qtr.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mqx4CPoQiXYrRNXtm2F2Xh8ujhWV6FbuaZg8dPh6rzY=;
        b=YVkRaT1orBRBmz5Cgx53VbWnRFACf9meN553cyGn+KT4KndwioqOXUa+CMVVmvWhPM
         z0PvAflf7jT+l5HwyZgq+OBgI4U15gjRgdLEF0gAgzdO/mYVL6obuWZSpE6Kln/QfDUQ
         wbtdu3pl6d0NUd9Rn11ac+beT7WYOQ99MF6gMkiPVKgJNVGMCSBZv1tguaSIoNUr0KQD
         h4SvEb5VvoYZMBDxL7j85Q9ypVFseCJLHqNmGo5S9DaNP2//RUEW9/ZnjPbPhqiWw8Z0
         UVY2Xe88sLwE28FxYJf/9BNl9mvmSkeurRGBAZWYBaOiXZd6uA3ZKcoKYm2cBGD6uFJi
         aWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mqx4CPoQiXYrRNXtm2F2Xh8ujhWV6FbuaZg8dPh6rzY=;
        b=AV+d080MGMqCZs0DrqR5A84McUG6Gc0Okt+r50aMYUL78/t9yEbLfIYPTsaT3Ymv8C
         XbFpNwVju3NScsom2FW/3kK1tIwJ6VgvZQEto/IfBw4l/mxYBGdmRsU1uHMCrl9b9Tk8
         yx6mRbue6b96nH81aApONf2h4d3d4CWfxV3xSwESY8loA/ZDsW6CfoKcfhQc5TI7Eavn
         xwfPpz5XSVmaJCGF6EufP2e3S6yI1tP7czoiW+H8vWqku/lXXzrQSziSH5kNhYARKSNM
         /jmt2wqBM2gZ6mNGf6Csq6GXnB9Uuhn3Y6HP+A0p4AmXXN9BIKE37DyTTuxqjrTWTG8p
         6SXQ==
X-Gm-Message-State: AOAM531zSdLeYdXJEEk+0AUmOitjgRapizYNEmmQLvlbzAljg5s52D56
        qP1C00lrNUCz2vaxQbfHo86tgEufFv7CxA==
X-Google-Smtp-Source: ABdhPJzThPVMTH5Cg3+HrPmsDcXbPaCNNafgsBA11VfVBvzFt4XRjXA4WulUyp+zGGl+CGdiCmFKRg==
X-Received: by 2002:aed:3103:: with SMTP id 3mr19967321qtg.105.1607368246019;
        Mon, 07 Dec 2020 11:10:46 -0800 (PST)
Received: from [172.17.0.2] ([20.185.65.145])
        by smtp.gmail.com with ESMTPSA id e126sm12860983qkb.90.2020.12.07.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:10:45 -0800 (PST)
Message-ID: <5fce7e35.1c69fb81.b8b8f.9b52@mx.google.com>
Date:   Mon, 07 Dec 2020 11:10:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6376790585084481280=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, encrypted.def@gmail.com
Subject: RE: Bluetooth: smp: Fix biased random passkey generation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201207174957.408-1-encrypted.def@gmail.com>
References: <20201207174957.408-1-encrypted.def@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6376790585084481280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=397747

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: smp: Fix biased random passkey generation
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#6: 
Since u32 range size is not a multiple of 1,000,000, current passkey generation logic is biased.

total: 0 errors, 1 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: smp: Fix biased random passkey generation" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: smp: Fix biased random passkey generation
3: B1 Line exceeds max length (96>80): "Since u32 range size is not a multiple of 1,000,000, current passkey generation logic is biased."
5: B1 Line exceeds max length (94>80): "Fixed this by adding a routine that selects passkey again if passkey is 4,200,000,000 or more."


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6376790585084481280==--
