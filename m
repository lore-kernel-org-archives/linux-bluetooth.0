Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D680C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKBRdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKBRdC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 13:33:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E0CE39
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 10:33:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r18so16795843pgr.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Nov 2022 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPvrYeIyYQuSHXDFmtNjQkxhzS6/ceZqEjDTjg/DnC0=;
        b=G6y5PTiLCDwR1xLQi+P6UswZbbSW3SHcUAn1OK9kOknjJPJ/XF7Mwtkk4MYS+Oq3hE
         AykQ4Mn8T1LUlpTUNxfyKPL3zZGo2CbUyb8T0OLbwxqIb7DEoLzSWWdtyW/QhHBhIMhv
         ok+WQSnJNF06v2l3N3F32dQbPlZQtEYpPRJuudoMJs+b/WRGnJcKMq5duVI309l5o/mT
         mBZkVPnkTIZJ6s0KK/STCNwD0jZvCPDRoWw3+q7hhBuGiP7cwqBXUyTiz+u88I4hFdeV
         SKkNzW5ik9CWZf28R5CtAbDnuq0VEAaAzNcIF0xo/daw+YQ+hN2SW8TboatlwEgNQmIu
         kRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPvrYeIyYQuSHXDFmtNjQkxhzS6/ceZqEjDTjg/DnC0=;
        b=7nFnw6MNHRSoh3sDek2ZkeT6AoWHgIJ62N1sHwdb2zDfuAeSzJPO5RJ5ZLumFDJdBZ
         dEZPyYrRtmu9Se/LVps1rVC2dZSSG0zQnv73+WIWxDRpJRhwbsqChfKLN94H0ON9zYrg
         VaxsaNEOl9DR5GPOHgqczdyh5Jq68pgSF514KRpHYoezJdIs1DaNY5wRTU58zc/alZGo
         Ky6MEYJNMUhH8zaebAUBjomkDDJNDUFT6ABGEkCjyajbJx9L6TATijzMd5nwv7ctmLIH
         xTUr0DeZEM72tM5hHbi3DNXUJ3TIAEsLgH1pBwqUG2VlUTal5jT2W1543FPHQYc2PC80
         UTKA==
X-Gm-Message-State: ACrzQf1fBnjqtBmhH2CNyvrZk9AZzWFBpbnJ8FCaSE51a98zuwSC5Hk4
        AVC3c8JlG2AHQs6SZQRA8JcPIxZxS9dsLQ==
X-Google-Smtp-Source: AMsMyM7yB98JW+spdsXI3xX9VaWdZm9CpRJ2u8ruFZ6DsikHExwROJxad5AmSzNZhC52xzaEXGFC1A==
X-Received: by 2002:a05:6a00:190a:b0:56c:123e:3e61 with SMTP id y10-20020a056a00190a00b0056c123e3e61mr26152357pfi.47.1667410380561;
        Wed, 02 Nov 2022 10:33:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.93.167.25])
        by smtp.gmail.com with ESMTPSA id z20-20020a63e114000000b0046fe658a903sm3517550pgh.94.2022.11.02.10.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:33:00 -0700 (PDT)
Message-ID: <6362a9cc.630a0220.88da.6f81@mx.google.com>
Date:   Wed, 02 Nov 2022 10:33:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8227352605660888686=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [v2,1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221102164705.14538-1-marex@denx.de>
References: <20221102164705.14538-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8227352605660888686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691310

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      46.24 seconds
BuildKernel32                 PASS      41.91 seconds
Incremental Build with patchesPASS      68.73 seconds
TestRunner: Setup             PASS      679.47 seconds
TestRunner: l2cap-tester      PASS      21.71 seconds
TestRunner: iso-tester        PASS      22.51 seconds
TestRunner: bnep-tester       PASS      8.52 seconds
TestRunner: mgmt-tester       PASS      143.45 seconds
TestRunner: rfcomm-tester     PASS      13.16 seconds
TestRunner: sco-tester        PASS      12.39 seconds
TestRunner: ioctl-tester      PASS      14.48 seconds
TestRunner: mesh-tester       PASS      10.53 seconds
TestRunner: smp-tester        PASS      12.39 seconds
TestRunner: userchan-tester   PASS      8.81 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.34 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8227352605660888686==--
