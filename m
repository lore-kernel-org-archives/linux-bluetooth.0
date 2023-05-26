Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80323C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 01:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjEZBMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 21:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjEZBMx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 21:12:53 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D802194
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 18:12:51 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19a36435e81so1189911fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685063570; x=1687655570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yKG0Qb4fQ8oN0IhFWTq5qA+zPUjwWrbst0eAvEHv5iA=;
        b=OAChMTXNkVX3gUeT3FyYxDM2APkqATwRj5xnkIQyG4jBdHdM8GNQSHWJq9Fo/+JMre
         tH+OIL4VyngUjTktLOWAdnJqVCvLC00CMrPfZl4JScN6hJ0qPk9cV/Xeof5FP60JRFC6
         T2Mu0ZS4ljAiGEEF9eE2ghvf/Encxb9ePxdmfHFp+du+sp/giJ4lfRropOrygIvpt7Tb
         hJ34lck7YSAcrG3I57vIGpDlcjOJGXYDUrKHYD9DyEc6a1Yx0yQQSo9AWVhabIKkUJkL
         duKJVYS/m6zFky2qK8umssn6S1r3MG8EKtkamDcCWDDsF5ArwMYRGdOVtNmVKFBUgIbL
         D6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063570; x=1687655570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKG0Qb4fQ8oN0IhFWTq5qA+zPUjwWrbst0eAvEHv5iA=;
        b=Tz0rXUCb0V8to0At5kA9jcbay3Lx4+6TS7gDbTXcfC1yGtAJ1CNipC2htMUODclU4K
         A56usi8N3nERMMANAbf/dKp+BPc2Zp/IMnIXorqRjNI+b+YukckY5YFI9maKN6+zfgk2
         izYksJtMSDu8RvLTW3Wer4FD7oywv2NnZP3pk9YI7mQyGB1EVTRfilH17GqNjqbwgSxj
         Rnyd82YMTC4SQ98MU5P2sBG5Twy8hCEns0wjUu4IeR5Cq4djnuNspHYY6LSr6mUCMzb9
         Q7p2XQCQ8Yz5z+zSbRBqh8/o7vXpYDNvEUsJnQUguER1yjSZgahfN1BiwjUFGA1boQPr
         CbKA==
X-Gm-Message-State: AC+VfDxdqwplSy7Yhqc8KpUhv61f+RX9yQ2hUhDdCUMqhRdeFHl0utaJ
        CgJjSOL3kewxBT0OroKLQXm5XvLvZHY=
X-Google-Smtp-Source: ACHHUZ4+LtGLKNhzr+E6z19JiRDhpkcx8FIwkCzwXI2eE3hb/JiblkfWAoa2lmnhrbNqnM3cstXA0g==
X-Received: by 2002:a05:6870:f5a8:b0:196:5d42:b979 with SMTP id eh40-20020a056870f5a800b001965d42b979mr2163922oab.3.1685063569933;
        Thu, 25 May 2023 18:12:49 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.10.113])
        by smtp.gmail.com with ESMTPSA id b9-20020a4ad889000000b0054fbd6f4ef0sm1045132oov.0.2023.05.25.18.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:12:49 -0700 (PDT)
Message-ID: <64700791.4a0a0220.4f660.5b12@mx.google.com>
Date:   Thu, 25 May 2023 18:12:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0886199022754526047=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/3] Bluetooth: Consolidate code around sk_alloc into a helper function
In-Reply-To: <20230525234643.3597907-1-luiz.dentz@gmail.com>
References: <20230525234643.3597907-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0886199022754526047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751132

---Test result---

Test Summary:
CheckPatch                    PASS      3.53 seconds
GitLint                       PASS      0.89 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      32.46 seconds
CheckAllWarning               PASS      35.03 seconds
CheckSparse                   WARNING   40.09 seconds
CheckSmatch                   WARNING   109.47 seconds
BuildKernel32                 PASS      31.02 seconds
TestRunnerSetup               PASS      445.53 seconds
TestRunner_l2cap-tester       PASS      17.24 seconds
TestRunner_iso-tester         PASS      22.16 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      116.58 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      8.51 seconds
TestRunner_ioctl-tester       PASS      9.77 seconds
TestRunner_mesh-tester        PASS      7.22 seconds
TestRunner_smp-tester         PASS      8.29 seconds
TestRunner_userchan-tester    PASS      5.97 seconds
IncrementalBuild              PASS      62.26 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:207:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structuresnet/bluetooth/af_bluetooth.c:207:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0886199022754526047==--
