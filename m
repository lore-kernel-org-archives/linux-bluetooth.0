Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2314C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 11:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjHXLDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbjHXLCw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 07:02:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448AB1711
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 04:02:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf5c314a57so30659705ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692874965; x=1693479765;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy/WnS0aKYpTOdOEILZVRFkKgNTG8J/j/Q+C7zBbM9g=;
        b=GpbCHBVYtxPdz8V0qca4jQupIrZc2XpUzvCOosjIMJ2EFxrzMG8edP3LtvqNRgrnK1
         74lwhFCNU6N4UTK+fQzetBLNMbkiNdJa69atLPCZbnz2yR/JwpPX/ymDkPXUFV1wTijt
         7IaGsvUAsmQP+OnfA2pXgStHkNlVXFMjb7ytqQ5fHRtU9l0C/lMaAp+KS2wHJQLYWPf0
         UpnUs2lBWS1mzI8/mskL68fL8cWd+QEMIcX0jTpIUq4xrnsxFkIlzkiz2wIlSocK4NXG
         6L46r5OAKbt+mqucWMV3DYV3xpk9B3ux+Xs9vYZH5LcK3I1C5O4DFkDF3U3OQns+6Gp2
         p2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874965; x=1693479765;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xy/WnS0aKYpTOdOEILZVRFkKgNTG8J/j/Q+C7zBbM9g=;
        b=EVa+pD3p5HfJO1Qb61pR0QiYTz3iw9f/EUnZlqnMI6qX0r0mQ8FEWaV8Flq5lDJZQj
         8PySF4E8nwEM++0k68iVW2KGUKyyJmUm3QD7J01f83YTpFPre6yTucgIgDkoI2z5o2tx
         WL6O4Y60X0fggqfR9m65Ep6mGAmKgg1DcbHs6FsO504gQI4ynEk4KkcWb+hnIwI7ZST0
         7+f3iNnIC5TBMB00zcZ725gslWeTYc70bQSfndCsEtPY6/4a03AJZlmfEiojEiKwk+gO
         93w1KEM6tWa9kq5A2MPOawyoID/k3kohvCvieKArZzve3KpB3dmzguOSBji5qv4IOKiQ
         qceQ==
X-Gm-Message-State: AOJu0YzMtDYuPZSmkU46tLo+IJZvQTuyV2l9XWm/+5b8633TYCKwOZic
        EM75VYwUlANLGSwhkilN0EZJsgti6CQ=
X-Google-Smtp-Source: AGHT+IFIID24397v0LXxY9JFd1Hm57ZtKi+3CXqUcyp6Xfr33MEsP4RW4vfW4jN8oULFTgYp/R1ESg==
X-Received: by 2002:a17:903:258c:b0:1b5:532e:33b8 with SMTP id jb12-20020a170903258c00b001b5532e33b8mr10838764plb.35.1692874965406;
        Thu, 24 Aug 2023 04:02:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.73.149])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001bb9bc8d232sm12552116plb.61.2023.08.24.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:02:45 -0700 (PDT)
Message-ID: <64e738d5.170a0220.bfeef.8eca@mx.google.com>
Date:   Thu, 24 Aug 2023 04:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0252130137552815969=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add support for handling encrypted BIGs based on BIGInfo reports
In-Reply-To: <20230824101635.25662-2-iulia.tanasescu@nxp.com>
References: <20230824101635.25662-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0252130137552815969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778935

---Test result---

Test Summary:
CheckPatch                    FAIL      5.52 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      32.54 seconds
CheckAllWarning               PASS      35.10 seconds
CheckSparse                   WARNING   39.78 seconds
CheckSmatch                   WARNING   112.40 seconds
BuildKernel32                 PASS      30.64 seconds
TestRunnerSetup               PASS      474.65 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      48.47 seconds
TestRunner_bnep-tester        PASS      10.71 seconds
TestRunner_mgmt-tester        PASS      217.61 seconds
TestRunner_rfcomm-tester      PASS      16.05 seconds
TestRunner_sco-tester         PASS      19.45 seconds
TestRunner_ioctl-tester       PASS      17.98 seconds
TestRunner_mesh-tester        PASS      13.47 seconds
TestRunner_smp-tester         PASS      14.29 seconds
TestRunner_userchan-tester    PASS      11.37 seconds
IncrementalBuild              PASS      58.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: ISO: Add MGMT event for BIGInfo adv report
WARNING: please, no spaces at the start of a line
#130: FILE: include/net/bluetooth/mgmt.h:6:
+   Copyright 2023  NXP$

WARNING: please, no spaces at the start of a line
#183: FILE: net/bluetooth/mgmt.c:6:
+   Copyright 2023 NXP$

total: 0 errors, 2 warnings, 0 checks, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13363954.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============0252130137552815969==--
