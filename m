Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8280DC43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 08:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJQId7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiJQIdm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 04:33:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC04599F
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 01:33:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cr19so3998632qtb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3CvwWw2g10NCeHn1JlIhgiu2OpJPjgDDSlX4YIuEk=;
        b=cl3thKN3m6klHMOwwlJPKD3vWaBHezA2dHfPk/ycsMg06mSqQwjhq48guUnyri/kDu
         bYFueJcBcqqJM7SkHZz+Loy39XrwDwhHZNqnEgwwR/B+rGzyJz09WfKT4TrUBhiq1NxB
         ytqRSGE5ip14JA9+c8nGTm7vLIB8Y8cnIineqAe1JODgqGV3M10PXn3cyKfwZNFSOhg0
         HbmWDvQcm0f/INE8IhtZ4T84ZQ7+hjjMFjwGSaeJsZnMXTb3daPsmEmanW3c5svDOMAA
         Pkt33opBNEWA0KXXg01I65QEKg3fpyu0KNbLRqDH8U3GgxlZN9RDkBWozYfi7maiKThv
         1i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Y3CvwWw2g10NCeHn1JlIhgiu2OpJPjgDDSlX4YIuEk=;
        b=M2gjr1wH5Q/94tOeDSSiGYPYm+n0g9Yhk9Vtm0qWyq3cijKsxf+E44lvqYDv43kvGn
         BDrF0kQIGYv1vBVCO7bL97DlCM8jkAFIdcMeuPe/UBrT7vEbdiXVvEsbWfoL9fQMcMUX
         ZiDDMFu5YEQxbZHPiomwaXDA1s+2gYuwHDB6GwpJ/Lt/x4iTvRhB8BbbjDwlQ6AQ5Nwz
         syeFGFcu4OvOphLeZ0eXO8BbVZaMX7Btg3BaSGhKWeZLqDIrNIbrKEji3NSJiSdRadOa
         AP65kpYFMKQUJ9UuOcoYdPzExIZAfsFWlzozrhLFV6ALWYobhEWvFg4LHnE8G0TWjbOJ
         zMhg==
X-Gm-Message-State: ACrzQf35pbC1dsmF+qXqH5QCvkNj9+WAAKk8UFei9upC5F01LemzXs03
        nl90U204AX5L+HcZeKN2NrKgLgSSK7Ow5g==
X-Google-Smtp-Source: AMsMyM4oraOLQFlo/FGCAGFyRGa9y+nG0Y+VdJxAwr7kQUGXviSJ6FWN/4xrqeSiWTI0Eu9WQ4Ojpg==
X-Received: by 2002:a05:622a:1d6:b0:399:75bf:2cfd with SMTP id t22-20020a05622a01d600b0039975bf2cfdmr7763566qtw.578.1665995612921;
        Mon, 17 Oct 2022 01:33:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.206.186])
        by smtp.gmail.com with ESMTPSA id r187-20020a37a8c4000000b006d1d8fdea8asm8637546qke.85.2022.10.17.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 01:33:32 -0700 (PDT)
Message-ID: <634d135c.370a0220.9eb24.2ee2@mx.google.com>
Date:   Mon, 17 Oct 2022 01:33:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0803542433973779992=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shaozhengchao@huawei.com
Subject: RE: Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221017075813.6071-1-shaozhengchao@huawei.com>
References: <20221017075813.6071-1-shaozhengchao@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0803542433973779992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685728

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      35.42 seconds
BuildKernel32                 PASS      31.82 seconds
Incremental Build with patchesPASS      45.28 seconds
TestRunner: Setup             PASS      523.07 seconds
TestRunner: l2cap-tester      PASS      17.89 seconds
TestRunner: iso-tester        PASS      17.02 seconds
TestRunner: bnep-tester       PASS      6.84 seconds
TestRunner: mgmt-tester       PASS      109.11 seconds
TestRunner: rfcomm-tester     PASS      10.67 seconds
TestRunner: sco-tester        PASS      10.09 seconds
TestRunner: ioctl-tester      PASS      11.35 seconds
TestRunner: mesh-tester       PASS      8.29 seconds
TestRunner: smp-tester        PASS      10.07 seconds
TestRunner: userchan-tester   PASS      7.04 seconds



---
Regards,
Linux Bluetooth


--===============0803542433973779992==--
