Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E10C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiE0JNX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiE0JMg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 05:12:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3159880C9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 02:12:14 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f14so2638919ilj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yfm2XY89+WksGEbReXq3JcT373NxaEB76rybHJnSa7Q=;
        b=QPruXFhlVKUDBzD9FVFsxyQO1Q692sguJrqo8phSaIkVoFBsVKwGp6Ic4QX6Aro4jG
         zrYRDnAuO6YJS5pWhpyRM5SdAibSpIM/qFmdZAYS8Q4QxMvkAOs4XkTrTRxvl5Ab3gJW
         FFobJlWo7YxmzIKJrTDSMuafSueFO3L/Rko45KNLF23wy3q1pn47XZo+frE2RlIdp83G
         xFSRNTojvCNWVYBgv4xgjtDFlHi8pq2mx4VorhePtkdhVbFa3TlzQR8eFnCBOOGR3JYR
         d9HLHzZSnHjNJ543uX3MGl4AI4nr6rHfR3GvhLidmNS01If5Mn8r9xtBrEVLc6VQVIoP
         /Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yfm2XY89+WksGEbReXq3JcT373NxaEB76rybHJnSa7Q=;
        b=yT/MIx2xW80s10TqCk1Gl/LTWuJKTcv6cxll/tYzjv33yLQRuLoes2v/mTCUoAkG2z
         mLWCFJSo34GuVEynGuFMBjyRbeAXoIIO1sktP7WzOIDVSc+yUR3ri3YR+buqfY640IXw
         Ce2l09du9Wr43Ete08rli9A1Kl5Mdkx+oPiD5SBZwkJJcMtWNfsL1gSUEwHKarWQQUVj
         xhTknbIhM5oPRvmRR86xZ3v5B1AhoS+tvkdSuiGYdntzbvTFyxCTJOS95SATNnCN63PF
         cl+eSc1vnznbgS6+pswMhObRgUwR4tP5VTBj2a1ASIwtlLsGjxpk3vD+/n1FRcps1zVf
         wywg==
X-Gm-Message-State: AOAM530eBBaILINnnMHNN/vOcFAUK8N/OHcGpu34S5CzxWJE0MdTLhf3
        /FtUsAPj6fbO7QEyqDhEjHOppWea7fI=
X-Google-Smtp-Source: ABdhPJwe2w6ljpXE0DRuogLi1pX2E0F6RZ2I8/iO6gga/S/ZmqtQGp8O4XKaiqU3W8a/6JBWAZA4Bw==
X-Received: by 2002:a05:6e02:170b:b0:2cf:9f8f:afdf with SMTP id u11-20020a056e02170b00b002cf9f8fafdfmr22777336ill.260.1653642733727;
        Fri, 27 May 2022 02:12:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.208.230])
        by smtp.gmail.com with ESMTPSA id cp11-20020a056638480b00b00330c4762d44sm436130jab.53.2022.05.27.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:12:13 -0700 (PDT)
Message-ID: <629095ed.1c69fb81.f5a72.183d@mx.google.com>
Date:   Fri, 27 May 2022 02:12:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3749651725435565865=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: RE: MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
References: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3749651725435565865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645499

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 FAIL      0.64 seconds
BuildKernel                   PASS      34.53 seconds
BuildKernel32                 PASS      30.98 seconds
Incremental Build with patchesPASS      41.58 seconds
TestRunner: Setup             PASS      519.51 seconds
TestRunner: l2cap-tester      PASS      18.08 seconds
TestRunner: bnep-tester       PASS      6.25 seconds
TestRunner: mgmt-tester       PASS      106.17 seconds
TestRunner: rfcomm-tester     PASS      10.00 seconds
TestRunner: sco-tester        PASS      9.67 seconds
TestRunner: smp-tester        PASS      9.77 seconds
TestRunner: userchan-tester   PASS      6.65 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.64 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============3749651725435565865==--
