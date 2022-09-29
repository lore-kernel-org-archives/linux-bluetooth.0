Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58397C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiI2U4l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiI2U4k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:56:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D5160E54
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:56:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 138so1863850iou.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=e2amtGHgIn/DHsHi4aEvw9BR9FbddVtvvJmspk8LO18=;
        b=OIkrhD2/lbywTm1+3Fj2REuYI6wHedEBkr5OXkDVko15BRPflV+T2LmPKIM4ypQw01
         0KtW1iXFhtzVcRgmGAEQkrUPNzAdMKJpo6P9h19JZ1Ggk9zFjuQ2i8Rp5WfoUBfQRRm1
         unme8iJ19YHE7VEe7FzFh/eW3HX31sRqJ7aB3o6rgU8zQCpQZTve6a3kpi34ffwO6Wo6
         vMecePXRbAHP+NhnwdkXLpbtoYsm58vDeR6RrSx2zBEiEIxzZXwyNVHsmq6b4HCd/LFH
         oS1Rwbc0hOBPLti3debMOg7hcgqBXJgt+Z/anlJSDSf9lxpCHt6xiQ4e4Fmol2g0A5s6
         CFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=e2amtGHgIn/DHsHi4aEvw9BR9FbddVtvvJmspk8LO18=;
        b=INjFliaQ6Y6v0J95pMFMNku1ARL3bjUfPqWp/Eewem6NmVaKBYZwDO6WAnOzVzno7l
         /j72dx8yf8fmjM8zXaZaIWPJgPJTYD/WLCazzlsTHo+2UQSKe6uodDGL1Z3BVCD8d70Q
         Tqe9DA7aiQQY5A7vpnE66lHUwcbC7f7bH9XRf/ywmBzQRTzA7YayKCmDjVPuC+4u7y/g
         xjtL34WO4DmG0lt+emR+cJncpU3Ol3Im4EzUNvHbIN9W+9ZxpglgKR4EUGwCTWvXPNPc
         s+syw7er2YDPCi7/GQgd858MY4AE3+jh8+Owa//12wX0REke3IQNauQnCFwIGW0SL5P/
         EQww==
X-Gm-Message-State: ACrzQf25+qgBYnXxkoYIaZaNCkJd1x5tXXUhxYE6plyMlCUr09FXWaGm
        E/4xm9pK65cHnKuXB8pAPNMowiHVwGs=
X-Google-Smtp-Source: AMsMyM65Nyk+aNBjihtFq/ZvQVXCzpb0vSUnk6KtYr7BczWhXyOAmRrgu4xHJpbJXJcwfvW32l1U8g==
X-Received: by 2002:a6b:c384:0:b0:6a4:3773:1fa9 with SMTP id t126-20020a6bc384000000b006a437731fa9mr2466780iof.181.1664484997015;
        Thu, 29 Sep 2022 13:56:37 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.70.105])
        by smtp.gmail.com with ESMTPSA id 17-20020a056e0211b100b002eb52f831f6sm250612ilj.57.2022.09.29.13.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:56:36 -0700 (PDT)
Message-ID: <63360684.050a0220.e99b1.0741@mx.google.com>
Date:   Thu, 29 Sep 2022 13:56:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1471038231707845944=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1471038231707845944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1471038231707845944==--
