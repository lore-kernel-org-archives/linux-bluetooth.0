Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1407C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 23:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiF3XF0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiF3XFZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 19:05:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4E53EFE
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 16:05:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b125so569747qkg.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K5XWvyHLVVweLvFUkB3cA0cc/km/OaXQSRa0tmmmZ2U=;
        b=QF5/UEnf+IPCh/49VYXt2KE6MA8G90eXk8sIFuSS/Wmzk1W1QL1bQGvScAIZcjngJz
         cWKhxQDSVzVMDCkTDVVHLHcqZYvHrD4I1UU8kqN6///Pp2KkYRBijyDTp1FTwLdD1jh7
         K/fk4M2xaD80eR/XSGZ9xBpAy0BO+m+pgGTnAQcqrC0v2cF3xreONfXgsHt9tZkHIT4D
         uO3LAgnl8F/R6QkV8S7I7l+h/rrRfnAG6QslIbLc8MUzbxjYPwifjtUxgDsa7txRec9v
         6TIHeOgRcRJNniV6+Ene9RpRvkj5S2PpIs5kZKGCBD1e8U9zx/LBhYu4bxJS2POyNs3w
         d1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K5XWvyHLVVweLvFUkB3cA0cc/km/OaXQSRa0tmmmZ2U=;
        b=XnetKEy4dBa4C3QPxvYhB89Ck4Pnmom3tI3Ct+0H1gBUiMW8+8+qvlsPYsbhozNGIN
         vYU2R1Ud2X0j9B95tPyHsBv44FYDRMfTug2tWrtpgxTahIDpJ6Jx+Np51c2TlxLcSIX/
         Uw+SUgKFAbQVOhdJZ4k+pg55KQmsuarUvVqXJKvVWkKtvgch6j/Nir+2AjaG41IWYzQx
         JJMBVSuRNxhCO1i4yMV2F2B63bxbzLpd63J3TllCSVpCzt5+ihsRHScIVRfsS1z0MCCz
         NnPCJF/iF1+Hv+skEj6IOuqghMWCtAw+UO8Kn4icliCGXscNouDN79Mg+qq34bsxwJvy
         Nlpg==
X-Gm-Message-State: AJIora9gxJvyR8w/oX4f3y/PdEdT75nBrSrPVjC+k4v2HhAjS/JEkiBc
        eUW95Lrux3gA9VViiSxEqFtGtbx+iX6yrw==
X-Google-Smtp-Source: AGRyM1vIWVdFuq0uUiNZCIv7kKhSDNswx255Dh2EMUpI/cz6qVrTt+xtKjJirfOm478aMUbUAIEh7w==
X-Received: by 2002:a05:620a:459f:b0:6b1:f5c1:6e61 with SMTP id bp31-20020a05620a459f00b006b1f5c16e61mr5258755qkb.436.1656630319760;
        Thu, 30 Jun 2022 16:05:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.168.129.219])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e902000000b006a6a6f148e6sm16112929qkf.17.2022.06.30.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:05:19 -0700 (PDT)
Message-ID: <62be2c2f.1c69fb81.34875.5959@mx.google.com>
Date:   Thu, 30 Jun 2022 16:05:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2571514315463940376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220630221415.638408-1-luiz.dentz@gmail.com>
References: <20220630221415.638408-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2571514315463940376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655563

---Test result---

Test Summary:
CheckPatch                    FAIL      15.26 seconds
GitLint                       PASS      7.39 seconds
SubjectPrefix                 PASS      6.50 seconds
BuildKernel                   PASS      33.18 seconds
BuildKernel32                 PASS      29.69 seconds
Incremental Build with patchesPASS      167.58 seconds
TestRunner: Setup             PASS      485.21 seconds
TestRunner: l2cap-tester      PASS      17.74 seconds
TestRunner: bnep-tester       PASS      6.15 seconds
TestRunner: mgmt-tester       FAIL      103.90 seconds
TestRunner: rfcomm-tester     PASS      9.76 seconds
TestRunner: sco-tester        PASS      9.57 seconds
TestRunner: smp-tester        PASS      9.58 seconds
TestRunner: userchan-tester   PASS      6.35 seconds

Details
##############################
Test: CheckPatch - FAIL - 15.26 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4,3/7] Bluetooth: Add BTPROTO_ISO socket type\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#176: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 1718 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12902307.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v4,4/7] Bluetooth: Add initial implementation of BIS connections\WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#848: FILE: net/bluetooth/hci_conn.c:817:
+ * */

WARNING:LINE_SPACING: Missing a blank line after declarations
#1877: FILE: net/bluetooth/hci_sync.c:1031:
+		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->periodic)

total: 0 errors, 2 warnings, 0 checks, 1873 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12902310.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 103.90 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.099 seconds
Read Exp Feature - Success (Index None)              Failed       0.102 seconds



---
Regards,
Linux Bluetooth


--===============2571514315463940376==--
