Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F4C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806A964E15
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 03:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBKDgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBKDgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 22:36:12 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798AC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 19:35:32 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t63so4041063qkc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 19:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=W5Oq5NZVXSGd8ah2J92N4gtz/6X70Ugm2yYYZ+jMBfw=;
        b=EUOynwa13LhZjWBygDcsuJ0OZmdnKZu+xVnbWZ/zIwrrFeBNVEoUCfoH1X9fieaa//
         K0h0W4hCcjdD6DdtVoK6le0zW0b4pB5SLzFeUzd7HDiHXkEXQOQ4eOo0m+gggGl01L8J
         7HS+jB2FZOIcXIJz8JwhxWKHUugMpjSEZ2bBVc0H1k6PLP0HR1K3v3Qk2Zla1D3BROYY
         k6DL/XZlvubSYxDqWh7I89vzZ0Qk9gXMGEdH0rUqxqCkuIwoWbPBC6Hyv3fNtCYoDV3R
         AVBVm4HuKk+FLQUp3V2ncDjMidVkLQYAWPZkKeRjIG8MELwMlcyBV/FEEPfKa+bjlg27
         pA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=W5Oq5NZVXSGd8ah2J92N4gtz/6X70Ugm2yYYZ+jMBfw=;
        b=CZdpfeS3ud+D0flRICCM5vqsOq3pU5NTLzD1xKzSntUm2EHp9XvRYxSbHpbpUaL5AN
         B33g8XjcuHXfaLMzNFBMAtn0KPTp1pz6fiT2/DOJ9AAJD0aw+Up4QBlQ7Gh2jKY/8H49
         4LWDP00LsHyMTdffes0qbCInsZ67H6Dv1QZZBIL3Qx4oOQPXZ3cr9D1smvNanoCXX/Wx
         /29OWFQbUQUUs0fPgWU/NFcioY8Lb7VWln4eCpn/zcM/FISMhUKTcH1QuQI7sX1xKj6a
         Rs1MbBXzzn1Innfnr4wh0UO98C/rFsKPl0yxPU5PSt2HRY9LDyYNwKrHJJToV1kD3mVh
         +W+Q==
X-Gm-Message-State: AOAM530A+f+VrQdMW9rr2k97uH3b2sk1ZmxjKkArKD+m0LR6w5TewP9q
        ZcPUYvsSqjyq7GeuceVk6SI/l8wftGk=
X-Google-Smtp-Source: ABdhPJz4rTjTVaoT0gRg+j1708g/Ooi3PP4O1hC3NAuG033PtzVO52rJorIMRlE8x9jiSZVzPfKXVw==
X-Received: by 2002:a05:620a:a4f:: with SMTP id j15mr1930637qka.419.1613014531671;
        Wed, 10 Feb 2021 19:35:31 -0800 (PST)
Received: from [172.17.0.2] ([13.77.106.98])
        by smtp.gmail.com with ESMTPSA id x4sm2859541qkx.136.2021.02.10.19.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:35:31 -0800 (PST)
Message-ID: <6024a603.1c69fb81.a4360.1e64@mx.google.com>
Date:   Wed, 10 Feb 2021 19:35:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3512468215731017536=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Clear node's agent pointer after agent removal
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210211025558.11791-1-inga.stotland@intel.com>
References: <20210211025558.11791-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3512468215731017536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=431923

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3512468215731017536==--
