Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18187C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 11:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHDLmd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHDLmc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 07:42:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F06B9
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 04:42:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f8614ce5so1874625b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691149350; x=1691754150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rV+KWt7uSuxYrJezxvQh2eef5Bdwk40WURZJmQzlfGA=;
        b=sHaGow9mlRNZXXReDMx5oh2HPhi7Vo/noKwhCqhJvLDhUM1vVaLwZdWs+QTwUcogl2
         QmFNJBSyJbf5fpdg08woChQgN+1V6q/Tidsb5fBf+Xj2jD9tYBCNrsqU51MuvPOynSNH
         +vQsUJG9iME/zVSSR9pTv0yiyg0qA9lzFQ4rTS2tR4hW00eO4BcLSqg3FXpqgfR4pdOi
         9NI21ScF810ZsV04tHwFrPDBl7FnWk9fB8a5iOfla6QL95dppnlyHUe+JcfSNF9ypX6w
         ykNaLvc3LA2vBwV7MuD08jW7gpmEQRkE6EUmWmYkUuMUeP94maPxbrUFq1lMDCfAlypz
         yBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149350; x=1691754150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV+KWt7uSuxYrJezxvQh2eef5Bdwk40WURZJmQzlfGA=;
        b=ecakQCWNQoOYV5x+btl0CRHHZPFX16ba+S8fK/+L2NYVe7GUenyIZFk0yqxFYKaLN7
         O4mDF4wTcRrF87kYej3ygUR7xHmouz7BIXyxWr/sLUo9hL7d9HLoAb0pWOcahT0S77uB
         bxF/hinudAvI1xW3VjWdxZAbS9R4WKlvWc1KCtCXV4/QVLbzln0i5iqUor0+1KMcp++K
         Ob24GXx5w8uiQuyK8gh90cvwHiwrrclvtgs5Dels9rBhXWfXOQp1tDdx8XIC7dW8DdO8
         n9xR8q0Ybp7rbVImrGNrDye5/g4mbYRCsO2dkeLOe4c8k01iJwnI6IJ7Rt163tuPJKbX
         rVNQ==
X-Gm-Message-State: AOJu0YyiOeay5BM93fTrzEvv9Gj0fWTSpVxZfIovA791+5B0RNRNbh2S
        m/VsV4k2ySq2eQn7MOG9SGrL7Mofan8=
X-Google-Smtp-Source: AGHT+IEHe2yP45urj/3nCsu9s1+DsQ6Zv+10ir30pAB6BzSCZMTyNgDCRZFtYXsx53/JRHPCrZ7xKw==
X-Received: by 2002:a05:6a00:9a4:b0:676:399f:346b with SMTP id u36-20020a056a0009a400b00676399f346bmr1867161pfg.1.1691149349717;
        Fri, 04 Aug 2023 04:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.224])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b006875df4773fsm1437680pff.163.2023.08.04.04.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:42:29 -0700 (PDT)
Message-ID: <64cce425.620a0220.d372.31da@mx.google.com>
Date:   Fri, 04 Aug 2023 04:42:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6777383383506223091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
In-Reply-To: <20230804104735.9281-1-max.chou@realtek.com>
References: <20230804104735.9281-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6777383383506223091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773049

---Test result---

Test Summary:
CheckPatch                    FAIL      1.07 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      46.44 seconds
CheckAllWarning               PASS      50.56 seconds
CheckSparse                   PASS      56.03 seconds
CheckSmatch                   PASS      150.02 seconds
BuildKernel32                 PASS      44.31 seconds
TestRunnerSetup               PASS      676.10 seconds
TestRunner_l2cap-tester       PASS      34.63 seconds
TestRunner_iso-tester         PASS      91.63 seconds
TestRunner_bnep-tester        PASS      15.60 seconds
TestRunner_mgmt-tester        PASS      280.65 seconds
TestRunner_rfcomm-tester      PASS      23.38 seconds
TestRunner_sco-tester         PASS      23.01 seconds
TestRunner_ioctl-tester       PASS      26.18 seconds
TestRunner_mesh-tester        PASS      19.82 seconds
TestRunner_smp-tester         PASS      20.83 seconds
TestRunner_userchan-tester    PASS      16.29 seconds
IncrementalBuild              PASS      41.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#89: 
The previous FW format of RTL8852C is v1. After the commit[2], the FW format

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: btrtl: Firmware format v2 support")'
#107: 
Fixes: 9a24ce5e29b ("Bluetooth: btrtl: Firmware format v2 support")

total: 0 errors, 2 warnings, 224 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13341662.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3226.


---
Regards,
Linux Bluetooth


--===============6777383383506223091==--
