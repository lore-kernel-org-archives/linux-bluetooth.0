Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2B6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiI2W4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiI2Wzz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D612DE81
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:55:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c198so2688236pfc.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=tqJ12kllhr9sscNQ03xli5dWkMQYMn2smPZGfvdT5Nw=;
        b=d4vQUC/BME3NQVua9/eiGXwHz3zPMaPuKGK6QsBCeat4jcjIlRLIKlYCpbz75AtaaT
         hKGzxIhBiRYOeEUI+dH1VL1UlLcjK7uGqG5AkfMXrKYMTCdd1e8JpqpK9O6/xdFC9Ixw
         9/azcgLcK8XeONLJROlVV/XXDs7rhqV4QNlo74Sx7JvvW92TwHOtC+8tBaE86kPQLXjI
         1fXVXox1LQmP2eOT0kccXo4zrEQqzA329YqgnGO4W/54eFHe5Kg2BEYUYhLmvgUc8YhN
         hXFDzB5L0UPC8C067SLALkUCFGMEdFk/Wr74VQiW5S981u6wGos7wEQurOqDfNW9TLEP
         Rlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tqJ12kllhr9sscNQ03xli5dWkMQYMn2smPZGfvdT5Nw=;
        b=hRwN2kfcqjKLroUSFiwtTnPZSrMTe3ag875jOmGSeJKihh9fcxUv6gMtkbRCKzv8Hv
         gRQJJM+oZAPCGsIhu6zOG5xeKgbE+JnMqTmVioadm8ZxXA1EXr71KPeRZv1yHD5WK3ZO
         fsWGh8QD43EhsL2UpLMFJaYx50wwle7oPHTOHFoyLjJ0o8yECuszWK0iHVLFGQncynM1
         hoQQDuTiTNrNbxrzrs8NW0/Yi7NxXK6o4hgO68cdvNWPu5fwtJmwsPlNqlFTIOeLeQ/9
         Ki89iyCjpsytsd/eP1/C1nkVpJJl2o4o66vWZTn4Ruqk9KOUhvSd3uRv8FuaYc62sBxe
         stBg==
X-Gm-Message-State: ACrzQf2A5+SEWXlgWoDqSPp/9D1zy8y7lHjGvN9zjvKm70aBVjSR09PR
        SrOTj4daUV53mBAQ1whQEtWBL/247oIEnQ==
X-Google-Smtp-Source: AMsMyM72ldylUpD8ZqOXCsjNfgbo9BhCEXMv7Gg9YB5FdwKGCRQ51OsNOSOv6D4u/LRuc8/hl9lYvw==
X-Received: by 2002:a62:3814:0:b0:53e:8594:20b with SMTP id f20-20020a623814000000b0053e8594020bmr5852752pfa.26.1664492136811;
        Thu, 29 Sep 2022 15:55:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.38.202])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0016c50179b1esm411644pln.152.2022.09.29.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:55:36 -0700 (PDT)
Message-ID: <63362268.170a0220.2d0ba.1097@mx.google.com>
Date:   Thu, 29 Sep 2022 15:55:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2312789754124576835=="
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

--===============2312789754124576835==
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


--===============2312789754124576835==--
