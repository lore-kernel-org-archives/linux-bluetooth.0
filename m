Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09CDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiDZJ5o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbiDZJ5S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 05:57:18 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786834B86
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 02:15:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id q13so4706341qvk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2Sunl2tRxDJcBn5IVd4ehJwEhvv3TSdkz1RBfkKI+tU=;
        b=GdGkBTTpQmjZvhsq+rQuCmXnLwdxzNPSBAx2Rjd8QoYgYK1FK69/+CVrl3VDgDZQ7L
         BuN2ZM1VtJRw3yebeP+3suux3aIV6F+AGazRLgjUbkeRr8f/Wq7hjkKdtzejiv5KDa6U
         qLNNAGbgEzxjKX48ZZATBjnjrEv6MNggFvAmZilpT5Xwhp8mgjBQD6S3pYtofjUtT9BS
         DCV4e5THBME0IOFo2IBtoZY6kykLHgs6Pn2p2ZTrmBADjCO7BKOg2UfPkGi0vUUmsIGY
         NNS+vNv8VwPjBFud4vxNXyiWClUekmiSEPVzxrh+wxNE3j8/ceyfICqYesOsK2JPBj3g
         Hymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2Sunl2tRxDJcBn5IVd4ehJwEhvv3TSdkz1RBfkKI+tU=;
        b=vzze7LTO8gjoooZFHkGwRNIWNVYKN/KY842XwfuZWoJ/W5wUsXB1L6WO1s85eACkpw
         +dVeBmkeO9fF65MynRwj206vwRnYqswvjm8RXP6JBwqP2D52GnqnzakhG60/1qm4BBMy
         7MukJLYdKjfasDYOa+5LuqBHOZ8mq1OliIatY8i2irtFpIN7wGtcOgQF4C0mBvyBV3iQ
         HuJUSgkm6WdVhJxls6X6n3T2YhSS737gv+AjoNclAxh+eOT4xIihKCvlTi1WgROvSPSq
         251G1TPiwEZBw0lWlulLJsbIEX/xy2akzZYiR+O6NyGTh8gc7WhdzMsxUrSMyKGlFEl7
         R7Vg==
X-Gm-Message-State: AOAM53084e9NSof4kggIFAkLKffRYsZkvL/zJnpy2m9IkpM/lN8lb5oP
        Ng8F20lrdCL/knqXwGGtteN59jOQIrg=
X-Google-Smtp-Source: ABdhPJxB6s2Ty+Tyt37z1ZCsjeB1XZilqDOwwr/Q//qLW6g8He/X+L8/PpCo4sCFoR0Nege1AiKRjQ==
X-Received: by 2002:a05:6214:23ce:b0:441:8296:a11e with SMTP id hr14-20020a05621423ce00b004418296a11emr15556790qvb.16.1650964529641;
        Tue, 26 Apr 2022 02:15:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.101.110])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a152300b0069ec409e679sm6169794qkk.48.2022.04.26.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:15:29 -0700 (PDT)
Message-ID: <6267b831.1c69fb81.b0cad.1f3f@mx.google.com>
Date:   Tue, 26 Apr 2022 02:15:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6768824902047767877=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vasyl.vavrychuk@opensynergy.com
Subject: RE: Bluetooth: core: Fix missing power_on work cancel on HCI close
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220426081823.21557-1-vasyl.vavrychuk@opensynergy.com>
References: <20220426081823.21557-1-vasyl.vavrychuk@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6768824902047767877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635639

---Test result---

Test Summary:
CheckPatch                    PASS      1.82 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      31.45 seconds
BuildKernel32                 PASS      28.44 seconds
Incremental Build with patchesPASS      38.02 seconds
TestRunner: Setup             PASS      470.78 seconds
TestRunner: l2cap-tester      PASS      17.35 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      102.04 seconds
TestRunner: rfcomm-tester     PASS      9.61 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: smp-tester        PASS      9.50 seconds
TestRunner: userchan-tester   PASS      6.38 seconds



---
Regards,
Linux Bluetooth


--===============6768824902047767877==--
