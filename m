Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiCAXNP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 18:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiCAXNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 18:13:13 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81340900
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 15:12:31 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso26542ooi.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xdLgkJu4sNcXIweolmQQnOrgaaemY6TL+Lq2Cbfym1Y=;
        b=dt/HKpOvECxBPwkuxHuK4WpiLogHRTGWYfyeJC/dW6IlF6Rrg0psER8MZoY6WqChQG
         sPe3ZbS/1NsWBxyao7tUpLIR8RYMCP0HW5RPpKDKBlC0dSz9GrCg06u7rjhE7JAf5DZc
         AOUV/MLx4x/YfRWL9+gr0IT2O0Q8ctJNBEaS2sl6yU7Uk4P5UaXBF8XkgjUd2uPfjg7H
         5lHG77EAOm64hWDFA09Rp8DPXJHIWCmLUjPPyqUTPxOYlpNRImaAci+W/ZAwySpWxc1n
         5ZdDa6zfwa73gCEsPckh8J48yHgopTlpgobCPB1JXISoj0ye+0iwV5AvbmfubuNSA2rP
         sZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xdLgkJu4sNcXIweolmQQnOrgaaemY6TL+Lq2Cbfym1Y=;
        b=lzlvcCJcIK4m6kEg7U3J2kBftp5G4LvB9v5d+sbnQNcbWXEGEaacz9+dRfq6Dyv3kN
         kKQUWiOl9DomAn6IPoaVI5FmnotnZuXYGM8DLYszbyuisB31O1oNnCIhbKzyxKEnjOWa
         3hYUYfOrBkKmOML2+mEQ863gPOXB+ImOWJ1rurqmHoYj4Q01KMfAe2frFHccCB30JY83
         9xNkygqtFxHz6ruWhM36iDc0t86cRjzpUl86w1WcGln9aTzsi3yabZ28NTC7JhGy6U93
         5vGugPX26L7ZxpEMmhAhzgCmZabdp7cbb7dozykyNEo/Mm3z1irSFHDaymw+Ca+zd80p
         U8+A==
X-Gm-Message-State: AOAM530M7TXHtGVUwi31NE9VdSy3KrFgX9KnvZqGphAe4rFJF2SghO2v
        iy3ZeOXjHenQjRlZ2LgeX4e9nLEzC/I=
X-Google-Smtp-Source: ABdhPJyvDlcNpi/EJ9lRWoeueeDgT//J8MX2+I+rnYVDTgyQ+KQ0yWQweA4M4VG1JgN2cov95Ks2Kg==
X-Received: by 2002:a05:6871:4006:b0:d7:597e:288d with SMTP id kx6-20020a056871400600b000d7597e288dmr2762723oab.27.1646176351010;
        Tue, 01 Mar 2022 15:12:31 -0800 (PST)
Received: from [172.17.0.2] ([157.55.192.201])
        by smtp.gmail.com with ESMTPSA id o5-20020a9d4045000000b005a920356a70sm6897181oti.77.2022.03.01.15.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:12:30 -0800 (PST)
Message-ID: <621ea85e.1c69fb81.bd144.a289@mx.google.com>
Date:   Tue, 01 Mar 2022 15:12:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3911627903277509928=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v6] Bluetooth: Scrub MGMT cmd pending queue for consistency
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301223457.784338-1-brian.gix@intel.com>
References: <20220301223457.784338-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3911627903277509928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619336

---Test result---

Test Summary:
CheckPatch                    FAIL      1.49 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      35.30 seconds
BuildKernel32                 PASS      30.88 seconds
Incremental Build with patchesPASS      42.61 seconds
TestRunner: Setup             PASS      553.01 seconds
TestRunner: l2cap-tester      PASS      14.93 seconds
TestRunner: bnep-tester       PASS      6.76 seconds
TestRunner: mgmt-tester       PASS      115.32 seconds
TestRunner: rfcomm-tester     FAIL      8.45 seconds
TestRunner: sco-tester        PASS      8.53 seconds
TestRunner: smp-tester        PASS      8.56 seconds
TestRunner: userchan-tester   PASS      7.31 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.49 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v6] Bluetooth: Scrub MGMT cmd pending queue for consistency\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#274: FILE: net/bluetooth/mgmt.c:5291:
+	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
+		cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&

total: 0 errors, 0 warnings, 1 checks, 275 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12765234.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: rfcomm-tester - FAIL - 8.45 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.171 seconds



---
Regards,
Linux Bluetooth


--===============3911627903277509928==--
