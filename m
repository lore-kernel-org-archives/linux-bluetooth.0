Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A81CA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 07:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjILHgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjILHgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 03:36:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820EE79
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:36:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fba57030fso1770871b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694504197; x=1695108997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXNQ0qriL5cojK9sTEy2vIuQP1heH23CuIlqBagtbPE=;
        b=Y4N6RyAopGPNn6P6AnYz0coBaEo0tzBH2YBCNWQDLlKPlvRGpkuTYXQz0JLD5MXGYD
         miE4V84PO3DAhO8LSftpHQjO3szJ5yFjdlFbg6ZqQ6Pl4zmTIE+eMcBN57uDjbpQ7oIp
         EBu1lqct97HspDbYrzQON71/2Bm/8sn/MVtOYt/rC8DI2znIgYdddGQd0Nc6knsDifi9
         TqZARiSYXz8q4IV9JeccGvfyY5JhYVpq0CAtQKxgKLKF9vCr66bP8FHNK/NqKkKBdh6F
         KdCIXXTqMYgdlvd6wHPy4LL0XkSigVXm8yaHwX9me0eHNpAwAHlgNuxQ/EsaVShSNSbv
         SwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504197; x=1695108997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXNQ0qriL5cojK9sTEy2vIuQP1heH23CuIlqBagtbPE=;
        b=WQRxf0pfacovTli6p/ETpgLwVwxI/diVz5iibKR1S40iNDnvZFB7fzqi3OwxflOQZD
         aHSPoc5G5++XfZO8pR1pDQHk3G4NPvfGb838D4CHWsie9+caIZszuDmfIyXepA9SifxM
         0pTdMnbYWJKHWWxqLsoIRt2ucZKBlO90ZPr3MOrw+pBtrywPEkyONKnpZ1rjqKfSD/Mv
         KRX680lRWVt4LYqE90O3nnviQu7KhybLONDJ8uesA4Ro/cxULr2tuJG12ihc/L1WLZ7G
         TruhM1V6ifYWmVfTNRcLsi5ahfZMu0JfIgKJIylCgxrrs7nrd/gA8JR/kQKxStjbwCgL
         HHkA==
X-Gm-Message-State: AOJu0YxFHutjY/6mJ/TPCM7zwjhHtwo5dmKUyfv/SaJ9WJlSC4PsAqC7
        6Q49yxWlFh/sRBZftAu9LwOCbCLD2nc=
X-Google-Smtp-Source: AGHT+IEary0jG/r+we3Fpl3mn2NSROJTibfKyDnra5c8TRCVnQqkW1WW+8aH2FybQAsqXp9QFb+kcg==
X-Received: by 2002:a05:6a20:842a:b0:134:9f4e:623f with SMTP id c42-20020a056a20842a00b001349f4e623fmr11544447pzd.14.1694504197611;
        Tue, 12 Sep 2023 00:36:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.59.222])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902eb4900b001bc59cd718asm7688620pli.278.2023.09.12.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:36:37 -0700 (PDT)
Message-ID: <65001505.170a0220.823c1.541e@mx.google.com>
Date:   Tue, 12 Sep 2023 00:36:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3981587690124633471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230912063329.1196184-2-vlad.pruteanu@nxp.com>
References: <20230912063329.1196184-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3981587690124633471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783273

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      33.18 seconds
CheckAllWarning               PASS      36.60 seconds
CheckSparse                   PASS      41.50 seconds
CheckSmatch                   PASS      113.13 seconds
BuildKernel32                 PASS      31.92 seconds
TestRunnerSetup               PASS      489.78 seconds
TestRunner_l2cap-tester       PASS      28.39 seconds
TestRunner_iso-tester         PASS      50.72 seconds
TestRunner_bnep-tester        PASS      11.17 seconds
TestRunner_mgmt-tester        PASS      226.93 seconds
TestRunner_rfcomm-tester      PASS      16.69 seconds
TestRunner_sco-tester         PASS      20.01 seconds
TestRunner_ioctl-tester       PASS      18.94 seconds
TestRunner_mesh-tester        PASS      14.00 seconds
TestRunner_smp-tester         PASS      14.85 seconds
TestRunner_userchan-tester    PASS      11.68 seconds
IncrementalBuild              PASS      30.04 seconds



---
Regards,
Linux Bluetooth


--===============3981587690124633471==--
