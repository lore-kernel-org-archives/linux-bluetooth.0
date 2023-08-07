Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D7BC001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 12:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjHGMDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjHGMDa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 08:03:30 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393310FC
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 05:02:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a43cbb432aso3283828b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409770; x=1692014570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5cY9Fb0k6VIUXEaGavLLKCGA6XLq/6pDECJqmzlZsa8=;
        b=anmwiBISKIGVvQjH/ZVzKNDDDkpOCjLdKJMdwmLSV64HPOzFSFL0jsIs+X1R7kwJTD
         yo8ICIT36QrChsyQHa1axq/JLDszXqj04+NjkNpC50ehzllAWQuu138Ur2R0+E/4Lu2u
         o3DIFmGinCR7ktPrhjeDuV3BAyWVYyF3iXsNdAeEbY3nmV5WeCJvtN7LDMALJE/ZcKCr
         xMP01tZXCoRhFmrVZlNRFNSJn3KMwxNAQjpvzhbHX4rS7rPb1Bo5IeVzlLjD8yUUzCGq
         xu49UflY5F4OBHEavR9/zz0SLCydHov/XJOrynJjHFxuKNrmW1yHZMQSrPUDq+2A9Frj
         jpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409770; x=1692014570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cY9Fb0k6VIUXEaGavLLKCGA6XLq/6pDECJqmzlZsa8=;
        b=GIoDEW0JQwSffO45aOZU70N9gno/Li9lLaElB2buZk72ajbUZzdqGCc+v8gszw/HoE
         2/AmZqRg8WOkqS5j+/LcPNIW7PN7X/ImXejvOBmJLVwEZb+wX3vJ4HUrsc2I9KWIhorF
         U6BdOragUE7MvIsTa/UWT4PTWVaBsoh1wJFYVqNquMBT9zyWPFiNk1D3gTwCFEeWVfRB
         KV7AVeow2oG84x1s+jkEWVngXxSFoHuAH3FXgNajLTUXKGAbohFPty/ERAOmpkDAwDkH
         FtcOThDJJgQT0JGbAKSNR3hdtnzgkclf7G8sL6I8NWe3AqbIz9olhG3g20JxzwMHWCB5
         hn9A==
X-Gm-Message-State: AOJu0YyDby8/CZjq/poOiL3incJxpHFYGhDr3vJoKSy0WMgq0E88lh0J
        Cg5q/IMNRkOfTVbY41zeTAa6oUH1hFc=
X-Google-Smtp-Source: AGHT+IEd8EuX3YuuHQCTKWMVUJm0ZzWpuRJ52fgUVKjF1hRdCtUVCAcxoYo7zF3c0qGHhcN2/pTEXg==
X-Received: by 2002:a05:6808:23d2:b0:3a3:f7b8:576f with SMTP id bq18-20020a05680823d200b003a3f7b8576fmr11648210oib.19.1691409769754;
        Mon, 07 Aug 2023 05:02:49 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.72.41])
        by smtp.gmail.com with ESMTPSA id bl41-20020a05680830a900b003a761fc74fbsm4592504oib.11.2023.08.07.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:02:49 -0700 (PDT)
Message-ID: <64d0dd69.050a0220.4eb15.289e@mx.google.com>
Date:   Mon, 07 Aug 2023 05:02:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0957415743519710318=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lm0963hack@gmail.com
Subject: RE: Bluetooth: Fix potential use-after-free when clear keys
In-Reply-To: <20230807110741.85859-1-lm0963hack@gmail.com>
References: <20230807110741.85859-1-lm0963hack@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0957415743519710318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773609

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.64 seconds
CheckAllWarning               PASS      38.75 seconds
CheckSparse                   PASS      45.45 seconds
CheckSmatch                   PASS      125.79 seconds
BuildKernel32                 PASS      37.24 seconds
TestRunnerSetup               PASS      545.64 seconds
TestRunner_l2cap-tester       PASS      25.96 seconds
TestRunner_iso-tester         PASS      50.74 seconds
TestRunner_bnep-tester        PASS      11.92 seconds
TestRunner_mgmt-tester        PASS      228.35 seconds
TestRunner_rfcomm-tester      PASS      17.79 seconds
TestRunner_sco-tester         PASS      20.39 seconds
TestRunner_ioctl-tester       PASS      19.50 seconds
TestRunner_mesh-tester        PASS      15.40 seconds
TestRunner_smp-tester         PASS      16.13 seconds
TestRunner_userchan-tester    PASS      12.86 seconds
IncrementalBuild              PASS      35.33 seconds



---
Regards,
Linux Bluetooth


--===============0957415743519710318==--
