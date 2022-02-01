Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D775CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 20:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiBAU0B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBAU0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 15:26:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351EC061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 12:26:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g14so54459305ybs.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ni7CaQfiByhpeDAPvCzGDS1O0zrjXfsGxopP/Ey7Bo=;
        b=PQOzpt6lyNt2smfkCAwJTtDELyGAhchoPSCSUk/nwUBiJA44ORsXTMNGsSPJBJJwgz
         a5VhxDqTb/UBdDd3D9tuDjuUQi9ZukcQ2NLev6GOxHSoH9FkTuO4PnMHMYty5rOLOKfH
         JdIDIbEW/LhNH/IVUKplivIzf+Y7MCQaAyKCH8RuufBXon60a7CX0Y09fmgXVndNb9NF
         otVioYk+Cei0TqFS7SrOmXibJGao0r431zLRM7FbvwllMPGfgbbqkmSQOSh8ko8L7X0q
         +Hs1rOWByE5cwNFBd5WHVw0h6ZBXENLxYxHyg935nrpIX0TF/wPrO9wOZKS2+lrFWz5o
         9LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ni7CaQfiByhpeDAPvCzGDS1O0zrjXfsGxopP/Ey7Bo=;
        b=dhek8QQxVpncZIQCUWFbdg8rashwPdz/4xp+S0KpRXu5hBK7g7Q1wB25+rptA8xWNA
         RKFKfKShr+OvtiphCueJWeaZXXwv2MPCLfTHmljdl9RJ3CXccwlKPI3Ux23OSORk7PCs
         reX/BaAwA83Pbw2GR1PziG+cbxsTxSP5ohlSUfirahBEZy39gT7N+FV+Isj2QJth8/FN
         f5Z+4kkSAryzh0u/rSut6bn0RUGAL7tIqAELnbSOQo+NwtlH3k6XNkb827TRN956v/Cu
         HpaR3yhS/+178Y63abwda8ppd5lC4T3NNhqVw48qRgUy8yY2ZqFrOR6Mpak9jRV2sJ6V
         X8OQ==
X-Gm-Message-State: AOAM532q+TgS6ayVDJmODmCxNkS7ERDg6+fP9xt9T10AXOpAVXIZQV2G
        yj1fIhkEo6651Sin4SFww6KQESqIa2/kRf3zp1iU6JRpfQQ=
X-Google-Smtp-Source: ABdhPJy7Re0q1TayBWITuT3zEw3W1WGWqHCgeLIXt8nTtRw6RCpmKCl+pxxoVRLh2/lWxwJ8hr++elUL1cD1DmJmLs8=
X-Received: by 2002:a25:2c8b:: with SMTP id s133mr37787333ybs.188.1643747159652;
 Tue, 01 Feb 2022 12:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20220121013508.950175-1-deng.changcheng@zte.com.cn> <61ea12e9.1c69fb81.9022a.12a0@mx.google.com>
In-Reply-To: <61ea12e9.1c69fb81.9022a.12a0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Feb 2022 12:25:49 -0800
Message-ID: <CABBYNZL7Ad_xYG4qabiBm264EaVsrzX8gB2wehBGLy71OHVG_w@mail.gmail.com>
Subject: Re: bluetooth: mgmt: Replace zero-length array with flexible-array member
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     cgel.zte@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 4:29 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607119
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.61 seconds
> GitLint                       FAIL      0.96 seconds
> SubjectPrefix                 FAIL      0.87 seconds
> BuildKernel                   PASS      30.32 seconds
> BuildKernel32                 PASS      26.97 seconds
> Incremental Build with patchesPASS      36.33 seconds
> TestRunner: Setup             PASS      472.13 seconds
> TestRunner: l2cap-tester      PASS      13.23 seconds
> TestRunner: bnep-tester       PASS      6.01 seconds
> TestRunner: mgmt-tester       PASS      103.93 seconds
> TestRunner: rfcomm-tester     PASS      7.33 seconds
> TestRunner: sco-tester        PASS      7.60 seconds
> TestRunner: smp-tester        PASS      7.47 seconds
> TestRunner: userchan-tester   PASS      6.25 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.61 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> bluetooth: mgmt: Replace zero-length array with flexible-array member\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #88:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> total: 0 errors, 1 warnings, 8 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12719219.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.96 seconds
> Run gitlint with rule in .gitlint
> bluetooth: mgmt: Replace zero-length array with flexible-array member
> 10: B1 Line exceeds max length (97>80): "https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays"
>
>
> ##############################
> Test: SubjectPrefix - FAIL - 0.87 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
