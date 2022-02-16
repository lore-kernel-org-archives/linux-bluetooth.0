Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13926C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 04:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiBPEAQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:00:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiBPEAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 23:00:15 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC1FFF86
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 20:00:04 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id q20so960858qtw.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 20:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HURjIxx3EGK8jFh1TmzxvIP38bMVABVdxegseQH4EjU=;
        b=WsNrSCJ1PI3iSdf9ZdRy6n8thS2UXAefusAvgPWc7o07u6mypmIFTOBylG9QmdA9P4
         Jp4BXWdvRvKXe/H9ZtjCy5s0cQ9IpD3XoB9tHCgddMoefVSTqYPLubt7+Z0IHERm4krF
         J+eoBm3RaBrCX0asWcf+j+MtwehM3HPDJZbRPDLYKCedtVtsXGbRwK3+GFAPWcIeDo/V
         eu24YSaNjHrfaPBl621hrbs1XnqNMviUlOlV/ncTxHXUSmuBbVj+Mr1MG/J14YkaJzfP
         cnKj0XHQk6psZslRbuNywX88qvIYWIx40EMQXFOsgxN161ODxRiiDAS8QLNdghk21vL3
         1oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HURjIxx3EGK8jFh1TmzxvIP38bMVABVdxegseQH4EjU=;
        b=zVsCSzQOpwxmXoNKvk66wlfRH+Ai5iqysK7mRTWepBF4KRYZLKOj8eWft7xUocKHzl
         pIUicTOWjnTG5W9g+BHByPDfPEGs2Wu8Kd5Szm3EZPGNe58vHQZVbrBpssAYUVq5+x03
         NXxgSkPEQ8wfcoD+ZS0Gt0KMeytctalrFeo/yXkP3yFEAYiCEns3kN2AfRwoHgV4cHGk
         QeEXj9IFxbZfKgEDCizFSnU9C20ltPoYslGdp3/8tb9/H2KnTv8EHD1XoUmzZx0uYATV
         GiJwedCDHJazwXSRLrVbbVWeVKy3VlC02Jr/xajomRBcSG/yukeMNsLD7xlu+dCBOEiP
         P6Tw==
X-Gm-Message-State: AOAM532HO7Qk94y/6A+ihS5TFjxxJCs5waWb79vm6G7sb9NPVeFslwBd
        YX2cfv7EqNc9cGJgwJuUQ1QvCqWMhO36Bw==
X-Google-Smtp-Source: ABdhPJzaaWLIMRNDmcMp3As9oL4+xWqHI7T90RxkXQJNy6FEXkGP7OvzFMWhvl6+IpEnVI1G2XZUAQ==
X-Received: by 2002:ac8:7f51:0:b0:2ca:8f7a:5586 with SMTP id g17-20020ac87f51000000b002ca8f7a5586mr807037qtk.462.1644984003428;
        Tue, 15 Feb 2022 20:00:03 -0800 (PST)
Received: from [172.17.0.2] ([20.121.218.143])
        by smtp.gmail.com with ESMTPSA id d22sm18821095qkn.112.2022.02.15.20.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:00:03 -0800 (PST)
Message-ID: <620c76c3.1c69fb81.fa102.5e3a@mx.google.com>
Date:   Tue, 15 Feb 2022 20:00:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0449285112646477339=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linma@zju.edu.cn
Subject: RE: [v0] bluetooth: fix data races in smp_unregister(), smp_del_chan()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220216033619.10821-1-linma@zju.edu.cn>
References: <20220216033619.10821-1-linma@zju.edu.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0449285112646477339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614788

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       FAIL      1.06 seconds
SubjectPrefix                 FAIL      0.86 seconds
BuildKernel                   PASS      30.92 seconds
BuildKernel32                 PASS      27.23 seconds
Incremental Build with patchesPASS      37.01 seconds
TestRunner: Setup             PASS      475.85 seconds
TestRunner: l2cap-tester      PASS      13.55 seconds
TestRunner: bnep-tester       PASS      6.14 seconds
TestRunner: mgmt-tester       PASS      105.79 seconds
TestRunner: rfcomm-tester     FAIL      7.67 seconds
TestRunner: sco-tester        PASS      7.74 seconds
TestRunner: smp-tester        PASS      7.70 seconds
TestRunner: userchan-tester   PASS      6.51 seconds

Details
##############################
Test: GitLint - FAIL - 1.06 seconds
Run gitlint with rule in .gitlint
[v0] bluetooth: fix data races in smp_unregister(), smp_del_chan()
37: B1 Line exceeds max length (81>80): "[   49.097146] =================================================================="
69: B1 Line exceeds max length (85>80): "[   49.097611] RSP: 002b:00007f5a59d6abc0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c"


##############################
Test: SubjectPrefix - FAIL - 0.86 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject

##############################
Test: TestRunner: rfcomm-tester - FAIL - 7.67 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.154 seconds



---
Regards,
Linux Bluetooth


--===============0449285112646477339==--
