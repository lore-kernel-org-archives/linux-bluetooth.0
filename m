Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiKRIiO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiKRIh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:37:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E698EB5E
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:37:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn7so2114053plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws/ob7cX+qH78PjwLOxivNly7ZMLVei6jsvQApHKlVM=;
        b=HFG68644aDA212OqUNDSguAMGiYXPGZWvx12D573622miiflPJTMz9/5qiR3j9Rrf5
         /DFItfNhu/nJKjrvuBC93q4QAGQm/RLNvW+KujN+CFTlWh/gGhaHS/jfN5f5CYcvqnXP
         4zQtPzoQ6pLZsaOD8b4lN6rnxvTNmojj4XBaKvGJfzDZ/xXSJtVFJHROsBCjbNIapj84
         9gARMvT/y8uY8QDxOiIsX4RxDepxGOPio81ftW1D3Yc4O1huLauxdww70p+knmSAAU6r
         Knu7OdBVM4tj0AJtr89K01iZX5ALxu/Ad6qIqAWv9q3KG/ItPwEXHrZgewBbm+MPukbi
         UN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ws/ob7cX+qH78PjwLOxivNly7ZMLVei6jsvQApHKlVM=;
        b=05FK1vglZMiz1iSzbd8aELuU4pzl4pRuOHpPd4kvpu/szckKrQIMPbta+qCAamRl0Z
         cghRbFY9ltSXuulPHrRoCjqjdxB8JVzFVGHiMLTbX7tjfNFTBd2W/fFznJJttmnftF8k
         XVZuv3jrqchVu/XwuYO4oPShBMPLtgsKsZAoDQ8HKHxMm2ghKdUwx8Yfq9UBmj0dj8kM
         AsepUgMgin90pZAvOSd7EpwHBu8wU32XCwLXVaWYZb/eVAfdkjOe4cL8vTzDZDRtJt59
         hqtOSkKi8hBpTB88cSJuQObRbPIOQL/T75e5cylodaQeOG22+1WO22svtY2Qq2CMSB+D
         KeCQ==
X-Gm-Message-State: ANoB5pnnoaRr9ncPjJRU8Swd44/bTJKrjMz93P6rWCIUZ6bdnw14Ac1Z
        wwks+IxlH9ZUiCCiI7KKON0AAjMWguk=
X-Google-Smtp-Source: AA0mqf7BNU7sZ4Og39evJtKjw2sjNw1Ybb6FwDBP28Tg0LkGmtEKvwAfHxcE4oCWVvHS/BIj/qCUsQ==
X-Received: by 2002:a17:902:9301:b0:186:a8c1:884f with SMTP id bc1-20020a170902930100b00186a8c1884fmr6850034plb.25.1668760658485;
        Fri, 18 Nov 2022 00:37:38 -0800 (PST)
Received: from [172.17.0.2] ([20.66.27.205])
        by smtp.gmail.com with ESMTPSA id s27-20020aa78bdb000000b0056c704abca7sm2530656pfd.220.2022.11.18.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:37:38 -0800 (PST)
Message-ID: <63774452.a70a0220.4f8fb.3e51@mx.google.com>
Date:   Fri, 18 Nov 2022 00:37:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4633743443989578353=="
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

--===============4633743443989578353==
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
CheckPatch                    FAIL      1.91 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      43.13 seconds
BuildKernel32                 PASS      38.50 seconds
TestRunnerSetup               PASS      542.62 seconds
TestRunner_l2cap-tester       PASS      18.80 seconds
TestRunner_iso-tester         PASS      19.97 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      130.08 seconds
TestRunner_rfcomm-tester      PASS      11.34 seconds
TestRunner_sco-tester         PASS      10.45 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        PASS      8.57 seconds
TestRunner_smp-tester         PASS      10.33 seconds
TestRunner_userchan-tester    PASS      7.14 seconds
IncrementalBuild              PASS      46.04 seconds

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


--===============4633743443989578353==--
