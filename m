Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiEJXCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiEJXCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 19:02:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C257A83D
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 16:01:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a22so721735qkl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6LL4LONsblU0dKZYs8f6uRdiY/pw0UYzyZlUT7BMAZI=;
        b=Iem7tyuszTSRz0+/GyeWoNMZrrk9aXbCt5LDZQLp0ZLwo2ddzwCiccatz0rnEynb9C
         zhAiQzSYKcgqQZs0J0h+aj/y6tLfZrBBmeGIRxwOI95kKOx4GbtZ2ZN9vjjvl7Mz8ojE
         16mRcgLMts4a4a5RPNxM84Z4pqOVb+W3LE5L9wA9GD5HtSPIyRnPzqFJO9YdKQadocqN
         25WZlImzX8/ZNnTwKZx/g14z1ijlpL5NTJJBrmKI8LZm0BiTeVuAtC/bLKL2buB2zWBQ
         Ug9LG4ninnsV/Q9ECN61oaqgbOuTIU5p3mtde/WTcldcgqighQShG2cQ540ZcleCim2A
         966g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6LL4LONsblU0dKZYs8f6uRdiY/pw0UYzyZlUT7BMAZI=;
        b=yAdmguyAPk3KxHpGgDm15rA4PiQnU8l10X1cM/HyeqLHKLLFompk1g8sZ2KE9dV4vT
         zsEQwpDl6/VYpOor5wgyCFMTgTJTqBrhtRXzs1PG6kzjLdsjJMHDtjOh0TtmgJj3qdsC
         ObPni5nq1wQjzlcflqPR7oERM/ALQzzDLthADpIyowg1/O5kRfQdJXKQUT/9+x932HXS
         2VkLOvyURLD/46YNu4mJJngAb0GGnWDYAcHvbW3YLuVAaqiXWHLg4DYHOR3nZUbamRGm
         /+G2jliv8w9FD12PQRqcsRbrELHdABOlbhwoWVuCusHSTJKzSpOptcvuuYDGgOXgGCXM
         gZjg==
X-Gm-Message-State: AOAM533+jGaIgYal24VFDA3EqpJmkYel71Z55aB64sWZzTTrsmKStnn/
        9Zmib/Kz2v12RmBTFJllyjKO2wh4rz4=
X-Google-Smtp-Source: ABdhPJwPdlKRa1INc0hgYStz147jRt7ehPYjTZCEUQpjK0AenlQKh4PjBWkF7gIeByPkswXmXI2acg==
X-Received: by 2002:a37:9603:0:b0:67d:da02:19e8 with SMTP id y3-20020a379603000000b0067dda0219e8mr17126956qkd.242.1652223718662;
        Tue, 10 May 2022 16:01:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.36.203])
        by smtp.gmail.com with ESMTPSA id 69-20020aed304b000000b002f39b99f66dsm182348qte.7.2022.05.10.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:01:58 -0700 (PDT)
Message-ID: <627aeee6.1c69fb81.3fcea.1001@mx.google.com>
Date:   Tue, 10 May 2022 16:01:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4130800669638329333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220510214325.633935-2-brian.gix@intel.com>
References: <20220510214325.633935-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4130800669638329333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640338

---Test result---

Test Summary:
CheckPatch                    FAIL      6.48 seconds
GitLint                       PASS      2.12 seconds
SubjectPrefix                 PASS      1.95 seconds
BuildKernel                   PASS      32.15 seconds
BuildKernel32                 PASS      28.72 seconds
Incremental Build with patchesPASS      65.13 seconds
TestRunner: Setup             PASS      468.98 seconds
TestRunner: l2cap-tester      PASS      17.39 seconds
TestRunner: bnep-tester       PASS      6.15 seconds
TestRunner: mgmt-tester       FAIL      101.05 seconds
TestRunner: rfcomm-tester     PASS      9.68 seconds
TestRunner: sco-tester        PASS      9.57 seconds
TestRunner: smp-tester        PASS      9.59 seconds
TestRunner: userchan-tester   PASS      6.42 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.48 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3,1/2] Bluetooth: Implement support for Mesh\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#701: FILE: net/bluetooth/hci_request.c:2122:
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+			       hci_dev_test_flag(hdev, HCI_MESH))

ERROR:CODE_INDENT: code indent should use tabs where possible
#1515: FILE: net/bluetooth/mgmt.c:10062:
+^I^I              u8 addr_type, s8 rssi, u32 flags, u8 *eir,$

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1515: FILE: net/bluetooth/mgmt.c:10062:
+static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
+		              u8 addr_type, s8 rssi, u32 flags, u8 *eir,

total: 1 errors, 0 warnings, 2 checks, 1474 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12845561.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v3,2/2] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:BRACES: Unbalanced braces around else statement
#244: FILE: net/bluetooth/mgmt.c:4537:
+	else {

total: 0 errors, 0 warnings, 1 checks, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12845560.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 101.05 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 492 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.094 seconds



---
Regards,
Linux Bluetooth


--===============4130800669638329333==--
