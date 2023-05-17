Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417DC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 07:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEQH5r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 03:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEQH5q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 03:57:46 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158244495
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 00:57:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1926e90d257so181007fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684310230; x=1686902230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kzbXSHGEhr6oiME3oiV312oJMfEw7r8LcXRpCZMA/78=;
        b=nfECMGcBIfylL5I1++Ey2DUbEvURnOCpAp+2GVOh0pUOVXwn85Xajzh0DzgADjY/A7
         cFynS1r5NpO5BBSM2JqYFl7CGJsuAFKVtNZM9myEaf37xl0uQVn1hQZDxP5BoM2oo2Pv
         wKR5N06XvuB3vYAuyVPCmJPUSnJfl/3T+yXokSFqHnp8GxSam/4U7+d9TeVahWe/jy1S
         zer1+ZoDz2b89EYTshn6/262RmLjU/3IgRlYrSR13ZB4CWIdLd/1z0cZov3ZtI24WxaA
         fxzYD28MGL6jGiB5Bw5GEayQIkY52teFcNeok1d/J+o/2LfVvXgLMyZEQOHdDbS7nrFh
         IMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684310230; x=1686902230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzbXSHGEhr6oiME3oiV312oJMfEw7r8LcXRpCZMA/78=;
        b=GrLjAdEtI/ql8ST5y+UJyn+IOM28IYpFqnckYPnMyPsGCff4ZdAi6DaG6gJHxigtGa
         R/ageC3IyUOKHSk7RhrdeqAaheLyIlz/sAuFznq6ztMV8Ds8A9OfQE22sdv49ZHCECQa
         CClHOORy26zlfeM1ePd+BEx7cwisP5otnoIa7/F0OrGVQnH3/NrfNMqZrlTA1GIKX0CY
         6thiP/JAyj6Px7DmOiq8AogGoTbhYXEt77+s5uvAtf+D4zhbOak/+lRJn9IoOolMxe2W
         +EoQx0vfawjDwTr+/7b9Ohj0CCmUx/TFWaKi3f5eHvBmV8QVhF77IWqZS9J/bcTTvpsg
         ccEQ==
X-Gm-Message-State: AC+VfDw8pduzY4w1KYCwhqQuYeCVE/BwRmR3VU1nIdOyRIpqq5+Mstkc
        zp2AyoyJnZxMzmUbQZySngaQwPewFQk=
X-Google-Smtp-Source: ACHHUZ6zAmoWIGlebz3fMzpSqdUKULE1S8rv60zonrya+GgEZoiHi1IkP9XonTwgzpOd8EK9BnKNPg==
X-Received: by 2002:a05:6870:718:b0:196:8369:dab0 with SMTP id ea24-20020a056870071800b001968369dab0mr12524267oab.31.1684310230354;
        Wed, 17 May 2023 00:57:10 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.43])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870198500b001807f020a39sm13776828oam.12.2023.05.17.00.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:57:10 -0700 (PDT)
Message-ID: <646488d6.050a0220.34caf.6ea3@mx.google.com>
Date:   Wed, 17 May 2023 00:57:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3889268780662911905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: Add support for creating multiple BISes
In-Reply-To: <20230517072706.5988-2-iulia.tanasescu@nxp.com>
References: <20230517072706.5988-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3889268780662911905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748305

---Test result---

Test Summary:
CheckPatch                    FAIL      5.46 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.19 seconds
CheckAllWarning               PASS      35.31 seconds
CheckSparse                   WARNING   40.44 seconds
CheckSmatch                   WARNING   109.45 seconds
BuildKernel32                 PASS      31.65 seconds
TestRunnerSetup               PASS      453.92 seconds
TestRunner_l2cap-tester       PASS      17.19 seconds
TestRunner_iso-tester         PASS      21.60 seconds
TestRunner_bnep-tester        PASS      5.70 seconds
TestRunner_mgmt-tester        PASS      115.16 seconds
TestRunner_rfcomm-tester      PASS      9.01 seconds
TestRunner_sco-tester         PASS      8.41 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.22 seconds
TestRunner_userchan-tester    PASS      5.94 seconds
IncrementalBuild              PASS      29.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: Add support for creating multiple BISes
WARNING: please, no spaces at the start of a line
#505: FILE: net/bluetooth/hci_core.c:5:
+   Copyright 2023 NXP$

CHECK: Avoid CamelCase: <Copyright>
#505: FILE: net/bluetooth/hci_core.c:5:
+   Copyright 2023 NXP

total: 0 errors, 1 warnings, 1 checks, 542 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13244298.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c:6964:40: warning: cast to restricted __le16
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3889268780662911905==--
