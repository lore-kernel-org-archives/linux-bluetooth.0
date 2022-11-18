Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534EEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiKRHdt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiKRHdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:33:47 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E2657E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:44 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13ae8117023so5031113fac.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=04R/r7VaYM9D62m09iz2lacYs6hQIL20FRAh9kfyAwc=;
        b=RphWoel8S1lCPVPqgoMd2I9athmyLBBXrlm/7C2J3d1vvYWCurBW883Oo2m8c6wnPK
         TBC8o0hbkvAUu4GN2XlqRfhreIz5JSHNPRZnRC2O73eEKBxQE4OBm5dYImSqthGhxeeS
         ePomkROjgtQb2sfjzX6TmBK1fJnC7jMb/T0hRPiyNKl3EgGEjxKLwtAGPnnORVeVTSSf
         Ad7MoKlO9brQroaKvhnftzjZN8fQMxJuKw2SiGtVeLtbdcD2EI06HPM+QW+gx+D5qxdv
         wpZ6wXN+5DKA1AGERP4s2Deq/iA3OdbUPQB0kE3RoA64XKVZCIQyCkzzLG9acraFqtPe
         UAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04R/r7VaYM9D62m09iz2lacYs6hQIL20FRAh9kfyAwc=;
        b=2NH1uHqwB4ed6ooAufziZzVBXpI3R700bcbSegaeM4GupdVn0yPPwQ23XJjgQ5NN3g
         ddGDfuSwQ1lamrPCrD5aafkfMxPrAWR/A20e/O8405gNeV7yGoctY0vzXjfFYBLUCNTk
         4pJM3c8cM4HTsmilosjAT9j2t8PhtlWyeB704Q/+BirNiIB/OgiHsoxYPe4+hnKo7jDR
         0D2X1ExGd7y6gSvg37Dtnojg6lcI+GEPVEd+RXgib20wLxQzRElXGV151w8b3H476TMx
         iGHDYzltmJ4DRbjbizXIOrE+Zz9nlehhYFAFxcPZyvJJzer+oJhsWfaEPV3YrHrTkrWt
         fJPg==
X-Gm-Message-State: ANoB5pkDsXblYJfF/LMqerCMv6d2Uo1Ue/1BMgcr33idocKzH/B4lFDS
        1QZcLdBb9iI4iLWl2MXRnSWR5w2ACDFF1Q==
X-Google-Smtp-Source: AA0mqf5iRgb463ZfhO7eaQRAv1/Gd8py3LxD4vZMWqcMAuVgJHBiFyML/CsWDw9cL8F9/lgET7O9qg==
X-Received: by 2002:a05:6870:4625:b0:132:93d1:5f5 with SMTP id z37-20020a056870462500b0013293d105f5mr6292227oao.133.1668756824104;
        Thu, 17 Nov 2022 23:33:44 -0800 (PST)
Received: from [172.17.0.2] ([20.225.201.127])
        by smtp.gmail.com with ESMTPSA id bq20-20020a05680823d400b00354b0850fb6sm1171953oib.33.2022.11.17.23.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:33:43 -0800 (PST)
Message-ID: <63773557.050a0220.30841.524d@mx.google.com>
Date:   Thu, 17 Nov 2022 23:33:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6542113798676028427=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        dominique.martinet@atmark-techno.com
Subject: RE: Add serdev support for hci h4
In-Reply-To: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
References: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6542113798676028427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693092

---Test result---

Test Summary:
CheckPatch                    FAIL      2.05 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 FAIL      0.44 seconds
BuildKernel                   PASS      40.44 seconds
BuildKernel32                 PASS      36.15 seconds
TestRunnerSetup               PASS      498.78 seconds
TestRunner_l2cap-tester       PASS      17.77 seconds
TestRunner_iso-tester         PASS      18.03 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        PASS      119.79 seconds
TestRunner_rfcomm-tester      PASS      11.05 seconds
TestRunner_sco-tester         PASS      10.03 seconds
TestRunner_ioctl-tester       PASS      11.61 seconds
TestRunner_mesh-tester        PASS      8.12 seconds
TestRunner_smp-tester         PASS      9.85 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PASS      43.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/2] dt-bindings: net: h4-bluetooth: add new bindings for hci_h4
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#114: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13035921.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6542113798676028427==--
