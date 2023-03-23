Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3EC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCWSf1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCWSf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 14:35:26 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4310AA5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 11:35:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l7so4071277qvh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679596524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yGseDo3IOAjui1zUgmIIT1WFf1+AgUlZQCTa9wSNiKI=;
        b=EAL1augp/BlFnXVDuY+s9GpdP4siUVujm5h8CMBwnAl0BFeW6eMde6VzVUKFzcQovh
         MFVkZ8k4Q5UiAajWTeJVj3SION8XCG6Zlbv05AM5hx/XSvHWeXaMvQ7N603FhXJHaxPs
         pCm0o9skTlLjzqWKWM8jaaVHqhXoHz4IFLcUy1V946CeUY1NFZ8t4oW4gPGrgUigIS4o
         xg9onIVYlwRK9q/Xw/cK/PH3iURF7Z3bEVrZ+NWsPHZ3mfOm3X/sjJd7wWqE/KjzqMiX
         Xh+prIjz2unRyKahXWuxEJqycRT6zyZgWZfLtjs53mTocJNPhU3IytU+RhOFMNQ3gdZn
         RX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679596524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGseDo3IOAjui1zUgmIIT1WFf1+AgUlZQCTa9wSNiKI=;
        b=396x8jxANqVAFsCKk5oiQEAcboyOowZ19GiyYsRlNLWdnVKcT8IUY6X6tJV1KNyXop
         +nDMwXeuxgfzY+AH1rijm5gMiolRHOIJds+tj2j8yNuf+jhzSE9SL2c5fajiFIgSFsFj
         RNRpTbClzmQW13MPx7HtYNfBo6IBcBoh1wWHlhONZy1A019wWlLskWIZzOoNjN1iOMI+
         KLyXr4vFABq5lN32LTZvY3CyMgFio04zzGlF1MeUz+Wfk3KaAOlBxVyjNVfg/VavXVfB
         P90E3c8JjM/OF23DKvKZYWfUiGgOiNtziVEy5Ibzd8TkU4jm1pHg5J6q0ayMyRQiaxyY
         dKSg==
X-Gm-Message-State: AO0yUKUFC6N8bR4kz/rcK85Gy25JgKxnn7uPKTTZIhZEopHUcOOEins+
        TvishZZWDD3m3y9DsyPVpY3Pdwnga4A=
X-Google-Smtp-Source: AK7set+52vqi7nxuchumDTYgskD1fTgr176sA4pk9j86JvWcjG3XbbjF2+uoaH6n/wEUGGAj5AOa/g==
X-Received: by 2002:a05:6214:acd:b0:5cb:e2fb:dd4d with SMTP id g13-20020a0562140acd00b005cbe2fbdd4dmr13551895qvi.32.1679596524258;
        Thu, 23 Mar 2023 11:35:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.99])
        by smtp.gmail.com with ESMTPSA id 143-20020a370695000000b00746ae7f7055sm3401948qkg.83.2023.03.23.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:35:24 -0700 (PDT)
Message-ID: <641c9bec.370a0220.3b5c0.0494@mx.google.com>
Date:   Thu, 23 Mar 2023 11:35:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0436299316048904260=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: [v2,1/2] Bluetooth: Add device 0bda:887b to device tables
In-Reply-To: <20230323174604.30088-1-Larry.Finger@lwfinger.net>
References: <20230323174604.30088-1-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0436299316048904260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733271

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.05 seconds
CheckAllWarning               PASS      33.89 seconds
CheckSparse                   PASS      39.06 seconds
CheckSmatch                   PASS      107.90 seconds
BuildKernel32                 PASS      30.11 seconds
TestRunnerSetup               PASS      433.85 seconds
TestRunner_l2cap-tester       PASS      15.89 seconds
TestRunner_iso-tester         PASS      15.60 seconds
TestRunner_bnep-tester        PASS      5.15 seconds
TestRunner_mgmt-tester        PASS      102.76 seconds
TestRunner_rfcomm-tester      PASS      8.21 seconds
TestRunner_sco-tester         PASS      7.59 seconds
TestRunner_ioctl-tester       PASS      8.68 seconds
TestRunner_mesh-tester        PASS      6.49 seconds
TestRunner_smp-tester         PASS      7.46 seconds
TestRunner_userchan-tester    PASS      5.39 seconds
IncrementalBuild              PASS      28.31 seconds



---
Regards,
Linux Bluetooth


--===============0436299316048904260==--
