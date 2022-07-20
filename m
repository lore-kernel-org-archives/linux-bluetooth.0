Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580FDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 18:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiGTSN6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiGTSN4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 14:13:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3269F12
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 11:13:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so17085990pgc.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a/9RgTTAo0aVCG+hYv53p0c8AZYDpLSGqan9QpSo9Sk=;
        b=kz9WA8XG8cWTyoaLTSeALhNAw1g3692RowKVhch6WpseOPnP26qXWDtpXNtW0LgrMJ
         ljHYGei4qLZcm0EzwycPKONQEtX36BHUkhUs6uMdZUpvLyEk0pe+o1y648qwcirg8vkd
         qaBgMWVlSZC/3arcKuuMUYRSEWSPKm4N4DvDQ3Xy2oGGJ0erM1LzAnx4KAe4GgDoxLmO
         bWEGSfBsbDYJk2hcQeVo4WWhVI4wAehlymBHBKY3hW8od3mvuTycUNKU4Ilgmzx018Fm
         JaudaZl8n81lk8I7B5ZP0VQCmrAn3Ere7Wh0LaC0F0QSy8AxQ1/Xz+7WPq1clDYRpikA
         /yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a/9RgTTAo0aVCG+hYv53p0c8AZYDpLSGqan9QpSo9Sk=;
        b=na33ET0T1ShIsbVSfUXKmXj9X0dBws1neP6nFxXkBDId5FAT/6G25WzswIFLEyg6cs
         yGr/NiAGjXMxLHg+8quVTe4uyLsYaBhRluq/adnglS2SQWZulVjs2V+Cz1cGn4zl+oL8
         M7Qlag6QV1MP9ZoJyYsDVMfmeZ2ofCCUfFrGAZgLA3M3wcV4ygmzt3b6bbl/iqh1Vd52
         0+0QF8ZTt9LZGffL8mUjUJJ0chsqcNQFslWu1vByxzNlFLQY7zc6ZkLsdCIRB/qgpA08
         8YOu1nnF53/gkPGoFABvNpZ/4Cc9bmfrDxUE+x1UrHa08soI+sRee+4HvJr2LExQL+O+
         T2SQ==
X-Gm-Message-State: AJIora8iDnIepowfjOO/2V3gHXjFqiOlQU/DvNIhgq+LG6wrH9wTQUq7
        09reUNbwnLzy7cdt2+M6+lM7b3nqqN4=
X-Google-Smtp-Source: AGRyM1sZTs7/BvCJiPMtu6pzZXh3jDADAqF90PzbQ5cgobciw66/quIUK3ONlEuBaBUYJIj3EG5+tQ==
X-Received: by 2002:a05:6a00:b89:b0:52b:2bc7:68ab with SMTP id g9-20020a056a000b8900b0052b2bc768abmr32773359pfj.80.1658340833884;
        Wed, 20 Jul 2022 11:13:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.64.71])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00168e83eda56sm14333158plh.3.2022.07.20.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:13:53 -0700 (PDT)
Message-ID: <62d845e1.1c69fb81.5c722.5d02@mx.google.com>
Date:   Wed, 20 Jul 2022 11:13:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0050777807308024194=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720170648.148219-1-luiz.dentz@gmail.com>
References: <20220720170648.148219-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0050777807308024194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661544

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      45.10 seconds
BuildKernel32                 PASS      38.60 seconds
Incremental Build with patchesPASS      54.60 seconds
TestRunner: Setup             PASS      661.14 seconds
TestRunner: l2cap-tester      PASS      19.94 seconds
TestRunner: bnep-tester       PASS      7.38 seconds
TestRunner: mgmt-tester       PASS      122.17 seconds
TestRunner: rfcomm-tester     PASS      11.24 seconds
TestRunner: sco-tester        PASS      11.31 seconds
TestRunner: smp-tester        PASS      11.12 seconds
TestRunner: userchan-tester   PASS      7.22 seconds



---
Regards,
Linux Bluetooth


--===============0050777807308024194==--
