Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DAC46467
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Jan 2023 09:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjANJ6x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Jan 2023 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjANJ6v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Jan 2023 04:58:51 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8CF76A8
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jan 2023 01:58:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id k11so3865126qth.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jan 2023 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4HcY/IrYibgPuhVcPanraVntY943srrnXqrS/oNpw=;
        b=k3n8XhPYQZ+m86uE+0DVQ0azzVlh0FT7HlyMbP0/EEO7GxrjCLXNhdP4LDqWTcB2P/
         Zg4uuzRySs2jEONIOVN3rFOgZMneG3DvGAwij9UlhkRWcCcXm/gwSDii1cL8l/uBm4cZ
         b6W93aAaW/jdGy7TXbCatTC9sacsWJcR1EDRhXNs6/6LSTwRcJpvBXYbK5OrTP+rTs/2
         PjlKB6mw8EfGisOu6xSIUd2AwDKkuoQnAvo9/zVlxiFU3vG5tqGu9A1loll/RH2Qcv0B
         U481LJFBiVO1yM+IHgQVuOE+4LWOtHL/OdHW6S+YI9y0J3xzZdZrTBQcperM/Erp8pvK
         oDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX4HcY/IrYibgPuhVcPanraVntY943srrnXqrS/oNpw=;
        b=xKlBO3vUN9G+rD8J/kbpVpdrpizKu4+JMdYNJedJNg6k1Nt90SayuN8GZ9Jvzwlvie
         ztrtn7abPrwOgUONPp1BDqmljE9RwYIg1PVRFpINLUuIHlSZvtTuS2lbpd737+NKRiBO
         TTeXv0B2boQC2IjMqPklzb2CEOZRayGf+y237ZPhuoBW0MwU+6oMxlyIQao1+2Y0ENIG
         JDkpGN4wYSwdtmhzX2KdcgMidv1K728y9pCRMXqEUHbvw1Uku5QIONHjr5uPsGHS7YM8
         tEMDyOSCrxApM6w86L/bHspy6so9fmmoivU4LDL8fWnLcrPoI33CWMuUxCzm1CSxhxsD
         ao+Q==
X-Gm-Message-State: AFqh2kr2Vj8QfqEicx+/oh4WkDtxRu1ekiJ3SDuaoFf7dkCLPQY40r9X
        PKMelxuUx0H+GZbkddxgaQ9eXospPfA=
X-Google-Smtp-Source: AMrXdXslMbHs6MDlIewrAntI2+NosPi7rry604S5LdP+A43r3yz3cgJIPIMx7q7NGaeAcFgudSBwFw==
X-Received: by 2002:a05:622a:1a89:b0:3a8:16a7:696f with SMTP id s9-20020a05622a1a8900b003a816a7696fmr32889403qtc.0.1673690329307;
        Sat, 14 Jan 2023 01:58:49 -0800 (PST)
Received: from [172.17.0.2] ([104.45.203.176])
        by smtp.gmail.com with ESMTPSA id l14-20020a05620a28ce00b007062139ecb3sm2385627qkp.95.2023.01.14.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 01:58:49 -0800 (PST)
Message-ID: <63c27cd9.050a0220.356e3.899b@mx.google.com>
Date:   Sat, 14 Jan 2023 01:58:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6830792181203594376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: [v2] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()
In-Reply-To: <58207d5b81c5739c037c030893fb08ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
References: <58207d5b81c5739c037c030893fb08ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6830792181203594376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=712009

---Test result---

Test Summary:
CheckPatch                    FAIL      1.41 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      37.00 seconds
CheckAllWarning               PASS      41.26 seconds
CheckSparse                   PASS      46.06 seconds
CheckSmatch                   PASS      123.84 seconds
BuildKernel32                 PASS      36.17 seconds
TestRunnerSetup               PASS      512.78 seconds
TestRunner_l2cap-tester       PASS      18.11 seconds
TestRunner_iso-tester         PASS      19.64 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      123.34 seconds
TestRunner_rfcomm-tester      PASS      10.41 seconds
TestRunner_sco-tester         PASS      9.42 seconds
TestRunner_ioctl-tester       PASS      11.28 seconds
TestRunner_mesh-tester        PASS      8.50 seconds
TestRunner_smp-tester         PASS      9.35 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
IncrementalBuild              PASS      34.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()
WARNING: Duplicate signature
#79: 
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

total: 0 errors, 1 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13101914.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (84>80): "[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/"


---
Regards,
Linux Bluetooth


--===============6830792181203594376==--
