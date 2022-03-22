Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0421C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 09:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiCVJD2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiCVJD1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 05:03:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E224583
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 02:01:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id jo24so5767923qvb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RcUXXg/94f1ojRxqDUFqaT3rtZnUPDL2lOO+DRpnvuQ=;
        b=cnr5x6bPzzqmEWhPeS2jZLw01GfmWRzuNuzJIMyXdrP0hsLfNBQpqjpRV8Zzc9x03b
         TLUljWsN27yd6HC7/Pq+f0M9UhlSiXnJINWo9POYvPETFYBu2uMVfESQUU8pxjmVy4Yq
         qSoIOEzmxrRNfBobWgdpHXFXzpgJj9TWU1IqsxRk2MaEiys20TxgPvTurWRto1HtgNDK
         LvYKNzT6mVh7AZnWtM2S3+LKHeMJJPXcFNVryEiTTXO7iFDdNtQw3zES/jS8LdtHu5w+
         fiQqodutzOXg9OpSJJ/CC85MPCQ63dNdyyhmHNxpwYmGpiPgOfIJj3K75e1rxdyiLsHx
         zFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RcUXXg/94f1ojRxqDUFqaT3rtZnUPDL2lOO+DRpnvuQ=;
        b=L4AIyto7Btdp7vMlgWpyePz7OUJUqa3Tea4rEBb7KiiFLlETAtM+FT6LjjPg7Xzlo0
         NNmGWWCWy3iglaxLs+j5rlP6BUM72aBZUoVbupy5hGEHXae4FFSssawFlOmKizBIl7AA
         3eUcSxbh+lcJbX2MWnxA/i6usGFRkkNGvTc8YWdYWH/3RfkJxrx0AlmtiQWXAAshYFcq
         +JBjDPuLrvShf5oMje7FXBMHt5ExGn3Mc7kqPo0ko+7LCet1Bm2IMUd1HmMw1UDpsi1u
         u53wJ+MnSUWme1EuLscZ/PXPj4UbnUKoyZIVVa+SOEmWXBLSDMJSkxmkQFC0dV/BMq3O
         fpxg==
X-Gm-Message-State: AOAM5323OsaK1R0XGLOR6S7xLNGv5TPDzV4WPvv0AbD95kB1xqAM+hnz
        hMuS38JeTU8CAkI2Q7jDV5pt+t0g52sFDA==
X-Google-Smtp-Source: ABdhPJyiTPQXAyjTPx0SRVjFsuk4IPwnt10fkexUWHCbjAhZYPBPTn9IPfqo6QsNJ378hOZJv4KMaQ==
X-Received: by 2002:ad4:5ccf:0:b0:441:3e3d:316c with SMTP id iu15-20020ad45ccf000000b004413e3d316cmr3175491qvb.15.1647939718039;
        Tue, 22 Mar 2022 02:01:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.223.239])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a060f00b002e2070bf899sm7753277qta.90.2022.03.22.02.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:01:57 -0700 (PDT)
Message-ID: <62399085.1c69fb81.b5526.5224@mx.google.com>
Date:   Tue, 22 Mar 2022 02:01:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7309241506246023974=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [RESEND,v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1647937864-25661-1-git-send-email-quic_saluvala@quicinc.com>
References: <1647937864-25661-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7309241506246023974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625392

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      31.08 seconds
BuildKernel32                 PASS      26.31 seconds
Incremental Build with patchesPASS      37.21 seconds
TestRunner: Setup             PASS      483.06 seconds
TestRunner: l2cap-tester      PASS      15.60 seconds
TestRunner: bnep-tester       PASS      6.21 seconds
TestRunner: mgmt-tester       PASS      100.79 seconds
TestRunner: rfcomm-tester     PASS      7.91 seconds
TestRunner: sco-tester        PASS      7.64 seconds
TestRunner: smp-tester        PASS      7.68 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: GitLint - FAIL - 0.97 seconds
Run gitlint with rule in .gitlint
[RESEND,v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms
1: T1 Title exceeds max length (86>80): "[RESEND,v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms"


##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7309241506246023974==--
