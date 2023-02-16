Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483FC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Feb 2023 09:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBPJ50 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBPJ5Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Feb 2023 04:57:25 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E373770D
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 01:57:25 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l7so552787ilj.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GydCxrNeRQ/eyRhvy5kxXrzmH2+wGIcYUNI9p4z84Y=;
        b=nduSwP4JjiNBSnwvU7euqQtMypcsQOgaYBPn+dtWMDwH3eVZvnkgfpH5yHaTGf4IQb
         Demh/cxQOATmCygA4btkINT6ubZ4BLJo+OCDJjvX2DNPdjLNvSC8RVJXr6+tjKnbJfIV
         uC1Ibnbk+dU4yQLE0KaTFA6ETQkfvj+3A5FUFoPpE2GhvMNMaBKOBgmoz9nmggcGZ2ca
         7rbgB0G4iIvELlZ9sgNzmkZ4rOHQAKwsJpNmya3u44J8m1bG63Zc23nxFWXor24jcPNr
         Dr/h/hlouzhj9FD8xuRUIU0GNF8bLnNRUP+u5gqmoshNaySH/IqUS4tc3vzMftrHBUlC
         J+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GydCxrNeRQ/eyRhvy5kxXrzmH2+wGIcYUNI9p4z84Y=;
        b=hOF8FMhfmVqUs61ds4hXF02u3pZTCBUHX4EwvJpGqDgS893/AIVpQu/V0rNF3nBZ9r
         XmtkcgSoE2+nwa45NMXX2DmnXjg1R7nNMhMagC9OuBMcL0ngnSDq31C4TxiXzEkkl+gy
         W2VynOsiKCbYHLIlfgFEozevr3HruKbYkmwnCDAqBCPAVv6Dx6UGfEyGlZKnZdKajRip
         kd0YbLu/LYOV2BvP4oiNPo8wQEY3lm3z4ApMHcqc5wDu+3cfhXNP8tPUHQevCgzGWQlE
         SvRZI7vr4qQU91dddNVYr5h8UA4KjUX9bN5m0oNVIuEpT07vC1Zk5xJAXNW1nk6W0rq/
         Ujaw==
X-Gm-Message-State: AO0yUKUB/RumhoUNv6/YXDg3oWUHXkaDyBcZQ8fVJmgBRkEifQRm5yeS
        tslzTLCmNXggAwtWhRMjDKG3Crdyp3XIAQ==
X-Google-Smtp-Source: AK7set/Qr9yCiu/rWfUqa9FFd+mwoUt6qEF96HbAxhsLyZ/rf3iXxIBSk3hacfrLoc2wqX3S7aFH8A==
X-Received: by 2002:a05:6e02:1c88:b0:315:2e34:490d with SMTP id w8-20020a056e021c8800b003152e34490dmr1234699ill.15.1676541444241;
        Thu, 16 Feb 2023 01:57:24 -0800 (PST)
Received: from [172.17.0.2] ([40.77.123.113])
        by smtp.gmail.com with ESMTPSA id n19-20020a056638121300b003b49e7d990asm420478jas.30.2023.02.16.01.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:57:24 -0800 (PST)
Message-ID: <63edfe04.050a0220.80351.0a36@mx.google.com>
Date:   Thu, 16 Feb 2023 01:57:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6533649896080528376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230216092236.26720-1-quic_tjiang@quicinc.com>
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6533649896080528376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=722423

---Test result---

Test Summary:
CheckPatch                    FAIL      1.36 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.60 seconds
CheckAllWarning               PASS      34.23 seconds
CheckSparse                   WARNING   39.23 seconds
CheckSmatch                   PASS      106.34 seconds
BuildKernel32                 PASS      30.48 seconds
TestRunnerSetup               PASS      436.94 seconds
TestRunner_l2cap-tester       PASS      16.55 seconds
TestRunner_iso-tester         PASS      17.21 seconds
TestRunner_bnep-tester        PASS      5.64 seconds
TestRunner_mgmt-tester        PASS      111.67 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.31 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      7.13 seconds
TestRunner_smp-tester         PASS      8.20 seconds
TestRunner_userchan-tester    PASS      5.95 seconds
IncrementalBuild              PASS      28.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#263: FILE: drivers/bluetooth/hci_qca.c:2343:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13142752.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:631:17: warning: restricted __le32 degrades to integerdrivers/bluetooth/btqca.c:713:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============6533649896080528376==--
