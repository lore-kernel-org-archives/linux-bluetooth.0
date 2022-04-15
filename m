Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0675C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 10:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352029AbiDOKDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352087AbiDOKCr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 06:02:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA804AAB4A
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 03:00:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e10so6343137qka.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rNnMPucV9s6/HIxGaMyi86BUuvYj//1L0P/5aHKYxuc=;
        b=KRmkI7wcbU/XYYqf6FK1mcUJSsotJ9UnpIRBT3ouObrDk9kT5o+cOnpiUy+cZr3Ecj
         BJrYiv/VG9QdeDD8Bfv+njBRbi8cezoQbNnjzft9+6k00p7wlkAnV1MT++ta1PfptOte
         42lBxWRvCN3DHHme+n4zUM2OCm0XGwHCMx/s6KEGBpYkG38CycRJOdmocJ0yRVTZQ2g2
         CTCH6BPdGGeXgWCSWCrHlQN2aamt0wlqGUC7PXVF1INcbRLA5mYp1e56oCClG61JiDwJ
         EtBMU3VqgWdVu80ZpaoFUMEpIlQgkuVKSX4uB260iecvMf3T6uZWpnpbfaRCbIXjShI2
         pg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rNnMPucV9s6/HIxGaMyi86BUuvYj//1L0P/5aHKYxuc=;
        b=NkBaOkm01cGS4RjRAVBaii5VkdbU1FbFH8Z8F1iB43XhYPgWtaD9gEJ4CI22u3Jboz
         6r+L2JB7aytxmuK1pLMo30Xjn/FEf6lFyrmKlYU1LuOiJJ60hJ7reOfca4QKW6OdemlG
         HcqmqU5xgkVq7Uedb5rTqIe4AkKuV1EcVwk0y6e/YnbiAUbVfGcwbUlPyUu4Vprp5F/V
         knBIAutdVsMUk6sa6XZ2SBGCQiqVhaB+f7BOcYb1XgCPeN4RPFMgaqTu54OZoqy0/t1t
         3/bbiRU8Sn2DYFq0ipD6YpUz5iinOFyF+C4iaeL+CJdYiFRCMDQusls93HzoveWVKiye
         4eEQ==
X-Gm-Message-State: AOAM533poaApHIrDqTvweEra/OQYHS9KIE1ZpjMMJ1nTKTNeJn7CV70q
        Y5jobEsjTAMXhl/MlvsCNA8IEGQHURznIg==
X-Google-Smtp-Source: ABdhPJzBjt6RMfm3nYanbYfHBWykdOQh52BK/wzjWzva+w2QcvNfIBeIUPKVHr5D2gGv89gJ072Orw==
X-Received: by 2002:a05:620a:4309:b0:67b:3fc1:86eb with SMTP id u9-20020a05620a430900b0067b3fc186ebmr4872781qko.495.1650016818590;
        Fri, 15 Apr 2022 03:00:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.140.212])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm2458994qtx.68.2022.04.15.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:00:18 -0700 (PDT)
Message-ID: <62594232.1c69fb81.6202b.e1dc@mx.google.com>
Date:   Fri, 15 Apr 2022 03:00:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8237525996506190608=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: add support for Qualcomm WCN785x
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1650012819-14665-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1650012819-14665-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8237525996506190608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632531

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      29.64 seconds
BuildKernel32                 PASS      26.51 seconds
Incremental Build with patchesPASS      38.38 seconds
TestRunner: Setup             PASS      472.34 seconds
TestRunner: l2cap-tester      PASS      16.64 seconds
TestRunner: bnep-tester       PASS      6.37 seconds
TestRunner: mgmt-tester       PASS      105.92 seconds
TestRunner: rfcomm-tester     PASS      7.65 seconds
TestRunner: sco-tester        PASS      7.69 seconds
TestRunner: smp-tester        PASS      7.77 seconds
TestRunner: userchan-tester   PASS      6.12 seconds



---
Regards,
Linux Bluetooth


--===============8237525996506190608==--
