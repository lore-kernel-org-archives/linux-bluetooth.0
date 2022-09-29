Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiI2T3V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiI2T3O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:29:14 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9316F9D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:29:13 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j10so1421228qtv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=hlGCSKpPAnZClDiImlA0AowHESzZ2Fp8F3gjWIAuawo=;
        b=kBhUos1Ez0bB5LR8t6VX1gpVkByvrLe2Kae0XnuBVZW0uOaZ8nAWwuXd+KEloyRoiv
         y9tvyUYCmThVLweMf+kLggxU7Bbr6gqAc4DJ+cvtodmscBDUzXJNKfybFWSq/B6vZSmH
         bpTfBEuU0li65CuEHQUP2Fr/kCMZOnnXlG8p/sN5R+mEj1lwnfJiwU329sEejIEZh1rh
         OJwEmSfZBGGEWvYFFOVAlUmmvrwUwLvrxqlpYJuADrrv7VZbsQ+Klq/nn7/tPXkDGkKR
         keszq2AZxj2nnsPCPP8SJTLQP7oPYM+hwXg/fVFenWWVYmjLoGCV9CxRUFxauZoUr0KP
         wX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hlGCSKpPAnZClDiImlA0AowHESzZ2Fp8F3gjWIAuawo=;
        b=K+LzgctPjCr07soQt3ZpDHZe5lcmBcwNb31RjMo9ZC9wgK/6hho3Zl8m2ZKVkho/LP
         ABz48KOVKcIDurwVjpVOkai0/3QNzmQ27M0J65/T4BjWc4gPT0ZA81LruORdtxd65xXF
         c/z9Vfbf31e54xFjgrnuLGaeE8N+0jewYsYmltcLy4wkn32IEwyr5ciCffYCuwrQ81Mf
         ik84K/WbvjJLUEq4oD2dExFJsVmQpv2iY79tb2SP+qutu04XUGfHoNPRjmlIDBzB/xGw
         X+iMKqxgJ9w39REmbgMsOLWDzV2hODm1s7bWzUgplVt2UdNr7YRyj1OQ9W/rj2nugjZ0
         1KZw==
X-Gm-Message-State: ACrzQf3aCiSGDu+NifBqUEuFgO39erpwTDLMpW8axxTyW/45PFGvw7Hv
        tIcTT3Xsj447ksw8MRy2B5Yu1UwFPmkCZg==
X-Google-Smtp-Source: AMsMyM7fkuqE83OR3sOEI9SmtoR3hvzQn4HfKXvoKYOrfyC/NEhFb/wJrVxrURRZ1c92fq2QSH0Hxw==
X-Received: by 2002:ac8:7d46:0:b0:35c:d831:5237 with SMTP id h6-20020ac87d46000000b0035cd8315237mr3718060qtb.639.1664479751467;
        Thu, 29 Sep 2022 12:29:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.236.82])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b006b95b0a714esm273713qko.17.2022.09.29.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:29:10 -0700 (PDT)
Message-ID: <6335f206.050a0220.a8cee.11ff@mx.google.com>
Date:   Thu, 29 Sep 2022 12:29:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9127235120677614525=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9127235120677614525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9127235120677614525==--
