Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54435C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Nov 2022 08:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKXIow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKXIov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Nov 2022 03:44:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ACB8FFBC
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 00:44:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 62so1008629pgb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 00:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CfvPP6nBLP+a7QOb15Z/SSp0285yYyt/9QEDSKLW6Do=;
        b=egNQKK0gUDI3/0OMl6Qr79+P9JAMfC4oWVnGGY+2MvXqsHmPJEY6nBwNOeR98iRacG
         Pbcr2G9k6ONArFUEewoGEMjQgtQdBtZEknHU7NVoAwhg6HAElXUR4Ra1CczyDcuM4vv0
         zowaGZ7Yxmaw/0EUrEQaI2Bt6N51NF6MLoMXaq5bhFFpXS0nm8JuOcG8pFxbcZwF3d8H
         vGK/j7KcXOJLcFjup1EICyOG5MeK8mCU30UmSiir70XNvSiuqFNabTxLWScyTFKnELcC
         tMx6pp0dbEZYxPxJ01Lz0IlYilLVcdPHry0ftB7k/jMbw+360hjWW/edPiPYE6fkvwCH
         GiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfvPP6nBLP+a7QOb15Z/SSp0285yYyt/9QEDSKLW6Do=;
        b=NiaWj2B1CcPzqmINguBTwynD6m72Dn8LI3qeLsN6IpTUBycalaguwUvpij9Ngz1202
         /8ce1ND7kWvPU9LhFWTl2lT/XacRMA+MjmffTliBbYjd0vMgPwj8W3sApaCSE8v/lJ0i
         wvS2y9hK/W+SHMj4ftkhBcKJTO/EaYKfc4+d3LqyBlwfiMX3sEAe+GXcz/XuqqMTzG35
         PZJkw+TGaSjBMbUHRa/neYHe7eMSUDYTboO8pD1idiTAprAC8/vqhueIpaS6JOSzBcwd
         hODEiG80XNeLcoDOHdXZdenkKuI67hx9CPXkvdPaw5/n2X3YTKMgc5TO0gaWj+abZyT9
         kJFg==
X-Gm-Message-State: ANoB5pl039yvNV80tuIngPTjw1gypQsp5b1Osj+eM2qFLCIHn5kmoIlT
        ilcy+lEHRfhRV0wdBs55+FEg0uR884k=
X-Google-Smtp-Source: AA0mqf5O+Or9hBQ3WzpL5laOXyDTNNip2addxt6bVMccn6FDreiXf1YOsL8Xdn5K5H9ex7CmQ8Pj5g==
X-Received: by 2002:a63:5042:0:b0:46f:e658:a8ff with SMTP id q2-20020a635042000000b0046fe658a8ffmr14615033pgl.493.1669279488163;
        Thu, 24 Nov 2022 00:44:48 -0800 (PST)
Received: from [172.17.0.2] ([20.245.234.184])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b00186fa988a13sm660350pld.166.2022.11.24.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 00:44:47 -0800 (PST)
Message-ID: <637f2eff.170a0220.dec89.0b1a@mx.google.com>
Date:   Thu, 24 Nov 2022 00:44:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8240151066609535528=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tglx@linutronix.de
Subject: RE: [V3.1,12/17] timers: Silently ignore timers with a NULL function
In-Reply-To: <87wn7kdann.ffs@tglx>
References: <87wn7kdann.ffs@tglx>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8240151066609535528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: kernel/time/timer.c:1128
error: kernel/time/timer.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8240151066609535528==--
