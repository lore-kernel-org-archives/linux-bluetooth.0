Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189CCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 16:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiFNQHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiFNQHf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 12:07:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23871E3E0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 09:07:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l14so2933915ilq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EhNKcYNMyQGy1UerK1aHz7Q2Z2aprkjSlPEhibVtzp4=;
        b=Ssw7kcCLgUg/vSGaD7kBjw4AB5/QYLIySoZ4mKAgVbD5fDAFT/q7HSLe+/AU8q+AwO
         +JzKErKza0gpGrws5UmCbzzCNvPu2hBasVM/rE0V+X9r5cwIolBUlgxPJYXLhDwjj2fP
         Z/As/dQfJwwKrC4gCZhlQwbPEYWFiiJ/1GB2wAqq6ctzWi7H+85FVV6hg1C1dvaNgTAJ
         6mRxt50QKt/TP+Ul8Brh+12bJRw5lVA6H5oiNNiZ5SvbmrUr68AGtc9TFVOSZ0L4HOF9
         6gzoenZKU4Yu3/o0fRfSN+UX1kc/XexkWZWNlfoWTM6hmp1EN6RoSj8+L/zLl6UCQHHL
         DM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EhNKcYNMyQGy1UerK1aHz7Q2Z2aprkjSlPEhibVtzp4=;
        b=FheEna6JStHMVqh2+SXl3Gaf6C4hW+zGPoxVNydug8zUc4fxaKPbY9sgi/TAaNx0tw
         +JgPtdfJB3bM1lqfIEkyFPcZS3AMEqDSEP8ILPXxCCgiqDvr7g2gD/NIF01rnPz7SFaQ
         NfAuddsX7itrINoXrGJ9zKq+8VBCpeXMDmxBicwZmXuupk5cVH3gsYsbZgVqPiM05zdM
         l90O7c7TW3JrrsHOQuoQ6A6ZvWNFYl5v09MSVbHbpe6Q6yKg9ppg4xaE7BQQiCN2Uqkw
         CgoOJ3nI4MA5oMQZDpchD95MzSmNJ9Om6STalMycm8fTFAhIAsaveT4OzJZSS7IXRfgu
         1WIA==
X-Gm-Message-State: AJIora/It1+w0CaC2kr7x+uL2cuAg+zg2nlfpSeQ/RcxOLAFCbC2sau4
        BEt17SNzytabQp40xAcazfAqhscPdR0=
X-Google-Smtp-Source: AGRyM1sgYT7pJ5Yxgq+uZDgcCSle4N56XRkHFtLgjk0BA/1dGZ5vu8jkHbRwdN/w053C3TPU4FP/ZQ==
X-Received: by 2002:a92:ca08:0:b0:2d3:c490:40c3 with SMTP id j8-20020a92ca08000000b002d3c49040c3mr3499372ils.167.1655222854090;
        Tue, 14 Jun 2022 09:07:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.85.154])
        by smtp.gmail.com with ESMTPSA id z12-20020a92da0c000000b002d149ec2606sm5566127ilm.65.2022.06.14.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:07:33 -0700 (PDT)
Message-ID: <62a8b245.1c69fb81.bcbbf.5f7e@mx.google.com>
Date:   Tue, 14 Jun 2022 09:07:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7276154296897812634=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: Bluetooth: virtio_bt: Use skb_put to set length
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614145253.132230-1-soenke.huster@eknoes.de>
References: <20220614145253.132230-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7276154296897812634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650254

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      33.59 seconds
BuildKernel32                 PASS      29.90 seconds
Incremental Build with patchesPASS      38.97 seconds
TestRunner: Setup             PASS      537.03 seconds
TestRunner: l2cap-tester      PASS      14.48 seconds
TestRunner: bnep-tester       PASS      4.49 seconds
TestRunner: mgmt-tester       PASS      85.82 seconds
TestRunner: rfcomm-tester     PASS      7.70 seconds
TestRunner: sco-tester        PASS      7.47 seconds
TestRunner: smp-tester        PASS      7.50 seconds
TestRunner: userchan-tester   PASS      4.69 seconds



---
Regards,
Linux Bluetooth


--===============7276154296897812634==--
