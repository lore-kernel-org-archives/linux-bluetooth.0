Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8980C76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 02:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjC1CgJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1CgI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 22:36:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60558DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 19:36:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x15so9540005pjk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 19:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679970967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUsGizuUAN+57fTrEDVyn6/nU+P7BmlOX8bcqdEG8KA=;
        b=CZb3+rEIRjV9In+pEZm1jTDR+xBVJfYGit/V1x+qz9Tk/RTeJq1jWtrp1Y3xiC0Drv
         1+AqaKcZOtlQqp9WLUDOmJ97QXfUvh5WbNRwMo9T/HbrGer+LFKHM/J64r9XRiRv44RQ
         yA+58CYKC3bXIl/u7RSKEw0qT+wxdNEeqho6cGMoQgauwDL996H7L3BklIYOS0LUib1Y
         4/s08fUkwz9D3/wfB7MYT9HTQh/pMk1ZIexNDIDEAwbAthxmLFdYmj2Covf5SvTjdx07
         OXB5sw7o8EMbKbMGaG6jHEc2Yl5wmkWnViI71HW6zsZpOmGAkb1dh0zX1KiTQXOgWt3p
         Z0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679970967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUsGizuUAN+57fTrEDVyn6/nU+P7BmlOX8bcqdEG8KA=;
        b=z10uLmCkWgCQALLMBHrmYjcE0K4pJ/fZYXSxp5MRmR95sySHsw2f6hQs6m7CHf/5M9
         RVsnFfGgPn+/Bs8BnAlfzdyF/1mG4W/BN/ILnUdg9gFvAxRcyJA1nVJeRoco6Cko+WiW
         5HJv2L7EygP5De5QCLPUT0r9u2Orjnr6XEugJkVFTuhC/6O2/LaQ/crJI/k1dBDqD2Uw
         hmEjtmc5t70TeflWaim7SQJpr90MmCTlXetlUswFTdUeP7kahS1p9MSxuk0OuM1KcuS0
         1D9S9LSnlhX0vDpfN5xBdelvfxo8ca2PEsH/RfXkHz2Mvl9o8zyP+0OiljP1i3HgvwIZ
         ajWw==
X-Gm-Message-State: AAQBX9cVCtvOU4tM7s1iWbUT640XecD9eTec1bMptHwYbmszKKKrdJlY
        Ks53fJYG/KHe4oFIShsi39zw1KbV6b0=
X-Google-Smtp-Source: AKy350Y1pJq7cxDsnV79SRGAL22Qoqtn6ZVMdLsIsimextjdQ/5jqLsRgf8tE5CYToJvmwP86Hc0yQ==
X-Received: by 2002:a17:902:d04b:b0:1a1:dd05:39fa with SMTP id l11-20020a170902d04b00b001a1dd0539famr10197741pll.48.1679970966682;
        Mon, 27 Mar 2023 19:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.86])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b0019edc1b9eb2sm19854476pls.238.2023.03.27.19.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:36:06 -0700 (PDT)
Message-ID: <64225296.170a0220.58d09.5093@mx.google.com>
Date:   Mon, 27 Mar 2023 19:36:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0172393072885205300=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v9,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0172393072885205300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734379

---Test result---

Test Summary:
CheckPatch                    FAIL      5.80 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      45.13 seconds
CheckAllWarning               PASS      48.90 seconds
CheckSparse                   PASS      54.74 seconds
CheckSmatch                   PASS      148.18 seconds
BuildKernel32                 PASS      43.41 seconds
TestRunnerSetup               PASS      620.49 seconds
TestRunner_l2cap-tester       PASS      20.48 seconds
TestRunner_iso-tester         PASS      22.12 seconds
TestRunner_bnep-tester        PASS      7.39 seconds
TestRunner_mgmt-tester        PASS      135.86 seconds
TestRunner_rfcomm-tester      PASS      11.46 seconds
TestRunner_sco-tester         PASS      10.39 seconds
TestRunner_ioctl-tester       PASS      12.27 seconds
TestRunner_mesh-tester        PASS      9.33 seconds
TestRunner_smp-tester         PASS      10.20 seconds
TestRunner_userchan-tester    PASS      7.51 seconds
IncrementalBuild              PASS      61.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v9,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#156: 
new file mode 100644

WARNING: Statements terminations use 1 semicolon
#566: FILE: net/bluetooth/coredump.c:236:
+	pattern = skb_pull_data(skb, sizeof(*pattern));;

total: 0 errors, 2 warnings, 0 checks, 689 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13190276.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0172393072885205300==--
