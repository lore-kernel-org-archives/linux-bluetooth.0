Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A44AEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGJRhF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGJRhE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 13:37:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7D3DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 10:37:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-767b6d6bb87so208802885a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689010619; x=1691602619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+aKJK8CrHJJ6tlqiokj48ypXxZD7l2IAJM4TTgmp8U=;
        b=OWtRWM8gZyv6yOPo5S1nG9ntXsEoZ2W0eZy4ZhGSxNwvDeBSsn4oVKcuLlvuj1zMwO
         vQ3KqPPmeErko+kA9/0HP214RZ8HNLMFVGMoY4fRaROTn3A+UTi8/QB08Q9tyIkzD+GK
         B7kzN12QIPvEnmm1tOX9CFuEoh2zaUnKf/6ZczpAhh60D5XsOxJCGzKD2DEG2jNksMEE
         aNtyM1TpRWs6fz/cry6LL9N8QhNZJoV+pEdll3GW3bTjxZAi0vbmPHGsBJ0yQj/jPkh3
         vG8QGP+zxRLt80izPjP23054ViBVzgirKOEZmRSeuT1p10CifQkI6R9BQZaMIj6VFf1p
         hv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010619; x=1691602619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+aKJK8CrHJJ6tlqiokj48ypXxZD7l2IAJM4TTgmp8U=;
        b=evhf3LVsArj4KkmvlgTP5d0AD5+npnU8ayg+9kmVf9UH6eo9FyPIvETRqtixVmDjTE
         ibabYqgAebdxb2KfxYQr/5H4ZUTk7Vfll+ajsVLFfSzkgNdGBRY1FB8OO48hfociKEc7
         iONAv9tNOYfbChJuYXhxrefkwMEgjOCz6eYW+wPATFBOkATotM3mBqWtwkkm7C9MMMJm
         3SUpjE5Ed4q6DKmThraBoJz4+O3kQI2JmccBYUcpKUTFu3xm2D5bgMIBMijfXjBJw9hA
         SbEok16wnfe+XWneKf/wiRg0Kv2lc3Ly+qQR6GODoAXtENMmDrljIWY3pvxanuZTbcSz
         v07g==
X-Gm-Message-State: ABy/qLZcKCYxKakRw6QgsgCRj/24E3KuqpqDCL4Xe9DywX07cAgOwacs
        F6MoNzbOZamxnecy8/slyhCMbBskEL8=
X-Google-Smtp-Source: APBJJlFAHZtdBmX5JP2KSryRsHDf2LXto3W+5OA8Iw9n90zGBAxFEUt/cF4Qp6bbAwUC3WoBMc630g==
X-Received: by 2002:a05:620a:489:b0:765:84bf:3cbc with SMTP id 9-20020a05620a048900b0076584bf3cbcmr11021565qkr.36.1689010619481;
        Mon, 10 Jul 2023 10:36:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.17.160])
        by smtp.gmail.com with ESMTPSA id p13-20020ae9f30d000000b007672e3348edsm64065qkg.108.2023.07.10.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:36:59 -0700 (PDT)
Message-ID: <64ac41bb.e90a0220.ca49e.04fe@mx.google.com>
Date:   Mon, 10 Jul 2023 10:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4824294628464382359=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: SCO: fix sco_conn related locking and validity issues
In-Reply-To: <490b5c6a0e13047fd1bea42d3184b46623adc359.1689003801.git.pav@iki.fi>
References: <490b5c6a0e13047fd1bea42d3184b46623adc359.1689003801.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4824294628464382359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764106

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.87 seconds
CheckAllWarning               PASS      37.12 seconds
CheckSparse                   WARNING   42.51 seconds
CheckSmatch                   WARNING   113.52 seconds
BuildKernel32                 PASS      32.46 seconds
TestRunnerSetup               PASS      500.07 seconds
TestRunner_l2cap-tester       PASS      23.85 seconds
TestRunner_iso-tester         PASS      42.86 seconds
TestRunner_bnep-tester        PASS      10.82 seconds
TestRunner_mgmt-tester        PASS      223.11 seconds
TestRunner_rfcomm-tester      PASS      16.22 seconds
TestRunner_sco-tester         PASS      17.16 seconds
TestRunner_ioctl-tester       PASS      18.11 seconds
TestRunner_mesh-tester        PASS      13.46 seconds
TestRunner_smp-tester         PASS      14.88 seconds
TestRunner_userchan-tester    PASS      11.35 seconds
IncrementalBuild              PASS      31.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SCO: fix sco_conn related locking and validity issues

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
32: B2 Line has trailing whitespace: "    "
33: B1 Line exceeds max length (84>80): "    https://lore.kernel.org/linux-bluetooth/00000000000036b9590600095d33@google.com/"
34: B1 Line exceeds max length (168>80): "    https://lore.kernel.org/linux-bluetooth/HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com/"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4824294628464382359==--
