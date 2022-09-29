Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiI2VaI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiI2VaH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:30:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A34D173
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:30:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so2527025pgc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+6iRruk9C/skZa7+zc8CJpw4vRGsIpe77Q12TvXlcio=;
        b=FNby7prfIUtcrtJDTf27HbSGYRmOzHJyzCF2nDDfnHRkv7qly7wcwnqnri34fJsSsq
         LwFN8ooKRB8/3U05Cqt37brwGEpvZu2smb1PZxtOW1zJLOqnEZix5C/LBWtnl5Xw3G2e
         XHXabTVyPoo0JscAw5z6VbvRmI5ZIbVOBBdEd4cq2GXst8/cmu5un55eWgU2M5pIwnrl
         e+INZiNACQ2qVzFZLDWbAlpoyfLr4XSQxy8ls94ZPBH2huzDYAkcAxAY6RdPxDUmq79O
         c65BQpbOIvvSmF54RxfRe0dl19opc1xJtn/jI8e/X/+a4T9Etvm64RobaJP8pPz9c11l
         2+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+6iRruk9C/skZa7+zc8CJpw4vRGsIpe77Q12TvXlcio=;
        b=H8nSqcIks5kxIz4KtBqq7K9ZYaEt/zl9IoJeIDNivTCXNvmF0rbZnWc3Jls+BFm+Bx
         2V60eMiDqRjT1PSkJDXDFs/dDob+Jez6jL0xm++iXJb+z77l3pa/xgnvTgtGPZ9gFD4Y
         oZ2LSM3y2hio0Dpw+gfssuQtOtk/tKmAhdk79lpRobmc/35HoYH1a5jFq2y2zy5p8T8H
         Y6BSHGX+SRiQKiC4VL/ipA4hyqMXPqA+mRgaP1yxl5p8XfdlM2IihLnM6TrojHZFxJl/
         NYOitjXyQCmZdXqnckhR24Wu8cbF9mk2aJZw4suSo66gww3BvJO3RzIneksB4NT+6TAF
         fScw==
X-Gm-Message-State: ACrzQf0giyPJDk3H0QT4DcPkQjM3dVYOSxsZZ5cJd5lpSqvikGSR0lXr
        KhwTQeXfd4j42VLQgTdPYvOXyBpbpzA=
X-Google-Smtp-Source: AMsMyM702xEdUEWiijFiWSGZ7FPSXKOnChKdsVnuHW3GUl9OVbpSpjKWxMcExOnlcuk0tKDYpDrX4g==
X-Received: by 2002:a05:6a02:309:b0:434:d151:639e with SMTP id bn9-20020a056a02030900b00434d151639emr4573290pgb.124.1664487003807;
        Thu, 29 Sep 2022 14:30:03 -0700 (PDT)
Received: from [172.17.0.2] ([168.61.6.117])
        by smtp.gmail.com with ESMTPSA id q26-20020aa7983a000000b0053e3a6f7da4sm157429pfl.12.2022.09.29.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:30:03 -0700 (PDT)
Message-ID: <63360e5b.a70a0220.a32de.0778@mx.google.com>
Date:   Thu, 29 Sep 2022 14:30:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1189554701478568936=="
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

--===============1189554701478568936==
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


--===============1189554701478568936==--
