Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4996AC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 10:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiHKKYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiHKKYA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 06:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DCAD255B3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660213438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CW1YBGJq5hbjGASaZL2gl+zXON3ocgAK7gzVHGlz8Y=;
        b=cONAzRK9YQy0cmvotCRe69zz1z39RXjDYVu84KQrAHGmLjZ9mfsWEV2rlM8cT301xlslf7
        fFP0gugMfOZMxH99DXJ/Pg1qIIOwykAh0Hmu8T+IsIgFvkpUjQWjvu6S6U3C+jk6jsQh1B
        QrbgAHcQg/1cbzrFJwFE9X4LBcwKov4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-JukYLyxrPpGF7kk9PeHoRA-1; Thu, 11 Aug 2022 06:23:57 -0400
X-MC-Unique: JukYLyxrPpGF7kk9PeHoRA-1
Received: by mail-wm1-f70.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so2761130wmq.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=4CW1YBGJq5hbjGASaZL2gl+zXON3ocgAK7gzVHGlz8Y=;
        b=W+XaSej8a2sQEjSUoWBD+m6jFKbJDzm4kbGGojxWbbPNtoOT7/A9FK+otrfZN4rWR2
         KFrQ2Q/9ucSv62xAtVbnkreqE37xplQOhhadXNYMe10tK99MdxSkIgyYoA3PlO3Fvamd
         av0JkwQ12yN/QbNrqo4lHmdfVkKqu+YCA7qVkCFviXmTtKR1BymX0FWxjg0l+csEzpJ/
         tdgwHPZAL7OgX7oMduUtXjRBljmQA49MCtebiTibxh9K7DDCaQ0AHr1I1vn7lydxNX2D
         yiKGI0PCubufrMFB6WUCMfSZViuD50v43wQc9oLKanKz335ouO485HOJw+A293PLGFHW
         ux+w==
X-Gm-Message-State: ACgBeo2KSoNb0vUa1vXF42WkykmL89oVWTqfsWebr3uOTpyijw4SVCSy
        Vwad3Oo+YG6TDAFKvwrldLFssJ/shCE+osurFrPF/t33BCP2t+47r/vwfDfPLHoVvu1quXcp5vc
        zghQc7tC3KYAngmQXWenJC7GVM50J2uR0xMaxNWZDkhjeUn1mGH6EGdQhwPXEbRzjd2iJWWDy9A
        ==
X-Received: by 2002:a05:600c:1e03:b0:3a3:6cd6:1d38 with SMTP id ay3-20020a05600c1e0300b003a36cd61d38mr5213379wmb.25.1660213436302;
        Thu, 11 Aug 2022 03:23:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6zXryMXMS7yWoym57wOsKPv7NIKgkrVCXuEIr40drEQ0JLzJO3OZZmdhh2bIx9ZojFiXufDw==
X-Received: by 2002:a05:600c:1e03:b0:3a3:6cd6:1d38 with SMTP id ay3-20020a05600c1e0300b003a36cd61d38mr5213370wmb.25.1660213436050;
        Thu, 11 Aug 2022 03:23:56 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0021b956da1dcsm18506177wrz.113.2022.08.11.03.23.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:23:55 -0700 (PDT)
Date:   Thu, 11 Aug 2022 06:23:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [v3] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811062309-mutt-send-email-mst@kernel.org>
References: <20220811094542.268519-1-mst@redhat.com>
 <62f4d567.9d0a0220.71d10.415e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f4d567.9d0a0220.71d10.415e@mx.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 11, 2022 at 03:09:43AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666822
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      1.28 seconds
> GitLint                       FAIL      0.72 seconds
> SubjectPrefix                 PASS      0.59 seconds
> BuildKernel                   PASS      38.37 seconds
> BuildKernel32                 PASS      34.59 seconds
> Incremental Build with patchesPASS      48.74 seconds
> TestRunner: Setup             PASS      566.46 seconds
> TestRunner: l2cap-tester      PASS      19.52 seconds
> TestRunner: bnep-tester       PASS      7.72 seconds
> TestRunner: mgmt-tester       PASS      116.56 seconds
> TestRunner: rfcomm-tester     PASS      11.25 seconds
> TestRunner: sco-tester        PASS      11.05 seconds
> TestRunner: smp-tester        PASS      11.04 seconds
> TestRunner: userchan-tester   PASS      7.86 seconds
> 
> Details
> ##############################
> Test: GitLint - FAIL - 0.72 seconds
> Run gitlint with rule in .gitlint
> [v3] Bluetooth: virtio_bt: fix device removal
> 36: B3 Line contains hard tab characters (\t): "	tkeaked commit log to make lines shorter"
> 38: B3 Line contains hard tab characters (\t): "	fixed error handling"


False positive: this is text after ---, it really should not be linted at all.

> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

