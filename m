Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6120C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D75861212
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTWhU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTWhQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 18:37:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C9BC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 15:35:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g17so4485766qtk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+hagwaGk/xA9ZfYPCQois5d+e8Lqzx4cmlTtOQHyDKc=;
        b=X43mctVlDzEd2dnLNJomMaL5cBV9eFYX+QhN/z+AullM9Cyh/ymgVijqjETIFdltau
         VqUI+NPwmT3b+0sElsskLjODFP+59gCjRPsP+e+UtGl+tI5Of2ygAUHZcxAJojztP5oC
         j8QASTz+h/dJCJT/1wxq6n8EaNMRMHt/IWASUxncgrv25XvQPRPP/SyDFZ+IYX1relqg
         EAyEbleHIUgVr+SKT0nAq0eaSPim4r47ZkXrdpay8W9V4UIQ1bI7qm0rlE6w6fve2tf7
         rQefA96DU6hUMvSFSocbZcsfflswXu6GCmnBheH4z1eQTDi959wGjJqEc7VuTstzXy1e
         IcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+hagwaGk/xA9ZfYPCQois5d+e8Lqzx4cmlTtOQHyDKc=;
        b=Kx/I1H+THtY2GJ7ZO1cs75WTsssYG3PACsw4ivWerynIeKTIRf04Ud4CPRxa/irLJw
         O5BkVEaWEnLxRVDMO0j2uiag+XreBobMEn0xRj7a+Gnd1xVFKotX6Vc4Z5nHQf2dmJIM
         j7wRescljQHzdOdPYOKZ32dYzi/9LM/ITJ/grLVSGNIeD7o+0hFVG00u9bqdX5d33STP
         JEUuiQY9ivJdHKkb7I5Tv2D8IZcNSEJnbDUKRj4nDeN1HtiHqisLFGhQfxt69621Z7sa
         XRkYX4N0vKw/aPjjZ2Yrlz+7kGeDCbA+1YJJ8VhRjfNK9Rm6mdRCpTOCwC8evm53x10Y
         P0lA==
X-Gm-Message-State: AOAM533hrwL2OI2b9FFi+QFb4ADbS8w2u/eoLW0ogD/csWrnntn2roIw
        JiLKWhboAPZMvWID+UKKyfhul0TwmNk=
X-Google-Smtp-Source: ABdhPJy8+a3sB7aXPsgsIMXkLsmMKE2Z7DwzELH8w+UNvOnwf29o/nhqpYveNEZihQhqu9hoh7IoDw==
X-Received: by 2002:ac8:5944:: with SMTP id 4mr2122381qtz.99.1634769300335;
        Wed, 20 Oct 2021 15:35:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.138.136])
        by smtp.gmail.com with ESMTPSA id g27sm1591792qtm.1.2021.10.20.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:34:59 -0700 (PDT)
Message-ID: <61709993.1c69fb81.e75c2.ae76@mx.google.com>
Date:   Wed, 20 Oct 2021 15:34:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5193093340957566216=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/6] monitor/msft: Fix uuid.u128 format
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5193093340957566216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=567367

---Test result---

Test Summary:
CheckPatch                    PASS      8.45 seconds
GitLint                       PASS      5.65 seconds
Prep - Setup ELL              PASS      39.54 seconds
Build - Prep                  PASS      0.44 seconds
Build - Configure             PASS      7.45 seconds
Build - Make                  PASS      169.13 seconds
Make Check                    PASS      9.24 seconds
Make Distcheck                PASS      202.33 seconds
Build w/ext ELL - Configure   PASS      7.73 seconds
Build w/ext ELL - Make        PASS      156.56 seconds



---
Regards,
Linux Bluetooth


--===============5193093340957566216==--
