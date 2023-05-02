Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FACC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 04:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEBE5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 00:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBE5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 00:57:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1219A1
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 21:57:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-61b5de68cd5so5380986d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683003457; x=1685595457;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oTygM03lgOlQMiKLwwdCPh/FDL3eoXimY/4nnjk+AkA=;
        b=ie3pLfSqC+NjLEHszcd29o5/jKJl3uPZ/bY6G23qOqEaq2Q3wQiHoIjxYbfYXI30JZ
         5/2PXWWLtGWBAXyD8ocs7MP8u2EScDMOBM/aWpM8X8tNQBZox1kIj1w5XrBmjiFSsjiQ
         ELq2bJ0oxliYgeBbJbyHzJkbHpOmLztZr94L3BdyEnC/PV58qhURqQhzCDeiQYNfyMH8
         mvnG4k9j8LWTMjrCAr1p59FtwTLhn9Levy80vz0oYVLmr4Np9BRG1vdlQ5cP1gmdAdvI
         /xTQhBOIvGqX/B+RAu9rXSPcEy31oCD6qzNStUHNEw6WOtaM7R/T3ORV7JvqVZmze7ah
         TIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683003457; x=1685595457;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTygM03lgOlQMiKLwwdCPh/FDL3eoXimY/4nnjk+AkA=;
        b=ANRS1sH1tTwNeg9ap3LdKNPGgzTh10bH7PQc1zucORWPviWSsgJ52j2pirg/SzoBGT
         5j/JmUixXQp4soVFFb+vW4+iq7J8mDzaLhTc8UNbbQda0fvRA49ZkOsOLtKGvN+/nBsY
         ZdCQvwZ/O1ZumBqnrCvAikPPXVBan8nx0mliOOb5wDzINQ1fdryFwem6qGKy0Zm8MJix
         gtwVUbp9PTJzKlBhDFfxoROzLdQNFK3R7Xx8rFomIsfSCJq1nLzanuSqAvh99wTI9ooB
         QRoPKxTm2t51cUhGFkJZuGAx0mv/L6X7LUBXYuU2FmK3xnmUqBLtrYXwbPO5+mSAzTFs
         YheA==
X-Gm-Message-State: AC+VfDwiBG1p01jqWehyy/uWBwri87hcyeMlC3AdaEy+YuK/SeBkWvjP
        BoEx05mbP/M5RDd3B8D7I6LWItZ2ZHI=
X-Google-Smtp-Source: ACHHUZ48fX30ZLoCS2yykOJGHKJxVW/woGjcJhFJMEOkMH+hcLQmQd9Lqg5sDiaOTHD+/CEsPsLT6A==
X-Received: by 2002:ad4:5967:0:b0:615:a18b:d5af with SMTP id eq7-20020ad45967000000b00615a18bd5afmr2414083qvb.35.1683003457043;
        Mon, 01 May 2023 21:57:37 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.166])
        by smtp.gmail.com with ESMTPSA id k5-20020a056214102500b006166d870243sm3618620qvr.43.2023.05.01.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:57:36 -0700 (PDT)
Message-ID: <64509840.050a0220.4d1dc.dcac@mx.google.com>
Date:   Mon, 01 May 2023 21:57:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1827542320054003045=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v2,1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support
In-Reply-To: <1683001332-29777-1-git-send-email-quic_saluvala@quicinc.com>
References: <1683001332-29777-1-git-send-email-quic_saluvala@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1827542320054003045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744296

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       FAIL      1.14 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.93 seconds
CheckAllWarning               PASS      35.03 seconds
CheckSparse                   PASS      40.17 seconds
CheckSmatch                   PASS      110.23 seconds
BuildKernel32                 PASS      31.28 seconds
TestRunnerSetup               PASS      445.42 seconds
TestRunner_l2cap-tester       PASS      17.21 seconds
TestRunner_iso-tester         PASS      21.38 seconds
TestRunner_bnep-tester        PASS      5.60 seconds
TestRunner_mgmt-tester        PASS      116.37 seconds
TestRunner_rfcomm-tester      PASS      9.00 seconds
TestRunner_sco-tester         PASS      8.37 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.19 seconds
TestRunner_userchan-tester    PASS      5.97 seconds
IncrementalBuild              PASS      34.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B2 Line has trailing whitespace: "Updated to work with the updated HCI devcoredump API. "


---
Regards,
Linux Bluetooth


--===============1827542320054003045==--
