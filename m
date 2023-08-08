Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF6C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 21:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjHHVFt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjHHVFb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 17:05:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43037A84
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 14:04:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ba97e4feso5827559b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691528698; x=1692133498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tzXDK67UHsiXoAM+Qknp2bUDUDf+7uKUZRwu/Yzh4pY=;
        b=iki+wRaN2+r7BBVEkFCX54T0W389FaDwg3+982U5xNh6RtDn9zu6KaQUXyg8sjiWTc
         sYErGDLZmSocaeQj5zku6FNITdHfzHoHvUpTUCIC1HSGy8VDhexbwvGFcZ31bzXT/zC7
         /1ITIxaITn5TbSr5GCUXh87eDIBjJtxQ51nD/j/j5zAa82rZNpbpL3/Gqmve/Wvak66S
         scGwQlp4On4O7GHkU7EhGoOJdeFieiqJRvdCj3aP+TZccDJI63lQ+rOMhT27d1gFt1C9
         1j7kk7Ia7jJeyIViDXbxcetOcQNW2bLPe6H073wW1CSbuTb3YV5lKCyQMvMBDAdcoawo
         2AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528698; x=1692133498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzXDK67UHsiXoAM+Qknp2bUDUDf+7uKUZRwu/Yzh4pY=;
        b=Hfmq3zVvHW6i05HHrlDudjPCUZVRhxJ2sl5tRhAkmXNuYML9zBmaigeMKzKcdy0Mmb
         6DrXgY4ilKHyOXYksChn17mQiFQo1bsvkNx8yG/G0A99g4HRgcM2xoqs4eb3qNMEWVU4
         DZqfOWfRdzw+t68lvSKOVG71gDK8JQroVIfpzEZZHYpTgdaDoTU9pGEdDHskkMdu5DBg
         yGhYAbI4yLBW1YJM7CGPmlb6Jek3g6pbvFKcI7unGo3/psIzcm1yz6R/Kh07qc8uPWP/
         5Gra1cXfBF/cJvFQTTK1Und+XXqgY+MsgEbtiXsMP7rdtN5VvzwKv1gbu1TNNsJgoWvD
         7A0g==
X-Gm-Message-State: AOJu0YzPfLKOm8lUvEI2r+ZqN41T+8O9Pco6oHbSCenVzURu0Yvchptc
        TdEJfZPM/mtr8lq2IQ+P9LjCp7T0uu2bSw==
X-Google-Smtp-Source: AGHT+IHc6oh0G5xf9R64DhnL/JOxOejBnUTVtRsb6ACRZpqE2mZDg6tedMj8M9aA1sJ07Jf+jUflOw==
X-Received: by 2002:a17:90a:5996:b0:269:46d7:f1db with SMTP id l22-20020a17090a599600b0026946d7f1dbmr704254pji.32.1691528697602;
        Tue, 08 Aug 2023 14:04:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.101.175])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090aac0400b0026833291740sm10898237pjq.46.2023.08.08.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:04:57 -0700 (PDT)
Message-ID: <64d2adf9.170a0220.cd28b.4701@mx.google.com>
Date:   Tue, 08 Aug 2023 14:04:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8990373202495659545=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: bluetooth: Add device 0bda:4853 to device tables
In-Reply-To: <20230808193455.11037-1-Larry.Finger@lwfinger.net>
References: <20230808193455.11037-1-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8990373202495659545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774260

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      39.26 seconds
CheckAllWarning               PASS      42.74 seconds
CheckSparse                   PASS      48.08 seconds
CheckSmatch                   PASS      130.45 seconds
BuildKernel32                 PASS      38.65 seconds
TestRunnerSetup               PASS      577.23 seconds
TestRunner_l2cap-tester       PASS      27.36 seconds
TestRunner_iso-tester         PASS      64.60 seconds
TestRunner_bnep-tester        PASS      12.57 seconds
TestRunner_mgmt-tester        PASS      244.50 seconds
TestRunner_rfcomm-tester      PASS      18.59 seconds
TestRunner_sco-tester         PASS      21.44 seconds
TestRunner_ioctl-tester       PASS      20.93 seconds
TestRunner_mesh-tester        PASS      15.54 seconds
TestRunner_smp-tester         PASS      16.46 seconds
TestRunner_userchan-tester    PASS      13.01 seconds
IncrementalBuild              PASS      35.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bluetooth: Add device 0bda:4853 to device tables
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#82: 
This device is part of a Realtek RTW8852BE chip. The device table is as follows:

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13346977.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8990373202495659545==--
