Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72566C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 02:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBXCgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBXCg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 21:36:29 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8205EED5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 18:36:27 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i12so834358ila.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 18:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677206187;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oB8xdr7icY42r8TnbkuIB2v05lXIjQHJlVisWSlJ33k=;
        b=QkIbz9AtmsckSmJ32HLWmN1NiPZC6GYGVm8Hb3scgtV2fKKK87rLz8LTxLS9Jwp4it
         SN0bWe0YQcK5ugU4Mf3GS8UCgDucX4L8Vu5ypJYEh6JJ4MLEaDFm8WOqpcL0ObMYOl7P
         T+PW8fGEzxm6JjQmpLs1DkeRUx+75xf8WeqVNq9RcSlNI1ocnU/99wEun/yja/JbBZto
         yLxv7urggIV1slKMIA6wEBHxDzXh0B/46kqfVEMVm8Lqv8Jye7U5/0MGVhA/zfrf6I/c
         6funUivkaG8yINOtcReHPNCf6zEgvQj58pZUCNsrpqW/Jh4c2++sAk2FkLax86nOdNjw
         dzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677206187;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oB8xdr7icY42r8TnbkuIB2v05lXIjQHJlVisWSlJ33k=;
        b=tTpirUssJQaLvadRJGgRbCDIv6TJ7J7Q2bNviPf+4PZEMXlic7beIFkOERSLWiumkc
         JY25M3vUDxqm9uZaQyyXn4PPdCaaFRAnTpTEs1eF/9VL/U3rRoHOJXz8CXipy4Qye5cP
         rUe185zwuXZG4Eq25n/lnDdo8qKgwaKsXrk2BJL4CNJV2tgjBQaBmmF/7bgfAI74PLuo
         p9/FbdAuMq/JXbhdskGhN7BIQ0M1WillBb9Y1UM8UOeYuZWj7/7T/jTSz+OwvBUkT8Ec
         pHcR5jXvmZLEfqLZGue6EwSp22BdOSUPRqtLvVnSXPgfc2hihT47/jzrhXX+lJPj7oy8
         aw1A==
X-Gm-Message-State: AO0yUKUP7r/y4BGeOxJLvh42KTO1ZaCVXXENSeDO9iYJ/iUr+JdtF5xq
        Tj+Ie53MrIde5FIz0qCZwGKqjzYhToA=
X-Google-Smtp-Source: AK7set+Mvw3L6WF7HLy0SlKhTkCXt+ueK1fRjqi06mG+eNn/4xz62Pgq9NVdbGLxB4ltUGP49kP8ZQ==
X-Received: by 2002:a05:6e02:20ef:b0:311:e5:5d11 with SMTP id q15-20020a056e0220ef00b0031100e55d11mr15083505ilv.9.1677206187185;
        Thu, 23 Feb 2023 18:36:27 -0800 (PST)
Received: from [172.17.0.2] ([13.86.65.48])
        by smtp.gmail.com with ESMTPSA id m5-20020a924b05000000b00316ecc80a61sm1811556ilg.11.2023.02.23.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 18:36:26 -0800 (PST)
Message-ID: <63f822aa.920a0220.569fc.3d66@mx.google.com>
Date:   Thu, 23 Feb 2023 18:36:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7735406106136704647=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor/att: Fix ASE frequency values
In-Reply-To: <20230224015136.3445113-1-luiz.dentz@gmail.com>
References: <20230224015136.3445113-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7735406106136704647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/att.c:890
error: monitor/att.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7735406106136704647==--
