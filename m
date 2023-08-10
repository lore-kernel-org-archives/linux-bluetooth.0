Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30923C001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 01:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHJBRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 21:17:07 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3D1BD
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 18:17:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63ce8bea776so2676206d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691630226; x=1692235026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f5t2o7ApJuATD9CLgZL2zoySnZabY8I+3EU2TyKsrXk=;
        b=GVFMj7nm6P1G14i2K9xYd2teOgC45kPURG6DnIkgru52MAkPFvwhqZHP8a4OTLAczL
         38fFAoLN509HSyrbXZthaNBQ6hBoJdvpJfrFR/MKxSvKWPX6vjsQqpZug3wqVyj0Z+1B
         6yHaASlR8hrjHfunuARuJIToqZ4QtSyO8sOKurla09E7x1w1cXArtyKrg1LnDvJSWXCT
         3mQKgJiIjOQo9pnDK5GkiB1BQval/CdM1dyE3vBMR+PdO+ma0++IZcPlN4YjJ8HiVqBR
         2PZGdyve+l457OJfh4hqXYfYPYYERMGFQbIJry/g1N41ljex9MPrLIDPKMQ3uuTjIwX1
         GXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691630226; x=1692235026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5t2o7ApJuATD9CLgZL2zoySnZabY8I+3EU2TyKsrXk=;
        b=k2GAsWPbil8sOfoBYy/oaAVGoJfZ+xPjhu5qndQXhWqGz6fvytFqRrOx9X6U94iEPv
         yzhTzAAFIcoR3ybLaI5KTjsVXyiSoGqdgUtVe14KIwwTOdRQg8Tm4jVZRqKpIYUn6DV9
         YYOUO3lsACTUm0hz/UmnerVpGyKRxUuvgyCEWYbAz2Sh96uLmvzmrzHvqH8oPnfVirK2
         bZaDC1zj9FctEZOPSAlBkQ2crTgvR71mpXF9hf991j4uHddeJFKLnDy+/kNHsdhOgPtm
         bbLV8VW5Azb3kNkDJ9jlx8S0YZ5U5azxsrnXvVYx2Vh3BQxkG53eOvt2J7hKIm2fNCUQ
         Golw==
X-Gm-Message-State: AOJu0Yx2JqX+B/kn++zUTJ5d5NSHZulMWgCG+SEjJHU1RTvSAG9XFLjL
        B7Oybkiou+N6K83LFdibLg+QWDWhdVw=
X-Google-Smtp-Source: AGHT+IG7MFyNbpcebJdsWUvGhcgW38hy1fChNQffQaLIH6pUfp0CC1sVmDV2d/EnOt4RHIuf+fJ1hg==
X-Received: by 2002:a0c:cd8e:0:b0:635:f5b5:77ac with SMTP id v14-20020a0ccd8e000000b00635f5b577acmr890944qvm.40.1691630226045;
        Wed, 09 Aug 2023 18:17:06 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.229])
        by smtp.gmail.com with ESMTPSA id q10-20020a0c8cca000000b0063d366b0300sm96046qvb.89.2023.08.09.18.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 18:17:05 -0700 (PDT)
Message-ID: <64d43a91.0c0a0220.2d9ef.03cc@mx.google.com>
Date:   Wed, 09 Aug 2023 18:17:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7644786384907663093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
In-Reply-To: <20230809235622.1664227-1-luiz.dentz@gmail.com>
References: <20230809235622.1664227-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7644786384907663093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774728

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.17 seconds
CheckAllWarning               PASS      36.99 seconds
CheckSparse                   PASS      42.33 seconds
CheckSmatch                   PASS      114.33 seconds
BuildKernel32                 PASS      32.77 seconds
TestRunnerSetup               PASS      497.41 seconds
TestRunner_l2cap-tester       PASS      24.07 seconds
TestRunner_iso-tester         PASS      48.08 seconds
TestRunner_bnep-tester        PASS      10.83 seconds
TestRunner_mgmt-tester        PASS      217.70 seconds
TestRunner_rfcomm-tester      PASS      16.31 seconds
TestRunner_sco-tester         PASS      19.30 seconds
TestRunner_ioctl-tester       PASS      18.36 seconds
TestRunner_mesh-tester        PASS      13.48 seconds
TestRunner_smp-tester         PASS      14.60 seconds
TestRunner_userchan-tester    PASS      11.31 seconds
IncrementalBuild              PASS      30.92 seconds



---
Regards,
Linux Bluetooth


--===============7644786384907663093==--
