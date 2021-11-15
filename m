Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC47F61B60
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhKOJlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKOJlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:41:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A27C061746
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:38:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s138so6054376pgs.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AIw/tWWxC8cxGfKyyTn5tvFuYLLN0mKW4frLA56c86s=;
        b=ljcdf2Zs/GlnHx6tUgck4R7JzfYOmMtIG0iTswQ2/2iOOK3VoZfWbi3353YXJNFtEq
         1fG5NZhqVR1pIcsVPwROOsunLbKJj59IMzv26ZuwCZtix0CDSIFA7ILjFkAZ7R15m1RX
         en8Tck5WQezHi9Kqt/gn8EdLRhVYacsPNhTJDpMhyoqNYDc9WSHwEbuX1ItMxasK3zZA
         hFugr8EF+JoqkofDZ4z15DfKRsmXYg+lnnoofpk765TIQS2rcT47pv1oOm2K1mBQkm7K
         WSS+0PSulnb4z6sTKamZHZyt1lAVGOKw/966EIv6wGDyub+cUiKrVo8wXcUel/3dgUq3
         WV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AIw/tWWxC8cxGfKyyTn5tvFuYLLN0mKW4frLA56c86s=;
        b=dh/k6gNIYxCR3HrEcHu66pZzw/xtgEFyIBfESI4IAsmr6Vv4dh4lBQd2Z5iE0mmzS5
         wbCVp1a+fV2/ny1Y90A7wA/bbVjm6NJD4wjrgOSKCaOKs2zdHhLvi9YxXofKZYWpVlt4
         1Kq/8dCrnrmLlLNbakdsqzfBeJI6OYMcDZkbQc5qtRPtgUKAYzxfS2szMVQh1GPfP3iF
         4asXhZqxrewFC+v3w0cCHvn3mOqBFGuppmJ2CA0/WQy8U+q4l8DlRtAN/mirpiqnOW6c
         mffRq+bV8V9QLbN/hTnWbc6yDBKmy3GSlpV6nS6lLVciB+7I+AJpBu4W/E4DWOwzoUry
         Hh/Q==
X-Gm-Message-State: AOAM532BY8IyyKtF19S6ubM3smsQ4756H5ezCLwXR/qFrjzfIIhKc8Ec
        MvP11mkEaj37B5bt6txSDN4m9Tu6tSE=
X-Google-Smtp-Source: ABdhPJxsyxtRi07a34PT8GLZdDpVc7YYrrlAlLa9LKNxw3oveVaqhoFMqmGqc3Mm2W29IHLc0e3WPw==
X-Received: by 2002:a05:6a00:14ce:b0:49f:dc1c:a0fb with SMTP id w14-20020a056a0014ce00b0049fdc1ca0fbmr32133782pfu.56.1636969103394;
        Mon, 15 Nov 2021 01:38:23 -0800 (PST)
Received: from [172.17.0.2] ([52.175.243.222])
        by smtp.gmail.com with ESMTPSA id 17sm11264045pgw.1.2021.11.15.01.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 01:38:22 -0800 (PST)
Message-ID: <61922a8e.1c69fb81.359b4.111f@mx.google.com>
Date:   Mon, 15 Nov 2021 01:38:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6815937742663868083=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/3] Listen and process remote name resolving failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
References: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6815937742663868083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=579995

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       FAIL      0.86 seconds
Prep - Setup ELL              PASS      46.44 seconds
Build - Prep                  PASS      0.25 seconds
Build - Configure             PASS      8.36 seconds
Build - Make                  PASS      205.20 seconds
Make Check                    PASS      8.69 seconds
Make Distcheck                PASS      244.13 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      191.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[Bluez,v2,1/3] Listen and process remote name resolving failure
12: B1 Line exceeds max length (121>80): "https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/"




---
Regards,
Linux Bluetooth


--===============6815937742663868083==--
