Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC79DC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944FA6100C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhGVOBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVOBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 10:01:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD0C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 07:42:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x24so3927624ljm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lnZ6Y0OTHt96qItLs6yg95ugZMUGh5/BVyNiweYbsvE=;
        b=QZcUfiedvMOhjhYMEOzpHNPY6txRK8E0f3kcF6O+CkxRWhebVg6LanJ31J9bnMCTdY
         qF2ynSs8iOTxQM8KJIVq1oPfhP3ALLx+mgu7gsKPYLbto8GTzbpRrQgzCv+v+1hxbRKa
         DVFhCuVO39DVvikTPgMi2NVpNQ0B/1uDewaAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lnZ6Y0OTHt96qItLs6yg95ugZMUGh5/BVyNiweYbsvE=;
        b=t+Jr93m4VLz1cihm/GV5NVhrrBO/AKDAFZDfaJ984QrCeZ4wQ57HL12HqdJSxPQH2t
         EDvvj48yDtjRG1y20QHRlDewMRa9meMFWj+mSh0FLrqymfd61SFA6EDnDum6oMa5dn8p
         YDbQq9fJE5suIsgwdKPO/W2/HmDviJ/FNKCx/Y15grORxSz1cRytHmuviNujSmTyNfWx
         Wsdrrj7GIot5WMDG1M+J27d2hp3kOJNhhcoAJLBN/IRXah+GuSmfS38OpId/WdAw72Uj
         /Xu01u+oOMNaNHAGc6vBAIBSNMbf+N82Ys7q25H3rkDVb7A9wTJUpXJkxJe/+p65ZMky
         94xw==
X-Gm-Message-State: AOAM5317mwSuKt/BEpXMJOcs65m/51yV486fD0LOwvGAmgvr350fzkWL
        RhUt5bQ2FH4IxIvp8sZy1n3625yGWZrqPuPJdEp3dA==
X-Google-Smtp-Source: ABdhPJwQyiasNG78Zd437qTFw3hLIozTK1rUo27LtcrqlOcLyxLP1W6HnGG7eO3uPC9K/JDhEtgwKQ==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr241756ljm.290.1626964934666;
        Thu, 22 Jul 2021 07:42:14 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id f12sm1994395lfu.67.2021.07.22.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:42:14 -0700 (PDT)
Date:   Thu, 22 Jul 2021 16:42:12 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT
 3 for WBS
Message-ID: <YPmDxETlABDcAXXF@larwa.hq.kempniu.pl>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
 <YPly1RR8V33T3odj@larwa.hq.kempniu.pl>
 <f32df70b9aaccfbb471a6305c5b4884ae14dede3.camel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f32df70b9aaccfbb471a6305c5b4884ae14dede3.camel@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pauli,

> Thanks for testing! What userspace software did you use? Pulseaudio at
> least I think had assumption that mtu <= 60, which breaks here
> (Pipewire works, don't know about bluez-alsa). If otherwise, maybe it
> then needs also the manufacturer flag.

I am using Pipewire 0.3.32.

When I wrote "this adapter (...) reports an SCO MTU of 96 bytes" in my
previous message, I meant that this was the value present in
hdev->sco_mtu around the problematic code location.  If this was the
wrong thing to take a look at, please let me know.

-- 
Best regards,
Michał Kępień
