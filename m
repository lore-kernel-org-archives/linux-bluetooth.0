Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22183C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 21:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiGNVBp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGNVBn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 17:01:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCB76C110
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 14:01:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f65so2635677pgc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ai8DdO9ypvTI4f3jjW61IIaEhqvO354viuFr1/UavmY=;
        b=Nxqh60LxdbzqpWokPKatoZm3BAax7cFeO5+pB81e0Lvh2yyGxoyD76fMYQLNH9ipnd
         pla1SyGlZL6D83zIvdozVJekSDCfLu7K6yU4EdA6avqhb2OuJJoyhK/jV1f++la+hErm
         8cnvt043/zBRpR/nVTFeafuF2I1D8qfm4QoyZ9FFRay88a7ilymIu8m/+8dIJicShxVj
         wk0FzBB5GCaAd42NPegK3YsaWM5/3KaluxhNAXlNezlXIfThrTjaGNvIXz5kWxfeZ3lk
         xZpNpFDtOdNo0cZI3T8evTOKNuS/z1gQlGzPbszux2CZFWzRgPGhUin9CE3g8E5WSRzW
         ++zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ai8DdO9ypvTI4f3jjW61IIaEhqvO354viuFr1/UavmY=;
        b=OLnV2naY181QefNPWBMasNYG49NXrahOJLrHxOGRcIJQU4+FiNr7LhSCHbkNkXaIpC
         vup9XcXepSpwIH6hgLU9yEph6OCEN7LRfwun35/NCETe3ADk69ktjsC2cKfewSw/RxFZ
         RBdvlIbIctIki2UhODGZRiGkrceMJxML8Pa6OSF7gFqQCELG93DrS+FrhaiQBrw1EQwB
         j03pnwVpNkripLPJOkxSGuFEJZC1PhRZT2cDmDncbY4ruX0M8sdA5Z8F3mS86wiqMyTR
         XxCsf5Qx24bNCICZ8S0dK8oIcCZ+j9J//MGETXxdNTcooiCisCJSEbWZq3iHSa6f2RoC
         Pr1g==
X-Gm-Message-State: AJIora9NB/faau1jchvlNkWi6I8rhLb5CryCmrGEXGpL/dMyp+djVlnU
        hOMJh9ckm3R5g1hjy1EiNC11Bcty41U=
X-Google-Smtp-Source: AGRyM1tQdDSUtusHfK5Dd0lpDCSrK2sIa/hYFP0mvwVPvSRRp9pn81r5+xMu53UFibLoOg8xUBYzHQ==
X-Received: by 2002:a05:6a00:1747:b0:52b:3208:40bd with SMTP id j7-20020a056a00174700b0052b320840bdmr1662135pfc.23.1657832501484;
        Thu, 14 Jul 2022 14:01:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.122.3])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b0016bdcb8fbcdsm1887425plt.47.2022.07.14.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:01:41 -0700 (PDT)
Message-ID: <62d08435.1c69fb81.9347c.3080@mx.google.com>
Date:   Thu, 14 Jul 2022 14:01:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8345256852428876995=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_sock: Fix cookie generation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714203035.3859253-1-luiz.dentz@gmail.com>
References: <20220714203035.3859253-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8345256852428876995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659854

---Test result---

Test Summary:
CheckPatch                    FAIL      1.26 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      30.98 seconds
BuildKernel32                 PASS      27.31 seconds
Incremental Build with patchesPASS      37.68 seconds
TestRunner: Setup             PASS      470.65 seconds
TestRunner: l2cap-tester      PASS      16.60 seconds
TestRunner: bnep-tester       PASS      5.45 seconds
TestRunner: mgmt-tester       PASS      97.05 seconds
TestRunner: rfcomm-tester     PASS      8.92 seconds
TestRunner: sco-tester        PASS      8.73 seconds
TestRunner: smp-tester        PASS      8.78 seconds
TestRunner: userchan-tester   PASS      5.77 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.26 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[RFC] Bluetooth: hci_sock: Fix cookie generation\ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Luiz Augusto von Dentz <luiz.von.dentz@intel.com'
#197: 
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com

ERROR:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal patch author 'Luiz Augusto von Dentz <luiz.von.dentz@intel.com>'

total: 2 errors, 0 warnings, 0 checks, 394 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12918480.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8345256852428876995==--
