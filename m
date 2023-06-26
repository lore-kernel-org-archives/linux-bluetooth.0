Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750ACEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 22:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFZWDm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFZWD2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 18:03:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF084C37
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 14:59:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262c6718d14so852479a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687816696; x=1690408696;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oRKg5gjen0s+toy29+6gB+mzKK1Ekt0PV+Lw36GddNc=;
        b=KTH68br1tv82j1UZLXrcphtYusjOSoADD3hBE/P8t32Jv8wiKMagd7xuOwdMFhA0Nc
         5wM7PhmYM0IYwwMTS5nex46SFHL5RRg0c7oBcbI5hP+cQCjBQrJqBpMgRPicYZ+rEwU6
         jNA0ruUxaM9Ru5bXLDX6uak9cvci8l7M9NmsUywghzUXTVzypmvuWaNsntrjIXDuXe77
         KzVZaLRbt4DZycwIJyzXtQaPyFx3oHbS2plEiaCWDMxrmUE+nrV1VTKOEROMn3MgrD3S
         K9DQa43D21Sf4xsCgJ4b0/wixrUxz/h/jL8kq5eh9QvYYSXBCyQlVCawG7oLJBDff/x6
         SD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816696; x=1690408696;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRKg5gjen0s+toy29+6gB+mzKK1Ekt0PV+Lw36GddNc=;
        b=lVWEyVWIkjFjENT+eVpMBAjrC+3vgKRZtUN3pQlT0DtVjBS3LNU4cHYiKbnL6iDwZz
         1NR8UrlmcJlxltLUs0w+EYAPI+e8NTqcYJYvm++d8rW6BNSCGEgoX5fiAUhn6wBvOGXx
         obmzcf43XTMF+dhGSk6IGQz1hCpy7/Tu5+QiuxcuwJjVRHHjc0/lhFbb17sOuJXc/fNi
         X7gXfRNxbxgnjjRMwCGepmEFTT6hcIb2+MX2Wcx7w4RXFfFPFZu7WhHEXOA0UV5Y2ZhD
         n5BA70KQAITUhYNKVR1pNDI6QKpEtDGDD6tra7tBlcqW7bjMj6mWNsx791bev40HEOyZ
         oEzw==
X-Gm-Message-State: AC+VfDxyjWdaP9i5U1VVvt+5XGNNg28APH+4jGonGAZkOMAQT0WuOEFi
        fx//u06LBgAcDSPJLkiKLyu5hsIa0SIl/A==
X-Google-Smtp-Source: ACHHUZ6RTRqBZn81ZygTyQQltji8AeJl6PbkdSbLQKYanSa72EoS770U5dL8haMGvtyqrZ5gTX+XpA==
X-Received: by 2002:a17:90b:1643:b0:256:5174:f58b with SMTP id il3-20020a17090b164300b002565174f58bmr19085191pjb.46.1687816695933;
        Mon, 26 Jun 2023 14:58:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.135.55])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090abd1100b0026309d57724sm720100pjr.39.2023.06.26.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:58:15 -0700 (PDT)
Message-ID: <649a09f7.170a0220.a7b16.2239@mx.google.com>
Date:   Mon, 26 Jun 2023 14:58:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8723001370892688664=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v7,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
In-Reply-To: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
References: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8723001370892688664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760403

---Test result---

Test Summary:
CheckPatch                    PASS      2.54 seconds
GitLint                       FAIL      1.07 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      32.25 seconds
CheckAllWarning               PASS      35.44 seconds
CheckSparse                   PASS      40.36 seconds
CheckSmatch                   PASS      111.91 seconds
BuildKernel32                 PASS      30.99 seconds
TestRunnerSetup               PASS      444.24 seconds
TestRunner_l2cap-tester       PASS      16.60 seconds
TestRunner_iso-tester         PASS      22.56 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      128.29 seconds
TestRunner_rfcomm-tester      PASS      8.51 seconds
TestRunner_sco-tester         PASS      7.84 seconds
TestRunner_ioctl-tester       PASS      9.07 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.87 seconds
TestRunner_userchan-tester    PASS      5.51 seconds
IncrementalBuild              PASS      41.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v7,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding"


---
Regards,
Linux Bluetooth


--===============8723001370892688664==--
