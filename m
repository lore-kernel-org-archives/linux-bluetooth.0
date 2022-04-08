Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E321C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Apr 2022 09:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiDHJLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiDHJK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6D12A8EB
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 02:08:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e22so6993774qvf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Apr 2022 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aml48up7YZP8OodU7v9vMYD0Pb2OG/CuZOmJpobZTwQ=;
        b=qcJ9FUm+U+DJV5MO2F1hHFYHnsD+/xiZY5nyOcpfKKsHZaBNzNRX5Ck1sIC+/RTq/A
         ZmjCoCXAbp6URlAlmyyzZVQQIko9aZ0M4L2puzYwS/46N7jD3DZIu9uhm5MseG3Gq0ay
         BHdCso1dUJfqTjjeJYdknuUlKMmY6kFhXohYBCAvxthqcg6t9z77s892apEknCt+upMQ
         6v84JD5F8jkwpeSAgs2Ugu8TIufHFVeRb/dGb7UogDpMKMVhjY+yHtweBy8JRQmJL0yI
         KWqO2j24foWeF7z1FbubStiDqKXwCIEyX26p9/hX/yE2WaoF7iqseFB07HvIvJ9b8hmt
         m/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aml48up7YZP8OodU7v9vMYD0Pb2OG/CuZOmJpobZTwQ=;
        b=j/+ZUVcRBaix5Y7kF/U9lBxZ1gST+6A+gDLbhRlaBOLmFTiup5MUdodbLpMso33hR7
         6RvLWU5ywu/055MuDTZGY7X/8PWwOp6mye5er4sX5Kh72G6Wg2TTHgdnfsezNEUcAUdB
         HYGC+DFEj0YvXIJKobej2YeMEyfDWOTslDynP2cN0D2ea0iB3ocmma646PtpEnfjL9wk
         jEuS8RC7Dp8Y3MqolgdHJ1vjEAuMJeHmOpL5js2HijmFNL7BY4t2mIj0rXh5yXkunW4p
         GwR2la7VKNErPByUFZcFUeWG86DbAOtNg/+0Mu52i6ascYSHMhVuinWUqKAQ3DIR70KP
         38xQ==
X-Gm-Message-State: AOAM5336JzT1BPhBCPXwhNl41fdEOQVkly15v5lqabEnzYMl15mDZOvI
        ihcn603jt7lWBa0/+OWQcWpFZ6pWasWhVA==
X-Google-Smtp-Source: ABdhPJzZw3J0umPTT2Lb/kJncwfDJkeM+Yy2owpfUsmXtWdZT1Z4CDONW03J/jIsWZjSNYGQ/fvz9Q==
X-Received: by 2002:ad4:5de4:0:b0:444:10b9:8e79 with SMTP id jn4-20020ad45de4000000b0044410b98e79mr5577602qvb.61.1649408931451;
        Fri, 08 Apr 2022 02:08:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.85.2])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a167600b0067d8efed4d4sm13451317qko.26.2022.04.08.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:08:51 -0700 (PDT)
Message-ID: <624ffba3.1c69fb81.69343.4030@mx.google.com>
Date:   Fri, 08 Apr 2022 02:08:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8016270319199402815=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support to configure TX power
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220408080633.20463-1-kiran.k@intel.com>
References: <20220408080633.20463-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8016270319199402815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=630327

---Test result---

Test Summary:
CheckPatch                    PASS      1.91 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      31.71 seconds
BuildKernel32                 PASS      28.41 seconds
Incremental Build with patchesPASS      38.53 seconds
TestRunner: Setup             PASS      473.64 seconds
TestRunner: l2cap-tester      PASS      16.07 seconds
TestRunner: bnep-tester       PASS      6.37 seconds
TestRunner: mgmt-tester       PASS      106.73 seconds
TestRunner: rfcomm-tester     PASS      8.30 seconds
TestRunner: sco-tester        PASS      8.07 seconds
TestRunner: smp-tester        PASS      7.94 seconds
TestRunner: userchan-tester   PASS      6.61 seconds



---
Regards,
Linux Bluetooth


--===============8016270319199402815==--
