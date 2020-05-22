Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 01:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910E22072C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 01:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG5tbgvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgEVBNB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 21:13:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16EC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 18:12:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i14so9230117qka.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 18:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KHW80Cb5yjguPJuXi1ycuqAfPzQ0yKpv69yDVBrv2ls=;
        b=AG5tbgvNOG3+L3tEJ9jZ+nedYbFEWgZ4zqb75CaTVIhzWLsV78psRElCdGp/llOveP
         mXGghC9cZ0lpeyV/YaSGtHVRZivvboqcV+KfpNUBkamVnw6yW3/HiJA09IJFlQ+kK4nD
         QlrAPKnUJJKiofztq9epogOb5nhOOjv55Ysruwlot/3iU2gT46n/9VkC8VTNRV6BBFTi
         Gd5j8r3BhGYLvJRFjE/GybyNHI6vT9pIfcAtxU0Jjzfb+yYjS/vfSlmdwu5cC8tFf4IP
         riqx6pu0BBU4KGVstCMdAWLNH76k1D/EbdZ4jCtqJkF8wlaCMYG/ClvHLl1P5kUGA+bu
         UUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KHW80Cb5yjguPJuXi1ycuqAfPzQ0yKpv69yDVBrv2ls=;
        b=Ki00FNND02GfcDA43p0sBGS09w2rWz+mwSsaVMvDTDJzXBXzZlDjj7CUxKQngQhLru
         ywWlIaaQmp4aQWV3sOc++2ToD9jTwtMk26VKC0qu03AnH3SSoOat/JziAzGOKZ4VulAU
         gbQM5KQg7pdl20IK87QMbAc1daJZpuTj+5eIsTAYyhAN7x7CtI2ZN6W5mvwL8zPjS+qN
         OvO9Rc0C+1oMVkNHd54w+tal+exfjyYxyUddKDi7yxo66Rs2OMsiFCwsc4u9uNPyanLc
         azYCtgBvZhW1DWyoxpbPYr2Msn1+ycthwSdU0dlx+K58vzEsg/9UH0ZCysnUP80yMcAX
         yFyg==
X-Gm-Message-State: AOAM532p+RiPg9XR1tcsogTdCzw0znqUUsTj62e7wC3DMWVKOwsNW7Q2
        Ji7f+dISxbC65B+9ZGpOjWhzcdoO790=
X-Google-Smtp-Source: ABdhPJzC9OtxT5CPEiEvO3KW15yZGM+3UjMqt5qrsxS99v0O2sTsNSi4s9xSTLLfoAsSKK4ukNjA8g==
X-Received: by 2002:a05:620a:2110:: with SMTP id l16mr6440056qkl.290.1590109978690;
        Thu, 21 May 2020 18:12:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.240.118])
        by smtp.gmail.com with ESMTPSA id i3sm6263403qkf.39.2020.05.21.18.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 18:12:58 -0700 (PDT)
Message-ID: <5ec7271a.1c69fb81.197ba.579d@mx.google.com>
Date:   Thu, 21 May 2020 18:12:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4909538740328797776=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,05/10] mesh: Remove unused function prototypes from node.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522003501.106165-6-inga.stotland@intel.com>
References: <20200522003501.106165-6-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4909538740328797776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============4909538740328797776==--
