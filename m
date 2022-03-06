Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D134C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Mar 2022 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiCFXBG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Mar 2022 18:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiCFXBG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Mar 2022 18:01:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55475D67B
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Mar 2022 15:00:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso12078235pjq.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Mar 2022 15:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4pJ/pcxwIYmi16cgb/ptO1VKPQ+U4fJWbnJ+Q+Z57hk=;
        b=pq6ehFKM1nZMSwcgvFc9RXfKMQnf3rpUPYlgvyjOvAgvZ3bxbqXV2qxuPFKoU/SfnK
         SjwiUi/9j6bLvVEcSPoAfoV5P7RzkPQP32gF+2UnajIkMZ9JqOXlG2hKcYRtcv/NQ3LW
         +NMWLY7fJKm3JOrEluj5AMkKhQkR2kTLFkqqp9iXgvuWPj5brGoABfTkqLKa0d1RnQ0x
         454D13yH926JxKBl2QHaRGfp70Gck8vdxk5Ak1dsJ5iA2IgN9c1DSFQNdHQO7Qv38tLO
         qz3htAvxSt7eRrce2dc7adgZD2DlipM9dDGelqqokzCG/yOe7bGa9rgXhfSwv3RSIN1Y
         H7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4pJ/pcxwIYmi16cgb/ptO1VKPQ+U4fJWbnJ+Q+Z57hk=;
        b=i95zJx6xf3JhiWAbxIgelyXbCUzZzPsCD0cyyMTxU8QdljJYmHfb9NyMLwPkAuXGyM
         KFIJLqZnzuCF5PQG9lao+FDYfaaYhwqr9m/DDz50FedM+qilf8YIBXTosNSYSApOW88H
         pTS0HYoBlsadgJFaAEAwV5tTn1G6TuHGKp0ELJCv3oa6sdA1TL+nz2OagIN2Z0IRZgEQ
         nmGLERG2ZlnufTsPPqvyPGy+7vwK1xWDsyAASDjap95vChvrXI3joDZatttoxIvUxp/d
         y/nYJCzLsMby7N1qmOuFgRxtyEnU4SUTfMMv69XAxLCW+Xm3HR3U0r3P4gXx+8pfOrmk
         hUng==
X-Gm-Message-State: AOAM5303yxM2tnL2ssjMiqBilkX9dqXVMUOoMzzFGCCGDNWC0SQIhLgm
        sAoq6+AZobjIJUrklhAtjSJvtBvs6ls=
X-Google-Smtp-Source: ABdhPJxTKaQcRjP2+3i9UKzr14nMIzB/WHw4tR68eEds+9U/LDcO0IUm5jLUbr+k1Yvdmo5SLv3/yA==
X-Received: by 2002:a17:902:bb02:b0:151:56a8:f80b with SMTP id im2-20020a170902bb0200b0015156a8f80bmr9529358plb.30.1646607611899;
        Sun, 06 Mar 2022 15:00:11 -0800 (PST)
Received: from [172.17.0.2] ([13.93.208.94])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00124b00b004e11307f8cdsm12593706pfi.86.2022.03.06.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 15:00:11 -0800 (PST)
Message-ID: <62253cfb.1c69fb81.ad015.0f49@mx.google.com>
Date:   Sun, 06 Mar 2022 15:00:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6879426771342160425=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bigeasy@linutronix.de
Subject: RE: net: Convert user to netif_rx(), part 3.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220306215753.3156276-7-bigeasy@linutronix.de>
References: <20220306215753.3156276-7-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6879426771342160425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=620752

---Test result---

Test Summary:
CheckPatch                    FAIL      1.03 seconds
GitLint                       FAIL      0.45 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      33.53 seconds
BuildKernel32                 PASS      29.85 seconds
Incremental Build with patchesPASS      39.86 seconds
TestRunner: Setup             PASS      525.29 seconds
TestRunner: l2cap-tester      PASS      16.50 seconds
TestRunner: bnep-tester       PASS      6.45 seconds
TestRunner: mgmt-tester       PASS      107.98 seconds
TestRunner: rfcomm-tester     PASS      8.33 seconds
TestRunner: sco-tester        PASS      8.05 seconds
TestRunner: smp-tester        PASS      8.16 seconds
TestRunner: userchan-tester   PASS      6.73 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.03 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[net-next,06/10] bluetooth: Use netif_rx().\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
   baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")

total: 0 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12770937.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.45 seconds
Run gitlint with rule in .gitlint
[net-next,06/10] bluetooth: Use netif_rx().
1: T3 Title has trailing punctuation (.): "[net-next,06/10] bluetooth: Use netif_rx()."
4: B1 Line exceeds max length (83>80): "   baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")"


##############################
Test: SubjectPrefix - FAIL - 0.32 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============6879426771342160425==--
