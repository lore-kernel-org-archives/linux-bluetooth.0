Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 00:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiI3ABX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiI3ABW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 20:01:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCDF8FA1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 17:01:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 3so1907242qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ah0pvzW8jZUz5TT7USlGdFH1rsxy6NYL/FTGx5jmOSY=;
        b=oRDFDIpaQi1h87QMfsoQyTpwsMbLfDR7ed5spVFUF4ElyqhExV/iX1jtBYgXQOWbyh
         sa4Cz3srPB9nEETWq2wX/YigGMxY5wn6FF6pQ1bPSHZHhVv3w9OPRgrLCupMRv31Aiot
         HszVlquwgDUyYaA3Dw78fCH7tDd5UdpQlG5SMq2Z70fQQMGp3F0ftlzOb2ry45VXPTUS
         jtie1cgtZUR8Xp7H4YiB/1d9mpO0UT+dvLGm8xnBHseusFJyVMcBT0LZCtInHVLtRPYV
         LnCM+7eb1HVAFvAPxG+UfMQizsDNNQbWmqH/ud3BXOiIqDFVPnr1LFqVnjPiyHs92iSG
         RT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ah0pvzW8jZUz5TT7USlGdFH1rsxy6NYL/FTGx5jmOSY=;
        b=hfTi88TWSsK3rnt1XdCEZfRJBo6P/7Qt1EuXAPkH1/s5JFb1s0EXZ0HbBNg6ouXBjm
         Oqp/ne4nAmP/y2vY3m7i5l+YOlH6RTa3+KjgBb3awAdAli1s1drP2I+grd5o9sg9hcKA
         kpHyoQ3HfTazyl999iSQjyddc1XEMiUySNb0ua6O2YvSLyBUHkF+0I2FuVQM9BJNZWVf
         Z9kVW5XrVxDm+rgWyT8ZBaBFh+NJWUOnWd4AAXvxdWXBXy/6aRV5Yy9q9cX7zzKKTotv
         gECTbELyr0PLwZciasz2jgtYZ7S7waKKjWIfWqAS/d9UDsvXB19LNS8MukJSxGbrGCic
         ktQg==
X-Gm-Message-State: ACrzQf1Ipta3tIp5hIgEU+pzZ7EjE1uTRKS28CpqCvku+WuV1kc2y/ZL
        n/2nKa3Oiuz2/jaVoqGr44qHr4RL36UK1w==
X-Google-Smtp-Source: AMsMyM52OqnWPoYLtUrbXkwqhuVM7DSpDGIkeZojv+6sCfHX/7jGg2/p+IN6giCccvIsjrOxaLTEAg==
X-Received: by 2002:a05:620a:1aa3:b0:6ce:3c85:d9d7 with SMTP id bl35-20020a05620a1aa300b006ce3c85d9d7mr4197201qkb.225.1664496078857;
        Thu, 29 Sep 2022 17:01:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.128.176])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006bbb07ebd83sm1172149qkb.108.2022.09.29.17.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 17:01:18 -0700 (PDT)
Message-ID: <633631ce.050a0220.9a402.3601@mx.google.com>
Date:   Thu, 29 Sep 2022 17:01:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8173355273232467717=="
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

--===============8173355273232467717==
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


--===============8173355273232467717==--
