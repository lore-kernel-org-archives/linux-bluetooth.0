Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE2C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 00:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJVASw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJVASv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 20:18:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3248A0D
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 17:18:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 67so4037255pfz.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rTzaXDlI5hMsuguY/CPEJEUdRCXdq9VwciN0sLuJAxc=;
        b=XWYid4OIq+4S2D7z50n34qR8ifO1KC1kGKCmwmSrvrud8sTqLI7Y6lk/AID5LbacSQ
         A0q/6nrjr6TZhm5VFISQns4WmrzcZZyaec6uaxAAkFvhtm9AJ6AAJSixV3wNNqm6Zl2l
         095Bu+WjyiFeVHzhJ8WWZZkgrU5HqertrMZygeOdnq/w7cATfYxjZKt1JjzxIzpRzVhq
         UqhPlGnziYdZPplzHH9qHMV0me+pnMxs3TI0g3nUh8jz4su13UTAJ+OC8AqSi4nr9mhq
         aYBxW3DkxhgmdRNM6GoFFrkp+qB4CJ14wR5ITDp3fakV83S+a5HEUKyatOFyuuGbazwj
         xZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTzaXDlI5hMsuguY/CPEJEUdRCXdq9VwciN0sLuJAxc=;
        b=S6IbZcZ5t2h2Zg7ltSTNSvQVvBv47eeSwBmonnr3nZnRWaJ1ijGLQMufqAx4sUApj9
         bZYH96MwbVOy7NCcx4aAIuiwIgsTL5uH0f8MFZoee5qP0qex34O/VUift2BCouELhbPX
         7wOfI2g0KN0KoajvsReVI/+xSpsN+CcwoRFkINJyRVtFxEGX28rTJEmFA0JPg6PYix5B
         gSTYnS33deYPv6DgIVDEiM0en4N01LpvCrre/p92Ei9vYudO15StsrUcmkLcqwOdE5qu
         FwcJKLL7Xob4zMjAkx0MW1uPYFo0b1a/Yt4FkjpjCywjKGnCIN3KJS2hxRbB9XKmKOGa
         Iv7w==
X-Gm-Message-State: ACrzQf0fW1jEt4x+8WB6879641bWQIq2QaACCs5tf5Sjt7SUDvAyix1t
        m2bWa9aZ5RwNi7PRIOc/e4VdRgr0LN4=
X-Google-Smtp-Source: AMsMyM7y8puzP6oL8vQ4AWKG22le34u1WAo3Tbuoe6cd87hZWxsHJNXjgM3OkL9fiQEYqpCx4V0VfQ==
X-Received: by 2002:a63:4e08:0:b0:438:9514:48b3 with SMTP id c8-20020a634e08000000b00438951448b3mr18557177pgb.439.1666397929434;
        Fri, 21 Oct 2022 17:18:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.118.149.139])
        by smtp.gmail.com with ESMTPSA id k126-20020a632484000000b0046b2ebb0a52sm12802043pgk.17.2022.10.21.17.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 17:18:49 -0700 (PDT)
Message-ID: <635336e9.630a0220.3bea7.8348@mx.google.com>
Date:   Fri, 21 Oct 2022 17:18:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4882489858111145177=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221021234617.28848-1-inga.stotland@intel.com>
References: <20221021234617.28848-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4882489858111145177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687718

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      43.52 seconds
BuildKernel32                 PASS      38.52 seconds
Incremental Build with patchesPASS      57.31 seconds
TestRunner: Setup             PASS      629.88 seconds
TestRunner: l2cap-tester      PASS      20.01 seconds
TestRunner: iso-tester        PASS      20.06 seconds
TestRunner: bnep-tester       PASS      7.60 seconds
TestRunner: mgmt-tester       PASS      126.26 seconds
TestRunner: rfcomm-tester     PASS      12.24 seconds
TestRunner: sco-tester        PASS      11.24 seconds
TestRunner: ioctl-tester      PASS      12.99 seconds
TestRunner: mesh-tester       PASS      9.48 seconds
TestRunner: smp-tester        PASS      11.29 seconds
TestRunner: userchan-tester   PASS      8.17 seconds



---
Regards,
Linux Bluetooth


--===============4882489858111145177==--
