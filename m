Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiI2TuB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiI2Tt7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:49:59 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D75C9E9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:49:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m81so2696854oia.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=oPIpVFu03EKtBs2qRJ1ghMofEVTkbLnUBpShEWZPhBo=;
        b=W22iLyGG5dY9ykvVGRlCHR+kWEgnacAd7E2+n9PV3/QvvMszbY3AbAgYwWwNMZX/8t
         J9o8oBDpECCo7pHpKLPz7lXHD2PVjYl8TxCm36OljIhAoXJChL8ln9PfyzZ9MX4tjY3I
         FS9UH5SPn9BFW2N+G4y5e5UvYdHuXdmHewaLkXDfMralBwIpoKvu/dQekJXLs/oB5yZ6
         l8C1kXakg6wixPx5YLM4lA0WdHPkPWEelhoHHq9EGEIkAUuSwO/icjFkSuBnbHdGXYHS
         oSjo82GqZS60eJLUmu8WE6uu4nmcEOZTqeM4pTp7AlUEwZWH/sPVTnd51elhgdYoz8BE
         psQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=oPIpVFu03EKtBs2qRJ1ghMofEVTkbLnUBpShEWZPhBo=;
        b=BuXfewtaOarmDs5UVmqBmj7KgYGTnZ0osQsjt0OcUDIUakamLYZVh6sTowbrw6vXTs
         3fWbGkYWYHy2BVU+eHoGP+nBFtg78hggKEFAkAmcZ3JKGzjdIUqEU15SUXcTE8Yyb3mH
         6mGEqVh9esg3Q1Nf2VG3pjPvevu308btSgQyPTzr2ivQ1dueYgCCg+8B9qTniiEasW8l
         7qm9B1XBgXUhivoMxlZPhdMnr8yq3r66RBfeS9+5afdDRnvwz2+xVFo+u/DS4l/5DYXX
         JyQNRjvFP9YkpTml1YgT9a6eV3GXoA0Iky5/ydRUCxq5idN8hyAWy9sMH6PiBRf025x4
         rqsg==
X-Gm-Message-State: ACrzQf0Q9FKk+P7p4sNSvOs4/OyPURgsrNvct3NI7rezYhdgYukFSEMj
        L9CbSSLRIX0Xm9qJCrwK+obM9Pm51fA=
X-Google-Smtp-Source: AMsMyM63Y2VUfGjweQSNk/ewljvKtyIsdU6qqN7B5hIWKsHC1fL+iqq1CJ2lFH6JD422A2gVkfp5wg==
X-Received: by 2002:a05:6808:148:b0:350:5a3c:4766 with SMTP id h8-20020a056808014800b003505a3c4766mr2325936oie.6.1664480997484;
        Thu, 29 Sep 2022 12:49:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.235.34])
        by smtp.gmail.com with ESMTPSA id n9-20020a4ac709000000b00425806a20f5sm92859ooq.3.2022.09.29.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:49:57 -0700 (PDT)
Message-ID: <6335f6e5.4a0a0220.d0ca5.0657@mx.google.com>
Date:   Thu, 29 Sep 2022 12:49:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8080590841301015372=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8080590841301015372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8080590841301015372==--
