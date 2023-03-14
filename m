Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC5C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCNQEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCNQD5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 12:03:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB9B480F
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 09:03:40 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ne1so11725074qvb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678809819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EuAW/+RqBRdvA94bVDREoYr/osRD/NHjss1cEeWA0tA=;
        b=dFMSUobEE7AfvZtWaGELq9R4DFQcI+1GhJ/DvWkZIOydi1mB+DdBrUTShYD96u+5ha
         EsWJlg5kA6vKuvVLPqlj6UM8pfrqeiVkTPj3gWPiZENM3yyqwHkq6N9tGe08FgZ874m5
         d0DqpNpHk2r3ZQFg8h1/OSw5PwE2aPpExgusgDbBPjzocle1gTxWtgZfotxzcGuA1x83
         fguNoCDjIc1Bi1ILi6w9phNenpHLDZwVOI8gGXf01khsEyzi73RB9sYOLqS8KXdwTzVO
         hxKMuA5SdgvxIJ9E2Uf3RVpISKVtTCh5A3BcGgiGkjle3K3t5cXZUfJWgakXlDQSk9Kw
         Pd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuAW/+RqBRdvA94bVDREoYr/osRD/NHjss1cEeWA0tA=;
        b=1B+p33qOCFxf+bbAbHndtqGVLsG9zQXShpROvkj9g+rWfNcBdbP4TfNv+HjP9qvs7u
         zTUWW2t+VKzul8GBYQaNVMyB+NeLrsIDeKzKmJnmjN2Rt2grNyn3JnO6nxcX4cGuVI7p
         G800ZDsxwukhOo41iyimmVp9+lwzPvVjCq84gB/gus+dtTYeChhlRZY9AHz6jjTiMvi4
         CPP8tjmWawAKcIkYYVM0EPZjsaJ73FNprMM8oxdJjoE973tS2kNCGrm+0yc4+BG1kvDe
         atnpL8hFqabAACGtMeci+434YFp2C3TIVFYbAcWgXkeO3Rnr/ff4AYM/cnthoBCjzYh9
         xT2g==
X-Gm-Message-State: AO0yUKXMyuDuOP6gCVzO+xx6c0DoCRVavQhgkFot4knBK/gWMoWQ2O+/
        HrhJPy3fdCRf7k2rSEukg55mTKPc9tc0HQ==
X-Google-Smtp-Source: AK7set96zoFRTvMtOSewpFtAhXAw/d6lDhMMv/H56NVuW6iinqxWlYBiPXmgTKGOMiskvnxsvG+Tvw==
X-Received: by 2002:a05:6214:124b:b0:5a1:d44:79a7 with SMTP id r11-20020a056214124b00b005a10d4479a7mr22548925qvv.20.1678809819425;
        Tue, 14 Mar 2023 09:03:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.56])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05620a808e00b0073b967b9b35sm1957411qkb.106.2023.03.14.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:03:39 -0700 (PDT)
Message-ID: <64109adb.050a0220.32ba2.7ed1@mx.google.com>
Date:   Tue, 14 Mar 2023 09:03:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0328224477739934607=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230314153213.170045-2-neeraj.sanjaykale@nxp.com>
References: <20230314153213.170045-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0328224477739934607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729973

---Test result---

Test Summary:
CheckPatch                    PASS      5.29 seconds
GitLint                       FAIL      1.65 seconds
SubjectPrefix                 FAIL      0.86 seconds
BuildKernel                   PASS      31.68 seconds
CheckAllWarning               PASS      34.57 seconds
CheckSparse                   PASS      39.40 seconds
CheckSmatch                   PASS      108.93 seconds
BuildKernel32                 PASS      30.27 seconds
TestRunnerSetup               PASS      437.21 seconds
TestRunner_l2cap-tester       PASS      16.54 seconds
TestRunner_iso-tester         PASS      16.72 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        PASS      107.75 seconds
TestRunner_rfcomm-tester      PASS      8.61 seconds
TestRunner_sco-tester         PASS      7.95 seconds
TestRunner_ioctl-tester       PASS      9.23 seconds
TestRunner_mesh-tester        PASS      6.86 seconds
TestRunner_smp-tester         PASS      7.86 seconds
TestRunner_userchan-tester    PASS      5.66 seconds
IncrementalBuild              PASS      43.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v11,3/4] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0328224477739934607==--
