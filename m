Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiKRFeY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiKRFeQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:34:16 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27ECE16
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:34:15 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso2463958otr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q69YvcXJWNHYaSZ5PcCVjbB80lpMKQ3IBpBFlhL0Sd4=;
        b=K2Lio5ieduP80w3QzZuLMCqSMlcpbPUP9SMHHO+4PF36WU3pNyFWC5rLDp9Giw5gk6
         jdnPDwJMSWCNv3b3QWx8LKM+i+c6QRMocuL64ybT1VKE72Q5Ohyxop/c7dbfXvbaMQck
         ROMW22YnLIXA1Nn/Tf6b9MG9xy0mHobrHHvDH97yaJCDfYP9VIaM2quiUy4w1WzkOIiA
         Tl/TZj1qTB4kDoTBXBLqCN6KUEQ5ERP2d0vRnb18fkgCo38xKw6//oQukIN8AS6IQxA/
         C9YNkQhQhNKWMSmhg/vrBduZIqEPYvsEWmNGLYjc5ehRZXmXZclxMSN2qKhFicDmKzGS
         LSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q69YvcXJWNHYaSZ5PcCVjbB80lpMKQ3IBpBFlhL0Sd4=;
        b=wkGWlwCb+AxJcmZ20brsrmDrny/U5xNkYWGdwKErxGENrr93aOleqTCsTO2Dvi5y5c
         LIXZnf1JYqExbu9XbeJ63DHhssFq53Gg2RsJ6hNmSfyN63BLBb9JquUJdXcWlaxs1rKW
         Eut3ugmFvmHa0/vbMKr5oDBR0wSrfEVT8DtADPd4N2l159aMgk0vuuSxCzP+XdW1Yqo4
         vlLPEAHTYhBspWUUlnc2k+fXoQypxUv8SpGyHUGkwVUw+jIjeSVr5I9lI5gq82jbtyO+
         +MvsYgo+YvLoPbc1bHi8T+1E5m4j/oCJ66qrn9FEO/P3mJXxZjHP3oA/60wwBOzVfnJO
         Zldw==
X-Gm-Message-State: ANoB5pltWY6FBumtl1xfmejKrJvgUT8ZFCqftJanHO3voTNnXWAYUA5z
        TxJwUQYX2D3uxwds9rmXESGixOL+mfM=
X-Google-Smtp-Source: AA0mqf4O+NqArwuKMeLl1EWCPdfb49P0qi8vwz+QWM2j9l2y5bT1EazN4VUstPu1WTtxCStg8kvnwg==
X-Received: by 2002:a9d:7b48:0:b0:661:c421:d2d3 with SMTP id f8-20020a9d7b48000000b00661c421d2d3mr3219895oto.83.1668749654856;
        Thu, 17 Nov 2022 21:34:14 -0800 (PST)
Received: from [172.17.0.2] ([52.171.35.2])
        by smtp.gmail.com with ESMTPSA id z19-20020a056830129300b0066ca61230casm1187949otp.8.2022.11.17.21.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:34:14 -0800 (PST)
Message-ID: <63771956.050a0220.9d978.5623@mx.google.com>
Date:   Thu, 17 Nov 2022 21:34:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7541870239591882725=="
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

--===============7541870239591882725==
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
CheckPatch                    FAIL      2.02 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 FAIL      0.44 seconds
BuildKernel                   PASS      44.25 seconds
BuildKernel32                 PASS      40.63 seconds
TestRunnerSetup               PASS      551.67 seconds
TestRunner_l2cap-tester       PASS      18.96 seconds
TestRunner_iso-tester         PASS      19.44 seconds
TestRunner_bnep-tester        PASS      6.87 seconds
TestRunner_mgmt-tester        PASS      129.72 seconds
TestRunner_rfcomm-tester      PASS      11.35 seconds
TestRunner_sco-tester         PASS      10.58 seconds
TestRunner_ioctl-tester       PASS      12.54 seconds
TestRunner_mesh-tester        PASS      8.77 seconds
TestRunner_smp-tester         PASS      10.44 seconds
TestRunner_userchan-tester    PASS      7.12 seconds
IncrementalBuild              PASS      47.85 seconds

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


--===============7541870239591882725==--
