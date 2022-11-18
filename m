Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F47AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKRFIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFH4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:07:56 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22E88FA6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:07:55 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-12c8312131fso4766841fac.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8glLMClhMMmkKcrvSz7OaYODHU5tKnO7SBe02yrKSV0=;
        b=TpVvZYpGxD+uuqTRwAWGoYoDo9ZVTuGhk36pqTDiZVR8Qk2j28BmgcBFh5Fnt8ccL9
         u7i7E/qP8HtVc3+z3bwPSPboS5tClKcD/88LDjrbhRPzWc366w3Fa1GUWB3V28P34bAZ
         iTYyTA9PnQDmU+GWS259tVzoBmx+HLlinAyO63TCOb5RsQKOvkOpU5YVFwPt7Rr2/rQ/
         DAye6aunZ7OeMlRM20zfm33IT+4Irzns7mLR+j5EIfhkzTKTPMhM68Gj0mRKI1C1JoF4
         kpcxM0HL+eHj44MMUcgTcyER3GhkoLUXlFPhrYcR3OoFWV/87LwvBSevdgB7UIG41mP7
         nmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8glLMClhMMmkKcrvSz7OaYODHU5tKnO7SBe02yrKSV0=;
        b=tpSjEzw9Mlkg74l/FB8GUgHN894GdUA2bDvgOnGcWfbusH2gBUE7BCCFdZBPKzFPrh
         j4GOR7w7VigJv2xErlplpf8iUaqLNMaOMvXBRT6eEMuYVRvrWd9RYRLMUiXJ+eppmG5n
         gM23Whon34SjV+SRCmuMWng4cN6kxRIRiLZmwE3aOPwFddh+MrlqcIJfh2QXFGwfep+l
         7SFyXllXJiJxpxN2JwycZERwAULOWNl2KOBYv2GBcXpqDowAH0bkv4AJ/6kZQzE9fYnM
         zhRfMdVcIfrYuYhX5BUnU49K2PIWUsWls/1KTXWtWtbeab7K9X96OBDKqJyhZAA6jhau
         Yo4A==
X-Gm-Message-State: ANoB5pnU62qwAOh0HV2FKpuYRjxwQ83HMF/0jhMN+un0twEN8PB+/lFh
        ARS2jiHDVkfnBvS31ihi2dRdB/nejPE=
X-Google-Smtp-Source: AA0mqf6D+jqZU1HpN6rdveH/GBIiThDEdrpUPxuhtVwRju7Nejypf+TgXXqdZIg5H4RKMeSHBRJ5TA==
X-Received: by 2002:a05:6870:d252:b0:141:85b2:b3be with SMTP id h18-20020a056870d25200b0014185b2b3bemr6131948oac.58.1668748075061;
        Thu, 17 Nov 2022 21:07:55 -0800 (PST)
Received: from [172.17.0.2] ([13.65.83.91])
        by smtp.gmail.com with ESMTPSA id w11-20020a056870e2cb00b001428eb454e9sm192961oad.13.2022.11.17.21.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:07:54 -0800 (PST)
Message-ID: <6377132a.050a0220.a916d.07f6@mx.google.com>
Date:   Thu, 17 Nov 2022 21:07:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5076650937267510018=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221116062918.11879-1-kiran.k@intel.com>
References: <20221116062918.11879-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5076650937267510018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695805

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      44.23 seconds
BuildKernel32                 PASS      39.88 seconds
TestRunnerSetup               PASS      560.00 seconds
TestRunner_l2cap-tester       PASS      19.19 seconds
TestRunner_iso-tester         PASS      20.50 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      131.26 seconds
TestRunner_rfcomm-tester      PASS      11.69 seconds
TestRunner_sco-tester         PASS      10.87 seconds
TestRunner_ioctl-tester       PASS      12.91 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      10.43 seconds
TestRunner_userchan-tester    PASS      7.37 seconds
IncrementalBuild              PASS      49.28 seconds



---
Regards,
Linux Bluetooth


--===============5076650937267510018==--
