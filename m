Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E4FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 17:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiI2RO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiI2RO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 13:14:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830962AB9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:14:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c19so1259551qkm.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=/ghpmZtV9JK0p4HJmhe7/6QBmFDtmaWOP1zn9N57eGs=;
        b=Rt1iAE+oA1K9rJqLfRkJAFM5yWCJaY8SyEuqoid13/PUvkMTqhXzuOhobhXn+IhfDP
         C0YaZZQyDQmwPMuLRl6rFZQ45k5iPeJOMrYQtTqx3bHNbKaqte3WSqZxbWdz/cIngxlr
         YEuKKB1crtog3XLbzd5HXqqkDPZyyCT4wz++wBBWYBb682bA9nUqnfZuwBPdixzNm4LZ
         WqeLQngz86rNNLDo2RITbqPEJU1Q8EevQEDzmpwErD/y+kB3hzwPDvGyp+/e07te0CjO
         16TGV1XUEetTqzc56HUW09v7KdoKZa40JbeSQyngcHfmurT6O2T+BxYmmuh3sju9/qjz
         S6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/ghpmZtV9JK0p4HJmhe7/6QBmFDtmaWOP1zn9N57eGs=;
        b=6h3hDyLFuqbWhl304KrjjMyn95UgMlFHhTneRfmWMWl+g/L/u12aL5GEOme8WzbNm3
         oOstDD5tGScxGJxFxOBHnD3aB9C1nramqpb7lFRZEd0Wrgg76Wu6SfFuTTnDd4OysiBJ
         9njfa9FlV8CQigMH97yeiLYLWTietqP7Lyj96keyZhOXdWrO1iPgy/fp3+uuXhrX/1tk
         NUfmX4nLSCIXiqIpEcE/AJqUNPTzxHPaedepeSX9NT+GZcM8LKiYJfbYYqKlbpiSuyWo
         3d2QcmyGw9p1YCD39729CjGJwa/SvAsMDqLVhheTPQJxB/cdOa2DXYOdD/2CXkV0qHTL
         ykGQ==
X-Gm-Message-State: ACrzQf2Qr1ncusdozH8GrHn4pNtUylqPtdJGSxb/8dGcSOXqZQM/5MY5
        L8HQLOeby8hmVAsQS7FsebdSrTAR57a8Yg==
X-Google-Smtp-Source: AMsMyM5D2DSoURVVf8r0kaEACbVUlXwuEpzfZVaGganmEOpez43HzzkywFSRZYmbDNpDkGTg8XZVkw==
X-Received: by 2002:a05:620a:372a:b0:6cf:719:23f2 with SMTP id de42-20020a05620a372a00b006cf071923f2mr3160759qkb.481.1664471694238;
        Thu, 29 Sep 2022 10:14:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.139.35])
        by smtp.gmail.com with ESMTPSA id c22-20020ac81116000000b0035d43eb67bcsm5590579qtj.91.2022.09.29.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:14:53 -0700 (PDT)
Message-ID: <6335d28d.c80a0220.c06fc.1239@mx.google.com>
Date:   Thu, 29 Sep 2022 10:14:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4652914372590040797=="
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

--===============4652914372590040797==
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


--===============4652914372590040797==--
