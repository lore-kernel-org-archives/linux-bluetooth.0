Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8065C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 05:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiFGFl3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 01:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiFGFl3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 01:41:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BFB0A7D
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jun 2022 22:41:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c196so14587332pfb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jun 2022 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbTJEcfY01ogSuU+DNg5ahC/a116BhM3r6sWtjnTiaE=;
        b=YIsydpsA5M/DrsgQ8ZUHBPq6hr9eZYiUmzOKD6Fj7hzdN13kg/phpDdLVD3sLHzDRW
         lNGiSkh0RhshqTyqac8y+yWECAcFrTZ5K/HaAMqHtbHDoXQpwizQHyxB0EALuFfUJpBx
         KLnUXJiU9lsHvAFQS1a5/UwSaQbTJmDlVOORn3qY6qCXSFbQ8ssZkhExhqhv96DV3dGh
         ySmyJ0brv5t1+rwpKLfa9efuYBBA9Emb4U3u0cDhO5zhhv1BSn4fVWIfZ5dNbyDEnhMj
         c+6xU0CNz//xsI1/EGnfE5SFk1+OwhuP/26tzLN5EXmblmLgQhbEcU/kffjyjzwKmXDZ
         N0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbTJEcfY01ogSuU+DNg5ahC/a116BhM3r6sWtjnTiaE=;
        b=J9JTR8aGl7yMarzUuaTPePUm6bbYNUnXYYBuOx4NSSb6b4Zq7LH++CaBCw+L3UGrsB
         wggzV9V2D4DywjP+tHCuTaUo1KrvU74ENqEfaWe4XRszyPT4E+1lEjLnKCeFtS8+HADE
         nSCWqqbs2tRycwKYzXZkKaWSm/2G0xb4yiVw890sd7tZDkBto0PXF8gPCVBcf5u+fNFt
         G0h3pub5utlCGqDYDbmfqc5fziOhIQLFEK4udst7dZXo90Xh62VbbbySuYJGZWOkMfx2
         oqo7kHMxVTmxtz6kSxDS0ap6VNBRrwG9/WgT7/0j1qkFw9cxu0GX+tIP+DAiGRvAZrpc
         p4jg==
X-Gm-Message-State: AOAM53124Hf2Gmgr7yi4bARGdf5b8U+CwRQrZCYktNwanozlMspvdiK1
        V6V+hmbrva8pkUigJkmXscf9YPWtk4/ZmDcMKgPGp9F6
X-Google-Smtp-Source: ABdhPJyAoUU4q8ouQW7YJVMGkVlTuFk8+U5ozl+Kp5lfEAif9jPwOhYuHoo4VzVYHQ+N9dencT33ZaXGPiKPv+pApos=
X-Received: by 2002:a63:688a:0:b0:3fa:a80c:a228 with SMTP id
 d132-20020a63688a000000b003faa80ca228mr23272689pgc.182.1654580487355; Mon, 06
 Jun 2022 22:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220603212604.13758-1-puffy.taco@gmail.com> <629a8c92.1c69fb81.37f6b.cfd2@mx.google.com>
In-Reply-To: <629a8c92.1c69fb81.37f6b.cfd2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Jun 2022 22:41:15 -0700
Message-ID: <CABBYNZL4Qv1TTxOYisY_3UV4XcHoxecPfokW=Riu5NUhkwspxg@mail.gmail.com>
Subject: Re: doc/coding-style: Update URL to kernel coding style
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Mike <puffy.taco@gmail.com>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Sun, Jun 5, 2022 at 5:31 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647329
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.41 seconds
> GitLint                       PASS      0.96 seconds
> Prep - Setup ELL              PASS      40.26 seconds
> Build - Prep                  PASS      0.68 seconds
> Build - Configure             PASS      7.98 seconds
> Build - Make                  PASS      1210.43 seconds
> Make Check                    PASS      11.64 seconds
> Make Check w/Valgrind         PASS      405.55 seconds
> Make Distcheck                PASS      222.88 seconds
> Build w/ext ELL - Configure   PASS      8.39 seconds
> Build w/ext ELL - Make        PASS      1183.08 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> doc/coding-style: Update URL to kernel coding style
> WARNING:BAD_SIGN_OFF: '-signed-off-by:' is the preferred signature form
> #95: FILE: doc/coding-style.txt:9:
> -Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including
>
> ERROR:BAD_SIGN_OFF: Unrecognized email address: 'line(s)". BlueZ does not used Signed-Off lines, so including'
> #95: FILE: doc/coding-style.txt:9:
> -Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including

This one is quite funny, it seems checkpatch.pl does actually end up
checking for Signed-off-by: lines even on the patch contents rather
than limiting it to just the git commit not sure if there is something
we can do about it but this is the exact thing the patches wants to
prevent.

> /github/workspace/src/12869423.patch total: 1 errors, 1 warnings, 22 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12869423.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
