Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC37FA3741
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJaWH3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJaWH2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 18:07:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7312625
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 15:07:27 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r187so14182874oia.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc3Xe48RO9uRPx3XGWfKeznOZQkGleXcPgDMKTYSJ4I=;
        b=SgFxg2W7oya/JMnz5Ge7Y657APE/nEOpEaXnfxXSMMnulm+S4nYCGjCTCz5Ug+GXR9
         dFMxv9JXy1Y78qIo7K9l1Fwa3/OmTtebV3p/3fjfDuNnXXjAIq96YiShcz+YhcbeZyvZ
         HltMsKMKWj9kNuK0kQMiYkILiAlBT3cvxV1gH1iPEi62svENZMyXH1iwMO7iI9VSN/17
         qdBTNcYgAf7cL+La00VMI0bGDWJ/hrkydfqbQE6gre50eRT9WXrCUvzkqZmzl7rnM890
         /P3vRXIUQ3DPKQwtQ3lnvSU5pa/qQdO2uP5tk0dhcwOtL6xAG7yMYbGvXkkqqIwnKEu1
         sshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc3Xe48RO9uRPx3XGWfKeznOZQkGleXcPgDMKTYSJ4I=;
        b=Lb8dBRxQ9VMglWP3QR2TeXcSPlWpj033vBxwnGgv2N1QcQ4c4mbSD39cqxIZyeTt1t
         5ojOpwbdCxVFcF89Mpva7y9r5yMG2xht+ZM0rySuuR4B1C3IMm4VLAecTP1rQUz/i2vQ
         zqOLEFVoCrpta+UOdMOhbcnYUFQmdQ682I4Q9pYQ8Z79KJjJ4Uz8rc+whOjZ7oeHxE6z
         wDFjL+G8mEknCFEoKlr+S/5j3M5gcHaDGC/I8ef/XKDrPExjieVnQ1lfhQT2K3seANE3
         ln19dkvw2r8SfQHMCYPMF/po7mt2NQLwudAaE8Oq2WMgjbB5R6x2bWzTuStMKsFrvP6t
         MSaA==
X-Gm-Message-State: ACrzQf24FZ6gQLOd87oZLPT2Q9kTBxzQ1ppuazrVuR8n5URIC5HrXf78
        P3nDfPS6Gnz3i34QIC9ffGDr4Y5s2x4=
X-Google-Smtp-Source: AMsMyM4mkAXwVQ58t/zdA7bYX6loAxvGGaqWojsZdK0GYII4P4ZJv9YSThVqsSNJcevg8tPn+IzrNQ==
X-Received: by 2002:aca:dec2:0:b0:35a:824:208 with SMTP id v185-20020acadec2000000b0035a08240208mr4367293oig.137.1667254046747;
        Mon, 31 Oct 2022 15:07:26 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.82.128])
        by smtp.gmail.com with ESMTPSA id y128-20020a4a4586000000b0044df311eee1sm2789566ooa.33.2022.10.31.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:07:26 -0700 (PDT)
Message-ID: <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
Date:   Mon, 31 Oct 2022 15:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8210114647755332516=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221031204804.195267-1-marex@denx.de>
References: <20221031204804.195267-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8210114647755332516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690631

---Test result---

Test Summary:
CheckPatch                    PASS      2.99 seconds
GitLint                       PASS      1.48 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      34.02 seconds
BuildKernel32                 PASS      30.96 seconds
Incremental Build with patchesPASS      54.02 seconds
TestRunner: Setup             PASS      513.84 seconds
TestRunner: l2cap-tester      PASS      17.53 seconds
TestRunner: iso-tester        PASS      16.75 seconds
TestRunner: bnep-tester       PASS      6.65 seconds
TestRunner: mgmt-tester       PASS      106.19 seconds
TestRunner: rfcomm-tester     PASS      10.48 seconds
TestRunner: sco-tester        PASS      9.85 seconds
TestRunner: ioctl-tester      PASS      11.30 seconds
TestRunner: mesh-tester       PASS      8.02 seconds
TestRunner: smp-tester        PASS      9.87 seconds
TestRunner: userchan-tester   PASS      6.82 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.58 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8210114647755332516==--
