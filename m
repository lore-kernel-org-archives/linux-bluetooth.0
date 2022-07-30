Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C4C00144
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 03:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiG3DSi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 23:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiG3DSg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 23:18:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874066B92
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 20:18:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p132so7598517oif.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 20:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=r/7e1/GF/WePXVug+khQcaOSuj26XqWXac1zLym3mGs=;
        b=AFS+6KgvTCKZptJKBw/gu1InFsl3nLfUAy01vcVwDq/kGQBFkvnYj9a/N2MkOrTbQt
         cL0XpTEyHdB5fsqi0bXM8oE4kiDStT2v7wF69n1p1LhCTWcCnetwIxkup8p9LeC8iQ9u
         zY8dm4NjlevDMbYfQYpx8k/9dZ6OiDVBttTngz2vFAHm9s8zUwV5RYXopb1nxoBW5v1+
         oRFtE+OQWPh7CDY9FlHjYDbaBdD3SbaeTBD8w9KAnDedewnoH91YOQe6dDtLCIxi2qVb
         NBvZfcSQcePJladCx+ADDz6IZU8YVRUcFJuTqTpQn/qsU7c6kPGMr5dPQ2s2mAhadCY3
         VIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=r/7e1/GF/WePXVug+khQcaOSuj26XqWXac1zLym3mGs=;
        b=wJsCYyX1Og9rZ/XoSWLZ3LOd8rnq39+cG5l9GWaf9Xsd2pybpZFNdRCyh7QBZUfB+H
         YCHUu6RAsXDDPFbQZMMDNy7DP+EiWW3WrqtKHcEbT61yW6nIS8SjW6lS+6+VxMfMl/x/
         hFRpx9/mqfhdoaG7zgDAGHavfSkc7HU/46SjRm5jN9V8M9WbTRIAcr6pjyxzzmxSH4uf
         I/eGolca+o80zF0+5nJCcMsaRDzc52dKR8dCJf9QSg/cdA8WC7/5h5av60O4X4R04AYQ
         MPq1M4rKZ8MplBD75q5tghDBk6kSu1jK9xS3l6rKjpohg62PBWuLP+88Slm/4usHGX2V
         HVcw==
X-Gm-Message-State: AJIora9xqFFI8dE6u50DLDXVRFmohKl2Ct1T6TMULvRZJ4k0vltm7CKN
        dhVvytoUZAQxRJI9CZOCVbgVd9luwZY=
X-Google-Smtp-Source: AGRyM1suCDpyjFuVZmreD8kxgTzxowVTBmJ1O/3JlpwkaZhxDNhOC1dROtjwS0PC/7VdBhE3Gv3nXg==
X-Received: by 2002:a05:6808:13d2:b0:33a:63c1:75b5 with SMTP id d18-20020a05680813d200b0033a63c175b5mr2964354oiw.17.1659151114482;
        Fri, 29 Jul 2022 20:18:34 -0700 (PDT)
Received: from [172.17.0.2] ([13.84.214.197])
        by smtp.gmail.com with ESMTPSA id bx6-20020a0568081b0600b0033a6bfdc5adsm1393109oib.36.2022.07.29.20.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 20:18:33 -0700 (PDT)
Message-ID: <62e4a309.050a0220.1cfae.699e@mx.google.com>
Date:   Fri, 29 Jul 2022 20:18:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1783487868138173673=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220730005038.894650-2-brian.gix@intel.com>
References: <20220730005038.894650-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1783487868138173673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664189

---Test result---

Test Summary:
CheckPatch                    FAIL      17.42 seconds
GitLint                       PASS      7.18 seconds
SubjectPrefix                 PASS      5.78 seconds
BuildKernel                   PASS      42.11 seconds
BuildKernel32                 PASS      37.61 seconds
Incremental Build with patchesPASS      262.87 seconds
TestRunner: Setup             PASS      632.55 seconds
TestRunner: l2cap-tester      FAIL      24.55 seconds
TestRunner: bnep-tester       PASS      8.21 seconds
TestRunner: mgmt-tester       PASS      128.42 seconds
TestRunner: rfcomm-tester     PASS      12.49 seconds
TestRunner: sco-tester        PASS      14.04 seconds
TestRunner: smp-tester        PASS      11.82 seconds
TestRunner: userchan-tester   PASS      8.42 seconds

Details
##############################
Test: CheckPatch - FAIL - 17.42 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v5,06/10] Bluetooth: Move Adv Instance timer to hci_sync\CHECK:SPACING: No space is necessary after a cast
#363: FILE: net/bluetooth/hci_sync.c:603:
+	u8 instance = *(u8 *) data;

total: 0 errors, 0 warnings, 1 checks, 328 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12932846.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v5,08/10] Bluetooth: move hci_get_random_address() to hci_sync\WARNING:TYPO_SPELLING: 'dependancies' may be misspelled - perhaps 'dependencies'?
#66: 
This function has no dependancies on the deprecated hci_request
                     ^^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 180 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12932849.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v5,09/10] Bluetooth: convert hci_update_adv_data to hci_sync\CHECK:SPACING: No space is necessary after a cast
#216: FILE: net/bluetooth/hci_sync.c:6126:
+	u8 instance = *(u8 *) data;

total: 0 errors, 0 warnings, 1 checks, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12932848.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v5,10/10] Bluetooth: Convert hci_abort_conn to hci_sync\CHECK:ALLOC_SIZEOF_STRUCT: Prefer kmalloc(sizeof(*conn_reason)...) over kmalloc(sizeof(struct conn_reason)...)
#308: FILE: net/bluetooth/hci_sync.c:6246:
+	struct conn_reason *conn_reason = kmalloc(sizeof(struct conn_reason),

CHECK:LINE_SPACING: Please don't use multiple blank lines
#312: FILE: net/bluetooth/hci_sync.c:6250:
+
+

ERROR:SPACING: space prohibited after that open parenthesis '('
#313: FILE: net/bluetooth/hci_sync.c:6251:
+	if ( !conn_reason)

total: 1 errors, 0 warnings, 2 checks, 140 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12932850.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: l2cap-tester - FAIL - 24.55 seconds
Run test-runner with l2cap-tester
Total: 40, Passed: 39 (97.5%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    4.469 seconds



---
Regards,
Linux Bluetooth


--===============1783487868138173673==--
