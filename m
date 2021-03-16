Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE33C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC52F650F0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbhCPSIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhCPSHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 14:07:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B5C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:07:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l11so5978238otq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC02tHMyevwgtTLSBSRIjAE1FVc5/9iqboLO63M3ods=;
        b=jsVWx0ldOif4x+Wf6Z1ItAfxHncAcQ7lG8lgK/U1bqYTv0Pj9Rl+wFk974cLHiLptI
         s0PAgICp8OxGn6WGqgVc+3hZKvm1FqDMSRQWLujqu2foCfxwfyGju66RpbCvGQQjJHKW
         TwvOTkzaExW+i96CcZvwwbwPCdRTs+pHZB3qPEwidT4MtDdA8h/9CgwljsAFlbKqe6RF
         ZPAeCvnqhqkE7uSwRgJaQBGtAgudQhZBoJkyxdrmh5QLj6OpW/H3Cy68j0P0BtDfWhlx
         VduB07eQhUmKpHm3dZ81yBVDaiDCDMJjSOK/LY8K6t8Y/XCAxASzOhtU0FusbLvLs2ge
         fDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC02tHMyevwgtTLSBSRIjAE1FVc5/9iqboLO63M3ods=;
        b=Fw/uuBxiLp9BYZ79Ozi6R8R25u4QJe7ikx6KWHUahqYPwaVzzZS080iuaQcKTWFBE/
         TqTe6i5+L795pL6mVShrAEVZHvLXJvCfEYut/ttYyPdy+kH5pIcB4e2QJyX6KwbeDg4s
         87zJHvUt2Opo5BV1RjVTaUg3yv6TGE68VPr6XTJD4oZBrQHMiSjpQbzRZ7m/4bwwyZS3
         gwaCHaR7FzyoBoOeKO0j1NKQi1JqhryZnTs0psszeWGiKyO9KvrKhrFxmtjsPiV8VabI
         ICJz+YUT9RehlOLAn1cRLQkY0cqB7awN2luIr0ukJlB1uH3D19voAHRbr+0Rdl+K2YsT
         1GrA==
X-Gm-Message-State: AOAM533+z9JyXaJ3LAex7Ql3xS17M1Y0pmHebWqut4TYe9tQ871voSWM
        kvJh/6K/gtcrjZGouDXIsa/V8DVup6TLs46xreGveC/iUDM=
X-Google-Smtp-Source: ABdhPJwCCpEplqd6eI5sv1YKXyLJ/+BhEm3i3+BM6bCNxoYvWhuJb8XKYl7Pa7yTMxp+LUwhqQBhJpDhupPIN6Tntt8=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr56373otp.44.1615918068914;
 Tue, 16 Mar 2021 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210316121212.Bluez.1.I92177a7c526b6d3e04c59f95d846ddfa79977b51@changeid>
 <6050374f.1c69fb81.65694.480b@mx.google.com>
In-Reply-To: <6050374f.1c69fb81.65694.480b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Mar 2021 11:07:38 -0700
Message-ID: <CABBYNZ+0osE6K07_PbkGALzMuG6+wUyYYECzm-9ZFY1k3W2gZg@mail.gmail.com>
Subject: Re: [Bluez] shared/gatt-client: fix BT_ATT_OP_HANDLE_NFY_MULT parsing
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Mar 16, 2021 at 1:05 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=448757
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
