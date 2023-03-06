Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4EC76186
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 17:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCFRfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCFRfh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 12:35:37 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B36A42B
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 09:35:03 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so11389832qtb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678124023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eHhtx1AJMnyugAXDtTG4apjSCFU1xBjU5PpQnOLBTNo=;
        b=nKNY9Vd6nBldlRE4F0uhxdmkjgO6noVegpmIKUPU+T46i3xu/sKORtZSlVxxlAoFnG
         AA7172ERBEptdZafO0tykQwQ7fX3QLjX0AKekEQP7juTeV/e+U+CbIz3WFlmhXfBdkEN
         STAkbBwwkGAzH8UjDo1rl2WnQMpgPHMnlG4qu9U6J5Exbax2czBqHWgV/xs37xXDxqzZ
         B34yklzdtY6++XBuJCtFRwNCTOIS3lIi1frATtqZe6L2n5fy/4ZFLsJKDViX2tiZqr2d
         dcF3F3thZpC7jDrSI8daLkSedyF0LLFGJK8e09m+dUIgwabppCrdXR90Ih03EVrPP9gK
         Cxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHhtx1AJMnyugAXDtTG4apjSCFU1xBjU5PpQnOLBTNo=;
        b=VjBuS5rhOeIlG4swXRa3r9Jse/cfMzS+KGVfZb+qtk1CaC9IP3n+K5r5ypWFxNF693
         sl1qTi/V6wV34QnrZSc8Iwx/5jzYQMMEUh1Q7N4p0Tdes5MSeKFhOTNwA+qhsEdmvO7S
         K1EL1N16/A8qIfyfU0IUl+JEJ2Lm4BnB+AZameCbP2dqgX2hj0IHXY/X44ZRzsgUNNbF
         01UIlDA/2oK+nNj6ELhOsDG36/XcOaPexskpfsk9su0br3U6GVp4nLL/Wb9w5HBZV1YC
         EwEh055ocZJNfk4oYUuOk8KNfT9EncsUVfEDz2R+xtKtEgxoqpPLA/5yQOBET6yghvLU
         ZqYw==
X-Gm-Message-State: AO0yUKVmSAh7lpmeILtYqcKS3wDzbtbPNeEbQaZhZL1dJvx6JgFQ3fZ/
        BV+hTVMv2CF051rF/o/pq1hC8FGv3bg=
X-Google-Smtp-Source: AK7set8CeW5WKr752H+UmWrSF66UC6Tz6vm2M8ZEkmC455KeK6G1EuykHQTusdkroJqYYZnsaO5bfA==
X-Received: by 2002:a05:622a:1a02:b0:3b8:5057:377b with SMTP id f2-20020a05622a1a0200b003b85057377bmr20275377qtb.65.1678124023140;
        Mon, 06 Mar 2023 09:33:43 -0800 (PST)
Received: from [172.17.0.2] ([172.177.254.83])
        by smtp.gmail.com with ESMTPSA id q1-20020ac87341000000b003bfa2c512e6sm7859294qtp.20.2023.03.06.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:33:42 -0800 (PST)
Message-ID: <640623f6.c80a0220.b8e4f.96f6@mx.google.com>
Date:   Mon, 06 Mar 2023 09:33:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1190282658081392646=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230306170525.3732605-2-neeraj.sanjaykale@nxp.com>
References: <20230306170525.3732605-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1190282658081392646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727005

---Test result---

Test Summary:
CheckPatch                    PASS      4.40 seconds
GitLint                       FAIL      1.37 seconds
SubjectPrefix                 FAIL      0.75 seconds
BuildKernel                   PASS      31.49 seconds
CheckAllWarning               PASS      35.00 seconds
CheckSparse                   PASS      39.26 seconds
CheckSmatch                   PASS      108.82 seconds
BuildKernel32                 PASS      30.72 seconds
TestRunnerSetup               PASS      437.10 seconds
TestRunner_l2cap-tester       PASS      16.23 seconds
TestRunner_iso-tester         PASS      16.73 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      107.51 seconds
TestRunner_rfcomm-tester      PASS      8.70 seconds
TestRunner_sco-tester         PASS      8.12 seconds
TestRunner_ioctl-tester       PASS      9.29 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      7.86 seconds
TestRunner_userchan-tester    PASS      5.69 seconds
IncrementalBuild              PASS      36.78 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1190282658081392646==--
