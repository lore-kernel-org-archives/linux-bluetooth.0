Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 21:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhLTVHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhLTVHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 16:07:32 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F150C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 13:07:32 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e136so32579507ybc.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQShlB+ND9f8vCsi0GeEIq+/H0JxKMpoqJvRPyPyGp8=;
        b=J6/WawzPCFRgFHbYMnhVSO3J8JdNPoTxdNnj+R10sa6wzBFG6Ln1RiUSot5jI0y4Xd
         UtlrQdw8n7ZVp1uNMYHVMx1BcO+6Euyybpve0TjOCQ2H1bGtV1L68AHbeM6LWlRaUQ0R
         5DnFTToeHTuLgBUKDZTJOfmT9JcJzy0lqfqq7YlfK+YGorrN0yo7zAKSnS7hro0edSP9
         I8pefCa7NTDUi9kZ6x3idKJmSX1Xn/7ts72JefjcjVgxzUtW09dPX3wBEFA4XiV/6mNk
         VMAOblkDthU+Jk02i8XIIdy9fFo6ydAm/wn3XsKZeNDf9eFV8kF5EIAAB8/063TZ3B0y
         xcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQShlB+ND9f8vCsi0GeEIq+/H0JxKMpoqJvRPyPyGp8=;
        b=4jX4vCx+ERnja5wvJ4PCWkiwJG1yz6904xC7IcpmxdQRIeuodnknCYj4LO+7Lv0+ts
         ke9YTCO0f/bKa+dW37Ev2ab+8UYEIcnvnwNhTJCnxXibASj84mgbOxxqt20ohdPcjuiM
         rqsoeZ/8nZMvzxrJypBb97hsM3Q53M0QUReFg63PqlBhQ15/6kdKiTYRIlz11ZueWb9F
         Jo/yNSseugUBqCCKO8p8z8f3UTt/A5dAqIP67MdU+r4kjR6kg7WfgAMfk85b0NvVcb/E
         6E+O00HujpkFb+M2o1FTmmAMzdHWkl10kupFgi1FFSHm/2Zu4wFESyF5GUphy4rKTvV7
         jZ3Q==
X-Gm-Message-State: AOAM53156+sJLC8e1uIL+0IYwFu255nmEjTEC1/nvELlowyM+W9Se+yE
        0NdA9/16cD+ojmvLqvrf0Ev7PB5bcn90mjPb5cGv0GxP
X-Google-Smtp-Source: ABdhPJwB/3AkLtDOuuka3wBN0hYNXjgV15HIEvnWcQ+fv/VFo3EjdqduNzIcIxiFjVDb227lfFw27LdENYIGlZCvSMM=
X-Received: by 2002:a25:3dc2:: with SMTP id k185mr24937508yba.733.1640034451081;
 Mon, 20 Dec 2021 13:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20211213212650.2067066-1-luiz.dentz@gmail.com>
 <61b7c408.1c69fb81.22a92.79f9@mx.google.com> <CABBYNZ+4CAg=4V7DHHws3J8T1LfVGJ8S91gCEgg-bQuSebkEAw@mail.gmail.com>
 <CAGPPCLAe0MbE3++O7Rdczc_M8C8jT038igiyr-Z40Z5MvcjqWQ@mail.gmail.com>
In-Reply-To: <CAGPPCLAe0MbE3++O7Rdczc_M8C8jT038igiyr-Z40Z5MvcjqWQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Dec 2021 13:07:20 -0800
Message-ID: <CABBYNZJmv5-sLhz7sK_5ytZEfjz7oyq-MM1yB_iFu8c0r_3Z4A@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix mgmt_device_found panic
To:     Manish Mandlik <mmandlik@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Dec 17, 2021 at 4:44 PM Manish Mandlik <mmandlik@google.com> wrote:
>
>
>
> On Fri, Dec 17, 2021 at 5:43 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Marcel,
>>
>> On Mon, Dec 13, 2021 at 2:07 PM <bluez.test.bot@gmail.com> wrote:
>> >
>> > This is automated email and please do not reply to this email!
>> >
>> > Dear submitter,
>> >
>> > Thank you for submitting the patches to the linux bluetooth mailing list.
>> > This is a CI test results with your patch series:
>> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=595033
>> >
>> > ---Test result---
>> >
>> > Test Summary:
>> > CheckPatch                    FAIL      1.63 seconds
>> > GitLint                       FAIL      0.92 seconds
>> > BuildKernel                   PASS      317.18 seconds
>> > Incremental Build with patchesPASS      321.54 seconds
>> > TestRunner: Setup             PASS      454.37 seconds
>> > TestRunner: l2cap-tester      PASS      11.79 seconds
>> > TestRunner: bnep-tester       PASS      5.89 seconds
>> > TestRunner: mgmt-tester       PASS      112.27 seconds
>> > TestRunner: rfcomm-tester     PASS      7.41 seconds
>> > TestRunner: sco-tester        PASS      7.54 seconds
>> > TestRunner: smp-tester        PASS      7.34 seconds
>> > TestRunner: userchan-tester   PASS      6.14 seconds
>> >
>> > Details
>> > ##############################
>> > Test: CheckPatch - FAIL - 1.63 seconds
>> > Run checkpatch.pl script with rule in .checkpatch.conf
>> > Bluetooth: mgmt: Fix mgmt_device_found panic\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>> > #103:
>> > FS:  0000000000000000(0000) GS:ffffffff8c097000(0000) knlGS:0000000000000000
>> >
>> > total: 0 errors, 1 warnings, 0 checks, 16 lines checked
>> >
>> > NOTE: For some of the reported defects, checkpatch may be able to
>> >       mechanically convert to the typical style using --fix or --fix-inplace.
>> >
>> > /github/workspace/src/12674615.patch has style problems, please review.
>> >
>> > NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>> >
>> > NOTE: If any of the errors are false positives, please report
>> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>> >
>> >
>> > ##############################
>> > Test: GitLint - FAIL - 0.92 seconds
>> > Run gitlint with rule in .gitlint
>> > Bluetooth: mgmt: Fix mgmt_device_found panic
>> > 77: B1 Line exceeds max length (97>80): "Fixes: 2023db7e3a343 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_FOUND")"
>>
>> Can you please fixup/squash this one, this is breaking inquiry
>> response processing.
>>
>> --
>> Luiz Augusto von Dentz
>
>
> Tested-by: Manish Mandlik <mmandlik@google.com>

Ping, we really need to fix this up.

-- 
Luiz Augusto von Dentz
