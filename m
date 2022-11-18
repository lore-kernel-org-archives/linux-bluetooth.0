Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2ABC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiKRDud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiKRDub (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:50:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C968F3FE
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:50:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z6so2453253qtv.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ai6/WL+5EGrdobIvN7zc+j1FQaW2Ve/hPUhJgT+2q5c=;
        b=IZ2xppSiXaqEbKigq7QPphBRAh9O7fn+eaO3ZOWwDqduN2fyMPGpzIUKZMEWwUGiWb
         9co0s0MsXBUO+ycrpBuLlCiHGYC5zd2GEwRBssWQVujKxF/cvFLUmldihr6uyaJRGVsi
         bpJnTXim4iaTouk8mpJfAj6YjQm0URJCPOXpO1PeCGxc9V/GocnuyJLUX2zT9kJX3MPN
         VqUDRsft6Wkq0Zyxo8B97d2Q90w1+1yLi6SfjXuUcO/D/JC5EmX8V0TA9ACcSGgP1oW3
         UBm1ZoF38T8WDo1xY7MakMK/92p2nSkPg10SZ62FebULxishzNDUZ3xBzV8LY7CdBCDT
         HohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai6/WL+5EGrdobIvN7zc+j1FQaW2Ve/hPUhJgT+2q5c=;
        b=Y5ggMDZrSgRA/VbZW/z6G2zWsppIh0hvjYZs8Jl5h7MQdL9slcJIf06iNrtJ+ow3ty
         1hnlCnWaDCJlrTMuuw5XffRd1gCNfwBFw19sjw0DTXLwRgEwe+Ha7AwetSWVvNQ4ZyR5
         SCQ0JTJGQQ5txhK2rXcyX5DdIOdqbj4M2O1x1sZ9t7Sdo85WBzFsaR0PG53gVQEdw7Hv
         Y9fELRyrHBKr6qFBCy+lzZWAkQUAj5F0BUdXDRsUi+KzHAP3OvGfHCWDekXxDkfxeiDu
         p0OHBbyQZ4iIgbe+VLvN0P4pW2IbdQEQiqh7cTBhb1Pm51AJfT7a2Mcph+ULIt/TJKvI
         KN1A==
X-Gm-Message-State: ANoB5pnsm85Q5RtUCwK3hwptp6dEJ6moIVIH03lPRVD8oHTrNh8VV7CR
        OA5sRerEOEn8k5l3IB4Ag48fkdtFqEb3pA==
X-Google-Smtp-Source: AA0mqf5ijUOa6dtmaR4lKPV3q8lv80R6dZqfBUj/vQcaWTHh94VOuWQOqjA3YHSXOJNwmHoNPTwkqg==
X-Received: by 2002:ac8:4d51:0:b0:3a5:1e6e:ad6a with SMTP id x17-20020ac84d51000000b003a51e6ead6amr5094234qtv.556.1668743429985;
        Thu, 17 Nov 2022 19:50:29 -0800 (PST)
Received: from [172.17.0.2] ([20.172.195.59])
        by smtp.gmail.com with ESMTPSA id ed13-20020a05620a490d00b006eeae49537bsm1614938qkb.98.2022.11.17.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:50:29 -0800 (PST)
Message-ID: <63770105.050a0220.1fc9d.9478@mx.google.com>
Date:   Thu, 17 Nov 2022 19:50:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1115493755164770674=="
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

--===============1115493755164770674==
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
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      41.72 seconds
BuildKernel32                 PASS      38.33 seconds
TestRunnerSetup               PASS      507.69 seconds
TestRunner_l2cap-tester       PASS      18.20 seconds
TestRunner_iso-tester         PASS      18.34 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        PASS      121.16 seconds
TestRunner_rfcomm-tester      PASS      10.91 seconds
TestRunner_sco-tester         PASS      10.17 seconds
TestRunner_ioctl-tester       PASS      11.67 seconds
TestRunner_mesh-tester        PASS      8.12 seconds
TestRunner_smp-tester         PASS      10.05 seconds
TestRunner_userchan-tester    PASS      6.88 seconds
IncrementalBuild              PASS      38.73 seconds



---
Regards,
Linux Bluetooth


--===============1115493755164770674==--
