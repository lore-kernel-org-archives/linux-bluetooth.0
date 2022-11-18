Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiKRGeR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbiKRGeB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:34:01 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8281A387
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id c8so2764900qvn.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w83N6XJPeuwsiRTNSXT/ZqN2qx4FAzr/mfGIzktbzZo=;
        b=d3ELTFeharUjEdYPkop3s2hoJSLMHr78dnvQ0ISOtks4nbx/kjvmAdg14lb4Lj6AbF
         abyCm9Kjf1jb0yh2BcPZ9o3opMPk0YC0q2c0LMO+ORF0AID8izcbktlvU86ETbkUD3rP
         EVc/LIKAT3881cxkDBheZBez44iK7hSqB3/p855kW6Yv9SPOzjOyZa/EI2wcMMANBmjx
         9VL3tP5CmXot4aGQf4DGfgKZ0NvRkF6wPOQC6xwkPcQX1v8WscuT6LqjsJv3+86LfxFU
         1y6KDaqLkVOUBjRWCYDxRwVt8GA9kR7YTXjosrbrFpVBHQzJoUCOofUBRzWEcqDq6Iun
         nFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w83N6XJPeuwsiRTNSXT/ZqN2qx4FAzr/mfGIzktbzZo=;
        b=Kn2jO3PrpDgB9UjYOd0b/5Zsycouf6JXNVWM+M3PgCSdH/4C7IIMsEqYtz8kGPQx44
         sqoQbQqpaWc6T0PIc0gMa18YgHEnWTB3omDLBhpWaVsmctyYN0Pc5HbmNVh3RPLih21W
         tTxa7hExJC0f4ydqpEdyQ9wdtFznm+JgS3HGyl5DKDrFLoi7h+1slbyy3ACi96CFr7AP
         wkr4oCNlJAiMmfbK0k7x4A9BXpPBPrAk0uNhHsau0to+cirtSmca62x0+pEGK8gr7zXp
         2eMzQ3cdZgTeWyoWe2huny3hklmsgim4Rtb4H0GBEW6ofqKdXRYkfxGGYfHqXqNYrvZO
         +SIA==
X-Gm-Message-State: ANoB5plDcH60ZgprKTyBv+5JByCRoVg6n/calX13pxQuiPJe9e2FNuWP
        n7iVMfG9jQA+v0FLt+veBC/iqJ7DFcA8qQ==
X-Google-Smtp-Source: AA0mqf5lYUBshqvSJTBcIVxmF9cBsbsGU/EFJuUAIZboboQB6LG/fBotQH5uXuXeA3W66DHf8tMkKw==
X-Received: by 2002:a0c:eb05:0:b0:4ba:f163:ae2a with SMTP id j5-20020a0ceb05000000b004baf163ae2amr5585476qvp.105.1668753240168;
        Thu, 17 Nov 2022 22:34:00 -0800 (PST)
Received: from [172.17.0.2] ([172.176.208.189])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a284900b006f9ddaaf01esm1937562qkp.102.2022.11.17.22.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:33:59 -0800 (PST)
Message-ID: <63772757.050a0220.34ca.9c39@mx.google.com>
Date:   Thu, 17 Nov 2022 22:33:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2591025254434240789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2591025254434240789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.29 seconds
BuildKernel32                 PASS      30.36 seconds
TestRunnerSetup               PASS      420.04 seconds
TestRunner_l2cap-tester       PASS      15.69 seconds
TestRunner_iso-tester         PASS      15.03 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      103.66 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.64 seconds
TestRunner_ioctl-tester       PASS      9.88 seconds
TestRunner_mesh-tester        PASS      6.70 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.64 seconds
IncrementalBuild              PASS      31.45 seconds



---
Regards,
Linux Bluetooth


--===============2591025254434240789==--
