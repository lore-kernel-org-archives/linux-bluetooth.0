Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F18C63684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiAZSBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbiAZSBU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 13:01:20 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A3C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 10:01:20 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k4so532473qvt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nOdSJohoAhccP1kh7Dd9ZNJodXMA5eeJkQN2espM+/Q=;
        b=Aimp7hxlsnj8SeS/FjYMCKczI5jXlfjsSjWKYwIHZzD3vPv9nX/wm2XRZypDl2vpNJ
         3Ay7ZteyyK5y3REpvAGAOyiN7H6kNTHKkYJT0NT/gYoHZVDhQWqgJnc/NSMwaCBnXoyy
         cWO0slzczp4IUPb/UqwK3jxBtEMzD0oOW43Re38ccdklDr3fsgr5gX0iWAb/OZLtyBWJ
         eIef0V6VHp5V3zxn0PHvAYcjkQF8DKPjauzDM+DtkAg3ML++ipl6+idljqbcAKOE6mxN
         nMFW0nDxH21OmyJAdglpnnqqS3lht+/K1TfyMqSEq9UG/BO0TZ80uWcfaoiuL+LZaoT4
         OM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nOdSJohoAhccP1kh7Dd9ZNJodXMA5eeJkQN2espM+/Q=;
        b=T0vgkkIU2dR+rV92njrQKtNPHL57rPAeMM7yLgbp7SJnPoDKW2ilVC4+wciMmikKqs
         CERBa7UTZoKZOnOeufymExFFIVsPDynqg9bcBjr//lRDUGM1JRA4x4Qb26/HJU6OKU3w
         biYTQL0SMLP5K0OSdG31MYjDzQuUN8iBM5EqSL1HNQvfto0E5WAGfYkpz9pHjx/P3vcM
         LxCpQg6v58TAk3g1AnSfnFTa/V1oa/Mw6FSFSGdMS4mclKXCN4lifQuQl6nf+MMupLxY
         2dtZ7TeMsDIo7g2+6+qBzvrZ0Pu8xbw+x/wlDl9eaABsLg1Xf3yWUk1o3fMgO8chQEG1
         kveQ==
X-Gm-Message-State: AOAM530H8QtcOia7EyMIgZk5pc0PxF1Qg7J50ddu4ZiYNoqgmxZ9Dl7s
        9Qt9UxneAPBaR/LadYpqIbyP+OXyJlCTOA==
X-Google-Smtp-Source: ABdhPJwfnc1+/4RvlQW4tmM3AtNftvjzouTEVbu/Grh8FkfpgxkJI/DzX1/RQtAVrhh239n1HYgfgA==
X-Received: by 2002:ad4:5ce4:: with SMTP id iv4mr48947qvb.23.1643220079065;
        Wed, 26 Jan 2022 10:01:19 -0800 (PST)
Received: from [172.17.0.2] ([20.62.99.174])
        by smtp.gmail.com with ESMTPSA id bs37sm11726510qkb.69.2022.01.26.10.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:01:18 -0800 (PST)
Message-ID: <61f18c6e.1c69fb81.5c7e0.5432@mx.google.com>
Date:   Wed, 26 Jan 2022 10:01:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4871940314168376339=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: Bluetooth: Increment management interface revision
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220126173012.81238-1-marcel@holtmann.org>
References: <20220126173012.81238-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4871940314168376339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608717

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      27.93 seconds
BuildKernel32                 PASS      24.44 seconds
Incremental Build with patchesPASS      35.92 seconds
TestRunner: Setup             PASS      422.60 seconds
TestRunner: l2cap-tester      PASS      12.37 seconds
TestRunner: bnep-tester       PASS      5.54 seconds
TestRunner: mgmt-tester       PASS      96.92 seconds
TestRunner: rfcomm-tester     PASS      6.75 seconds
TestRunner: sco-tester        PASS      6.93 seconds
TestRunner: smp-tester        PASS      6.92 seconds
TestRunner: userchan-tester   PASS      5.78 seconds



---
Regards,
Linux Bluetooth


--===============4871940314168376339==--
