Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF8EEAA6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 19:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjINT5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbjINSqV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 14:46:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB67AB8
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 11:40:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-770819c1db6so85491185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694716819; x=1695321619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=49GAJ5WDJfgZ3wR3KUYJWmEAhFaW6vvj16rAdqHD/wk=;
        b=q3MOLznYu8cHAEvN9y8jNI7ZHjwHs2Ehx65588EkDByVL+jkjcgSc2TY8slEVy3yIa
         H7H39dO/gbpCpuHa/n2dwy6I9osH9oP/6nlkV+/fp3A9hrCg+iRISpXqx/aHwHJGzQhr
         6o23gwQdzzwaw5PTLaZZckbS/BOYy5HTHRl4leURKo09VdOEIV9+1qEJMsLdP2IaPi8D
         5OwyJPlYWey2t0pp+eu3LOaUqWDppqm3RRlUi4epaOn3K+hIK/+rkTt6jlyH6HCvhLfi
         7CHvTi7TWjLq2l1ESfwCBr/XLzeXOIZsfh2fRlOmQwJzApd7iknd21EOKwsM0wqy3NDY
         BNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716819; x=1695321619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49GAJ5WDJfgZ3wR3KUYJWmEAhFaW6vvj16rAdqHD/wk=;
        b=REf/5umz9+FhosBxXPARAva/sqLpadGmZHO49QD4VpIL7AVsdcPrbocuJz32WtPWlw
         qJOjgqS9s+wNN/shcPBNYtECDGu5gFrh2sPQ+Z0hW/CBmncOxLC3K38N7zU3+XEGj2Zr
         0KilqnmXLS8A7lJmD0/68Ujkp7C+10LC7yF5aSzVxVikrnagAP54VfbmgRApYtT1F2wa
         LOGmA0Y8PZjCDj9fs58ani2ZXI2I2KmPMZ6m1gGDONTaiLgLHKXnaX/5KfDIu1XdCuqF
         2ApD+n7tKpt7QhKnu0civI2q5tkUWsuMOsCy5tx5LN/IZ4nIsYk6Jrhl62LphRT/RdgL
         Llfw==
X-Gm-Message-State: AOJu0YzGkIsYvemCrSpujHPpyKNpeUEqTa7a1GGTYT8BV3F3yVl+7GKK
        /VKhEqGxFSHxbxzeXX71LQtv1u9aPi0=
X-Google-Smtp-Source: AGHT+IHNEAptSPtsO4ij1LEB7zC01YSw3eEWK9oKJSQ3DjnVDOJVc3nXCTtWfcbaUCo4PTaoqzxeEA==
X-Received: by 2002:a05:620a:3790:b0:773:a83f:4a66 with SMTP id pi16-20020a05620a379000b00773a83f4a66mr1280935qkn.36.1694716818931;
        Thu, 14 Sep 2023 11:40:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.60.97])
        by smtp.gmail.com with ESMTPSA id vq25-20020a05620a559900b007671cfe8a18sm659101qkn.13.2023.09.14.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 11:40:18 -0700 (PDT)
Message-ID: <65035392.050a0220.9c6d.3520@mx.google.com>
Date:   Thu, 14 Sep 2023 11:40:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2914474493939026862=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Remove le_restart_scan work
In-Reply-To: <20230914180553.3264477-1-luiz.dentz@gmail.com>
References: <20230914180553.3264477-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2914474493939026862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784276

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.26 seconds
CheckAllWarning               PASS      38.22 seconds
CheckSparse                   PASS      43.04 seconds
CheckSmatch                   PASS      115.84 seconds
BuildKernel32                 PASS      33.67 seconds
TestRunnerSetup               PASS      507.36 seconds
TestRunner_l2cap-tester       PASS      28.30 seconds
TestRunner_iso-tester         PASS      62.87 seconds
TestRunner_bnep-tester        PASS      10.74 seconds
TestRunner_mgmt-tester        PASS      221.75 seconds
TestRunner_rfcomm-tester      PASS      16.22 seconds
TestRunner_sco-tester         PASS      19.86 seconds
TestRunner_ioctl-tester       PASS      18.40 seconds
TestRunner_mesh-tester        PASS      13.79 seconds
TestRunner_smp-tester         PASS      14.86 seconds
TestRunner_userchan-tester    PASS      11.46 seconds
IncrementalBuild              PASS      32.34 seconds



---
Regards,
Linux Bluetooth


--===============2914474493939026862==--
