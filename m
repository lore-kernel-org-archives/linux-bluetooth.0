Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiI2Vv7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI2Vv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:51:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B92126B72
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:51:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u28so1744735qku.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=J4RhRJg7ObNPsE7wVrh1Xl3nZ6Spny4EAmEiZHkHWeo=;
        b=TEDy7jgzamNKb1y/vSC8i5RRy755ArhpAEnXpe/zueN7Ykx8QdFWzr69Z60N97BRwC
         vs6IxjX/gQtOc2yJCcgq5k15L1JW+0l5jmud3Z7XOdxQLEoV6OIWQk+shvev5BTUzopo
         yauOlzypdub54BSXQLV/nv9xeNo8qi9To8hhCuWODQiO/8ftyKBAyhaFgLBZTrfDAp22
         GuBCvh6UlQ0o/I26ExJUaVI6VdzytdRtbDM5qCzAZrOBtGMnWk6jKlxorW9FaFJixSR2
         PwaUJEIwVqWMjwuGbf/1gOOfZlioTLupQD4POAs6SVOTIOKoOwtng0hSTSJ3zMqu+9/F
         VDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=J4RhRJg7ObNPsE7wVrh1Xl3nZ6Spny4EAmEiZHkHWeo=;
        b=sgGJx7SABjnZoC//JP4uMHucSnB1/jvFyRxAp7zsrGSD3RslGX0PWLB5OyAqMQqymE
         IGeecRr3v/I1Wvlu+WvtypJxSBaUi6uvLwycg76MmpUPmZyN43Py7vp1M07vHpWvpXHN
         S0RQ6J+i22tdfMU/Y8w4iG3h/vL1CpWCS/wkMSm5bHnMrDNX+LrTYS0tTvZBOsev2aDt
         oTvH+3TMGlWY/+AmnNwxX1NMAeoA2Ok4maRGAwX8UE4bsoNrxx+B62J39SHrBWH6OL/p
         dH7RYvq3PfX8CmIfbN8stEsICqdGZigx87hbzucxOZz/R3AmYz2IJF4QxnQjGyGVB7b/
         XkeA==
X-Gm-Message-State: ACrzQf0CAUpQSEAWfeAMoSAwSRaZ/t3/XCKyQwUiTNvgueqHU7Xz4OdX
        uKB+kbG3GpKPgJBNP1SpY5jBQlZqYiC+xA==
X-Google-Smtp-Source: AMsMyM4dxmaWEneSqzi9FnqrhQFuY4J9k2AqdWE/fGcne68vyEqaRwFlk/E1yTRzMsUkpZa7b/UZyg==
X-Received: by 2002:a05:620a:240a:b0:6ce:d370:feac with SMTP id d10-20020a05620a240a00b006ced370feacmr3920999qkn.154.1664488316529;
        Thu, 29 Sep 2022 14:51:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.145.230])
        by smtp.gmail.com with ESMTPSA id t26-20020a37ea1a000000b006af0ce13499sm518640qkj.115.2022.09.29.14.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:51:56 -0700 (PDT)
Message-ID: <6336137c.370a0220.4dff5.1f06@mx.google.com>
Date:   Thu, 29 Sep 2022 14:51:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1972283474268347851=="
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

--===============1972283474268347851==
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


--===============1972283474268347851==--
