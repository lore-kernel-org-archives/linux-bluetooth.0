Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F2C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 03:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355292AbiFNDH7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 23:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355305AbiFNDHf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 23:07:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED782AE2B
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 20:07:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r1so6655389plo.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ByoLOPD5VhSoABtb78ljDfD3tV5trA/A+OH9E7/kkAI=;
        b=pluZhUeSFTd95RLvFjDKTiano32T5k2EFswPPieq2WNb/aJKox/xnucn0OKtbsdT5E
         AefYAKGxIK65qcLvNMPtrTkMBQOmGtJwBRUu8oCF1bxScRWdrHkpb0gQIflucFX3AXu/
         G3yWI6ISOkGcBr+NMuE1IZLNCoeFUimWowE6TaEPYK1rtKbrTNV4sPnRa1k4rNYMfGA8
         tVQB51p5C590HQxiOipn6UoaVTn5Ps6lZGhjTiENvpG/tnNIf585xlWhJgqhY9gxraHS
         e7pByWXpD6WTgxPIiVLT59IxWxa6oWctF4jrcsR8DdqkQBn5xPuVG3lE+vHHq1CSjRhz
         jQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ByoLOPD5VhSoABtb78ljDfD3tV5trA/A+OH9E7/kkAI=;
        b=U0CRx4+ag9m6WWI1FQGNzUG03+WJW3rM+ZZ4XIjEs3sGWWWERsUBUfOTmYN1TelCP9
         Aanuu7DasMcnEm+OW2wPMbbhgNADaQnaiVuw929WBdTkCsVDJO8mWlQ9Fy9Q2NJKQ2QE
         WUIF1L0J2p7t0yids1yNBvwuJG1d5DroitR/DObQ4M21wRm/X1boIwbnGXUboPz7tqpc
         Ku0ux4J0bkNoSR5uBwU/49673thdRw0Bt/UDKKOIad8ATASsF74e/ebViWhBNFKKMF6j
         Jbwq/WXJeQjQLwdQhvRleZEASW9YcaUMGmuJJpUwTMJysI/RgJ2BlKqzHikTdei1avCd
         Mb1A==
X-Gm-Message-State: AJIora9n8/BIw7dkGqDTugF3y0PbTjYp6XBQj3CDiCdKuhBu8BBGWs11
        qRR1UkLH1UDiQp1XeTIJzqz7xXHHeM8=
X-Google-Smtp-Source: AGRyM1voFTH91RkJATXUdHmoINVr32DqtuXIn/UqKt+nwTCeaDskt/65bGEg6ii9zn8/iNfKo37Xcw==
X-Received: by 2002:a17:90a:fd92:b0:1e2:d731:9ad5 with SMTP id cx18-20020a17090afd9200b001e2d7319ad5mr2103740pjb.199.1655176047750;
        Mon, 13 Jun 2022 20:07:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.141.79])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902f38c00b00166423df3cdsm5826255ple.209.2022.06.13.20.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 20:07:27 -0700 (PDT)
Message-ID: <62a7fb6f.1c69fb81.86627.745c@mx.google.com>
Date:   Mon, 13 Jun 2022 20:07:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8764072539755825891=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: HCI: Fix not always setting Scan Response/Advertising Data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614003935.361245-1-luiz.dentz@gmail.com>
References: <20220614003935.361245-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8764072539755825891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650011

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      31.89 seconds
BuildKernel32                 PASS      28.29 seconds
Incremental Build with patchesPASS      38.02 seconds
TestRunner: Setup             PASS      474.86 seconds
TestRunner: l2cap-tester      PASS      17.33 seconds
TestRunner: bnep-tester       PASS      5.90 seconds
TestRunner: mgmt-tester       FAIL      107.97 seconds
TestRunner: rfcomm-tester     PASS      9.60 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.16 seconds
TestRunner: userchan-tester   PASS      6.14 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 107.97 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 490 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Add Ext Advertising - Success (Complete name)        Timed out    2.635 seconds
Add Ext Advertising - Success (Shortened name)       Timed out    1.999 seconds
Add Ext Advertising - Success (Short name)           Timed out    1.999 seconds



---
Regards,
Linux Bluetooth


--===============8764072539755825891==--
