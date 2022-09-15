Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCAECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 23:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIOXyo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 19:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOXyn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 19:54:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53B101C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 16:54:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c19so12678970qkm.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=rV82js7UyM0Zz9kvcbuFyddMi8NeaBrhwZjWX57oOhM=;
        b=NBBrA8nOV34kUx+xJbbjyZIfuZOyWvh6vUaRF6Lfir8TcwUalgEShQm2+Kp87F+m8q
         kC4TaU+YZoQVNrNcFAL2lVHraTyMCi0UDZaCNmvUFoQuLA/3JbrFNOXrVc8uMRYPuqkC
         n8AOn5DWhyeRvjJ4PmJ6W/3wymaFcfFGFWYCdAAd3EqCpNQPz5HeLwW9+LlcekwFzKgF
         2HS5NArHsoildsPDWXDap3PBIhLAtexbdgil654vsigH9Ec/uAGQTdmY1FQgwbUbfePq
         t8RCABkNF0G14z6Zoou/s69AVpBqRS2QugpzL68I2gflzZVmVrpOCMmAGPsG0XrUn5Oa
         s3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=rV82js7UyM0Zz9kvcbuFyddMi8NeaBrhwZjWX57oOhM=;
        b=CxyqxwGBK+FWrdhHY89WnlmIfBpjuwgoURqz0ONhO4A1dfc1eVxotOYxfKbV+o/vbB
         1i2rmh4QyQ5nxzxtx/SrWIBf0EJFh3Iq8vCmVHVlCD4jwAaO+F7Sykz4e5fFTJHTon3n
         +g34sbW6oadBcCFvnTEHILNaT1q+L6BdvRCsSKFFyuysKmDbWBkxW4ePHccu0NvczF1J
         kdYaP/ICAh6cuxn9t+e00OHpQkM/fyM00FdSSPKvH6OHykpcJb+CQZo4+U0XObReCr5D
         d8Etdw4KN7wnbG8O7pBJbm4JnrGb1enyBDSfa73Nm5tAKKLPlQqXpWbuEAXLDWoe15zC
         Ltog==
X-Gm-Message-State: ACrzQf2is54I6HoR3qpQEw65/w0gXhEJ9yaTNr14JLvS8TiATXtoLb2P
        Of4vpuQXa67GPLP/Ix9a0qiED6xPodOiuA==
X-Google-Smtp-Source: AMsMyM5IFIeljNHr80cMCkuJgS4nSuHSZOuTJEVVgzMSdXGW3dEwvm3a0b5weqAzc8Jo9+kXrT3LZg==
X-Received: by 2002:a37:f514:0:b0:6be:730a:ac1a with SMTP id l20-20020a37f514000000b006be730aac1amr2192119qkk.10.1663286080171;
        Thu, 15 Sep 2022 16:54:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.75.122])
        by smtp.gmail.com with ESMTPSA id n7-20020a372707000000b006b5bf5d45casm4731124qkn.27.2022.09.15.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 16:54:39 -0700 (PDT)
Message-ID: <6323bb3f.370a0220.f49bf.011b@mx.google.com>
Date:   Thu, 15 Sep 2022 16:54:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8999556369455199414=="
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

--===============8999556369455199414==
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


--===============8999556369455199414==--
