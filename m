Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1733BC63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A0920857
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvb7EynX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgKXVWS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgKXVWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 16:22:18 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E45C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:22:16 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v202so268656oia.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35G4dJOub1syQqdRMIT8ImrbhxdoVX4zVggXu5TO8Cs=;
        b=Kvb7EynXLb335mYcQNe4EwYQJj5SnkWoSvrnCpXA6Wbw3gf1U4nx7Wc9qm4k3NF5bQ
         Ma11eJ61DfjUWfPY7JNom38gP59tx1rAbYKKNigF4NHnb91jMLwbRGLkxdiYSlgNjN44
         AsSxksG2B3Bde4kWmOWT7BUNbWEu7nzofrRKEq62w/9FKKMFzSg77yMgbZbYt2T1O10s
         Qsgv/nws121jVA/tCGNAoattCr95ZiDtuh5DuKyCV/DeRDXSJMOad9lOUqv085MDOvWG
         GAb5ori3yWMcZh/NSRHuEI6baNFjWhwSGdNYWzoje1quWB4l3oJm5cJaZDPRxdPjP34D
         ccog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35G4dJOub1syQqdRMIT8ImrbhxdoVX4zVggXu5TO8Cs=;
        b=GrF9lI9R5hN6wDS5+/Qm2UMBfmkBZhkKypJIHDCqxxbMnAD5LmCcFhKgYn1cUIXBKM
         cI8iGM26a/VgnxF8TIodMxG5RKLN+o4RI4NdZkiQvb72ivmMwkabsaRQ/9Qr3yD5zb38
         pNATHTXvUumLmr1jz6fc33P7efyINW4fK3rrsz33cSykSBW7NpFP9ylfji1rXjAErP4q
         GSRbIXv0Wk4+3oaMlpJxKQToeMgiUUSAN6Xo6m0GFRbfACzEnQGxLjAZ+fwq8cqSoopJ
         ntneW9BLD6IBbKezngjJcWCmnMbg6cs8BaVSw3GRSFPZ2mfSJcx1BrO17ILDZlCF+e3S
         zNKg==
X-Gm-Message-State: AOAM5339slkJo2gRRVDwngZOEas46wH9lfW+UDz6zmO0cis9EC6MFIgg
        yZ3sfsTOh4KdzFwJ5bw83p90JYHPB6rjHo0fYkucwVE7
X-Google-Smtp-Source: ABdhPJwqZOPGlFyI2Y541IBXsjIV5KNw5IacrFmNmDPC4EbFSbPAGLU5bgqpwC+5kCP1aXnsJXuwVDbsu0mMJrVt/0g=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr101318oig.161.1606252935695;
 Tue, 24 Nov 2020 13:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20201120200712.491219-1-tedd.an@intel.com> <5fb826af.1c69fb81.2b100.279a@mx.google.com>
In-Reply-To: <5fb826af.1c69fb81.2b100.279a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Nov 2020 13:22:04 -0800
Message-ID: <CABBYNZKMJ-PSUPP7duG7W0_=w8tQf4tAZxuJ5i5hLi4gNRaFKA@mail.gmail.com>
Subject: Re: [1/6] monitor: Fix potential memory leak
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     hj.tedd.an@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Nov 20, 2020 at 12:31 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388665
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> monitor: Fix potential memory leak
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #12:
>    ==258684== 1,500 bytes in 1 blocks are definitely lost in loss record 3 of 3
>
> - total: 0 errors, 1 warnings, 64 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] monitor: Fix potential memory leak" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
