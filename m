Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6CAC001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjG0JlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjG0Jkl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 05:40:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18483100
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 02:38:17 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bb29b9044dso656100a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690450696; x=1691055496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QfQDdgnltpgeS9gjJr0ef17CsCqr3yRj7nF/YVeUGvI=;
        b=C1zSmx6j5itHTG+772R8m9wRmXZdeL6w7WZEKQp1nO/5Z6j2u33befHA95Z7s92bOD
         O5AiEW9blky+LFNnSuMr02NikQuBfxQVTMuGq6j6yc0NhH+hftOZ5ZV1w58rt1Iu+5Nl
         KFcgkB4bEQT3xrMlJhcCV/hy8PV9A4u9CFl8SasI90aVoIRVMyyF7S4LlY6obuhxCOj8
         jzh1tVIBU0b672c1k5PapI9PSBS+V19E15+HJm6syPyRbPyG7sQ+O90AtsOzuMLWgLKX
         Xl4Nf2PSN7iHwEo4Qg8I5DSBkLu7jqWz24G7Ligw421SCX/IrmCw8hk/RL8A1JR7Cklv
         UKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450696; x=1691055496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfQDdgnltpgeS9gjJr0ef17CsCqr3yRj7nF/YVeUGvI=;
        b=bXHdpyyWa1BZh1r5hMa+5V3nEKd74fR4pA2vIoMi8Euk5vflu2mYqgBV8WFPA1Hlv6
         Dmr0QFwCOmgFhHsb8L+hHdTMP+4O6Uv8VMg8+/dSfFXArDy4wD2hdPMPMYRoAX4OneZm
         6PkcZCQzwXrFYtjlpl2KZkhMGup4RjnHi3V3kYsRLyjjBPSgDOz64PsZhWcneBgiKp/q
         eIKwxdGQIMYlXDEFHKkTCQitcfa1X4V8adIqZsAEep1d9XUooCNNja/HBXUIWCZSXCHj
         P4AJimU064TPxk6sOIGUW67JW048CI7bUWC+7Tuhj+1tA/XOwdqtf0v+vQ9g2TiNcxHK
         vL/w==
X-Gm-Message-State: ABy/qLY0dgQiIBJgA2ADDcD0TuA83IF/othpey/GWE6sBYE/HdDP1nPd
        ku8RcUv6TO7z6AU/xY26ZZt7ZfxDHD4=
X-Google-Smtp-Source: APBJJlEkmcM3Lvd1YVUUYL0GM8PNQV35XHiAFQR9erR+5npKW1aqZKgTTYX6ny0idWdeBaWRC0iTrg==
X-Received: by 2002:a9d:7306:0:b0:6b9:2b25:459c with SMTP id e6-20020a9d7306000000b006b92b25459cmr4800100otk.28.1690450695937;
        Thu, 27 Jul 2023 02:38:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.134.51])
        by smtp.gmail.com with ESMTPSA id r3-20020a056830134300b006b9b0a08fdasm465290otq.59.2023.07.27.02.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:38:15 -0700 (PDT)
Message-ID: <64c23b07.050a0220.54d46.223b@mx.google.com>
Date:   Thu, 27 Jul 2023 02:38:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8176999951124540734=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230727083555.1023992-2-quic_tjiang@quicinc.com>
References: <20230727083555.1023992-2-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8176999951124540734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770039

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      36.27 seconds
CheckAllWarning               PASS      40.16 seconds
CheckSparse                   PASS      45.18 seconds
CheckSmatch                   PASS      119.72 seconds
BuildKernel32                 PASS      34.65 seconds
TestRunnerSetup               PASS      533.64 seconds
TestRunner_l2cap-tester       PASS      26.59 seconds
TestRunner_iso-tester         PASS      54.97 seconds
TestRunner_bnep-tester        PASS      12.08 seconds
TestRunner_mgmt-tester        FAIL      237.13 seconds
TestRunner_rfcomm-tester      PASS      18.10 seconds
TestRunner_sco-tester         PASS      18.68 seconds
TestRunner_ioctl-tester       PASS      20.63 seconds
TestRunner_mesh-tester        PASS      15.59 seconds
TestRunner_smp-tester         PASS      16.09 seconds
TestRunner_userchan-tester    PASS      12.62 seconds
IncrementalBuild              PASS      38.15 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.942 seconds


---
Regards,
Linux Bluetooth


--===============8176999951124540734==--
