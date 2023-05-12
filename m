Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67866C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 21:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbjELV5A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjELV47 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 17:56:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C77AA3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 14:56:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-74e4f839ae4so531465185a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683928617; x=1686520617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hOh+TJ5veqS+L5Vc61N34ZTgrtUqBzQpF/r8C1vqims=;
        b=JApWS1iIx8NPZ/sPFSaG+JmiGs98CMFQYufrdGkfGjdqgchGLaWH82U6Z/Lrhzm0yS
         ibdsa7bm2W9DlO8D/dIfP585hhkYTzlCQvaL1wQ6BLwL5FBuD2eqwWNhYEdcVpRrnKFx
         Hw+bl+ZTA8HubDDJaG4ETMYF4v1bAMDYd9MwWdvRtMJE7Pun1zD5SDNcLNL5gc+Grlva
         yTU2WUz2gQPgCHdEwHX2fbP7aUwDDtrVqMhnAkuuRJCfHOgul4PLsmh741qqZ5Sif1Jq
         6vzNJtzqiIm74Uu1gQRcRjYQzCwTgHcciaRZ3PZjEWgtSOxGxBTx+h6WRCWB8fAI6dCk
         1YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928617; x=1686520617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOh+TJ5veqS+L5Vc61N34ZTgrtUqBzQpF/r8C1vqims=;
        b=Jq/bflzEHoQSkZybjj09nwmAVfZZyVWnVLV00saShMyDRK2P9p/e0uXNU6MLT/RxGO
         RFUiWnD3WBRWddSBh1IMUL9ERgzj3buaXngSUgDrtpB8adF2OP1BHTu2Eu8m6f9wMvko
         CN3r5R/tIMJh+9fM1nQ8hQPUwNcsMQM7+ejK17m6zdtA7q2IsQVN7hcBSHJAIZO5ITcx
         uGKpDBLpNIlE0xOBB5YvgIz3uvWdx4wIDfF3YyAsQ/yafmuXiByHZddIKOQWlYbCJX+0
         Q1B+hxkChFEJXRO6KmVKgHHcqTZx4/M6/pbDVFPnmmEOb1bi0cX9WgnY3+68G7zL8ybP
         Ks8g==
X-Gm-Message-State: AC+VfDxdNG16PJIBo9+pbqAIWYWS+hQAJPcOgtK2+eea8Ylned7NEIF9
        SergyXTMReHJiKY6zs5CX83DxQyjxzo=
X-Google-Smtp-Source: ACHHUZ7QjaZSl2fiVr3ijTZVfucyGQKTw17CFHAIzF5QqzMtriOgrwJHpea+P1mfqGKW/Znfn/F11Q==
X-Received: by 2002:a05:6214:4108:b0:621:1695:dfec with SMTP id kc8-20020a056214410800b006211695dfecmr28079439qvb.51.1683928616775;
        Fri, 12 May 2023 14:56:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.36.114])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85312000000b003b9b8ec742csm3366775qtn.14.2023.05.12.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:56:56 -0700 (PDT)
Message-ID: <645eb628.c80a0220.90d0c.3017@mx.google.com>
Date:   Fri, 12 May 2023 14:56:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2796187180924562517=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v6,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
In-Reply-To: <cc4ae6f7545cdf0615279890521b11774f062add.1683925801.git.objelf@gmail.com>
References: <cc4ae6f7545cdf0615279890521b11774f062add.1683925801.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2796187180924562517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747196

---Test result---

Test Summary:
CheckPatch                    PASS      2.88 seconds
GitLint                       FAIL      1.28 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      31.29 seconds
CheckAllWarning               PASS      34.79 seconds
CheckSparse                   PASS      39.03 seconds
CheckSmatch                   PASS      109.66 seconds
BuildKernel32                 PASS      30.30 seconds
TestRunnerSetup               PASS      435.28 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      20.11 seconds
TestRunner_bnep-tester        PASS      5.27 seconds
TestRunner_mgmt-tester        PASS      111.35 seconds
TestRunner_rfcomm-tester      PASS      8.45 seconds
TestRunner_sco-tester         PASS      7.84 seconds
TestRunner_ioctl-tester       PASS      9.04 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      7.75 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      40.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v6,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding"


---
Regards,
Linux Bluetooth


--===============2796187180924562517==--
