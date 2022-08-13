Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57781C00140
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Aug 2022 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiHMACT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMACS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 20:02:18 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFE81B05
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 17:02:17 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10dc1b16c12so2563410fac.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=eiX7bEqfjPqCWqY4+7XIl+wA0zskvdKH8VgB/e6tiTk=;
        b=Qa2RHcCE1p0FJWVKUmrsVgXjbr2TnkqK80VYXHTDXPK0MTfYfWRV/2SjdweGC+wOgl
         BwtMOzjqqwTHpO2bH163x9rufSgJFQQq8XZDgpAq5taTTIS+edyMEWJqj4RYQEAh+sh1
         m0eyQomewhoa2IypfmIxEYbTkIXNkFvgAixIFZ9PAaUsSbjOLBAZGR/96+QyNVc3XnMC
         pH8M50CB7WxjvKVcDAgrP/zUn2pkyXRjg6a+4HFQ5bmXIVteb7CBZo5200GflmOKEIOi
         MuXfvLI6xBUoBMhpqaohDdV6qu7gVwWDu9wdpnYiDXJ+frkBOEYgBHyqLUMDlBsiHbon
         02Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=eiX7bEqfjPqCWqY4+7XIl+wA0zskvdKH8VgB/e6tiTk=;
        b=LFVn5wTqZpcz/aW/R1VyjaUKwUBJrwGZCNkICqMZHmcaPeqMmatkWetl4wOOtaZOLc
         BtkBlXa8Mrhi5ONmhijgKWgrU7ak+jX9y9FLNgaKj0Iv42TpKQVX7B2kyTHKXeA17gx7
         NOW48asl1fMU6ZKJGiE+wgV/b3FOZ8O/QMuTE5KZexyJPL3rWhCJZpKyNkgWNDCSHjqC
         eN1SDjaC0LcrW9z3qK2t9h5QuJcnoeBrKOOZIlsPiQV/701MAB1iFhMi0FJ4FzctwNh6
         IolM7ZrFqZu6tGEs6NFHOb7OjbMPa+3IwKHvFfIQn8lJsaY+LQokGRJJZgGCBKzQSCo4
         F+Pg==
X-Gm-Message-State: ACgBeo2DxXp4K7KQ1oMJ0bJaBkd6/HlvWtalzv9n7Zsw85f8RiYwPEDW
        V5bm2/U7mv+gPM8n4Jh6eUxl43QxOugNYg==
X-Google-Smtp-Source: AA6agR6gcsTPc89afE69sTEfHa6mJ9zENhd8NKwxkYCTaVAVOZe0MYZkFme/6Ag79lyDwG4CQ7AL7w==
X-Received: by 2002:a05:6870:9686:b0:113:5b33:9478 with SMTP id o6-20020a056870968600b001135b339478mr2695882oaq.133.1660348936374;
        Fri, 12 Aug 2022 17:02:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.215.152])
        by smtp.gmail.com with ESMTPSA id f23-20020a056830205700b00636e9a0cce5sm633786otp.60.2022.08.12.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 17:02:16 -0700 (PDT)
Message-ID: <62f6ea08.050a0220.ae57c.2e2e@mx.google.com>
Date:   Fri, 12 Aug 2022 17:02:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7150039050270024201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix build errors in some archs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220812231329.540559-1-luiz.dentz@gmail.com>
References: <20220812231329.540559-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7150039050270024201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667289

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.74 seconds
SubjectPrefix                 PASS      0.73 seconds
BuildKernel                   PASS      37.55 seconds
BuildKernel32                 PASS      31.88 seconds
Incremental Build with patchesPASS      44.12 seconds
TestRunner: Setup             PASS      547.06 seconds
TestRunner: l2cap-tester      PASS      18.38 seconds
TestRunner: bnep-tester       PASS      7.13 seconds
TestRunner: mgmt-tester       PASS      110.56 seconds
TestRunner: rfcomm-tester     PASS      10.81 seconds
TestRunner: sco-tester        PASS      10.81 seconds
TestRunner: smp-tester        PASS      11.11 seconds
TestRunner: userchan-tester   PASS      8.05 seconds



---
Regards,
Linux Bluetooth


--===============7150039050270024201==--
