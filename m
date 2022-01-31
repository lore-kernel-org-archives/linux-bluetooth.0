Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jan 2022 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380941AbiAaRZN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380755AbiAaRZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jan 2022 12:25:08 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C57C061401
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 09:25:08 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id o9so13400496qvy.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=j5knhYAl2mdL5y+FftwlK2H3Ut6G9bD2VxP5WbgP5DU=;
        b=nE4eLFM0tuN1wO0sPy6YbonM6sGSMh4S2qVzG4yn1IwbzWTmUthelpl1pDNFifNbdM
         qocSokW46pD7J1Kt1cVNFBFT1CTEedHV+WMdlwCHzyvtyOATSxHBLKvNJHpPS9+l+2lb
         pgHLGnCfc6pp/KcGTka3XVKP7qHQORHQ9Khd3MQlCquKtyDcaoKgSaqLO9u5S4M1AWsW
         waQ5WLMJtO5WrbCBX67wR4/kdIKQPf6k7Xiy+34lk45vwOsDTlPO4xn74O4F+zO1KP0y
         sDPQZ7yFjqYzIBEy2+E5du4FcswhxSXIvb9Z8vRxekMThNbGlPpcRpBrOeaQfSl2arGw
         gkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=j5knhYAl2mdL5y+FftwlK2H3Ut6G9bD2VxP5WbgP5DU=;
        b=R5ru1csleM4iTisKzvyRgFYpYZdwF0rbRFlkgMUUg1IgmsabauMtalBCdwge2hK0rF
         Q6rt5O3dAwkJbIUzllpZfgrFalhDtwWWhguMtk37/jq4sjmQhjEqTWGSQSFggIwVDEKo
         SXRvNsouODj4DOK1KBqlpc1jCH3zgX2u23QgqmLIaUGLMQCrba9Rqa5yLDDnoT5/1hYz
         0IKfA8oMKKqEPtqIwn97q5bDvTDYiLJcyn+iOhMcqu+EwX8o1mSEOr4u/Q/yOZ5ULkMe
         c9GF0VQJQQMTyymIW9C0c/lyplxZA+Rssrao/8ZHAm15nVg0NN+mBDWKhir5v0qn6GXC
         0myg==
X-Gm-Message-State: AOAM530UDUmZUOq/+FRiFqE0mACG+ClhheWFYffMnahd4/vZFA47xtp2
        beqWVyff0Ht2+gOSovTUH7isb3ccdN4skA==
X-Google-Smtp-Source: ABdhPJwKy5k7PFxzTAsoK/iALmd+mobsdWeAqfCzG3O2ExjmhoqFqQEe6JGTyFD2HIHsxvsaZZHkgg==
X-Received: by 2002:ad4:5dc4:: with SMTP id m4mr18337189qvh.17.1643649907030;
        Mon, 31 Jan 2022 09:25:07 -0800 (PST)
Received: from [172.17.0.2] ([20.114.237.83])
        by smtp.gmail.com with ESMTPSA id d11sm4502690qte.10.2022.01.31.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:25:06 -0800 (PST)
Message-ID: <61f81b72.1c69fb81.3d485.0bea@mx.google.com>
Date:   Mon, 31 Jan 2022 09:25:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0700342882714193115=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btusb: Add support for Intel Madison Peak (MsP2) device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220131163235.17020-1-kiran.k@intel.com>
References: <20220131163235.17020-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0700342882714193115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=610072

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      30.32 seconds
BuildKernel32                 PASS      26.70 seconds
Incremental Build with patchesPASS      39.02 seconds
TestRunner: Setup             PASS      471.33 seconds
TestRunner: l2cap-tester      PASS      13.46 seconds
TestRunner: bnep-tester       PASS      6.10 seconds
TestRunner: mgmt-tester       PASS      104.40 seconds
TestRunner: rfcomm-tester     PASS      7.62 seconds
TestRunner: sco-tester        PASS      7.71 seconds
TestRunner: smp-tester        PASS      7.57 seconds
TestRunner: userchan-tester   PASS      6.39 seconds



---
Regards,
Linux Bluetooth


--===============0700342882714193115==--
