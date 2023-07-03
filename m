Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62944C001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 14:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGCO7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCO7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 10:59:33 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A7E41
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 07:59:32 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b09276ed49so4280632fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396372; x=1690988372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3hRhFLaTv5FpZIHsHPtx3B1/obZXb2HHt8RBI/Cyc1k=;
        b=MGQ03quv04W1CNlksZwNTkgJ0iAdJVjvCzCXppspxnrAsUlQcg2vWM6vpSmPmH9jbJ
         eDGKvfsOSD+Yw3KLKCVECTsLUVCMUIO8H3WTM/lUFBPIg4lyhRVeHr23pCT8+aFf+EKd
         FAaYsUawenSp9EiKg0vN9qNQOwBz2blM4a7+6C9ynHjlD65oSAzmEw5k09TnaCn4S9+8
         gxD4bh7MNEhk/3MdcXKwgHrn/Oj5mII+gwiNj1QIlwFBaUA3ohwCjjrRxAO+i1b7i7Lt
         ggsMpzNysztHhhWGrLNzLE+1iu5veaQORwTxVEqi56BwMcH/cjEjmb2ZyScm/u8kZJFD
         cHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396372; x=1690988372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hRhFLaTv5FpZIHsHPtx3B1/obZXb2HHt8RBI/Cyc1k=;
        b=Tx5JSLEbMyt8zej/XooE/7qz2aXGphohU+xLL4d6oFtMuR4oVPWNwPBze8Wg4Gu1AM
         RbusMP/oUkg4k/Oeqzki7M0mmMrh9MK8+Vh6k8tNbvVXITQ/0s9IkQreem783Zn8lsQ6
         xubyGCEaMvMWl62UD3/W3aZ9YTJSJh4PzBofuSa8wEAGd58M55Ix94pQzWrTOlo98+tM
         MWEaNR6+avZfi9A9S7FmhaOp1JEouECwwfJTaP8WwpPXyjJO81krSbirxsA09tvps9NO
         lLC+55reGZ5kwwFxfV49CtNRBdIpjOYEcDRIb+GhvWaHS6mZNg3UyyTOgjhkU2rMNh5P
         RvvQ==
X-Gm-Message-State: AC+VfDxvXfWEWU2AaiE3p+/vyi9t3sWxo80mG6EiQw/RqNz75IP+Syjs
        TyQXg6/sc5mhi9Hj2qKEe0K+fNk/OSY=
X-Google-Smtp-Source: APBJJlEttBKhqbaErfQ6Tj6NSKnLJH/4NCJ0I5f0dhdYzcWjqJfEuQpM4MXysBOJYC4uO5gDVuPYzg==
X-Received: by 2002:a05:6870:e8c5:b0:17a:c7ff:ccf5 with SMTP id r5-20020a056870e8c500b0017ac7ffccf5mr11482465oan.32.1688396371965;
        Mon, 03 Jul 2023 07:59:31 -0700 (PDT)
Received: from [172.17.0.2] ([104.44.128.254])
        by smtp.gmail.com with ESMTPSA id w2-20020a9d77c2000000b006b1570a7674sm2035775otl.29.2023.07.03.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:59:31 -0700 (PDT)
Message-ID: <64a2e253.9d0a0220.ac647.88f4@mx.google.com>
Date:   Mon, 03 Jul 2023 07:59:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8676070792700198492=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: msft: Fix error code in msft_cancel_address_filter_sync()
In-Reply-To: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
References: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8676070792700198492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762052

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.51 seconds
CheckAllWarning               PASS      36.46 seconds
CheckSparse                   PASS      41.12 seconds
CheckSmatch                   PASS      115.33 seconds
BuildKernel32                 PASS      32.10 seconds
TestRunnerSetup               PASS      460.82 seconds
TestRunner_l2cap-tester       PASS      13.21 seconds
TestRunner_iso-tester         PASS      23.96 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      132.90 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      10.54 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.20 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      5.91 seconds
IncrementalBuild              PASS      30.54 seconds



---
Regards,
Linux Bluetooth


--===============8676070792700198492==--
