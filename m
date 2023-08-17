Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02EDC27C7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 07:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348528AbjHQHgX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348554AbjHQHgA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 03:36:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC192D6D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 00:35:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-790cadee81bso217250039f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692257755; x=1692862555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aS8hkyz4256gwRkzzrzpHu46PmM5z+r6S07W4i03KuQ=;
        b=alZ70Pg4Dn0VXkmmquhD63V9udISBEyR8cIkO34DgjUdgf4vo3SL3uAy9dYfF2M+nD
         U65colDJUHtxvK2ys8ahNTgx+8VyEXhrqrArrNdWyvxaGVLn4hOO+A7ktZphiv952ELa
         li7V2rLyIRYgzhrF+XbDdB2mrY+/8w5fCHINCh4f5j+uZSEqSufntwzkHk1qr9T40bJp
         +lYANhsea11IL9vKP1ALTA9zqIcgbkYt98BboxCnFCK7+X21k3RK+byGfoNSZrXuMc0r
         kIOitTQrK/LuWwa6Ns/VWox/ncIYzndm7pqqHGuyuuWRoL5FDXIDKNDIJplecUeYpo6d
         sSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257755; x=1692862555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS8hkyz4256gwRkzzrzpHu46PmM5z+r6S07W4i03KuQ=;
        b=USXDITL4qovhhrWD07LBLPUzyrsJ0hZrKK+g21USa9QulpyoXJi9g/58FeOLHhyAya
         FGBe4jBW48bj2OaUhUqYdD9/tufjJNRigaj7Hvsk87T3Ubyzm2WCc+6Y6HOZKWH9oylS
         kuXmJO/AOfDtboeN7pDeWPAeyip8sLClcrgTQT5vcYHSFac7y7DvBntEZs509ZWgEatL
         HkQlDN6Wigh7vVIQGG/LACRb9JKPE7/+2awW5Z1aT2WwoH2fbW0sTk+zMJly74liow/Q
         QcvztvcHYBloqXNwISEz67R+G0h49AZjSRuk4L7gwebU68D/h0+ESlbFPO+2gWKGNMmD
         egnQ==
X-Gm-Message-State: AOJu0YzEUZ6EwgbqbopENCP/8DLxgJEEzoHHU+XJtDwfCEkUnnMbtIkU
        iM9eogHbMU4f75osB1GUzQdCBzx2tOE=
X-Google-Smtp-Source: AGHT+IE7SYQJZX5tP0UVoR/rCb65iTQbD10Vp6NUjW1HxG2OOsBfv0UtvnVKKBIw1d46RAWCn6QUfA==
X-Received: by 2002:a05:6e02:1a8a:b0:348:8ebc:f759 with SMTP id k10-20020a056e021a8a00b003488ebcf759mr5746356ilv.6.1692257755383;
        Thu, 17 Aug 2023 00:35:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.5.30])
        by smtp.gmail.com with ESMTPSA id z16-20020a92d6d0000000b0034ab6f53e23sm1347828ilp.28.2023.08.17.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:35:55 -0700 (PDT)
Message-ID: <64ddcddb.920a0220.604a4.30be@mx.google.com>
Date:   Thu, 17 Aug 2023 00:35:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5087082285731472083=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
In-Reply-To: <20230817064427.3647-2-iulia.tanasescu@nxp.com>
References: <20230817064427.3647-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5087082285731472083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776876

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.76 seconds
CheckAllWarning               PASS      35.72 seconds
CheckSparse                   WARNING   40.23 seconds
CheckSmatch                   WARNING   113.18 seconds
BuildKernel32                 PASS      31.03 seconds
TestRunnerSetup               PASS      478.51 seconds
TestRunner_l2cap-tester       PASS      27.42 seconds
TestRunner_iso-tester         PASS      48.76 seconds
TestRunner_bnep-tester        PASS      11.03 seconds
TestRunner_mgmt-tester        PASS      220.60 seconds
TestRunner_rfcomm-tester      PASS      16.08 seconds
TestRunner_sco-tester         PASS      19.13 seconds
TestRunner_ioctl-tester       PASS      18.04 seconds
TestRunner_mesh-tester        PASS      13.44 seconds
TestRunner_smp-tester         PASS      14.34 seconds
TestRunner_userchan-tester    PASS      11.23 seconds
IncrementalBuild              PASS      30.12 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5087082285731472083==--
