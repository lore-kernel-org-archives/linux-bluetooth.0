Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1FEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 12:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjGGMtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGGMtH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 08:49:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38DA10EA
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 05:49:06 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-767b6d6bb87so25666785a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688734146; x=1691326146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yLLhmkDXPCLVNW8Q5RMRlC5gFzdxpK2G47dDAKbC/Hg=;
        b=I9n97S8DKF8R86vQqH0C3JP/3CkCU+MT5Wm3LIRO5ashs/qYGBzG9LHa20MID4aTcS
         ylbTz6VC2UeFePhxaUJQr1NzqoOIs1VuoXUvQIlGcotoTpRYAe4Ll7vLfmk+btM4xAlw
         hfh59VczyurUcLRFqMX/Sc3GGF9C8O4x43roeggm393DImbJTqgsJhpo3W4ohvCOLZel
         H25ckzqUTSuM9US1FfINGs/Ppdu05onK7tQTSd14Yd7StaWRh/D0cI7/4mrlhXNzand6
         KgF+U3nSzLbvtF52+RiRxnuy5Y7ZN5Iiy5ZvYwV3pwy2nSbTZiKDQsGkcLOGKu323kL1
         lfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688734146; x=1691326146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLLhmkDXPCLVNW8Q5RMRlC5gFzdxpK2G47dDAKbC/Hg=;
        b=KBDpI6TKJEOaLEZyJ/W9oD6iRXfr5YWp4QiecewURFNSF4YvbaE7ce9dnd04S1CYyU
         +hdNn7qTBa2E8K/OyG/JZZDhEgaKwvuNXOhozZnKRI0F1MfwLcGqTjPFAmZRCu5wKcBr
         WhFRn/aeXHJ922wSyq6b+RoD8azybjMhuqjdHF9niexFCvYBpNuNKtPmT616rv0Fv0N7
         WfrFcdfvyukTHnWznfZLhLILr2gjzq0SP0aY+pKC55kRYmHltN7LLOlpyTEmadV15HzD
         NAySXbvHk1fYxuFWdwQMUb4cJqfu2taXckNLjztIhEumtJY7vYdQWn1soVgP4cYOBm07
         bhfg==
X-Gm-Message-State: ABy/qLZV5FFIwDk9sufLXhxdZv/N8FRS+Wmybg8ftnb2NtvXCaCAehGU
        fdmdYiuaGgnVuwrjMB3+qBTXD8Gc4Oc=
X-Google-Smtp-Source: APBJJlGAXBYs2YV/D6aTPKljuMGc880ySjTlZaN+sLcRW8yqj1yWyV2tCKS23dSpii1UDWGIlJYFhw==
X-Received: by 2002:a0c:f394:0:b0:62b:3c25:5ae9 with SMTP id i20-20020a0cf394000000b0062b3c255ae9mr3923380qvk.65.1688734145703;
        Fri, 07 Jul 2023 05:49:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.57])
        by smtp.gmail.com with ESMTPSA id a12-20020a0ce38c000000b00628563d4441sm2034643qvl.66.2023.07.07.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:49:05 -0700 (PDT)
Message-ID: <64a809c1.0c0a0220.ed6b9.58b6@mx.google.com>
Date:   Fri, 07 Jul 2023 05:49:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1554413305737596838=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v9] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230707113645.10673-1-quic_tjiang@quicinc.com>
References: <20230707113645.10673-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1554413305737596838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763432

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.62 seconds
CheckAllWarning               PASS      38.12 seconds
CheckSparse                   PASS      43.91 seconds
CheckSmatch                   PASS      116.20 seconds
BuildKernel32                 PASS      33.32 seconds
TestRunnerSetup               PASS      510.99 seconds
TestRunner_l2cap-tester       PASS      24.68 seconds
TestRunner_iso-tester         PASS      42.77 seconds
TestRunner_bnep-tester        PASS      10.85 seconds
TestRunner_mgmt-tester        PASS      232.99 seconds
TestRunner_rfcomm-tester      PASS      16.68 seconds
TestRunner_sco-tester         PASS      17.29 seconds
TestRunner_ioctl-tester       PASS      18.55 seconds
TestRunner_mesh-tester        PASS      13.46 seconds
TestRunner_smp-tester         PASS      14.89 seconds
TestRunner_userchan-tester    PASS      12.17 seconds
IncrementalBuild              PASS      32.23 seconds



---
Regards,
Linux Bluetooth


--===============1554413305737596838==--
