Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52633C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiI2U4o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiI2U4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:56:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06717167058
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:56:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y189so30176iof.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=sudND7cp5dQ6gndlcXIlz0OpG5/BWAf9RNrekLsThNs=;
        b=ohUv808O6RCBusoXnAdsZWpwWho16DoT1Z7TPO8EpHBmkZ6poskUecP6fmluFqBKv0
         kMGAfggAhQP/vcbyyKQGttzw6/kVvtGFZMZCqH0Jd0ZWBk0vJ2p5m1eYunM4y64cRa6a
         3z0OcUz5MwpErAqmIibI1MArHndUpo32+sL1gZc93Jf7wg+xHyvJhSMyZf9dAoNjpvKs
         WaLs6cEjxMNfKgeUxzV3aUGgr2Qz2nR5bruOPtTDhkiRwGJYTaHrd1YBhguzpVmXmakV
         PY+QO0WkUs3VmRv4fnL8CBr8DPTQlGLEhzbgoRlw32Z66CnKgmiRbJqG/EbOv+Fn4TKs
         PCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=sudND7cp5dQ6gndlcXIlz0OpG5/BWAf9RNrekLsThNs=;
        b=Zd8Dsjr4iGvGi7/csbXNLyIpJoQKb8ccDrzrhLKa5PgtDr8IOry4+o61s6K9CWquFt
         Y33qZfa9/RAGK8sTU25zWvORKe0rv5v5diiNJL07cn5NdEy4tdh29OcVl4eKd5s4Ab2h
         /nwliAh+TLPz9h9tpVmlaEuD6okSPBoZZknXTixtbCFc4Sht1bUJ0ZnwFi4/qFyCd9qb
         YRyPbXXjnnQf3cYQ137tXTLkxVGjnMPPM/cUO0IAvz8LgNKaF/uzrtn4sFjc1M49f8iY
         NbpZxs1gvc9ZzTtWZDGcS0aQbccZ0FKXIp8YKFcIfPMXIbvRpNa3ZGk78KC93AftlHdg
         mK+Q==
X-Gm-Message-State: ACrzQf1GmMczfxHgkxWObt+xq75x0Lh3ZSZ/CnvKacLTVy4bkS/U1PKP
        nCZm4rfBa92z3XvK/pC5vkCRD5pyMAx+6w==
X-Google-Smtp-Source: AMsMyM6J8dnk2AySFXrg66OJdoNrNghzA1Rz54Lgry6UZoafEwJ46JxigyXdPyTFn4NNNnL7LCC+lA==
X-Received: by 2002:a05:6602:2b09:b0:67f:c159:91b9 with SMTP id p9-20020a0566022b0900b0067fc15991b9mr2409986iov.182.1664485001002;
        Thu, 29 Sep 2022 13:56:41 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.70.105])
        by smtp.gmail.com with ESMTPSA id k3-20020a023343000000b0035b2e0864ebsm157870jak.160.2022.09.29.13.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:56:40 -0700 (PDT)
Message-ID: <63360688.020a0220.24740.04b3@mx.google.com>
Date:   Thu, 29 Sep 2022 13:56:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8681376603603512429=="
MIME-Version: 1.0
Subject: RE: [v4,03/18] Bluetooth: RFCOMM: remove define-only RFCOMM_TTY_MAGIC ex-magic-number
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nabijaczleweli@nabijaczleweli.xyz
In-Reply-To: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8681376603603512429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: Documentation/process/magic-number.rst:78
error: Documentation/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/it_IT/process/magic-number.rst:84
error: Documentation/translations/it_IT/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_CN/process/magic-number.rst:67
error: Documentation/translations/zh_CN/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_TW/process/magic-number.rst:70
error: Documentation/translations/zh_TW/process/magic-number.rst: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8681376603603512429==--
