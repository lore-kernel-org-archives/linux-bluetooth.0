Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02458C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Mar 2022 00:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiCQABR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiCQABR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 20:01:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687A1C109
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 17:00:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v2so3198679qtc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ykVbmWKPyrk0Fk1cw+idj9E+7iaK0nR75o6MqJ3QQcE=;
        b=plM6tU5ttaibNTOedVtHXQJgI7tZ4wBDxDeZlQjuJ3hBIDoidF8l+CFbltJmDSpYSl
         UcceOhA1v04Hz6SN4QwA9QogyUYztxtJYRAFFenC8cheBm/8K7ipLwkZoBGs0B0yWyg9
         dce7faHUXdeYbR3wXYGJCriFswG+8zA55rwAe1L5KaBl/3nK3f2XtpF2BEyvb+akkjL9
         MX0fOz9QDwaB31rlNychpLn45f1poWMNeWEM/7UHkZopSwIiCGocdhsGgOKhEPr1n4N0
         ckIePVZOUdWsvLx4d3dT9HhMM87B1LYasA123C4VZeZDJSyz2a+OHizNT9M1HIr4dSDn
         bMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ykVbmWKPyrk0Fk1cw+idj9E+7iaK0nR75o6MqJ3QQcE=;
        b=cGWTwYqNi+LuTXMGOlZ2JuibdzaOOoLOKZLpWmqradeav7ihNXjW+ugVYfSaNnX4if
         kvpi2qIPcobeSDLaIP8dqXmFztxHas5tYKKDXkUvTTTmiwENhMhIXKo4fT8ejtKJiOOb
         IumxDmiqCByDYGFryGtcdkaFzb3YDoiBfQBZOLcDo/S32vLBV5J13K+bwsmgFVZ4qh/j
         g0WH8DZZMPjJTUidbko/Jsq8/mUCdT81BpgfOL21ynBbGLId53Nul6sa3gCwj76rNntr
         0JdxL1RGzyFk4NIvMGMdjI6ZITCTsBw3BckMagq4kl3a3O1JA0SbrRIv/O4eqxqlGqol
         LWkg==
X-Gm-Message-State: AOAM532Od6Arg4y0LjYZQGL+9YKNnHlcpda4BAKy2an8uySgRJ2M1NkD
        UnmB65nTPaBBCiqoKRlY6py1dVQftGo=
X-Google-Smtp-Source: ABdhPJxooDmnoK6AUlAVnq2WQfVKebMiVBArqHYT4/c0YLWP2m9qcL+isPJnnUKAjtP9KVQKzWayRg==
X-Received: by 2002:a05:622a:1a97:b0:2e0:62b2:4507 with SMTP id s23-20020a05622a1a9700b002e062b24507mr1866011qtc.328.1647475200837;
        Wed, 16 Mar 2022 17:00:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.39.149])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b002e1cde99863sm2373389qta.83.2022.03.16.17.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:00:00 -0700 (PDT)
Message-ID: <62327a00.1c69fb81.7f9e.f38d@mx.google.com>
Date:   Wed, 16 Mar 2022 17:00:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6629956725116378399=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v5,1/5] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
References: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6629956725116378399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=624053

---Test result---

Test Summary:
CheckPatch                    PASS      7.95 seconds
GitLint                       PASS      4.78 seconds
SubjectPrefix                 PASS      4.21 seconds
BuildKernel                   PASS      29.45 seconds
BuildKernel32                 PASS      26.38 seconds
Incremental Build with patchesPASS      60.34 seconds
TestRunner: Setup             PASS      469.68 seconds
TestRunner: l2cap-tester      PASS      15.98 seconds
TestRunner: bnep-tester       PASS      6.24 seconds
TestRunner: mgmt-tester       PASS      103.42 seconds
TestRunner: rfcomm-tester     PASS      8.11 seconds
TestRunner: sco-tester        PASS      7.87 seconds
TestRunner: smp-tester        PASS      7.85 seconds
TestRunner: userchan-tester   PASS      6.60 seconds



---
Regards,
Linux Bluetooth


--===============6629956725116378399==--
