Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 02:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiEZCWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiEZCWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 22:22:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F117061
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 19:22:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cv1so775523qvb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 19:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=haJbIpfJSbAUH5BRlButroLehR+NWjHXTUCK3xrtuRw=;
        b=TuQfH299fCCW4fwXpCLI6Efyj/QESpBxAcUulQ+WoRa7K2VAZMJpO4nX/teXa2Uu4y
         VmPh1QObhNH1r0PvZ1xMThJhpyyytjb6S3S6H4R5D4YT2vBK/7k4d0oAZvQFD8Z1IG/C
         FF2R3EYwFiGi+2LJnJsJj637JtLfTeX9LhpiqnbKGNNQ1L1+z0f9OH/YMzsMze2pWXGL
         m+4WQZPa9tjUkzatSljwgaxUwNY42s9yIsJbNEqmCI60JbRIYIiyrmPow7V8yEhwLG30
         tKMBHhIA43I54C7hcxRnN/eVLB5QqMe2WCgIzSl9Xw4mElnd7B0UdpY/eg0Ok5bMfl63
         TuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=haJbIpfJSbAUH5BRlButroLehR+NWjHXTUCK3xrtuRw=;
        b=X279xqcDB83eAeX+3UbVlH1P4WWJkJuED+VFxSjwiStnnXmKRAxoj8KdbPwMZYRo5I
         it//dlNmL2h044ei16oDQYO3K+p3ADjHaloMu2/Gza1dfBTdNjeodVLpWE0lj6U4Hd0n
         7EK7eokNE5w2uvzPAeXVCs7gMKvdqXQD7np+s7hY4/1cuJIhQgnI+BEb3wBv9mTN4pJo
         1UBWSJBhc2u0YnwUbZzyPnwxOOf0gzLYsEnNEd83w0Zb1ooM8tqJmZ++D8YAFqcbS55Q
         hYsgYl+KHNbyIAfCFQgkC8428AQL5oLAokQf62N+4ak4Aa/pV7DDR01Xo4capPRw8LU8
         /MvA==
X-Gm-Message-State: AOAM533KLGVwax6l+SUmKOqLzPDSads7UfraRVGotCTgireuw75nBl5m
        Hgg774zG8VAs1C43EamP3lSl6Tc/bGT5bA==
X-Google-Smtp-Source: ABdhPJzj3MHzqGZOye2m8b2pqo9Uc90SaetCJleFjptcBVwrWuZcavVsL30NP/h3RdJr1TmnRYWTdA==
X-Received: by 2002:a05:6214:2aaf:b0:45b:9f:8752 with SMTP id js15-20020a0562142aaf00b0045b009f8752mr28587708qvb.9.1653531748081;
        Wed, 25 May 2022 19:22:28 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.10.5])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b006a3750e8b25sm421548qkl.82.2022.05.25.19.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:22:27 -0700 (PDT)
Message-ID: <628ee463.1c69fb81.427fe.20ad@mx.google.com>
Date:   Wed, 25 May 2022 19:22:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8048767261586385442=="
MIME-Version: 1.0
Subject: RE: [BlueZ,1/3] monitor/att: Add decoding support for PAC Sink/Source
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220526003927.3972965-1-luiz.dentz@gmail.com>
References: <20220526003927.3972965-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8048767261586385442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: src/shared/ascs.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8048767261586385442==--
