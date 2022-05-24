Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiEXVJr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiEXVJq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:09:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEA4A3CB
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:09:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c1so15987411qkf.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VeAoMTQR0p/Z4iPN7PIn54C3pu2jdUUUgaYbU/ntaeo=;
        b=C2b4dgu/dGCrhiCO1P65k+KfiYOXK2je6DEurumRXjsExPm5DkMySckIee2mYSCb1I
         V16Xv4QEryopFFvZ7X3jvpGDFcmJ0qZrga20nrzvZcvLemIkgJs6h6iV3VpiVCL4QZX+
         g26y+yy68OptFbxkYegPXboRC0REM6gQOPn7xrI2MzTarNnq4F4n7/SNRkKKleQKveoQ
         KcB6xI4lF3ok+AqGbJVCTDVKx0QsEUYvCqx/LtQV0v60dLBYDhf5FK4Zk8tJQwqOv1sa
         rj7nR05ul4BdA6yRHGOUmySLTRl4XnscnHz0uLYnOrxGholP8bHmDh/O9kjfW/hw4uf6
         5oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VeAoMTQR0p/Z4iPN7PIn54C3pu2jdUUUgaYbU/ntaeo=;
        b=DfCc/04vD02mGiCMlzDDuyvzqOxKyXHHxWr1nfbPaQGfyRDtSQDSuD8SickLyIC7GG
         eIyBU+QJCwjIntE82Ff+FKAu6aRhuZFB4e39rw+VqdnfsExOKkgExcb1kjvCz2jc5Mk4
         ylw21VaTWvTa/Y8pNFb92ug2wKIjIaWSIrvK5/DRYaM9x8bWeLOtYdyaO1wuuuznfIh9
         WuVbrCIJ8j1T8LoAVfK7dvmbkaRdruN2bdebqOGsfOe+1M45sCzS+UJFU03fOT62gSTb
         Zysf4layCe/sMoaduAwLTqxXjxuxtwdHWfDW6D0vCPWJBcTompWh2ToOV62EYTHkznUs
         2IZg==
X-Gm-Message-State: AOAM533QWCVEFiiczTX0D5kZqkLcq8afUin1NuB7gMoyUC+P3T4Zww2H
        0e9aqi32WQuP0/WRyQYGU/3IebcLH7tlLQ==
X-Google-Smtp-Source: ABdhPJzz1El5YCyx+o6V7vs3IkIWxtWUuX5BymA4gZpOK5xrqt2pJORaIJdkK7pvgWsX1TpI87pHpQ==
X-Received: by 2002:a05:620a:d87:b0:67b:3105:4f7f with SMTP id q7-20020a05620a0d8700b0067b31054f7fmr18790637qkl.230.1653426584724;
        Tue, 24 May 2022 14:09:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.246.61])
        by smtp.gmail.com with ESMTPSA id p17-20020a05620a133100b006a39e915252sm159876qkj.97.2022.05.24.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:09:44 -0700 (PDT)
Message-ID: <628d4998.1c69fb81.6b5d7.1141@mx.google.com>
Date:   Tue, 24 May 2022 14:09:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8855300545681380737=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [1/2] Bluetooth: hci_sync: Refactor add Adv Monitor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220524131406.1.If745ed1d05d98c002fc84ba60cef99eb786b7caa@changeid>
References: <20220524131406.1.If745ed1d05d98c002fc84ba60cef99eb786b7caa@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8855300545681380737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644760

---Test result---

Test Summary:
CheckPatch                    FAIL      2.59 seconds
GitLint                       PASS      2.26 seconds
SubjectPrefix                 PASS      1.84 seconds
BuildKernel                   PASS      40.42 seconds
BuildKernel32                 PASS      35.72 seconds
Incremental Build with patchesPASS      82.96 seconds
TestRunner: Setup             PASS      597.82 seconds
TestRunner: l2cap-tester      PASS      19.89 seconds
TestRunner: bnep-tester       PASS      7.36 seconds
TestRunner: mgmt-tester       PASS      122.66 seconds
TestRunner: rfcomm-tester     PASS      11.60 seconds
TestRunner: sco-tester        PASS      11.25 seconds
TestRunner: smp-tester        PASS      11.21 seconds
TestRunner: userchan-tester   PASS      7.72 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.59 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[1/2] Bluetooth: hci_sync: Refactor add Adv Monitor\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#383: FILE: net/bluetooth/mgmt.c:4836:
+	status = __add_adv_patterns_monitor(sk, hdev, m, data, len,
 					 MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI);

total: 0 errors, 0 warnings, 1 checks, 533 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12860520.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8855300545681380737==--
