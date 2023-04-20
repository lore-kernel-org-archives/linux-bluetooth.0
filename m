Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDAC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 13:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjDTNN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDTNNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 09:13:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A5187
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 06:13:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef49c15454so2654151cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681996404; x=1684588404;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh3zdl/hbEpwNTZVzWE96rIAylYZh7Ut0QSG/0aLLUo=;
        b=B2F9BXsVXbTvyOGK//VMy3USAVQimRir5KVJxcROUnDdHPQ0tYORwYr1/3Vk4+Lra4
         pBiSEFCAokOj5WZqEJp6c1ldhfUR3IquSirDN28ejiGo/Dr099GYrdGW3ssto+1JPs0Z
         6lNueW2hp+w4BVRCIpwwVL294aSBfzJjJggcrSWS3/7UZAxwD/qTzWra7Edt/XhR9kR4
         TM9ByQlLfakHxyLmQJCUhLqWFtn1sdzREiZRtK1tF2o9xX8RsPv1zq6wSAtU8hJ16V8V
         E/nzy/LyI4y20JYNnMK3nOujENAYz270Wc0FiabjuiafTHzybAsIvUe+OCPcypVeWKpv
         sGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996404; x=1684588404;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh3zdl/hbEpwNTZVzWE96rIAylYZh7Ut0QSG/0aLLUo=;
        b=Y0TfOm85l1I1aJvFTisYuk4GA74ogi0cd62WE1pUEjvp83+x1AbXEkba+P6ixGJOdB
         gvyngVWU/njVX4kVvu+it/dqBe1B7p2v/HzT75RiQqurJhiTdbknlGMm9im+0JuBTrsy
         ikK2gBKYseAjqr5euK4rZmNz6+U6QfgypDjETbZSmimjZ/k+gk0DW6PB6gzaT0tuaFBG
         Zy/G4fGCuRpmljcAboB3YfV16yLpG/6Dey9vsHa/5rxj0mnH1Bcte2edDYb0dSr+mX1a
         OirFdgKawBNuLTAC/fnbtHz08jOyfLNLPgFJjDQ868O7ZXfvkO9Qt/RMWCzQW1ZavGfg
         wZ5w==
X-Gm-Message-State: AAQBX9flt8YdUWdErwv6MNL5/hXVJxVPr0lMPRzrTwU9mjSeZ2D3FGAe
        cprOFehJCtvJ4HCr0YwVh4vbPciYza0=
X-Google-Smtp-Source: AKy350bSggvaVsX9YokdzD58TNjir+cYwGkyBwVibyps0LeSQQm9Im+KEfAFkUuZ/LGGwggWQE2BVg==
X-Received: by 2002:a05:622a:1041:b0:3ef:3ca6:c77d with SMTP id f1-20020a05622a104100b003ef3ca6c77dmr1571193qte.47.1681996403227;
        Thu, 20 Apr 2023 06:13:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.113.41])
        by smtp.gmail.com with ESMTPSA id z26-20020ac87cba000000b003eb136bec50sm467525qtv.66.2023.04.20.06.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:13:23 -0700 (PDT)
Message-ID: <64413a73.c80a0220.ddae.20fe@mx.google.com>
Date:   Thu, 20 Apr 2023 06:13:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1817797041463906126=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: Cancel sync command before suspend and power off
In-Reply-To: <20230420202312.1.I53bc906a716045c7474a77d3038bfcb6909094e2@changeid>
References: <20230420202312.1.I53bc906a716045c7474a77d3038bfcb6909094e2@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1817797041463906126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741724

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.60 seconds
CheckAllWarning               PASS      35.22 seconds
CheckSparse                   PASS      39.70 seconds
CheckSmatch                   PASS      108.30 seconds
BuildKernel32                 PASS      30.72 seconds
TestRunnerSetup               PASS      441.03 seconds
TestRunner_l2cap-tester       PASS      16.96 seconds
TestRunner_iso-tester         PASS      20.94 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      115.13 seconds
TestRunner_rfcomm-tester      PASS      8.92 seconds
TestRunner_sco-tester         PASS      8.20 seconds
TestRunner_ioctl-tester       PASS      9.50 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      8.13 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      29.22 seconds



---
Regards,
Linux Bluetooth


--===============1817797041463906126==--
