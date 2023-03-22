Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A7C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 02:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCVC2D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCVC17 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 22:27:59 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE1AFE
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 19:27:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s1so3251006ild.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679452075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=57ZqRAjN7+myYAtJMqJ1FKTkWWeGUxo/rCENjLtTmZ4=;
        b=PczdkDRpw19bvggDOKWki5HWf4y7jMNTM1UJC6V59aH5LGcELJmcFMRIOtakRRnMbY
         p6n1zVt6SXJNPPybHaUymrtS4+jEXaF7ObCpI3UljO5POQXzLxtMqxtmrkVNqRbDSvJh
         pxa7G0ClCE9A75AgzFiTQCi4T/to4ZYDlHEsAxnYduWH9CskplefH7QHoMS/hNn4EnBO
         vm8IaO6F8H0TM1IoYoU/Tu7+aagWUlE3xlH2EPrQbDlii8T27qVIhXW1e/vVUDmOYrnc
         1j23vHT09J7n6Lwdb3S3PzBjK+qVZVia/VsFWDENwCUBeIJgmJSgHNE9VWkC2kN8ojWo
         TFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679452075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57ZqRAjN7+myYAtJMqJ1FKTkWWeGUxo/rCENjLtTmZ4=;
        b=gzGM3BL39I26OKrPYytV/H69/e2JmuFmZifKaVdwrqmfPmNNrczN/GRIwRGQjeZvYT
         KaELH30agVpCrKWeZyfhsoPHamTMH3XmbbLli6B9kp+WfqjGFAeTW+l5UUcjvDvpFOfH
         HOVqpUa9zympMGfbdfpNrd2XZqeErWVHMvuyvxguuDlj3eNYmmfYRFkTr34vf3fuGmmI
         QWCHWH8iWVF1VTlm67ggG349Lholg1uT4C3LOeRjXBrpEOtQ6zZfw3sboqe1Jicpoysc
         gz83cAS3ozQTMGL+dUfDqzgJSmpevVHHEIHZSVXeEXV3JYt9kKA1PofSCIMAEZapKWCg
         Z74Q==
X-Gm-Message-State: AO0yUKVM8HJi5QbrZRGA7lf6DziiE+XBxFIohewSNhy5dcqx2XpNIykP
        rJSRjKFO4PH5F7eoYC83v4/n07qEMg8=
X-Google-Smtp-Source: AK7set+2FA7YO0nPoP0zpTBBLo9U8Z4d/j7f8NREbi0Hp3lgIzCx15/ng4qrnSN+VzxYDlibfJw27Q==
X-Received: by 2002:a92:d3c7:0:b0:315:56ab:1705 with SMTP id c7-20020a92d3c7000000b0031556ab1705mr3223765ilh.27.1679452075466;
        Tue, 21 Mar 2023 19:27:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.2.171])
        by smtp.gmail.com with ESMTPSA id e41-20020a02862c000000b0039df8e7af39sm4791893jai.41.2023.03.21.19.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 19:27:55 -0700 (PDT)
Message-ID: <641a67ab.020a0220.2a7ea.a107@mx.google.com>
Date:   Tue, 21 Mar 2023 19:27:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1223961148506384218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: [v2] Bluetooth: Partial support for Actions Semi ATS2851 based devices
In-Reply-To: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
References: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1223961148506384218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732542

---Test result---

Test Summary:
CheckPatch                    FAIL      1.39 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.21 seconds
CheckAllWarning               PASS      33.98 seconds
CheckSparse                   PASS      38.36 seconds
CheckSmatch                   PASS      107.42 seconds
BuildKernel32                 PASS      29.97 seconds
TestRunnerSetup               PASS      436.34 seconds
TestRunner_l2cap-tester       PASS      16.75 seconds
TestRunner_iso-tester         PASS      16.64 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      108.73 seconds
TestRunner_rfcomm-tester      PASS      8.66 seconds
TestRunner_sco-tester         PASS      7.90 seconds
TestRunner_ioctl-tester       PASS      9.30 seconds
TestRunner_mesh-tester        PASS      6.82 seconds
TestRunner_smp-tester         PASS      7.76 seconds
TestRunner_userchan-tester    PASS      5.57 seconds
IncrementalBuild              PASS      28.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: Partial support for Actions Semi ATS2851 based devices
WARNING: quoted string split across lines
#198: FILE: net/bluetooth/hci_sync.c:4534:
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported."),

WARNING: quoted string split across lines
#201: FILE: net/bluetooth/hci_sync.c:4537:
+			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

total: 0 errors, 2 warnings, 0 checks, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13183456.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1223961148506384218==--
