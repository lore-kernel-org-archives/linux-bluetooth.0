Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB018C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJCPXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCPXX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 11:23:23 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD585317
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 08:23:22 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id l19so2318874qvu.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Oct 2022 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=eVD9ykcFaKTLeIop1MQ6hFZk8XI/D8jIPJ/ia4edCOs=;
        b=MGdSgbJOnbfPGV1gBRlIKQ7nmFVQq4INqLhARGeDyQTtN6jNRR4CZlwtm/4SduZ4Wl
         GGcJ+2F4QCbSCIlOBKNbfdfQWaFpOxU4wfen3/VNUkKBh2m6GOvMt20q4zer+MWnXktT
         QLw+ZW+/1bJIulYwXJlVtHeoCMKTzSSKNAHGq/yML2qGAepGrXPPKJG6PK2cfWUiLUKd
         5FlnxaQg2q0Y9DKAp9Xxz4ionlBj6SJDgLz1FighuBlCdltSEvEzOT4clJTl5C4siv8l
         sREMjo7uiHXkuE5CoMkf/Pz2b+qC27vTtUfMZnuIgi5pxoykMu2tneWytiu0TOQ1+RQb
         x9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=eVD9ykcFaKTLeIop1MQ6hFZk8XI/D8jIPJ/ia4edCOs=;
        b=uG58wncLR3AvhX8E/m6+uhrKBFNURAflkB5HeHR0J9ccsvnyBAK1uY1gif/0IwyBB2
         /FRp8dODQQJ6uw9b89fqE55yJCEn2qg3nqCbwYymRHqhXCcJj4NhkClK+LEGVVI/fZJL
         PiLLowBmfYdVIGoJJOGtr+fEbAYQ6n2F5/PThHaYB2tGMJHPY+H33luodXHi9d5KoNw7
         bMxjT7zS7rND+XVH0y8YdN+ZdPOCCBxgQMeZNVu5mez5+E8PWCvSnAtDczr6gXFWpdBo
         IKaEz3GqF+k1q2Vs7NKxixlKSvL7dIKpF9QdtgJotE5zLuvP5rxnhZ4GrL3u0FAW3UzE
         J3KQ==
X-Gm-Message-State: ACrzQf1oj81JVHNrBXTYUY1yLTSllxP3FKqEaI1tc8ekonk60LAEInkq
        qEOJOwj5ZYWGzHj4n3J1HpnsBkDGG3DJ+w==
X-Google-Smtp-Source: AMsMyM6R1I0t2CvPwcbzjZ+pUcGGXDLBboVr8yk0e91XYmrO3pS7nQeyoDzGDx21DcS6/BqnPhXb1g==
X-Received: by 2002:ad4:5c6c:0:b0:4b1:7030:b195 with SMTP id i12-20020ad45c6c000000b004b17030b195mr11175801qvh.107.1664810601667;
        Mon, 03 Oct 2022 08:23:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.244.244])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006bbb07ebd83sm12981607qkb.108.2022.10.03.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:23:21 -0700 (PDT)
Message-ID: <633afe69.050a0220.9a402.6c33@mx.google.com>
Date:   Mon, 03 Oct 2022 08:23:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8841768647954253244=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        nicolas.cavallari@green-communications.fr
Subject: RE: [RFC] Bluetooth: Add a workaround for SCO over USB HCI design defect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
References: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8841768647954253244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682780

---Test result---

Test Summary:
CheckPatch                    PASS      2.27 seconds
GitLint                       PASS      1.12 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      38.94 seconds
BuildKernel32                 PASS      35.46 seconds
Incremental Build with patchesPASS      48.99 seconds
TestRunner: Setup             PASS      580.44 seconds
TestRunner: l2cap-tester      PASS      19.04 seconds
TestRunner: iso-tester        PASS      18.33 seconds
TestRunner: bnep-tester       PASS      7.33 seconds
TestRunner: mgmt-tester       PASS      112.41 seconds
TestRunner: rfcomm-tester     PASS      11.39 seconds
TestRunner: sco-tester        PASS      10.90 seconds
TestRunner: ioctl-tester      PASS      12.24 seconds
TestRunner: smp-tester        PASS      10.71 seconds
TestRunner: userchan-tester   PASS      7.55 seconds



---
Regards,
Linux Bluetooth


--===============8841768647954253244==--
