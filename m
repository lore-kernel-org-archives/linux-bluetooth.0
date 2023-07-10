Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F1EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 06:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjGJGlS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGJGlR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 02:41:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E213D
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jul 2023 23:41:15 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63770af327fso28967556d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Jul 2023 23:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688971274; x=1691563274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=59a9kaPFqiDyUxeqth8PGfYgpQpescSxm5rI0wrvx38=;
        b=YWVEor0ZxtrA+j+QsScSqfMTDgUgdt6VTSNsyAIgmHtDvNaD7TiIekxnUf2noc30R5
         SJO4/Wu07Ui4sjodzuK2YtF5Uf/EX15A4RVaAHZpfNuZsl1XnxAfZkxJGqYKOfTuOUSa
         NAjiau438tVfs7Yho4xa7hecgf1QM1rSI+CUVKy3IIT8IZTNlu5+7liCsu7a0WIvcs5x
         PWRbWV30HkxrLhFGAxbc+o/MxTBjeRMJhZpf7bKUS75kNfgjS4BpMxoT5iWDULhoNlH8
         2Ujvh5APjCM/7EaltkBCiICqV6T7076TzR2/3KBx2f/XjuHe8BC+gGB3TtTej5FdF8Y8
         0T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971274; x=1691563274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59a9kaPFqiDyUxeqth8PGfYgpQpescSxm5rI0wrvx38=;
        b=VMOkvyPeUertV6kfJFYBMdDNnf2mw4zlBSt8svwlNPwpaXyr0g7KCrYNUBUqP9h3dF
         kvEAmnxgkq1V6GScPOfHF8tecICYZE9fWkw5jtSjohnqih0Nng4z4Ehrav1p1Ub6uoGv
         yXKJmqsU3pZw3koGOXkB3ZF8pdPa5r5sM1CjCDh4gdy+qUwKU5RYFBALdV6MFRRJBgeB
         Z7OUdiUaZiltcqkDc0wohoERC73wbYtPbeGPvQGW2H9if5TriDj9O5XgEG1Vi2g/Z34E
         uZ2kJuMT4tYqlLI53nqJbhGMFW7P5KCwAay0z+4lu2ZRnISXA4j51mgTuO52brSVAI6+
         22kA==
X-Gm-Message-State: ABy/qLZF1UnVcD3oKDvcIDD5DEsbnjKCtv5no47Y96bSHEhuU5bZMa9V
        RtbkHoFylLIu0wcalT1t01M/mUVAJuDNlQ==
X-Google-Smtp-Source: APBJJlGB9BY3xsshcdCE/uh2gqfz6EI9WuzVeYUxLq4MdqyCcd5Wf4IHMZSgWi6CEkCsf+gVm4L/Gw==
X-Received: by 2002:a0c:e4c7:0:b0:635:ef7b:c74e with SMTP id g7-20020a0ce4c7000000b00635ef7bc74emr10556198qvm.62.1688971274314;
        Sun, 09 Jul 2023 23:41:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.122.125])
        by smtp.gmail.com with ESMTPSA id d15-20020a0ce44f000000b00623950fbe48sm5282102qvm.41.2023.07.09.23.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:41:14 -0700 (PDT)
Message-ID: <64aba80a.0c0a0220.aa670.c38d@mx.google.com>
Date:   Sun, 09 Jul 2023 23:41:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2041716840770786654=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v10,1/2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230710055915.3290-1-quic_tjiang@quicinc.com>
References: <20230710055915.3290-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2041716840770786654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763866

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      32.53 seconds
CheckAllWarning               PASS      35.32 seconds
CheckSparse                   PASS      40.15 seconds
CheckSmatch                   PASS      111.85 seconds
BuildKernel32                 PASS      30.83 seconds
TestRunnerSetup               PASS      475.12 seconds
TestRunner_l2cap-tester       PASS      22.12 seconds
TestRunner_iso-tester         PASS      40.87 seconds
TestRunner_bnep-tester        PASS      10.11 seconds
TestRunner_mgmt-tester        PASS      212.00 seconds
TestRunner_rfcomm-tester      PASS      15.28 seconds
TestRunner_sco-tester         PASS      16.07 seconds
TestRunner_ioctl-tester       PASS      17.17 seconds
TestRunner_mesh-tester        PASS      12.60 seconds
TestRunner_smp-tester         PASS      13.64 seconds
TestRunner_userchan-tester    PASS      10.62 seconds
IncrementalBuild              PASS      34.47 seconds



---
Regards,
Linux Bluetooth


--===============2041716840770786654==--
