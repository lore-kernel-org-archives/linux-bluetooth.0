Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D1C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjEZO5W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjEZO5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 10:57:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994FC9C
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 07:57:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b17b80834so99435385a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685113038; x=1687705038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu7K9QaaYd4mUIBYA+E6Nb6+kIHGJz+Q1EtFcJm3XfU=;
        b=haVakhQKQUMSVPE9iikgxcYznDXs5oqQ7U7N8F/sw/P2JdEqmRMsYCKozTjG6ktcND
         UPh/cg8fL0Ir4TI/Mgd7gP356vtq6Uawzk7WkxgGZIGLqZ1D/4cGt4FO4XU6/FX2exOD
         v05fvJvt/VV5c5epCLdTJC5ELkjNFc/5iYEqwfjza6kwxl0yJ6LC5Ew8WYLBz2hhWnmv
         q0sr0z/97uadsGx8acBHxydJlqoOcBKJxCNPin7ul4jV/Qd67+Zn2263uGKX2uMMX82Q
         8g9npDlfrD+1ZQcSri1XwyEst7XlMFHmnhbdFx/v5gEHkG8oZ78W8oFwFWObAHR2DX6M
         kDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113038; x=1687705038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cu7K9QaaYd4mUIBYA+E6Nb6+kIHGJz+Q1EtFcJm3XfU=;
        b=dga+USI2jrREvQ1in44O3XStiJsfMzbfpO95pjw9r6ObbkKKgSt4rmKbgd6+/yGgOs
         8tzPkG2yx8Ut+Y/kEJt+3bDwTIfcpqV2nWMEJQNPwxjDR7uz6knZ0uVFa0g+hopw45SJ
         tc++g5KWpMHgNpUhs0agFz5aSQaO0LjP79Pwua3d5WBYDz3IdQjRyL4aVrmdNHHx+Eta
         4wuGaXxNC06rWGTsQPxsecXzovct3Xdh3WThKFtgeXNSD3Y6ds6SBtkrGnBvOWUjZwkz
         QUkEcmI3gJuHj/p+h7R9mlgr9O9TBRKr7kcitwbD3c3YhohspBXi0mCRyyEDgNZ/HRSz
         NOhw==
X-Gm-Message-State: AC+VfDwlzTE5gDre+oeR9LXFpSpX5IeYVSXgCKDq+6sDVpmIf3Btbt6k
        NTSgRkpkDiBDuVS23wxJol/whDL+bIU=
X-Google-Smtp-Source: ACHHUZ6qG3NNcq15ryO1gbIwn0aZsOMgPh9ZM9Sqk77xbPgXRtw5b7uc8YV5X+qS8mZMdqLqomb1iA==
X-Received: by 2002:ad4:5c46:0:b0:625:aa49:ceb3 with SMTP id a6-20020ad45c46000000b00625aa49ceb3mr2231858qva.60.1685113038283;
        Fri, 26 May 2023 07:57:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.20])
        by smtp.gmail.com with ESMTPSA id e14-20020a0cf74e000000b005dd8b9345besm1257430qvo.86.2023.05.26.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:57:18 -0700 (PDT)
Message-ID: <6470c8ce.0c0a0220.c4651.7003@mx.google.com>
Date:   Fri, 26 May 2023 07:57:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0411083153176767633=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, horms@kernel.org
Subject: RE: Bluetooth: L2CAP: don't check for out-of-bounds value
In-Reply-To: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
References: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0411083153176767633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751393

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.79 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      40.68 seconds
CheckSmatch                   PASS      110.56 seconds
BuildKernel32                 PASS      31.81 seconds
TestRunnerSetup               PASS      451.39 seconds
TestRunner_l2cap-tester       PASS      17.35 seconds
TestRunner_iso-tester         PASS      22.55 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        PASS      117.28 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      8.50 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.29 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PASS      30.04 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: don't check for out-of-bounds value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (106>80): "  .../l2cap_core.c:4165 l2cap_connect() warn: impossible condition '(scid > 65535) => (0-u16max > u16max)'"


---
Regards,
Linux Bluetooth


--===============0411083153176767633==--
