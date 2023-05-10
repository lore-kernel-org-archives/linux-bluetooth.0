Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1939C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjEJOnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEJOnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 10:43:03 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE292E51
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 07:43:02 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-54fa79be6e8so1008688eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729782; x=1686321782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BIFTs4cNNouBTKgVL15MyLtU9z+8PRIOiFER6eOSJ3I=;
        b=XL3EnzeDwoFN0qTJ7uYx+w6gPq4adjffwaCq4x4MXIBImhHPykkhf5UIqLOeq0dmtY
         VtuWm7mEh+yCFk0eymDFas/N65hnAPdM2L83kRJcEie8fAhmxhzE5+klytOP4h2V2QM8
         ygPyegmz5ByYK6Dl+/U+abFykXYzgb/eeO6Fjk0iflLUUAqaI5X732gomGHKhIm58w22
         vFYvqEQQHIfgCw2AOsgAgezexEzv+wy9ez4EQzXtvXZR8+wOJYLqhWlt2+U8cIPoM9VQ
         sU2o6sGsGFMpZZoXsoeCCiP1lauhy64T+ou95I6ed/WvzHEiejZPBxTZHlC3AX8COAsa
         GbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729782; x=1686321782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIFTs4cNNouBTKgVL15MyLtU9z+8PRIOiFER6eOSJ3I=;
        b=bqH0LRPTLPSwNMH+ME9XSmymckCT1yRa5gxcCfshqe+XGvv/aiRBbjaaLxyGVj40D8
         8eWzL3By6/vQSFGxaP4dE+9R/iez4uxIlvFH8SrGIRxBL7T04PIH2paA8BDV4z8gM+Lh
         igX2wNUlTqnn2uHhdasbMYTdGOJ4EcX+sR2F8nudL1aguJGfsdfxtpnqmBsJGUjCSGHk
         ATJIIG7VCCyuLam/p4HMLid4FGly+wbIBCoCJntGiJHRiThrbdBc56YCxITd7gxMecB4
         R7+RGOyAXCiNjMPGNkbZdZGAaf89G+NgoO7jBRJN+LHsPUNZIDzkJNU/Bd1NDRrkrO11
         iK1w==
X-Gm-Message-State: AC+VfDx+SEG4KlQE2RwFB1Z6UP12BpAucreg07PY54h/+Eql4LLa8fyp
        pgLJ70tGYWo4uetAvkCofzdAZ+eo3X78hQ==
X-Google-Smtp-Source: ACHHUZ62BI9wIP6ZaIksLtUH1EQn2/30GQi8UHX6oaP7X9qFI9zqW0BawU8JQCdFc+Qjy0ldiCzaSQ==
X-Received: by 2002:aca:1a02:0:b0:394:2792:fa74 with SMTP id a2-20020aca1a02000000b003942792fa74mr1455246oia.29.1683729781920;
        Wed, 10 May 2023 07:43:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.134])
        by smtp.gmail.com with ESMTPSA id i3-20020a9d6503000000b006a44a70beafsm6363476otl.25.2023.05.10.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:43:00 -0700 (PDT)
Message-ID: <645bad74.9d0a0220.9b268.f320@mx.google.com>
Date:   Wed, 10 May 2023 07:43:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4617768334761371422=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: Check for ISO support in controller
In-Reply-To: <20230510134557.11486-2-claudia.rosu@nxp.com>
References: <20230510134557.11486-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4617768334761371422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746439

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      40.69 seconds
CheckAllWarning               PASS      43.72 seconds
CheckSparse                   PASS      48.83 seconds
CheckSmatch                   PASS      134.15 seconds
BuildKernel32                 PASS      39.52 seconds
TestRunnerSetup               PASS      558.98 seconds
TestRunner_l2cap-tester       PASS      20.03 seconds
TestRunner_iso-tester         PASS      26.12 seconds
TestRunner_bnep-tester        PASS      6.72 seconds
TestRunner_mgmt-tester        PASS      137.39 seconds
TestRunner_rfcomm-tester      PASS      10.83 seconds
TestRunner_sco-tester         PASS      9.68 seconds
TestRunner_ioctl-tester       PASS      11.62 seconds
TestRunner_mesh-tester        PASS      8.66 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.50 seconds
IncrementalBuild              PASS      37.18 seconds



---
Regards,
Linux Bluetooth


--===============4617768334761371422==--
