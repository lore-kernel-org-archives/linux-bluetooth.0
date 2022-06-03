Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FAEC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 09:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbiFCJEF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 05:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFCJED (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 05:04:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69467381B6
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 02:04:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o73so500743qke.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ADgnatRH2P5Oy6FUfxNhqrx5EMGqgzTOobUQ+iCDDw4=;
        b=Xbf7Ti9jTks+FwM8shnhRmj6FPYvOZM7mB5fl9sN+G9JmiWuwynjrBd5mjI76bIyKl
         q2CV3CvhZb2TUz77oYsrrSVtc8zJ+27vQ6MsB9vfgd6HXXLsXS6VerfdmBxkjU1xgldK
         wpyug4K34cfx5uzhkPfMU3smkpprMmcppOIMjHNZTutZmqYEYyqHKPlQJPvkkliPqbv3
         S/r2r7RU6NAWL7ewWQI+OosBu6Cs+VMYK4Bq65mN8OzW2zwMYkEa0fhGvjclMWFkWSLi
         hNMZRCE8y49sCyaEAr6n//xoOzqL5gx/6D4iK//zSd26nOWbT+FQr1Zc96Oa459ABo06
         swtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ADgnatRH2P5Oy6FUfxNhqrx5EMGqgzTOobUQ+iCDDw4=;
        b=7HSspSGeLmFtZw+V3N6qYnnl5QWw4u3c4jD4Qd4DWUZWqo6gDfEAww3vL02gglr3q9
         1qn/qlUB4T4gbAV6bs7mLclggmKGDKoPxyaDmMUN+E3FEBNk4GpH95a7T4BAjo78CpnU
         nop+6NJCKJhgCshVE3JV1ZEdP2icb5QeHN+djveTAnGE95YbtEc3fABWk31Gz7yi2C+l
         bBZmVySvUrBBXaGIbz/I1vbLAi+TKxM5NviTWsBwIIzX1oE1c7jBc8TIapGR8KhMOX+O
         0GSSq+622fejnPAAWMq0mRuxRfb8r+kUtTDDmchycFbEepif2L+WGQtlkiNbayn3pvjH
         wspw==
X-Gm-Message-State: AOAM530QX9ReY6T6Ba3+grbv2eAVa5lG9nnlZygT0SJlB9eoYmnwP5ZH
        W/L7msCHuN9rwQhm946WK3tpCRXEvZQ=
X-Google-Smtp-Source: ABdhPJz5Iv5tqDaSankAv/Gs4N1TEkb8Yw3NX9tJp9ak9Hx+2qGHIFkTo+aTfhapOs3ZftZip+8fbw==
X-Received: by 2002:a05:620a:461e:b0:6a5:b906:ad92 with SMTP id br30-20020a05620a461e00b006a5b906ad92mr5607635qkb.261.1654247040411;
        Fri, 03 Jun 2022 02:04:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.11.245])
        by smtp.gmail.com with ESMTPSA id r12-20020ac8424c000000b00304dec6452csm1037908qtm.78.2022.06.03.02.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:04:00 -0700 (PDT)
Message-ID: <6299ce80.1c69fb81.334ba.44a8@mx.google.com>
Date:   Fri, 03 Jun 2022 02:04:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8488051347786833953=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, schspa@gmail.com
Subject: RE: [v3] Bluetooth: When HCI work queue is drained, only queue chained work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220603081914.42512-1-schspa@gmail.com>
References: <20220603081914.42512-1-schspa@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8488051347786833953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647101

---Test result---

Test Summary:
CheckPatch                    PASS      1.88 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      30.46 seconds
BuildKernel32                 PASS      27.47 seconds
Incremental Build with patchesPASS      38.46 seconds
TestRunner: Setup             PASS      449.95 seconds
TestRunner: l2cap-tester      PASS      16.39 seconds
TestRunner: bnep-tester       PASS      5.83 seconds
TestRunner: mgmt-tester       PASS      98.99 seconds
TestRunner: rfcomm-tester     PASS      9.42 seconds
TestRunner: sco-tester        PASS      9.15 seconds
TestRunner: smp-tester        PASS      8.97 seconds
TestRunner: userchan-tester   PASS      6.00 seconds



---
Regards,
Linux Bluetooth


--===============8488051347786833953==--
