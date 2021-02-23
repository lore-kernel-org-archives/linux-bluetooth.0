Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D35600CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBWXCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhBWW5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 17:57:50 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C17C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:57:10 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id h17so443335oih.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gqG/Phkzv3uMKgpDURFaKKpNWGkqZQUnsxWrGUYD4kU=;
        b=qReZ+llEZM864nBxRd0dxkBcLcB/uOMJzhnmGV7Lh7kS/t0Wh108M5tpsY22EYOUFF
         FCAFnkAYxs6Z4GkYykuNPVVDS3cLXI8ZncR4LLRPqE4NmRNqD3rFr3f9ye05hVuxN7CO
         GDRUV6tspYrUiD3iAUNzUmuDFJTddU3k2yXMFnZIcmYuTy8J/sItiEL5T59Fb7c89VDc
         YzZrJ0DjaqKVSXmXeEp5dLslTpN2kYmudKkO6y68P8Sit0OqVkzX4G6Es+vxku8a01sh
         IyKWsXIS9Sk3Csfkw2qRkSC1akdYqtq2aF8m7nuPu4g4LUJd5yeWrQSKvxt24JzQJdqB
         q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gqG/Phkzv3uMKgpDURFaKKpNWGkqZQUnsxWrGUYD4kU=;
        b=tibd4mOG9DPitSOQTrKcMZ/mVGV3eqsBUyx4ZxR5oc7pXtej1VxA+m/l1gEx31ESeW
         o9ygJtBgS782YgwFR2hlFGCN9/6wgKt//+B32F1aWDuRcueIKLQ4+Y4v4OdflIIah6Gx
         zTIz83xLculdCEkJQ80XdYNVmY5QtNE9Fr11MZAQI6L3hxauSx0RUCc00YlZ6gjw+InJ
         Xgx2PC76s2PM39EpWjeNMFUC3cdO2nQthIs2Y8d+zh8YEN8R7uK9UDBx+MvQlJsPy7VG
         rD+zbgq++mY4J+evENXAcRNlWznD5l7qfm8wLJBpxJg3MSlCmxirhXTf9pxi/PZKmMqC
         6NSg==
X-Gm-Message-State: AOAM531mRJnR3XD4oWWkPGX6X9o5yhWi/L/0+VPISYw5jryEYQl2LZ2R
        SVa0ibefM8ZzTgW0lMlNFMpQDoDu3hPcPOOOVv+dLO5J
X-Google-Smtp-Source: ABdhPJwKr5Qmz0ydFpHzQR/o9Mn611c1pPu2tptcq0aNkUSarpX3fhbDqDlrxT72kxneCQeIbJf1y5Er1Xi4kIULdL4=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr734877oiw.161.1614121029719;
 Tue, 23 Feb 2021 14:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20210223190904.1718994-1-luiz.dentz@gmail.com> <6035597f.1c69fb81.b6540.2f16@mx.google.com>
In-Reply-To: <6035597f.1c69fb81.b6540.2f16@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Feb 2021 14:56:58 -0800
Message-ID: <CABBYNZLFxTdG93yzJB5CLPFczkQZs0ZGZ_=QWiDQws8mX9DC6Q@mail.gmail.com>
Subject: Re: [BlueZ,1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Feb 23, 2021 at 11:37 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=437331
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
> Test: CheckBuild - FAIL
> Output:
> configure.ac:21: installing './compile'
> configure.ac:33: installing './config.guess'
> configure.ac:33: installing './config.sub'
> configure.ac:5: installing './install-sh'
> configure.ac:5: installing './missing'
> Makefile.am: installing './depcomp'
> parallel-tests: installing './test-driver'
> configure: error: Embedded Linux library >= 0.37 is required
>
>
> ##############################
> Test: MakeCheck - SKIPPED
> Output:
> checkbuild not success
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
