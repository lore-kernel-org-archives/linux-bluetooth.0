Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4114DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 08:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiCWIu7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiCWIu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 04:50:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6594710E6
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 01:49:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k7so715443qvc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=KH8InULThuU+BTJrlvIcm8h6fXKZoJXUM0u8I4Kyey0=;
        b=a/Aqqd0jrO4t//u5ZykUFIvFqpZeWILCYom5PL6MWmN6i7d487+1k2l1UUiffqvZx3
         lR329LKu+xWebO0Skk/PboYi5x+NNHMWobZN9Rv2Qt5Ufb9yzgJRnu9wevbsD1XdanYF
         X8ekRvi9WUPdE4QiC7PYoxk0eh6xinXDGy3Sm06F2CZQc2e4JvCBrnvHeh5x4lt4CORc
         K1e16/Sbf915Sdn2OL9DQkFi/aiy9NREYWsnQ3ID1Ig1zOMIrc2aGf66zLzW5swLQQgu
         ZLouKO+UFvA9ZJMUEzQJWAtnzySM/8aOCuVAG61qtcFd+fLXgHSkfdesY4oQrGhbW3bd
         F9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=KH8InULThuU+BTJrlvIcm8h6fXKZoJXUM0u8I4Kyey0=;
        b=RFNtz7WimEg74+PTUXfGqG0ZkgEnKWLgVTYhx28iJNn/ObvBTN8cFY6ITKo5aQiB1j
         hdJnaulMT1RgcDHW4wGSUvKr7GBbhNYGP/h3KuYorirYQ2tnGJH/2EH4PLmPOomXu7v0
         tN0fjZx2x0v22bslMk44mMZjdXIWjgb/nmEpqZ6CYOos3h6fMhRHSR85lx8gmubmnOT9
         H3jn5mCR12N0hRWw0ni1WT6JfXGwY/UrAEvDEn2IOuLk+/5zCkqj1IzwVlu+U2zeuHTt
         PkF15oy1KwMg5EFzN1zJQe6ifa9BfhKp+lshbqpfKV/QKOLZQUo9Tc3IzG5eAltGQOcs
         7jDA==
X-Gm-Message-State: AOAM533W7mjMt8ne+MhtrDgT19+UG3mvlb2n/FNMWhZsomKFjyt/EHcr
        2rT6UTuqwZ/Lxh9uD2lkV12o07nH5PYTyg==
X-Google-Smtp-Source: ABdhPJz4BufuSu9mv8NCYOHEB7RrRaFAhrhnb+plBbF51cQGMCLlPnT1WTMCeoQZMZryKjsmCOg/lg==
X-Received: by 2002:a05:6214:224f:b0:43f:cd6a:1d6b with SMTP id c15-20020a056214224f00b0043fcd6a1d6bmr22618562qvc.12.1648025368881;
        Wed, 23 Mar 2022 01:49:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.241.109])
        by smtp.gmail.com with ESMTPSA id b126-20020a376784000000b0067d21404704sm9983485qkc.131.2022.03.23.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:49:28 -0700 (PDT)
Message-ID: <623adf18.1c69fb81.66f4.6592@mx.google.com>
Date:   Wed, 23 Mar 2022 01:49:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3863232852182858732=="
MIME-Version: 1.0
Subject: =?utf-8?b?UkU6IOWbnuWkjTogW1BBVENIXSBCbHVldG9vdGg6IG10NzkyMXM6IGZpeCBhIE5VTEwgY2hlY2s=?=
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yake.yang@mediatek.com
In-Reply-To: <TYZPR03MB5278324850B998139A88B30482189@TYZPR03MB5278.apcprd03.prod.outlook.com>
References: <TYZPR03MB5278324850B998139A88B30482189@TYZPR03MB5278.apcprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3863232852182858732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: cannot convert from eucgb2312_cn to UTF-8
error: cannot convert from eucgb2312_cn to UTF-8
fatal: could not parse patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3863232852182858732==--
