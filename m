Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 17:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbiEKR2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiEKR2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 13:28:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E588517C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 10:28:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b20so2796690qkc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rbaEytWXTYlbMsIWco7vEZ+jIPuef76qL4Be0bwQnZk=;
        b=VEi7Xb1d1Nf1SYZzYdM8sA2l3OIJaHFQH57IGq2JNV6A3tgmY7abYOkWAgNrktVMal
         6JJHnPJIxsCzvlMRxyNSAC1uxsp4L112uAVxYgtsG+4DjfPSw19HoYCuoTB8X/iVvv2s
         +dTo54EUKehyGloxUfmwsQ7Ax4nchvaRcllZGpNT06dj+Jnh7su0d8Ao/bYaJx4Y3tuv
         EabmGv0+vpOHLuUMAGYQA733sWv+kGYegXFtQ1hiaNFXvBrGfhlmQMUX02mgeEFbQQkU
         ZDwbawcgyo+qYz/Ly26oyjYz+B/ZT1d7gQbo3KwcrQcdbVvsd0t4J08vQq4AfI1/Cy8s
         QWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rbaEytWXTYlbMsIWco7vEZ+jIPuef76qL4Be0bwQnZk=;
        b=znYp/ovDfIVHdCy13f8Out06twyL7xfRPWOFZxvIHcN5dR2PkMHRizWn9NXKk5Ti+2
         qFEsWe6cV1OkpX8oqHR05SNxXty4kgigfEi5k0CFSddY+GWMbntrVstAscSdi4RbLTy8
         M4b1rN/jRLPQ8z7xngk1PCSLyayjv5BFaK7/6FCPdX0fxb9gwK7uDNvIZDT4NKs68moR
         OUTFwb1HqX4jD9NBd1dfZtg5frZlbZQlqX6DNy8ydbLYZRnhFESEmkFE9JWBHmUnqVpz
         OJeL3L2GDvUI3vLbfkYxHMATF2rif41x8E5S3A8BKsbe2rS6f9gNHoumFtLqRyqYh0AM
         z/Dw==
X-Gm-Message-State: AOAM532zR3Xm7C5WfzVeD1n3EUfjcKbyJcxKBg00IF7IqszwlqI4gH37
        tvuMzzyHFbx2oNUFm5rxk1H0PFhR2qCjoA==
X-Google-Smtp-Source: ABdhPJzWB/H+umGE/wWXVpbNgGWGRw77BT1rdAFhucyaIwssW/dEwpTkG4QlhwDZkKmO3ciMbuXu+Q==
X-Received: by 2002:a05:620a:666:b0:69f:bbd4:b9af with SMTP id a6-20020a05620a066600b0069fbbd4b9afmr19640123qkh.11.1652290130087;
        Wed, 11 May 2022 10:28:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.120.178])
        by smtp.gmail.com with ESMTPSA id 138-20020a370890000000b0069fc13ce1fcsm1540555qki.45.2022.05.11.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:28:49 -0700 (PDT)
Message-ID: <627bf251.1c69fb81.32174.755a@mx.google.com>
Date:   Wed, 11 May 2022 10:28:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3319853983655234419=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220511155412.740249-2-brian.gix@intel.com>
References: <20220511155412.740249-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3319853983655234419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640639

---Test result---

Test Summary:
CheckPatch                    FAIL      6.70 seconds
GitLint                       PASS      2.25 seconds
SubjectPrefix                 PASS      1.88 seconds
BuildKernel                   PASS      33.01 seconds
BuildKernel32                 PASS      31.50 seconds
Incremental Build with patchesPASS      68.01 seconds
TestRunner: Setup             PASS      491.17 seconds
TestRunner: l2cap-tester      PASS      18.07 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       FAIL      107.31 seconds
TestRunner: rfcomm-tester     PASS      9.69 seconds
TestRunner: sco-tester        PASS      9.54 seconds
TestRunner: smp-tester        PASS      9.83 seconds
TestRunner: userchan-tester   PASS      6.59 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.70 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4,2/2] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:BRACES: Unbalanced braces around else statement
#244: FILE: net/bluetooth/mgmt.c:4537:
+	else {

total: 0 errors, 0 warnings, 1 checks, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12846409.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 107.31 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 492 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.140 seconds



---
Regards,
Linux Bluetooth


--===============3319853983655234419==--
