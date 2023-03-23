Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5081CC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 01:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCWBON (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWBOM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 21:14:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4F6E90
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 18:14:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u38so7434718pfg.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679534051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NZJx1p0+6W3ErRbFD2RRFrv4605P2SaLDlx/+k2ufwk=;
        b=CLB11NZJfDQkhWyVtqNMRySa7TKlLgJspR9/woewQ2qYCuHtCiTf8RO4DJcSjC4cNu
         pN0r9ELYi/FhFkAXVPpd9NLKqrD4vZ1U9/HTsgk0e4DzAcOFeH0WKAS4z08a/jdW/tRA
         wcFvST+JmUSePI7r29Euxavt294iFb8r7jRKABwqcnXpLFGZwmQMXFEqmQ6SK2Iiw1qr
         qltkq608di7Vud6wDq0i5d+/fZBj7IzhKdzvEasm0uH+X/UorCy7/LoSCOXTJ1lr5qh6
         sO3FLkRDBEWPXEEXcySxMeqCo0ELbViIaiPiUgvlts3DEsv21MPo7noDNwf+z0j1AlBs
         c+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679534051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZJx1p0+6W3ErRbFD2RRFrv4605P2SaLDlx/+k2ufwk=;
        b=Z96m43jb/Ic7N49hytkk3IyAoTgdZG/UnGIjYBYQFZl7BHoBdgV0DZxYlAFbUQ7rRT
         EMioKnDhiqe6+ffv1006Wp7RW1V0piJbVE6FKD8N9V1OlXDIU1kwPO/1hxIG333USTtc
         YuUbYkMCMKznCAUNxE5WhEO+ajWqXBVIMSytaRIGMsLr/7BGteR0qRsgkzp9VLoZ2moa
         piU8MPFs+hud6WVfgBszYgcq280va0pSI1ati4N9xBcPtiykYKWj+rSqn35U50zB3DD6
         1yqSWPCTmFepYMWBR8PhdTWJhcBpH3C3UCYeODOGcMXfyWsG1cLgoopc0CBH+Ha7Y1UC
         i2ZQ==
X-Gm-Message-State: AO0yUKV5e+/FA/9ELvQzJCnigwb+w1nzIG1orOjD7hzqdhkbxv2syvyO
        EKOjqAQImLdsOEj6NRg/gwFG32pBz7U=
X-Google-Smtp-Source: AK7set+4BHlaun8vo6YQksBGy18gDqwH3a1BPbqEnImdY7w9Erue59pRxk7w4ejjWEQdJ7ysZthorA==
X-Received: by 2002:a05:6a00:8c:b0:625:fe60:9b5c with SMTP id c12-20020a056a00008c00b00625fe609b5cmr4477233pfj.23.1679534050748;
        Wed, 22 Mar 2023 18:14:10 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.156.35])
        by smtp.gmail.com with ESMTPSA id d13-20020aa78e4d000000b00622e01989cbsm10994929pfr.176.2023.03.22.18.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:14:10 -0700 (PDT)
Message-ID: <641ba7e2.a70a0220.8eb22.4d03@mx.google.com>
Date:   Wed, 22 Mar 2023 18:14:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7749782228080371255=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230322011442.34475-2-steev@kali.org>
References: <20230322011442.34475-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7749782228080371255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732538

---Test result---

Test Summary:
CheckPatch                    FAIL      3.02 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      37.53 seconds
CheckAllWarning               PASS      40.72 seconds
CheckSparse                   WARNING   45.71 seconds
CheckSmatch                   PASS      123.06 seconds
BuildKernel32                 PASS      35.86 seconds
TestRunnerSetup               PASS      512.99 seconds
TestRunner_l2cap-tester       PASS      17.96 seconds
TestRunner_iso-tester         PASS      18.17 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        PASS      116.76 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         PASS      8.96 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        PASS      7.77 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      6.31 seconds
IncrementalBuild              PASS      48.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
Add support for firmware download for wcn6855 which is in the linux-firmware

total: 0 errors, 1 warnings, 211 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13183445.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,3/4] arm64: dts: qcom: sc8280xp: Define uart2
WARNING: line length of 109 exceeds 100 columns
#147: FILE: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1220:
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,

WARNING: line length of 105 exceeds 100 columns
#148: FILE: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1221:
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;

total: 0 errors, 2 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13183447.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:640:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============7749782228080371255==--
