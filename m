Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A27C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 22:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhLQWnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhLQWnE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 17:43:04 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C930FC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 14:43:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so10687484ybn.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tH8+7OpMWoBniz8eYkzcpbmOwm+ECuFr8ZLJ8/1RoJI=;
        b=ZFAiRo6ff6Xca30+5sK0kCBOGyVG8ar4h2jLOdZxyizcu0QIsM7vLJ3u1kYwrk9UJG
         9HdSWWpwMfBThVsIW4M5PgCETDZA8mmYkM4P0v4iKZHpOP1PGLaLsE5x1MBKntejDx41
         afa+7d1Ii2KD2GtxeIb7jjGEzxAvLQ05TsthJ7CK4Es6MRn7701d7F5+Hg2sncAT5QVq
         9pfSJbeMf0rnOCzMKyPQtbAlGgnt2N5sfx18fvfyt05BgiNQ7kX9FohOqx3ZhlxZD1Ri
         KZlYRRcok2tFD84j2A3zFClOZO2oq9XSs3wcNdx3kowBQwRAYOl23wWiV15SVUNgEdTR
         yv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH8+7OpMWoBniz8eYkzcpbmOwm+ECuFr8ZLJ8/1RoJI=;
        b=sq76QxxoiF5iGPMBRCKvRz5x6yXxRNQq7Rr2gs8qc3JD8lVc5EHYIOl3ne4I35e62U
         LrZXFbEhqrE6d63I8YcTGo30qy1Tvp2u7ehOg7Epi5k4v3C3PQElQz431cu8ZA5SUZWC
         abxIJwO5yJps8ZJRQ6arVbJZbZElln8KQk5sGPSQUum0sDof1cCz8gDo+Q3ZwxDfOeVO
         iT9F4dNYtOjdcOu1ETt9vpgD9L6VOuoZRDIPfmQuSLb+iBeZlWU/augHCYMYJNox99x7
         FRHslwKz2NFc1pShJr8EhIu6LgSFYDQiNmWLvJ8NydLfXkkagS5h11iWy68UMn2V2+lp
         E3tg==
X-Gm-Message-State: AOAM533ujUO1T6S7ziONA1PehDjEnIZHJ+lrdZ1R47u9+WouTpcdlcLE
        eAJfVmY77TDpb1b2EBxE/yO3suGoKCm6oCMZe5sj+iQV
X-Google-Smtp-Source: ABdhPJyR6QqL3HIAbHn4GNw74iMz9mk8MpMne4Sbns67hbyvRzoLESbCryAKvWEAlcz54czOVgOj+oKu6y/PgMX2Kxs=
X-Received: by 2002:a25:b096:: with SMTP id f22mr5494443ybj.284.1639780982694;
 Fri, 17 Dec 2021 14:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20211213212650.2067066-1-luiz.dentz@gmail.com> <61b7c408.1c69fb81.22a92.79f9@mx.google.com>
In-Reply-To: <61b7c408.1c69fb81.22a92.79f9@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Dec 2021 14:42:51 -0800
Message-ID: <CABBYNZ+4CAg=4V7DHHws3J8T1LfVGJ8S91gCEgg-bQuSebkEAw@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix mgmt_device_found panic
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Dec 13, 2021 at 2:07 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=595033
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.63 seconds
> GitLint                       FAIL      0.92 seconds
> BuildKernel                   PASS      317.18 seconds
> Incremental Build with patchesPASS      321.54 seconds
> TestRunner: Setup             PASS      454.37 seconds
> TestRunner: l2cap-tester      PASS      11.79 seconds
> TestRunner: bnep-tester       PASS      5.89 seconds
> TestRunner: mgmt-tester       PASS      112.27 seconds
> TestRunner: rfcomm-tester     PASS      7.41 seconds
> TestRunner: sco-tester        PASS      7.54 seconds
> TestRunner: smp-tester        PASS      7.34 seconds
> TestRunner: userchan-tester   PASS      6.14 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.63 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: mgmt: Fix mgmt_device_found panic\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #103:
> FS:  0000000000000000(0000) GS:ffffffff8c097000(0000) knlGS:0000000000000000
>
> total: 0 errors, 1 warnings, 0 checks, 16 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12674615.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.92 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: mgmt: Fix mgmt_device_found panic
> 77: B1 Line exceeds max length (97>80): "Fixes: 2023db7e3a343 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_FOUND")"

Can you please fixup/squash this one, this is breaking inquiry
response processing.

-- 
Luiz Augusto von Dentz
