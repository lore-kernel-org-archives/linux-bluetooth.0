Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA3C004D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 08:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjASIjz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjASIjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 03:39:47 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C8C4DBC5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 00:39:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 200so928574pfx.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dq9F86nZwwNLjMN2vbmRi+YxipNaAf5UKIFHsLD4M0=;
        b=EVEqv84MjFWcdtN1Mtiyi9uhQ7d2e6Pi9fvFDvfEFwtzYQSATyh1JcNSDKQgL5TrV3
         GI6v7d51ARpWL9vF2OBsaa4AeSXNo5CYi+8daUAmgt26qwEECkBVYR80bBSFxs7jN/Mx
         bORFYSVpNo1QH1SVtgsCPTkKo2Iv20GSaQzdm+tICIr+du7cyPwft9EiRZGeGLHnpIKS
         +x4539pTmSedJS+2iQJTw8nbyeis6UXnLMg559VGRJCXSA0PvvvtxffCgVsjPU1Syk5T
         yPqiDU2QgYpdJMnyzAi4s4vmFmvvKZOdSSDsBDmANURXqwVxPB+l3cnTi2C9QczpIeAT
         C+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dq9F86nZwwNLjMN2vbmRi+YxipNaAf5UKIFHsLD4M0=;
        b=HqcHu+w/axGZO0ecrjmedBrsd4zTx1IqNKbi2981L0de8KbJWLT01UgjilfuQSACK3
         BJJchX2K81r3zTFwTnpyss520r4OKmSDBJPE5GcyGvc5tgPiGxkax6WrTLEG8X5MfKS1
         2TY30uAd0bCEFxsw4S5IYsczr21wgse4Sn6uPOUG1Py53EyvFIbGqmsJI+5eenP3ZTu1
         LzqUcJSXT/RJ5wJaJP/NrIlqQ5IqnYSnFvvIaaf3A7Od0eXYkmSMdKKhb+k+bcDl8UiZ
         vmJR090ScuWwNLx2Y25Y//SZGGkqul5CGFNWxVC3cCCKXqz1FwSfuxMCuKXGknQwiR+K
         q51A==
X-Gm-Message-State: AFqh2kqh7fKYgq2B+nxUaU16LYxPrk+s0K9oSkEQjLtzco1gDvkNtkFn
        cb6X6Ohj2O11n/bzNZLsKqwUWyS76gU=
X-Google-Smtp-Source: AMrXdXse6i0DBfB2EqhCyG6uiCBzrCIR13w0c/aMi5pUIwkk+Q4Jg48IS0ptjg9ulG/qqgnO5qEFjg==
X-Received: by 2002:a62:19cb:0:b0:58d:b2eb:86ef with SMTP id 194-20020a6219cb000000b0058db2eb86efmr9763890pfz.9.1674117584223;
        Thu, 19 Jan 2023 00:39:44 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.195])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b005815a371177sm22726203pfb.52.2023.01.19.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 00:39:43 -0800 (PST)
Message-ID: <63c901cf.620a0220.ce7b.4781@mx.google.com>
Date:   Thu, 19 Jan 2023 00:39:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7710274923208330442=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [1/1] Bluetooth: btrtl: Firmware format v2 support
In-Reply-To: <20230119074714.156283-1-max.chou@realtek.com>
References: <20230119074714.156283-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7710274923208330442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=713556

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      38.98 seconds
CheckAllWarning               PASS      42.77 seconds
CheckSparse                   WARNING   49.12 seconds
CheckSmatch                   WARNING   130.11 seconds
BuildKernel32                 PASS      37.73 seconds
TestRunnerSetup               PASS      543.53 seconds
TestRunner_l2cap-tester       PASS      18.83 seconds
TestRunner_iso-tester         PASS      20.04 seconds
TestRunner_bnep-tester        PASS      6.81 seconds
TestRunner_mgmt-tester        PASS      126.67 seconds
TestRunner_rfcomm-tester      PASS      10.59 seconds
TestRunner_sco-tester         PASS      9.78 seconds
TestRunner_ioctl-tester       PASS      11.47 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.61 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      35.70 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c:893:22: warning: cast to restricted __le16drivers/bluetooth/btrtl.c:899:27: warning: cast to restricted __le16drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7710274923208330442==--
