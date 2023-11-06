Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76424C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjKFGlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjKFGk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 01:40:57 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D6B112
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 22:40:54 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-777754138bdso269525385a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Nov 2023 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699252853; x=1699857653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M52JhP1CRYuIE2emf1Q076siyYaFCvupXMjtLQ9i7A8=;
        b=XnturPphqLsfw0HkyNReYvVlTtYyoFoLPWvCo7kephyPYwty9DfKmRPGoIfz26lPSg
         DgJF4DS8Hvj61IoSHiGF4B+aBC44l+N68d+vJEIdcDBAY9ATzzaLjGkoN/sz6AZIeCbK
         LD3yzKZir6IjIEL8YpfzXz5DxOkBcOo0I7hB9+M0ylEsgyCpG+Ngguow1gnFOmhsTbNe
         jufxY2JiSbRPV9WwbvTkJi67pMO9hd9bdLILcxYqRQ8FJTV3/CXQVzs4D8cZc4A/tLey
         yXArpZKILgz2F/i1PpdODMyFAn5RYfRd1GkvR58z13qdarlUV+L4d9ytrpfIijEFtaVJ
         ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699252853; x=1699857653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M52JhP1CRYuIE2emf1Q076siyYaFCvupXMjtLQ9i7A8=;
        b=Nm4TYGvDfkfN8o7zUDWxcElTBPQ60XJ5zV94zt+gwTQqyDrrg/txrmgARgU+TisS6K
         Q8rIL/V8pwPOg/RO408CZEWeH4BlyceHYjOAt/GfCD2ZyHuRlvPxDzVeH9rybqfHVs/6
         CytgkzhcyNkQ/Yay36vVO6wGBh/klGMes+ktiewROWssIVqnJDPyNcgj2VzlkjBDHKtd
         Jo5E5IHit6RoUC6zVyAAJo2wwOmpzT5OlxZ+dh69/cFTnRFGXCO0gByZLyvXZJV3HbVU
         vwvUQNz4iv+Ab8ft3SnQZSbW6v+wl+zb3f2tryW57uwDTfKO/fLMDejKf7RznAQPS7VA
         QYfg==
X-Gm-Message-State: AOJu0YzXl5jJwNH+S3ycvHJTbVwP+j02IvGcBSg9ZeBTotwC4uqygt33
        TZq3TzDTjq8yEsRYrVSiNVYNeY84rAM=
X-Google-Smtp-Source: AGHT+IEFjCzonMJ5QjVHNw0srxqBhMGt5ucBWM9JD83c1ent1cZFxV6/UIHQ8zdZU0XkH5f5zg4Ckg==
X-Received: by 2002:a05:6214:21e3:b0:66d:2eb6:f3f6 with SMTP id p3-20020a05621421e300b0066d2eb6f3f6mr29370141qvj.32.1699252853460;
        Sun, 05 Nov 2023 22:40:53 -0800 (PST)
Received: from [172.17.0.2] ([20.57.43.221])
        by smtp.gmail.com with ESMTPSA id t18-20020a0cef52000000b0065b151d5d12sm3177424qvs.126.2023.11.05.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:40:53 -0800 (PST)
Message-ID: <65488a75.0c0a0220.bc9e5.b95a@mx.google.com>
Date:   Sun, 05 Nov 2023 22:40:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8317404874809690387=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,1/3] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
In-Reply-To: <1699249824-20358-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699249824-20358-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8317404874809690387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798975

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.91 seconds
CheckAllWarning               PASS      36.46 seconds
CheckSparse                   PASS      41.70 seconds
CheckSmatch                   PASS      116.06 seconds
BuildKernel32                 PASS      32.64 seconds
TestRunnerSetup               PASS      504.05 seconds
TestRunner_l2cap-tester       PASS      29.73 seconds
TestRunner_iso-tester         PASS      51.76 seconds
TestRunner_bnep-tester        PASS      9.69 seconds
TestRunner_mgmt-tester        PASS      211.31 seconds
TestRunner_rfcomm-tester      PASS      15.09 seconds
TestRunner_sco-tester         PASS      18.66 seconds
TestRunner_ioctl-tester       PASS      16.75 seconds
TestRunner_mesh-tester        PASS      12.60 seconds
TestRunner_smp-tester         PASS      13.30 seconds
TestRunner_userchan-tester    PASS      10.26 seconds
IncrementalBuild              PASS      31.17 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v1,1/3] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066"


---
Regards,
Linux Bluetooth


--===============8317404874809690387==--
