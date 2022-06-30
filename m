Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B8EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiF3VDQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiF3VDP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 17:03:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3F1900F
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:03:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so390501iob.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SiRIEah7V7ikXmAe2ubi9LTBDnAhjo3m+aXQsYCKa7Y=;
        b=KPri+lEFtQ2kmLKWnALAbTyo6a4Vrq4/hScrPEZ3WKZ0570weyxEc7gJRqiQ+vyYI5
         UnQUck8UsE0K8Vyp4lcRDXcy80uLmB2IQaCWuV0KmE3G/J7/MjG9NkrvHSRCudQoWK39
         BnnxwQwneYRH4KuMn7b7yHEvuSRGHHi7E1/7PoAccybE/QBN+IuMo1OH1nKgmy60MKvI
         MYHWt804RMvwWGQti77RsIJfenC5nT9ycEl0HxWFkP+9Xp+Bt62bu2es3Nf/3htG+Dg3
         bNY9jjNbsXEJHz5qjBswusC7aX/+4ik7sUrYyuxecM22v1bfkbRZWIbVGNapAqC5GGVQ
         Nw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SiRIEah7V7ikXmAe2ubi9LTBDnAhjo3m+aXQsYCKa7Y=;
        b=2BIu5ch1g+pICJIVjSFekCO01o+atprDPYKS99XS4tfklA24rUtrqOARDih4sjhuC3
         aUhbD8whpBJxGkpgsRm53pj7yzsLMsFVEfOEIjOyrbnXbWvjjsyj1q3T4I8elTRiBxbA
         C1URxjozDKieE70dsXkezQD6ThyigGiAA61z3sArvAMa3u7jXRdYy8n7hI9waUSsiPjb
         DnXxMy7a9H/7lsK2qOpQ466XoiLJMWaLyu6IuOTXvm54d3h4VPpvFiE3UDSm6DaPDkPq
         FLVaNgB3M4ui/X0CQlnPnmIEukOCvpa8Z141bEAF16JG2ZvAizpGbElVdSOlnk4IYk6o
         zO8g==
X-Gm-Message-State: AJIora83VKvzgztUEqsp5CXQch8Mgo1808z2qQ6/sYcj+HO2SfsfLHTv
        t2UvARYE/PGh44uHbxHu/Al1NG7UsatzoQ==
X-Google-Smtp-Source: AGRyM1uEtAinR5ZhTKEYu7oVBC9XT54RzDCqDa7l6w29ZmwAl6igepYJbPUbO7nDS8matmy2WXr61Q==
X-Received: by 2002:a05:6638:1a8b:b0:33c:9a15:1ad2 with SMTP id ce11-20020a0566381a8b00b0033c9a151ad2mr6582833jab.38.1656622994189;
        Thu, 30 Jun 2022 14:03:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.149.126])
        by smtp.gmail.com with ESMTPSA id x26-20020a0566380cba00b00339e18d2c9bsm9078681jad.115.2022.06.30.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:03:13 -0700 (PDT)
Message-ID: <62be0f91.1c69fb81.8aa16.c3e6@mx.google.com>
Date:   Thu, 30 Jun 2022 14:03:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3506412397783420784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mst@redhat.com
Subject: RE: Bluetooth: virtio_bt: mark broken
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220630202700.18187-1-mst@redhat.com>
References: <20220630202700.18187-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3506412397783420784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655536

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.67 seconds
BuildKernel                   PASS      31.50 seconds
BuildKernel32                 PASS      28.18 seconds
Incremental Build with patchesPASS      38.07 seconds
TestRunner: Setup             PASS      460.18 seconds
TestRunner: l2cap-tester      PASS      16.66 seconds
TestRunner: bnep-tester       PASS      5.62 seconds
TestRunner: mgmt-tester       PASS      98.63 seconds
TestRunner: rfcomm-tester     PASS      9.03 seconds
TestRunner: sco-tester        PASS      8.92 seconds
TestRunner: smp-tester        PASS      8.96 seconds
TestRunner: userchan-tester   PASS      5.86 seconds



---
Regards,
Linux Bluetooth


--===============3506412397783420784==--
