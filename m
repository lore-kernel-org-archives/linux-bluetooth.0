Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 20:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiCAUNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbiCAUNi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 15:13:38 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0290024080
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 12:12:55 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s5so17230887oic.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lq1bQAiAS3DL4I1pwslt3QAdHNaAt1wPnyuRtX+Vqdc=;
        b=mQPEA2tJ4KXAtl4oDVECu882bmP492Wvf6qhweWrVzdbd6cy7ADYdWNExQYJS8jSNW
         d0nQoImoHuU2Y5MLcHWB7dczhHMZZR3fxs8pTzSueN0zt2MtFcGnAWq+LbLl9FL4oNB3
         Vyq+0ZNWhQF39Gd6nu3eU4pbCH8lAC4E9twcCeNER2Ct+ztxzLKsuPFhOfULwAu9jDIK
         gQ1bb3tx533RGQNfIpwl4t6eDZAV00P0sAOo4UoyvOs2Wsrmx9Y1ldkw9pzl226eIsls
         IR5b1yP+tedd9Fm3ObUJXrEVZDefZmXg1WqaVappYh6meAO/wLuibWmPSRgL5I1YnAvC
         axtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lq1bQAiAS3DL4I1pwslt3QAdHNaAt1wPnyuRtX+Vqdc=;
        b=jNlziuHpI6M3o8yIBWqm/1ZwDncIf2ORN3z8R71/fj6bkyWjF1DU/MnUmX3KQwQSLC
         WmZVlJHI6wgyCrNrhAzkdomfjRaToxr+iUEPNekSks7sCstDO7NDpO6L06SD7Ra60o0B
         IUeI71pcZLNPfzPqb/IDHR8P323iE07ZSEplK03oiWwfLiRM7xSaLAhqccCBQhQ/K/W2
         70br3mu9+u8BgifylH5N49RuUDWHBdaoVgzC1uwljD6LpLeYZVg+7cseBlmx6rbgzvTj
         7353YYsY8AAzlpAB+SstBDvhMEcH60va6qC18/ORv5noPtmGF9z32cbY5+tFHNzoLE9t
         tTiQ==
X-Gm-Message-State: AOAM532kjVgnNaJssCUkzwpBvajCif7kmi0GQa5CQzboVUfvPD753cz2
        C1m4tMZ1h9ZcR1ZYOWVWxPw+47sb9B4=
X-Google-Smtp-Source: ABdhPJyBkswyDJa9abQgnSTzGAIo9FvjVOVlNRw+jvMtbj9r6u6tl6jAbsF2BpwyTjPF/v8ioIj6zw==
X-Received: by 2002:a05:6808:9b8:b0:2d4:cc01:6cad with SMTP id e24-20020a05680809b800b002d4cc016cadmr16111025oig.35.1646165575044;
        Tue, 01 Mar 2022 12:12:55 -0800 (PST)
Received: from [172.17.0.2] ([13.84.166.196])
        by smtp.gmail.com with ESMTPSA id e25-20020a544f19000000b002d53ce2f979sm8297786oiy.38.2022.03.01.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:12:54 -0800 (PST)
Message-ID: <621e7e46.1c69fb81.60dab.37c1@mx.google.com>
Date:   Tue, 01 Mar 2022 12:12:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9196729663453384125=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v4] Bluetooth: Scrub MGMT cmd pending queue for consistency
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301193930.752813-1-brian.gix@intel.com>
References: <20220301193930.752813-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9196729663453384125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619296

---Test result---

Test Summary:
CheckPatch                    FAIL      1.98 seconds
GitLint                       PASS      0.84 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      40.88 seconds
BuildKernel32                 PASS      36.84 seconds
Incremental Build with patchesPASS      50.99 seconds
TestRunner: Setup             PASS      653.51 seconds
TestRunner: l2cap-tester      PASS      17.27 seconds
TestRunner: bnep-tester       PASS      8.01 seconds
TestRunner: mgmt-tester       PASS      135.80 seconds
TestRunner: rfcomm-tester     FAIL      10.08 seconds
TestRunner: sco-tester        PASS      10.45 seconds
TestRunner: smp-tester        PASS      10.08 seconds
TestRunner: userchan-tester   PASS      8.41 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.98 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4] Bluetooth: Scrub MGMT cmd pending queue for consistency\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#409: FILE: net/bluetooth/mgmt_util.c:232:
+bool mgmt_pending_find_cmd(unsigned short channel,
+			struct mgmt_pending_cmd *this_cmd, struct hci_dev *hdev)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#435: FILE: net/bluetooth/mgmt_util.h:48:
+bool mgmt_pending_find_cmd(unsigned short channel, struct mgmt_pending_cmd *cmd,
+					   struct hci_dev *hdev);

total: 0 errors, 0 warnings, 2 checks, 310 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12765107.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: rfcomm-tester - FAIL - 10.08 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.226 seconds



---
Regards,
Linux Bluetooth


--===============9196729663453384125==--
