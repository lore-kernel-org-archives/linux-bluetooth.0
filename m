Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF17DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 06:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFGhX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFGhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 01:37:22 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7148E1
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 22:37:19 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so2631590a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Nov 2023 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699252639; x=1699857439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sF2ELdfdj0OCKP/iP0y5jTJKh8oE4tsHiS/L+sGesOU=;
        b=iMhRkHnxrHswyGPIXmCUQDN2Kt3XLa7CLwwwa/9FYiap1c9YSjYyU5z0q5+1R/lkym
         wWl2U9FNXuB04tfWdb7ghMjRuCif+rcxghl63YFOu1sOwekVl1yEQw5UecmIUJwJUCn1
         buG9PDJU8vKzKrGQnczi7eG2q/1LxsoTm0gHfD5qBo6hFpR7DrSHilHLUlO88FM8LEkg
         Gwa5FoXKFwlJ46kL4tCwdr2zV7kVdlIa4hSI8dCeYsDweVFe/t0ULJTAz8ou7OZ/+fj/
         bdQfw2srSyySHOQ3qhzPwNylXnfOo57a8qdxKvCAwWkcI7FoftnYuOUdp5IELsPVg+N3
         Ba1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699252639; x=1699857439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sF2ELdfdj0OCKP/iP0y5jTJKh8oE4tsHiS/L+sGesOU=;
        b=UlZsJ9V5dTl3LgBrTptaDwUwoDoIuLfsgSK99jXDs6Dj09ui/7I/Xqp9/5F5aJ4fgK
         Nycd9Y7Ay1+G1M6WnFeL/0KHNZlOiKSwyaWM3dLNXYCD8oc2gPS6n7Ru+vm5jk/PHgDs
         KXMkXLkhEXcjDFmVnA+6GPPKcn1vv5oqnTd6ELDv4aXIquxI7zi9KFTmzz99PL/j2g3k
         q7hsREhCPwzdziGcfHXgderYeBJrkXs1YxVm2phGVbmb+1IZsL6TJ1Aiuh3DxTE/mS0D
         4sT9yehqHtL38u1t1qp65JE/g1V6iyQDjgz/3ZHTqxw1C2f/gIgOtVwcxV5UAOwIxPHu
         hbrw==
X-Gm-Message-State: AOJu0Yyqa3lY1AbNEZvEmBM+qLxbx6ErDPHjHRrKOjLTE0acJHogDPcW
        caFNQxRHJaPjYlK7UqxjmEkIkZni/RCZ9A==
X-Google-Smtp-Source: AGHT+IFsKBIUaShPSaqk+SFGzD3VPIpVEbAmUrzOtzK9itPG1189HWMvq58zBF0KsfBmjJbSw6qM6Q==
X-Received: by 2002:a05:6a21:a103:b0:180:2827:1e7b with SMTP id aq3-20020a056a21a10300b0018028271e7bmr19176328pzc.58.1699252638651;
        Sun, 05 Nov 2023 22:37:18 -0800 (PST)
Received: from [172.17.0.2] ([52.157.1.129])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d51100b001b53953f306sm5105233plg.178.2023.11.05.22.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:37:18 -0800 (PST)
Message-ID: <6548899e.170a0220.b666d.b18c@mx.google.com>
Date:   Sun, 05 Nov 2023 22:37:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2212697364490623706=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
In-Reply-To: <1699250566-17101-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699250566-17101-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2212697364490623706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798977

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.70 seconds
CheckAllWarning               PASS      30.26 seconds
CheckSparse                   PASS      35.53 seconds
CheckSmatch                   PASS      99.02 seconds
BuildKernel32                 PASS      27.56 seconds
TestRunnerSetup               PASS      422.34 seconds
TestRunner_l2cap-tester       PASS      23.17 seconds
TestRunner_iso-tester         PASS      38.96 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        PASS      166.49 seconds
TestRunner_rfcomm-tester      PASS      11.01 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.22 seconds
TestRunner_mesh-tester        FAIL      9.27 seconds
TestRunner_smp-tester         PASS      9.74 seconds
TestRunner_userchan-tester    PASS      7.90 seconds
IncrementalBuild              PASS      26.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066"
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.197 seconds


---
Regards,
Linux Bluetooth


--===============2212697364490623706==--
