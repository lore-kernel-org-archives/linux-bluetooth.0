Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA7C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 09:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHCJka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjHCJkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 05:40:16 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E6FF
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 02:40:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c711a889dso490870eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691055612; x=1691660412;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tIIC0uhNaMCHUV1MUb2kGLPH4gEcPRysNzl79Ql47tw=;
        b=C4SioWKeARcMmhDdf9BTQPLrPDrqUuPOHDqKdmOxuDaCPGW87mgtk2LpcjHQUIKpvQ
         rksvPgYHnzMvkbFzlwOmxX27iIOSQbH9U8BeXkw0v62ffkSsXv+tCptZDHAMOHj6JCLG
         lox6nOEm9Qj4PHShOnQCAGvqqG8HNKqBHPlsRM7ulP/9hqQEMvRdNy/vbvf18mu2+FzB
         KbqiisjItQctW2k9np3aTCDOyICjyu08UirCqDOYCO65mws/K6BmnhK9fmnvQjw82P+G
         ac3GUKDpW5m/uNemZsdkULrbHUgjBmUZ9DAO93NORs1zBZZVGbv1IdubeRU1Dw7J3aWN
         be7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055612; x=1691660412;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIIC0uhNaMCHUV1MUb2kGLPH4gEcPRysNzl79Ql47tw=;
        b=agPptF6BLZ+tL03mgDaMb+mpxCiLkJaoTXGyU3L3K0P5fhS0ucmtKSFlOyD4VhUbKL
         b0VHcAVn6NcNzf8Sdhn3Rj1sztQNd/8Um1s6c3HZ/VIO1txmtgQMK/fT9k5bLsZL1e4t
         9STgMx7N9PVV/wwbMWHemJxiuorW2ArsZSvjEvddPgMciT2l4QW+9yD+izmcUIoBQtX6
         cHDDDcuebASgOjOcCDPLWFmDxxcq+WtEhZYgbCGuqhHFbPgjEsZXY7tGGT7ZdoWhrizS
         a9nEor7IdN42nzFrfBANrcZHODtC+wGTUXMzOPwpm070xzoGsthSSfDNWjMygHYY4hkO
         xnHQ==
X-Gm-Message-State: ABy/qLZytWePLn80YV4Wmn/RNp5zMIFdaGALocUP9YelWuezolZce9tM
        U5bNnXVLe7/43OcExFCUENSybVPjZs0=
X-Google-Smtp-Source: APBJJlEDZ0b6qdbv4mGI6sR55eUze6DP3UT+jJwhs6WDMUBmSonbQhC+g8kuTeP8BEpa13oSFvUP8A==
X-Received: by 2002:a4a:6c5b:0:b0:56c:e928:2889 with SMTP id u27-20020a4a6c5b000000b0056ce9282889mr7394938oof.3.1691055612306;
        Thu, 03 Aug 2023 02:40:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.176.205])
        by smtp.gmail.com with ESMTPSA id v2-20020a4a5a02000000b005660ed0becesm7221932ooa.39.2023.08.03.02.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:40:12 -0700 (PDT)
Message-ID: <64cb75fc.4a0a0220.c0e92.0616@mx.google.com>
Date:   Thu, 03 Aug 2023 02:40:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0822135193808348804=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neil.armstrong@linaro.org
Subject: RE: bluetooth: qca: enable WCN7850 support
In-Reply-To: <20230803-topic-sm8550-upstream-bt-v3-1-6874a1507288@linaro.org>
References: <20230803-topic-sm8550-upstream-bt-v3-1-6874a1507288@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0822135193808348804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772514

---Test result---

Test Summary:
CheckPatch                    PASS      3.09 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      39.20 seconds
CheckAllWarning               PASS      43.11 seconds
CheckSparse                   PASS      48.53 seconds
CheckSmatch                   PASS      130.89 seconds
BuildKernel32                 PASS      37.86 seconds
TestRunnerSetup               PASS      576.58 seconds
TestRunner_l2cap-tester       PASS      27.60 seconds
TestRunner_iso-tester         PASS      65.42 seconds
TestRunner_bnep-tester        PASS      12.76 seconds
TestRunner_mgmt-tester        PASS      238.21 seconds
TestRunner_rfcomm-tester      PASS      19.13 seconds
TestRunner_sco-tester         PASS      19.71 seconds
TestRunner_ioctl-tester       PASS      21.41 seconds
TestRunner_mesh-tester        PASS      16.12 seconds
TestRunner_smp-tester         PASS      17.12 seconds
TestRunner_userchan-tester    PASS      13.60 seconds
IncrementalBuild              PASS      48.41 seconds

Details
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


--===============0822135193808348804==--
