Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE1C6FA9D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 16:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCAQjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCAQi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 11:38:59 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FC5FFB
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 08:38:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l13so14953595qtv.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Mar 2023 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677688717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ3Rl84LZjNRY6nvjPIEhEqeNC4cAYO971Cb3brf5As=;
        b=HE3zsOZrE7ID3WIEb4K1H32Rv9Hw7NtLB4qLuMPQo/W2uFoQbCU9p5DyLRpXQLseDH
         G4NQivm4GlibhsPl1vUKHWH7T7qJKn2Glc2QT9GNSP8vgG9D5KwYTNPx6heDtFptWXU5
         +RyPVCc6UUfXt0FfqtQIMsi7LrtUeNzjpMyAdpixsRZ/deGysL/lGpNRM/JpU8010J57
         Wn2ln0vMY39TtkN5jUkNafPi8ggYFMGmFUnOLGdslyVz0Z69vuZIbCqp56Irn0kE9nuH
         eDvcdwqk3ne1+emWmV8k9oj3LxLNAb4v78lUCk5UXfCPrTFXnNNvOCa5VN6uL/3pUy9+
         rDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677688717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ3Rl84LZjNRY6nvjPIEhEqeNC4cAYO971Cb3brf5As=;
        b=2P/L8Io3w1VdQjtj4vvFkwt424ugkFKQBjevB22kz5koKt+fntolqWyQIsv5OvUo+c
         O99VYcHVk/3exUSqpd/uNW6+khD8olQJzQZ7iBJ3micTlkLKVT92XIhZMr0LgmCIXuAt
         JSaqjRoqFzed5sMg/ttvDl80L6WxuqbT2AXxD6TfRAmwNA4g2XSLrVYafrvejuA/gveS
         95pcQi7E4zwrLDii607gcmTa2XNjDUxHADKKEuNjYLVz8b3Jn307QIWIjN0K2cgPSMWY
         mWKkLXTtOzGJZg8hu8caoOBLZWQZ3C9rDPO5Ad1KhIeQnrFLn//Fwa7Vb35X4JLvW5FY
         cWIg==
X-Gm-Message-State: AO0yUKWgpWszPffXkJo3t/yjNakwUmY8X04r+YTHC1vQbFI6/RZdvswc
        nB9fzabszMp2waxilOajvIK6gvJjyMk=
X-Google-Smtp-Source: AK7set/ugdtayejAp77GjMONMjIf1DW9xl0t7slQFm9gUz1OdOwGkKhCPhqcvTWq7mzKBHYoPWhS1Q==
X-Received: by 2002:ac8:5f08:0:b0:3bd:11a5:c129 with SMTP id x8-20020ac85f08000000b003bd11a5c129mr10069178qta.34.1677688717079;
        Wed, 01 Mar 2023 08:38:37 -0800 (PST)
Received: from [172.17.0.2] ([172.177.65.65])
        by smtp.gmail.com with ESMTPSA id 8-20020a370608000000b0071de2b6d439sm9065350qkg.49.2023.03.01.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:38:36 -0800 (PST)
Message-ID: <63ff7f8c.370a0220.a8a76.fcd7@mx.google.com>
Date:   Wed, 01 Mar 2023 08:38:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2849783133158022091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230301154514.3292154-2-neeraj.sanjaykale@nxp.com>
References: <20230301154514.3292154-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2849783133158022091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725841

---Test result---

Test Summary:
CheckPatch                    PASS      4.60 seconds
GitLint                       FAIL      1.32 seconds
SubjectPrefix                 FAIL      0.65 seconds
BuildKernel                   PASS      33.04 seconds
CheckAllWarning               PASS      36.20 seconds
CheckSparse                   PASS      41.47 seconds
CheckSmatch                   PASS      111.13 seconds
BuildKernel32                 PASS      32.47 seconds
TestRunnerSetup               PASS      457.46 seconds
TestRunner_l2cap-tester       PASS      16.87 seconds
TestRunner_iso-tester         PASS      18.22 seconds
TestRunner_bnep-tester        PASS      5.79 seconds
TestRunner_mgmt-tester        PASS      115.68 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        PASS      7.49 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PASS      38.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

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


--===============2849783133158022091==--
