Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A78C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiI2T32 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiI2T30 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:29:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D815D653
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:29:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g23so1422262qtu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+XVV0TXtF7oJIVINMX9dajh51ucbvqiCorJ0x2rmiVg=;
        b=bH0ybejE6HMoqWl+cEvXfDu4IiC4rP+XLl0l4odno2/9q1iYDWUiqZIViUg28mI42g
         jnrEYfTcPcS95ehN0O7wLl7fQf/FwHiOxcSlW9hGuO+tu3bLOl/+yW7ncfX0n66G6Pag
         22VgIRRnqn5tm1R9CxvuxEUI8kHvzQG6xsccQ28+ZQ/Lx3UI37N9bVCwTeTjTUT2E57q
         ztbvxZfgx13hPI0avmh1RADdt01vAxgaBl+mVwE1MswgXa/xs50JX8eAQf6TShrxJvAd
         fVvMMX6hw92Cgrgk5lFgkpM0yIsfyVHrlmSfiLBkw5tjJpUVqvBzgr64xRcX7eAmbhBC
         k10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+XVV0TXtF7oJIVINMX9dajh51ucbvqiCorJ0x2rmiVg=;
        b=A+LnqFQCtgo1yqA08PhSXAdtI0BNlRwWCDRD8eC1fOS330VCM5AHKUuoYUALDiHzTI
         qOatkihXS+CRZjk9VDLuq518fq8oiEGWtg9CzHQncc8SjO9ntv3XfUi1fhb9TYJWiF3j
         PUHAPHRHMcjrbGp0MNjX1gjb3YcRZwI88IsK8qZXa89SCcwKlrHMHMUycsP3i2A9YZAO
         Go2mQ7FwXibjSpnbdyaJiXNz7YN0SH4ltLLjqGfhggiQjv6vqpXmGKrdMO0q/afzxlCP
         s6FrSHogycrPuIc/cvbn3N8jcgwOuTfRLlFBI/TTrzrzYHGpj2KZLTJwdsKY0sB2Zcnd
         OzMg==
X-Gm-Message-State: ACrzQf2t2vGjgEXgfBP8sge7y/JmmbpP+MvNzGxCFufYUTzqMJiay/H0
        46/Sjjg/xZwiitIzPLHxlxaegZa11eLJZA==
X-Google-Smtp-Source: AMsMyM7V4KW4V5u+8i5MyU6pwLqD7mo9RiTCruMzhXa4F+E2USTJEFMn9ukmy85ebn8oKwjdzC5JJA==
X-Received: by 2002:a05:622a:145:b0:35d:43f7:cb21 with SMTP id v5-20020a05622a014500b0035d43f7cb21mr3794583qtw.202.1664479764999;
        Thu, 29 Sep 2022 12:29:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.236.82])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a254600b0069fe1dfbeffsm195512qko.92.2022.09.29.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:29:24 -0700 (PDT)
Message-ID: <6335f214.050a0220.7e5d0.0adc@mx.google.com>
Date:   Thu, 29 Sep 2022 12:29:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6279815167755830173=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6279815167755830173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6279815167755830173==--
