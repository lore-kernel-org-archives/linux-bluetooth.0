Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC9AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 17:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiI2RpC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiI2Ro7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 13:44:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4153713DD0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:44:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v4so2056696pgi.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=TImXgmoVjgqaB3oBWufRAIW+ywL+yAYqkf7p+T89oS4=;
        b=kQwPG2Af0RCCHzuQ2DIGKoUi2siWk7naXbsvvz/6ZYhiINadniadHFHOKjLr+acmmr
         l07JWqiixWwiPkHRO0fV/9VWpkrLEnDf1OqeIrxZ8pJMpbOjzn+0CF/PyKfuT0XBfGni
         yp1LkhDwnikFNx91txisv3sp8wecSNfYHk1UG3IDFtIAazZ5OdvqYFAJHvy5hoHwqcPE
         qzGvSqfAQQwftKL3oWSS7vOaNBzgdqKzmn9lthUq7Y8ynL2wpdj1GhxAkZ3AurISA1Se
         zxmoKBV0T2N5aJ4g7UazvVgUQm/2nz091NfkG4zr0hu17GVPRPC926qmQw2eBYBLSEUZ
         POIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=TImXgmoVjgqaB3oBWufRAIW+ywL+yAYqkf7p+T89oS4=;
        b=Gv8SmVxX0r4czOSQdulVShl0kSdt/2FP1Js7LG+cFP4DI96+6NUhEMG7cqYQdX1GkF
         kmjwRNLhIsHY2cWv8KVAKOKCgvdaayLa4RbtkZHqsWipnW6IoJ63/M+iuSi1QGNPDEKk
         j8G4HrmC4No2mkZwrrwLk2jC3EyPDMnuvREdJG6p+R/M5ErbploDjY6G3UXqQot/Zrbj
         yihB0XWAti0dJ3/E1tS8pIljHaL8Uwue0RvqWy8mTfBTpk6FYxspLNFrw06B5uPCpODz
         P0j3Et5B/B7zRAAzaTwXBEQpppsAlK/w5fDm3CcLhJ+oxzT4U0ccRyFCjarYfYVe/gXx
         2M1g==
X-Gm-Message-State: ACrzQf0SLIQqn51D+bnuD3zQQrO9qJXYtUaNYEybGf/+bXvISvbxqx4i
        VwLPl/TZPQl7y9IkyzMjJG3fBtg9tHF+LQ==
X-Google-Smtp-Source: AMsMyM5rHBaQH4itR0LlA0XqWpbOFUEinon8JWfXDBilkLRHz2YN7MA0hHNE69Po6gdhrIuTcxDGRQ==
X-Received: by 2002:a63:440d:0:b0:43c:5e0:121f with SMTP id r13-20020a63440d000000b0043c05e0121fmr3966046pga.617.1664473495199;
        Thu, 29 Sep 2022 10:44:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.161.36])
        by smtp.gmail.com with ESMTPSA id h68-20020a625347000000b0054aa69bc192sm6454852pfb.72.2022.09.29.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:44:54 -0700 (PDT)
Message-ID: <6335d996.620a0220.4b03a.b7c6@mx.google.com>
Date:   Thu, 29 Sep 2022 10:44:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3156832703770379981=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3156832703770379981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3156832703770379981==--
