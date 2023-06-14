Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2CEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 05:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjFNFhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 01:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjFNFhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 01:37:08 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB031984
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 22:37:07 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a6bd78fd14so1349013fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686721026; x=1689313026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vU7mbLmfXgcVIOWz3z5t3uf+827wY+gHh171xjK0DGc=;
        b=BEpdmNLlAEEh+O/e/hHvhESvBnDbPTR9HoHlUc0QB28rbqjO68xaI05D9n4EOO31Sw
         dOPQ7jHp7rovuoe7JpOvuTDrrwqXc4PAoZHDLc/6TFEiqhBUlMKyP3J3DuLgA8/viCib
         o0aVVz8cpEKUI67ChrMBchcARD62VvWZgHeoFF3Wt8c3Ffz6b5lY+/fka5qeikNTCO17
         jWhtlMSbrfNUbxbDGi8sU/VEmKCdCNADJo5siwoO8MyHefWYu//fq4Z4xxdnIdOLwANE
         Jm+vd0meOa9SWzBtXnQLHV59JOyioOsjBdJgUfD806DfQB55ncE0rOagbJwleAV353Ke
         53Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686721026; x=1689313026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU7mbLmfXgcVIOWz3z5t3uf+827wY+gHh171xjK0DGc=;
        b=ebfH5tmvMbUrzU6ZY/B9xB4R5uodUt6hLQoKLKLvmyQLGYI8EXWea6R58Pj8sZ7yEZ
         xOlBsNDu0yUdixef+h7aNh7T3f5vxu6kZMVcX7kXhU05Tu9rut8WF5x2DvQQRLTvwLJA
         rp7tP6sMdPQWp23r058RwbFhaPpOaPc/N3a5R3wkphgPHYk/vTkmjQgbpgZ8GPzOUGXB
         dGQ3E0PTo2Ssrx8WQKYUpOD7JQUfZdyW8Rz2RF6EE0ft/A4vHbNxst0ol42p5kNsPKN/
         AU2k3Sk90Sjks0YukJF+K4yTcHjFnFfTn/9opWBC19jk1qtQoBA14Dhvzq1HifIlzfeq
         7xvA==
X-Gm-Message-State: AC+VfDz3pkwelC+9f/5EHc+4UnS2zBlsnad0SjN+nDy/8j1KJFMmozgd
        bCnIAXPcJDLN+tlYycpcK0xNNPSO7qg=
X-Google-Smtp-Source: ACHHUZ7zoq7bIPVwckjK2PUjiIFSbuSNPIvXNBS1Vh7HxvD+6ZdREOiMqASQqyIaYgkDM7cwPV3OXQ==
X-Received: by 2002:a05:6870:6256:b0:19f:5958:3b01 with SMTP id r22-20020a056870625600b0019f59583b01mr9345981oak.16.1686721026598;
        Tue, 13 Jun 2023 22:37:06 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.182.65])
        by smtp.gmail.com with ESMTPSA id n9-20020a056870a44900b00183ff6b45a2sm5146767oal.10.2023.06.13.22.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 22:37:06 -0700 (PDT)
Message-ID: <64895202.050a0220.c23e4.9d0e@mx.google.com>
Date:   Tue, 13 Jun 2023 22:37:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7456416658728005728=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [RESEND,v3,1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs support
In-Reply-To: <1686718695-31734-1-git-send-email-quic_saluvala@quicinc.com>
References: <1686718695-31734-1-git-send-email-quic_saluvala@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7456416658728005728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=756942

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      42.25 seconds
CheckAllWarning               PASS      44.82 seconds
CheckSparse                   PASS      51.92 seconds
CheckSmatch                   PASS      139.51 seconds
BuildKernel32                 PASS      40.26 seconds
TestRunnerSetup               PASS      573.20 seconds
TestRunner_l2cap-tester       PASS      20.76 seconds
TestRunner_iso-tester         PASS      30.31 seconds
TestRunner_bnep-tester        PASS      7.26 seconds
TestRunner_mgmt-tester        PASS      141.61 seconds
TestRunner_rfcomm-tester      PASS      11.10 seconds
TestRunner_sco-tester         PASS      10.71 seconds
TestRunner_ioctl-tester       PASS      12.69 seconds
TestRunner_mesh-tester        PASS      9.25 seconds
TestRunner_smp-tester         PASS      10.17 seconds
TestRunner_userchan-tester    PASS      7.47 seconds
IncrementalBuild              PASS      45.20 seconds



---
Regards,
Linux Bluetooth


--===============7456416658728005728==--
