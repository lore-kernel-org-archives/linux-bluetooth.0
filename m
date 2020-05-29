Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 07:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B85207D4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 07:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhQlPSKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2HIe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2HIe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 03:08:34 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B5C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 00:08:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j7so630585qvp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ktkufbhdkmfONbYld1qnD7JcLycfWslp0Tan6AYveRw=;
        b=mhQlPSKFfAPowgqi3y3DyLbTwGDYgwgjq7b4iVbsTnpbMnvBUOW5FdI6d6DPIexihs
         BCfDcXKOaMkSa8t0b/soF7IbuJ00qeDNfjD6vjgoK2pXiL/J3LK+Tvo741n8YmukWplE
         nDTyuAzLyfck/3pafwvRFOLKLxxTb70KhxxbbuNEI3HywWrYTsyCKDjThbeYgT3Sn5kW
         Dmj5NGNLC1eb6blNWrX7xa+mLmNP+Kx49iOhLGaw6gyIavn5pTS78lq/IDFmoxhs/FhS
         qX+HTxgH5lLvpAVmTnIX5MhvTcBR+bEL+E+yjbyF4wyWyldZrWFfagZ0M8CTGH+QbJS+
         fL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ktkufbhdkmfONbYld1qnD7JcLycfWslp0Tan6AYveRw=;
        b=fAsZKhf/GEPdNjlZa0/MnD5uNGY2VgdaiwWIPswfxFTp47k5ma3ayw2bkXlmjhepEH
         jRWwLuKYLMYMxNOP/Uld3yB6cvnO04/WFCTzhbikXbj6tR7FLcF4WHtSCX16F//M4msl
         ARHpPJHH3dvWXNNvGExhNS4KVFNEoNgMgMZ+VxXBY7G9YxjyOHKTrO9uXk709RWJfT0s
         mpCrlJgT5sn3u5MqqE/f8ZapMHJylF9JxdzeGjaeCUiHdItIR6tcu9q0K9yu6Stg1UFR
         2I+yyoGi0xXeM6NGRxwPod94s+qVhhHqKavsw/QLeE9p0e1l30jPCcxW6rjC3fbZzXJ4
         k3Tw==
X-Gm-Message-State: AOAM530+PwiW3Z7ZSeR/1erfIrqQoFou4HQ5rRjlzFhCLz+HwaT7Q5Vs
        5T2BjFohxOaCwwdTKE7zR3CYt3BQ30g=
X-Google-Smtp-Source: ABdhPJwb2X+I9hIR/fjjaaLrXvjdqHQp2ubI+1qk++lxPb1p9g+3ijZc/tDtuwW9h2cxNNBs6rJSzQ==
X-Received: by 2002:a0c:fb0e:: with SMTP id c14mr7050935qvp.63.1590736112145;
        Fri, 29 May 2020 00:08:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.232.180])
        by smtp.gmail.com with ESMTPSA id e1sm7187351qto.51.2020.05.29.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:08:31 -0700 (PDT)
Message-ID: <5ed0b4ef.1c69fb81.82515.9cda@mx.google.com>
Date:   Fri, 29 May 2020 00:08:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7255856642865961908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,4/5] mesh: Clean up style in net.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529063750.186278-5-inga.stotland@intel.com>
References: <20200529063750.186278-5-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7255856642865961908==
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

--===============7255856642865961908==--
