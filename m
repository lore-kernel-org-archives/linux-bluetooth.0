Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E5C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 05:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjERFcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjERFcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 01:32:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26E1BD9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 22:32:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f39bc37e91so8721001cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684387927; x=1686979927;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xL8ml1wQZFxCFe/lvXQADogtVcpH0IYvStH1TEGsxjU=;
        b=IAvwhaXbPJExlvA0d7DVJMhMPpSwzLjnze6USncPSbSYOBc/2IKEqyFDqGUtbpJUH9
         EKFcterrShlzydzGxRZX3I0QkqAAX9pi5rEMJw9NjaXy+aIl1FsWh6UPLtQ1fiGIzEmn
         43NxQ2bJEQ1s+RMXo4034jHhSWT7AgtXpdSeK47gILO8HmsBrFmzzZ3uwjBWNuhayqJM
         qJ3dhbHY8geqrhsxmyRW3UisU5i9XnWJInxBeYlL6H9DeTAn2rqagUuUMDsj8qovJPiD
         qRf+qTt7VgoPadGtTEo14QSuMqAawnYD/yR7h5pW7ACrGH/tgUhatH3VGZkgfFYL+Qoz
         Yl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387927; x=1686979927;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL8ml1wQZFxCFe/lvXQADogtVcpH0IYvStH1TEGsxjU=;
        b=IC7+BzlWEF6uMOLDyJkFsp2ZQtJVF1ZaFzt4hlwY3bH8GIsxRPj6wEfc++q4yWheQN
         Glxho9iv2RKTUJQJv0aXmVyGEBpqGsFPgHVTlyuqFB0kswB0jkPUQvkILaHDtXmIXEgq
         wqjCtK56OtDEdhyQ65nl4YqAtfDd4md7Ai2dq3z3NVjWHinUuaXZ3GE5FJnXhJXfDIXf
         LmPrhGyVUuMaDN+X7KRD1w493mdMaVgeQncahgNuSPp31QJU/Eu+s8C5OVtQJr1qnpGG
         RJdZvDclU5rtwcGLxQ2JcrBrNDa+tPEoRVdGGax8L6xjjb8XNuocx3spgVsmQ12oFVfG
         PYGA==
X-Gm-Message-State: AC+VfDw1GIGPfKcAJhcHArXc8navHZQYAZEMnvFaauVSgmBbcQFVtY7H
        nEKVVyudPcJSg5DZQXHFpzaCaeG/MOk=
X-Google-Smtp-Source: ACHHUZ4RBM1eD9R1r8WvfACJYzH6Q2uCP+WX61n/z/duizIpQ0siH+yYV7UHwAE0uL+6GvGZsM5eGg==
X-Received: by 2002:a05:622a:11cc:b0:3f4:f6e6:a2ac with SMTP id n12-20020a05622a11cc00b003f4f6e6a2acmr3895147qtk.57.1684387927158;
        Wed, 17 May 2023 22:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.65.65])
        by smtp.gmail.com with ESMTPSA id d11-20020ac847cb000000b003edf043048bsm256831qtr.9.2023.05.17.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:32:06 -0700 (PDT)
Message-ID: <6465b856.c80a0220.ca012.0a93@mx.google.com>
Date:   Wed, 17 May 2023 22:32:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5809553918832383834=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v1] dt-bindings: net: Add QCA2066 Bluetooth
In-Reply-To: <20230518050826.27316-1-quic_tjiang@quicinc.com>
References: <20230518050826.27316-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5809553918832383834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748749

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      31.50 seconds
CheckAllWarning               PASS      34.17 seconds
CheckSparse                   PASS      38.91 seconds
CheckSmatch                   PASS      107.24 seconds
BuildKernel32                 PASS      30.27 seconds
TestRunnerSetup               PASS      436.00 seconds
TestRunner_l2cap-tester       PASS      16.87 seconds
TestRunner_iso-tester         PASS      21.34 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      114.77 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      8.23 seconds
TestRunner_ioctl-tester       PASS      9.65 seconds
TestRunner_mesh-tester        PASS      7.07 seconds
TestRunner_smp-tester         PASS      8.18 seconds
TestRunner_userchan-tester    PASS      5.91 seconds
IncrementalBuild              PASS      28.64 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============5809553918832383834==--
