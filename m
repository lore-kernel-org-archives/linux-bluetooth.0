Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C53EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGEVlP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEVlO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 17:41:14 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139131998
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 14:41:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39eab4bbe8aso120929b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jul 2023 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593273; x=1691185273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZAZbWb2AE2SxEe+ju28RXskvDk9SwGGzWqP5Kj+yuo=;
        b=HUQPMoTcxLCUNO3eRXK40JkC+KdIhfjXJquX6xC0PkafjT8ebIH3M5rPCIMN4MsMVl
         c4J6jCs/XoxqLF3q3wvvjkCEYpDe73FwMheUAlaufZkcpdmQ/7NkOv8LgElKCqG/0l94
         tMvVctzs2CdFR5tumz6AoupHnrmIi9T5h+dNooNszHnWZ22kzquPj4WD7dzlJF8n+cq3
         6BkQ4n5rmenKKENqpRoVgr0S2iyf6k2zLi4JH8guGuRUIPk3VI/G1RdCsj06P3vI/f7I
         t9I/bYM4dk73HmLIma3RQCYtuiDVJWBYNyIwDrtxDgoimI68argISLMNRXn6/v14etA0
         YHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593273; x=1691185273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZAZbWb2AE2SxEe+ju28RXskvDk9SwGGzWqP5Kj+yuo=;
        b=BDfJmOsth40GCQaVLspohYcRz0V7PZObJ85YQHyb9m/vC+gj6UioVWzeqHc7Wv2zxg
         NNw+knzyKLJD/wGP2iCyXjZFJ1iAOsSSlnLBrqR+l+fDbiLAM03ORaEtLEsL4Z4BAwYE
         +8aRPRjRO7FnzwH85SnE+E2iFuW21jnPVKH32PtCWD++Egc4kz88R4XF35/3rnO46dFH
         xl1wRqyTf1UVxL3uVQFo//u6xXEIBJVuEK7EY2nrRreRz1eA1kT1z4VBv6oNfGr2S0oY
         baMDkcqjXFRVeBAjoyV0RfuQprDyJovaEYHdTN53gc5N9XCopNkvVUi+SEpGvRprMoU9
         F1eg==
X-Gm-Message-State: AC+VfDysgGzPxxnaaE4rssJ7kEVeuh9NgNXxr/VkANhfadNhKrofyaXP
        2mMS5SKgYPLQa2dBOt+TQKmjOupvnIk=
X-Google-Smtp-Source: ACHHUZ69tqk7Ja1LzLj0Vk6twy3yUizPevPBAVhN86QisMSCYPxdfrAKu5Fl6mMf5zSVUuRsLRx5yw==
X-Received: by 2002:a05:6808:4ce:b0:3a1:eb0e:ddab with SMTP id a14-20020a05680804ce00b003a1eb0eddabmr18376492oie.28.1688593273244;
        Wed, 05 Jul 2023 14:41:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.134.52])
        by smtp.gmail.com with ESMTPSA id c14-20020a056808138e00b003a05ba0ccb2sm21107oiw.39.2023.07.05.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:41:13 -0700 (PDT)
Message-ID: <64a5e379.050a0220.a4f53.0289@mx.google.com>
Date:   Wed, 05 Jul 2023 14:41:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6957644005890415471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Fix hci_suspend_sync crash
In-Reply-To: <20230705210647.1.I636c21e4dc8fe3352f4d7aef26c0ec3857e24ca0@changeid>
References: <20230705210647.1.I636c21e4dc8fe3352f4d7aef26c0ec3857e24ca0@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6957644005890415471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762867

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      40.45 seconds
CheckAllWarning               PASS      44.29 seconds
CheckSparse                   PASS      49.58 seconds
CheckSmatch                   PASS      134.53 seconds
BuildKernel32                 PASS      38.85 seconds
TestRunnerSetup               PASS      594.80 seconds
TestRunner_l2cap-tester       PASS      28.84 seconds
TestRunner_iso-tester         PASS      63.10 seconds
TestRunner_bnep-tester        PASS      13.19 seconds
TestRunner_mgmt-tester        PASS      256.80 seconds
TestRunner_rfcomm-tester      PASS      20.28 seconds
TestRunner_sco-tester         PASS      20.72 seconds
TestRunner_ioctl-tester       PASS      22.56 seconds
TestRunner_mesh-tester        PASS      16.72 seconds
TestRunner_smp-tester         PASS      17.53 seconds
TestRunner_userchan-tester    PASS      14.28 seconds
IncrementalBuild              PASS      37.29 seconds



---
Regards,
Linux Bluetooth


--===============6957644005890415471==--
