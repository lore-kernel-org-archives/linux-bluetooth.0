Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1131C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 06:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLPGgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 01:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLPGge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 01:36:34 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C59642C
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 22:36:34 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s187so1187132oie.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 22:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz+dsYIrZnPGciImPUnMwp8VYSoV2WLungKip93LucI=;
        b=VnmzA6RGaOc2FKAhJdVZ9zUOewoEH9UUc7zvFsNhpkCMVazp1mDYw//1yTl4301f4W
         x6qIQNy4LmENPymY6+7r8bhkJjETGXUVt0PKXKLKSeZXaWtALlcdzvQateFs+P4VYFop
         v74ZiGb+g5w7hQFBQjVKpCu4fi1mPhBXEIYUVFpWWFJoKoPFcm4NPVVAzzc0/Hi6cNij
         8X39ihlvqeMRqCyUyNNhZxYpJVHTE7B9hwQWNWf0H16GvEfj8k5+k0jH0dmIhPk29t9+
         KtVr7NJXPFMcp+epSAiABHMbT5ZeV2MuJVnuopFapOcN7EuTpeO5IGlO0zFOixyWGPWc
         m2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz+dsYIrZnPGciImPUnMwp8VYSoV2WLungKip93LucI=;
        b=vw5ow9iXJ9f/fRAygPxkuC9xQzha4BGy45nm7ZuldWjYLqhIgpdizhtNKQ5zVmSap8
         m+wgSpW2LxZd4j0Vz3RXO7uyHtTYuXONVOksHGU9Inu7rICbypkLxcHA4j0pVwOmfPmZ
         GSLn+J+ZzuPtg8LEVMj/Z6B/pHn2oeub/H6ONlvEthzlqcuCMsijncI53nwoPaLM2Frr
         QIGpZQ2Etrv4DsPTJnReXoOA5smiHxqVUsnghv/LcLOdpzaMRiPFEo+pg3hZFzhrJ5m0
         0f4wHkyDVau+hbu4+Tn4z/BwU0xH7PIhWwslWrrq1oTXZFuVY7N2NlOsGp5+95h/32JU
         4zeg==
X-Gm-Message-State: ANoB5pl1fVHx0y3tkQieVMyFro2NivpHNtBhC6JNmsQcjW5zZe8Ibc1v
        uxuwwVgfpGBUQ/4BVATXX8Cyn+vT1DnvqQ==
X-Google-Smtp-Source: AA0mqf4tHe8gbsax8uDC9Z5daZiBLdquzqOBRWCBnEpYXwnOjsk/kEJncovVuPqYgTkJziX+ezJWmA==
X-Received: by 2002:aca:1b1a:0:b0:35e:b08e:165 with SMTP id b26-20020aca1b1a000000b0035eb08e0165mr5650479oib.14.1671172593193;
        Thu, 15 Dec 2022 22:36:33 -0800 (PST)
Received: from [172.17.0.2] ([13.65.246.128])
        by smtp.gmail.com with ESMTPSA id r44-20020a05683044ac00b0066e7e4b2f76sm495968otv.17.2022.12.15.22.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 22:36:33 -0800 (PST)
Message-ID: <639c11f1.050a0220.b057c.2189@mx.google.com>
Date:   Thu, 15 Dec 2022 22:36:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3452260760966823897=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <20221216060058.746276-1-neeraj.sanjaykale@nxp.com>
References: <20221216060058.746276-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3452260760966823897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705009

---Test result---

Test Summary:
CheckPatch                    PASS      3.04 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      37.38 seconds
CheckAllWarning               PASS      40.53 seconds
CheckSparse                   PASS      45.53 seconds
BuildKernel32                 PASS      36.03 seconds
TestRunnerSetup               PASS      512.22 seconds
TestRunner_l2cap-tester       PASS      18.33 seconds
TestRunner_iso-tester         PASS      19.39 seconds
TestRunner_bnep-tester        PASS      6.57 seconds
TestRunner_mgmt-tester        PASS      115.01 seconds
TestRunner_rfcomm-tester      PASS      10.03 seconds
TestRunner_sco-tester         PASS      9.48 seconds
TestRunner_ioctl-tester       PASS      10.91 seconds
TestRunner_mesh-tester        PASS      8.00 seconds
TestRunner_smp-tester         PASS      9.34 seconds
TestRunner_userchan-tester    PASS      6.96 seconds
IncrementalBuild              PASS      33.86 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
43: B1 Line exceeds max length (94>80): "v2: Changed the subject/summary lines and added more details in the description. (Paul Menzel)"
44: B1 Line exceeds max length (88>80): "v3: Made internal functions static, optimized the code, added few comments. (Sherry Sun)"
45: B1 Line exceeds max length (114>80): "v4: Reworked entire code to send vendor commands cmd23 and cmd53 by using __hci_cmd_sync. (Luiz Augusto von Dentz)"
46: B1 Line exceeds max length (92>80): "v5: Used hci_command_hdr and combined OGF+OCF into a single opcode. (Luiz Augusto von Dentz)"


---
Regards,
Linux Bluetooth


--===============3452260760966823897==--
