Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Apr 2022 00:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiDBADC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351761AbiDBADC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 20:03:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D502FFFAB
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 17:01:10 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id hu11so3230577qvb.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3gzi65F8UdaKFUF4C4ArJ12QtpWJZjHq5C2bJtFy7xc=;
        b=bLE95lLMYCyt4sAgN9MSBZA7evVm6U/qEfO35oJsEqYucpVlGeHnQeDsz+AGaLcruO
         1+hTeACRWQ2XQSuuihQWxcTJYKrosXpyH+EOOFPcNGoqxLn2lsqazOOb2RHl1cLkCrfm
         YPanptyl+Vubl0qYWV+2zr0Nm6WzrZ5GY7poVKTjdChGGxZBahBkNaWPw1+p8n5Xcnsa
         SRS2C4ToQKrX1GKTs955DIZoTQykLbEE6IvsRP2Yo5bvqcM7wJmyL5WhDa/bM9nB4zrg
         Gf/i5+VNgYD6TY/fDRY1vbbTYnHyq30qCha4AIkMKH9mgakb1ZPlz3pYN+/KpqOwwgI1
         wmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3gzi65F8UdaKFUF4C4ArJ12QtpWJZjHq5C2bJtFy7xc=;
        b=Ng3TMAmB5hyuT1JIcwccs98JrBfS5MYlrLsCq1JrOzSShZuIZyoMN20mnZdare1Tyw
         PPYMrZtWUhUsGy6i9VJxSxLMPpU9qIR4Jq2YLj1LAcmi0Yd3KaY5/N3QuhBXlQWV5mz4
         b+n3I9+OILtuys81u5BXDgg0VtnPffso5ZsCKr4U+uxR6G8+xv1S7onc0DCNv3nE8kjf
         0Mylgzy+PrY8S8L8dyu1MEsuWUG+N/GJdxDPoFTh914V/VIHKGpfOLevuqxa/Op6+2YU
         WvUZij4ScWQI+wrG7KIyjayrYU3jqfUa1lNOX9EplAcHuGtCJPEqYOQIAJdetHyV/9M3
         lnRA==
X-Gm-Message-State: AOAM533l1/XvkuSxCOiVtPWnv9oobz8pE24wMGhVCZFSlaCm0dNs4VUX
        AjWLhSjGB97i8dri3hK0MhzLfR8+8U5PDw==
X-Google-Smtp-Source: ABdhPJzUzaP4uD1AzS5UIO0oik9xNvQ/8VhWNTWbml2bNYU8I3modiLh5x70MTMHEkZcAjMMErCIdQ==
X-Received: by 2002:a05:6214:242a:b0:441:1e13:5dcd with SMTP id gy10-20020a056214242a00b004411e135dcdmr9801626qvb.121.1648857669066;
        Fri, 01 Apr 2022 17:01:09 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.116.15])
        by smtp.gmail.com with ESMTPSA id y66-20020a37af45000000b0067dc0fc539fsm2129311qke.86.2022.04.01.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 17:01:08 -0700 (PDT)
Message-ID: <62479244.1c69fb81.81ccc.cb83@mx.google.com>
Date:   Fri, 01 Apr 2022 17:01:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1432548320220766519=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/4] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220401233826.122544-1-luiz.dentz@gmail.com>
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1432548320220766519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628357

---Test result---

Test Summary:
CheckPatch                    FAIL      3.82 seconds
GitLint                       PASS      4.00 seconds
SubjectPrefix                 PASS      3.54 seconds
BuildKernel                   PASS      30.56 seconds
BuildKernel32                 PASS      27.22 seconds
Incremental Build with patchesPASS      57.55 seconds
TestRunner: Setup             PASS      453.98 seconds
TestRunner: l2cap-tester      PASS      14.95 seconds
TestRunner: bnep-tester       PASS      5.76 seconds
TestRunner: mgmt-tester       PASS      95.91 seconds
TestRunner: rfcomm-tester     PASS      7.36 seconds
TestRunner: sco-tester        PASS      7.14 seconds
TestRunner: smp-tester        PASS      7.14 seconds
TestRunner: userchan-tester   PASS      5.90 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.82 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4,2/4] Bluetooth: Print broken quirks\WARNING:SPLIT_STRING: quoted string split across lines
#109: FILE: net/bluetooth/hci_sync.c:3838:
+			 "HCI Delete Stored Link Key command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#112: FILE: net/bluetooth/hci_sync.c:3841:
+			 "HCI Read Default Erroneous Data Reporting command is "
+			 "advertised, but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#115: FILE: net/bluetooth/hci_sync.c:3844:
+			 "HCI Read Transmit Power Level command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#120: FILE: net/bluetooth/hci_sync.c:3849:
+			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported.")

total: 0 errors, 4 warnings, 0 checks, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12798857.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1432548320220766519==--
