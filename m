Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A7C25B08
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 08:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiHQICW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiHQICV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 04:02:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6A5399CC
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 01:02:19 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n133so14675277oib.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=VoUz3V0kDl+Y6qNoPlxsZLMPWC3+D4QLYM5TzDEZAgg=;
        b=bzjit7Efid6aMgUDgha7y1/VDNx2a/me86txIL61EJiAtcQGsv8PpTC/10qHIRLTGn
         7IUmJePRqKWffa/kEQD3fcnBMztuo9PLExEsb5oja8Tca/YUJEG+l0H1UWrpZBB5azz8
         a6NOszgoKefkLBbZ326h0t40t5qtSws0w/8+vuRz/ctwekbdEjDiHzQQc8lxf9Q+U8tN
         E2ZMzEds0ISU9+dQw8OrkU9Y34ajJ7Tm84CxCEixyoZ5pFjVadWE+6UlWKO30gPy5YJC
         BDzPe1iTer6ixgYkcIyDh3WWuifYWoRGQUgqFC53FejGzPdlw3d1Sr/ho29upVqNLTU6
         dcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=VoUz3V0kDl+Y6qNoPlxsZLMPWC3+D4QLYM5TzDEZAgg=;
        b=qoRuW8nyMk9oty6FK585pSw2qO/istMl6SMz9YqQD9wBAbEjqenzyVgsJO0Jh/J2R3
         X8IOimxcR+DJZcgUhoiAm/XE75yMqksYeUm1Y6CcIC3VtsQ/nuSuG+ozwnD1QOfvJnjv
         vS62/FKokij7LCbSRaEN/8vihOACCwdfWOPNvzQVfSw4nAV2k7cdQHZKfe1lDRNS4zid
         puI7GWGkDwfAm2CLJNb1vYDd0o9VLJqDrcPxutcu6h1Fid6Ty4M7isiuu6h6sjFe3Zal
         kdqWuy9ac2PLBIvGpngbhnpZS0g78nVQU+7t325SLBx1Gdk84Z8E0iAquiNXdac8UKxu
         a4cg==
X-Gm-Message-State: ACgBeo2FCZ6dqiR5Qpe54iFXDxW3WVcBhCN+01IM7S2NOKUsAYkpoz59
        MA/k4U3U9nJRgUD8cJGnSjE54zGy9Rs=
X-Google-Smtp-Source: AA6agR6+iC3RIUwslyXyRPIREm5zfNMKmNl+majH01XbKop9TznsKTtKTgT1zu2qFMxj/QRUq5bXCQ==
X-Received: by 2002:a05:6808:1287:b0:344:d266:4ecd with SMTP id a7-20020a056808128700b00344d2664ecdmr1001968oiw.88.1660723338788;
        Wed, 17 Aug 2022 01:02:18 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.193.130])
        by smtp.gmail.com with ESMTPSA id c9-20020a9d75c9000000b00616d3ec6734sm3198706otl.53.2022.08.17.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:02:18 -0700 (PDT)
Message-ID: <62fca08a.9d0a0220.76a1b.b368@mx.google.com>
Date:   Wed, 17 Aug 2022 01:02:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6161682849277656799=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Workaround for spotty SCO quality
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220817065807.21824-1-hildawu@realtek.com>
References: <20220817065807.21824-1-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6161682849277656799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668292

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      33.57 seconds
BuildKernel32                 PASS      29.41 seconds
Incremental Build with patchesPASS      42.91 seconds
TestRunner: Setup             PASS      489.65 seconds
TestRunner: l2cap-tester      PASS      17.32 seconds
TestRunner: bnep-tester       PASS      6.68 seconds
TestRunner: mgmt-tester       PASS      103.67 seconds
TestRunner: rfcomm-tester     PASS      9.96 seconds
TestRunner: sco-tester        PASS      9.95 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      6.90 seconds



---
Regards,
Linux Bluetooth


--===============6161682849277656799==--
