Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD2C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCJTDZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCJTDX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 14:03:23 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257171167F
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 11:03:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c18so6869733qte.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678474999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0iW9sQDhI9S5zn4IUOlnHVsFhdVMHSnvP7KURqpcNjc=;
        b=MQX/dROJ2PqRDDsViIBCxCmVsQPPwMfSsmS53zyUU7e4hQks0fazSJPDeVjRTWeO/J
         /20j+lwLQW3JQDt3Qq7XGm51dK0Z3RNAxAeJQA4gIRThgdiKMPFj9ESw0l6Sl4l8LX38
         iBTs5WIOpSk7GjoUJo43/GPH9lLOJo6zCgf9EjVPDKG9C/V1z64QYNoOLHs19zmRTDd/
         Y1LzqxxRvluwqLQnNQ3mKG04miQuP7UjJLoJBZmH/SzGtfb8Xwe4b/iEaPRysAS3tLaJ
         KECEmNPkiOjDsAFhWNo/kDPRdTMRWTAEi9R0G9sVdG8fhP1D7a8WtGenCZyudq71M3o2
         kbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678474999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iW9sQDhI9S5zn4IUOlnHVsFhdVMHSnvP7KURqpcNjc=;
        b=ygVFVE3h0p87dLdcaOqDc+KcmhBY/D6pLSL5Y2jJuflDz4lXVpjlCU3vpff4Q5xkFN
         xZNT5M+8hRXvOrzP9aX0AE+A5DnZyQwWWJLELabnL95d6HDfmDNZDgoF9OLhCfzIOUmU
         O+x7AoMt1pLjYF6fR0T7z9CFv6m0OQj7D0Wyx6s8qLbRc5cwgH70iRflDdth4dJyMiK0
         F6TLVXY9YY5O3UZ9dTaHFfHZ1gU4f3JQU6X0IELHNZYGFujvxAWdC8eVw/SqeHBMWcsz
         j+A4GPb6JEk+sMtWZyPhQ03V/+eAcN07A7e9+T2TWJAJa15K0LNlKOS+2dG4C3yTEB/R
         tDCw==
X-Gm-Message-State: AO0yUKXjBW35AEfm3ac3EVhbo3Koe0f23DPDRGFr4Oa6CBjAL/56q3RX
        FiivK6bChVP+Y7UYJOz7i4vjSBXLrQo=
X-Google-Smtp-Source: AK7set/zOW8O6A+chlgiCyq0zTNKq3OSZXr8PmJmfqtXdu2VHAa3LGw+T9bPIgBakmO53qvwC/ZuCA==
X-Received: by 2002:ac8:7f16:0:b0:3bf:d0b1:433d with SMTP id f22-20020ac87f16000000b003bfd0b1433dmr48573913qtk.60.1678474999554;
        Fri, 10 Mar 2023 11:03:19 -0800 (PST)
Received: from [172.17.0.2] ([104.45.205.16])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05620a808e00b0074357a6529asm286367qkb.105.2023.03.10.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:03:19 -0800 (PST)
Message-ID: <640b7ef7.050a0220.3789f.1c73@mx.google.com>
Date:   Fri, 10 Mar 2023 11:03:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3276173923934508136=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230310181921.1437890-2-neeraj.sanjaykale@nxp.com>
References: <20230310181921.1437890-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3276173923934508136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728841

---Test result---

Test Summary:
CheckPatch                    PASS      5.02 seconds
GitLint                       FAIL      1.42 seconds
SubjectPrefix                 FAIL      0.64 seconds
BuildKernel                   PASS      37.65 seconds
CheckAllWarning               PASS      41.25 seconds
CheckSparse                   PASS      46.81 seconds
CheckSmatch                   PASS      126.67 seconds
BuildKernel32                 PASS      36.91 seconds
TestRunnerSetup               PASS      523.67 seconds
TestRunner_l2cap-tester       PASS      19.02 seconds
TestRunner_iso-tester         PASS      21.05 seconds
TestRunner_bnep-tester        PASS      6.76 seconds
TestRunner_mgmt-tester        PASS      127.35 seconds
TestRunner_rfcomm-tester      PASS      10.91 seconds
TestRunner_sco-tester         PASS      10.12 seconds
TestRunner_ioctl-tester       PASS      11.74 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.65 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      45.82 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v8,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3276173923934508136==--
