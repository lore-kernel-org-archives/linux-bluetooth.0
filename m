Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiB0RRX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0RRW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 12:17:22 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8E65481
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 09:16:43 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so7075382qta.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6j07jOpg8gdNiA+hCEL46FRjncWB0T8NZvkI2eYPsYk=;
        b=E4tTD0GJ7yOuXVfrXtVHR5/ZTq4SMNM9O2munUjHH7fBb3xJvKJYBvc4RPrPazSVoA
         O+McbpCo5heW+XIumZKplpxVVYbWNy+U/SBejyTG+DcZNg2MW3g2cRoIC3s3X6Eurdnp
         0+OGjEUEra3FI8s6iY7spz+TCajHVnvbWa8hFMwn199NLOKAz8Ya9rZLdc5u6jUFqyfb
         HdEHZ8l/k0NfJq1BC4Qv8qeR2uUYFDO0307mFiGCaJCYVi8Y/BlvPGZqN89utufwdsky
         FJNYgEBuNFJu/XWd3ZLtRaPpplgqgxN2m8LtwnqCp575G2HRM2xLJS5DsrVfxg0X0bIg
         x2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6j07jOpg8gdNiA+hCEL46FRjncWB0T8NZvkI2eYPsYk=;
        b=t0xnOOJ0hzaRgiL0uWbBUUIC1dVkCDDtpL94B7cfm9rPbhgOZzd3orJywv5uSJSjtA
         U76cG2RgkpCj4XJafY6kyIpQn3QsIfsGPRKs4QkWP57taXcseWdZCcfZp6s3cbqY5Xbm
         +eJAP1RTzGavdhus2LSNuZYU/Hqdk6ANbQacHqNDziYAFbjQnoLXLbpgDJUayKICuFoA
         vR0bJNZAQAGBP3SxVRig8Zm+uCZj96kh0oNXI1wkCHLkpVweb2V+AnLTHBKqel0YLaSt
         Ey77tJoFXMcxRF9qCmNXiT7vxQ2rhJiNuuQ3zL/ScFfBnSUxY7+oswKht3PZ7waEdNBG
         YDeg==
X-Gm-Message-State: AOAM5325nOAA7AvBijvXPT6vbPKs2UE1mxoBNqzrkJWv+CYSjJ1AM2Xo
        6faB/wlvZNLNrYZropHbZR5ymOVygv4=
X-Google-Smtp-Source: ABdhPJzIrtQCmNx2jAhr1PWBIPijh4G/s672R50YCdpAbSZ6d8U/9SaAWTSukVu0STmBhOW2jVnaow==
X-Received: by 2002:ac8:5e51:0:b0:2de:b1ae:bafd with SMTP id i17-20020ac85e51000000b002deb1aebafdmr11029476qtx.391.1645982202061;
        Sun, 27 Feb 2022 09:16:42 -0800 (PST)
Received: from [172.17.0.2] ([20.65.63.6])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002deaca065dfsm5350891qtj.10.2022.02.27.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 09:16:41 -0800 (PST)
Message-ID: <621bb1f9.1c69fb81.5f9b2.bd54@mx.google.com>
Date:   Sun, 27 Feb 2022 09:16:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7981513964558111735=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC] Bluetooth: don't use ESCO setup for BT_VOICE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220227163430.24694-1-pav@iki.fi>
References: <20220227163430.24694-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7981513964558111735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618448

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       FAIL      1.07 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      34.67 seconds
BuildKernel32                 PASS      30.46 seconds
Incremental Build with patchesPASS      41.73 seconds
TestRunner: Setup             PASS      544.79 seconds
TestRunner: l2cap-tester      PASS      15.36 seconds
TestRunner: bnep-tester       PASS      6.82 seconds
TestRunner: mgmt-tester       PASS      119.15 seconds
TestRunner: rfcomm-tester     PASS      9.02 seconds
TestRunner: sco-tester        PASS      8.56 seconds
TestRunner: smp-tester        PASS      8.42 seconds
TestRunner: userchan-tester   PASS      7.03 seconds

Details
##############################
Test: GitLint - FAIL - 1.07 seconds
Run gitlint with rule in .gitlint
[RFC] Bluetooth: don't use ESCO setup for BT_VOICE
20: B2 Line has trailing whitespace: "    "




---
Regards,
Linux Bluetooth


--===============7981513964558111735==--
