Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 14:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiCBOOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOOd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 09:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0B9CAEF0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGmuz8udOyL8rcNnLPnBOYv5OxygyY0n3rMmTqllwTQ=;
        b=GjZ0O3E28NfYCDTqB5Ji/crkWOZjXxKQ+LSm9fnEaiKu6JQr3wk7MRgjcsRm6tgWxioGaX
        cVU8lzGT1JGVHWvta7P27JjXMbHizBkz1zSzo4q+G2PE7/yquc294Lu3m/myKbHdKRf3SK
        xENhrlYOwvVtqo3/AI+Pop6QKFhLTqs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-RIpFt3Q7Mh2rKfE0ln0-uA-1; Wed, 02 Mar 2022 09:13:47 -0500
X-MC-Unique: RIpFt3Q7Mh2rKfE0ln0-uA-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso1068288edh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 06:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mGmuz8udOyL8rcNnLPnBOYv5OxygyY0n3rMmTqllwTQ=;
        b=ow5/pi7GaXWHIjJ5p0y765I0xSqAio/9YR7hLz82fMEKA3WTOdzGxhqHb3qqF27Rf9
         LA8wIbE38gp2nqmaTVpKZVPFld9xENhIIuAp+/1cDbLPPoak5j4j4GLnM8M7bWMQK88z
         qeKpK0g+dYQZlTMC+hgMqOuI7I3ecT/9RacslrAYxufJm/oy3uF5hD/CxrcuNQhnZPAe
         trP/OcU+mHMxmzwIAPOfZ0Hi/L/w6VNplAic4DTYSXLGviaIRw8rMtsUTDL7UC01MkW+
         KfQYdm8yWaaic44IvkVJfg9dNWoA/2n2PPqDLIftHw8sRndjHJawlqMxXeuEmhp7sWKU
         vvMQ==
X-Gm-Message-State: AOAM533J3cx764e9YltdOTiYs9zVTH9BsWRwfbQHb8Mzl5nY/umfU/e7
        7/Hax6t87/Rhoz6fjMN3zf7BF0rmHzhHmZjoYN4q8GB3QtzH2fHxkYlC+t3dGYEDXX3/ni8Efio
        EsPJqZf5S8YtOTMXZSF4e/Zw6CSssY3xX8SXX1n+sxzV46L3d1ORVINhXWIpEupgT+qDby6pgrA
        lj7h16
X-Received: by 2002:a05:6402:3719:b0:412:fc6b:f271 with SMTP id ek25-20020a056402371900b00412fc6bf271mr29560244edb.345.1646230426519;
        Wed, 02 Mar 2022 06:13:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAAu+xa0nY5Oa/poY/MxYUTOBL2dU3TUcvwJ0Ecfj9cdry/mHPcfewKvwqQTlMrrTBMSsM+w==
X-Received: by 2002:a05:6402:3719:b0:412:fc6b:f271 with SMTP id ek25-20020a056402371900b00412fc6bf271mr29560221edb.345.1646230426172;
        Wed, 02 Mar 2022 06:13:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ga25-20020a170906b85900b006b50ae27c2csm6319104ejb.154.2022.03.02.06.13.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:13:45 -0800 (PST)
Message-ID: <fe9f0d40-bfda-3048-273a-bce2b0cbfa3a@redhat.com>
Date:   Wed, 2 Mar 2022 15:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
References: <20220302134439.515377-1-hdegoede@redhat.com>
 <621f7aae.1c69fb81.1e0a4.91fc@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <621f7aae.1c69fb81.1e0a4.91fc@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 3/2/22 15:09, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619579
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      1.68 seconds
> GitLint                       PASS      0.97 seconds
> SubjectPrefix                 PASS      0.85 seconds
> BuildKernel                   PASS      36.20 seconds
> BuildKernel32                 PASS      31.72 seconds
> Incremental Build with patchesPASS      43.70 seconds
> TestRunner: Setup             PASS      564.00 seconds
> TestRunner: l2cap-tester      PASS      15.37 seconds
> TestRunner: bnep-tester       PASS      7.22 seconds
> TestRunner: mgmt-tester       PASS      117.53 seconds
> TestRunner: rfcomm-tester     FAIL      9.09 seconds
> TestRunner: sco-tester        PASS      8.99 seconds
> TestRunner: smp-tester        PASS      8.92 seconds
> TestRunner: userchan-tester   PASS      7.47 seconds
> 
> Details
> ##############################
> Test: TestRunner: rfcomm-tester - FAIL - 9.09 seconds
> Run test-runner with rfcomm-tester
> Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
> 
> Failed Test Cases
> Basic RFCOMM Socket Client - Write 32k Success       Failed       0.188 seconds

This seems like a false-positive failure, since I don't
see anyway how this patch can cause this issue.

Regards,

Hans

