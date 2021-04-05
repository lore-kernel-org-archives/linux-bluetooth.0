Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BBC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEC9613C6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhDEUmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237190AbhDEUmN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 16:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J24YxSoEEoDm85XB+ubxbNmHGb18U3JcHHVQEjHvk0=;
        b=BiI0StaFxKM2fW9qqPt3ks+trHzbsxHxSArbJFCDBVK9WcF+zTCFG41rMkxdUYD9n6tldN
        ZltlMQyobYZNIb5LQcmG/5tLnXRXQy3pRC9qxSR4gvmCyAflZYKPx2uhvsx7IIHNAgXlYe
        wVqzKEH9faplPRL/Et/VomvUs1JY0i0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-tuonnd8tMsOzPFLpPLWyhw-1; Mon, 05 Apr 2021 16:42:05 -0400
X-MC-Unique: tuonnd8tMsOzPFLpPLWyhw-1
Received: by mail-ej1-f72.google.com with SMTP id bn26so4655143ejb.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 13:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/J24YxSoEEoDm85XB+ubxbNmHGb18U3JcHHVQEjHvk0=;
        b=J/DtF2TZJalLviD809d0geccgrZDMbOgbJOoDp7kjb1N2j9rWaIjlfch2wsEXJHYZY
         61RIoilZZHEy1QDMNzVATnTSFfFCH0t1MlhvYNV+/xBtZ1sT1cKFpfXptZ4ZljScg9+x
         Vp2q3OIYfZNIzz2OGJpmO7oTYxFc5KDdX8IJZBzrzaJv+ppFlM7gG/dY1SYoyR4lyO3y
         LUMa05fUBQrh3Zm2Y/UFlpWIZ9gQ4mAEIx91YFts/UEJDGw0qVQlH+HSjK1tTHAdUBat
         45FjFNgd2tAPGRtU1FWQZSfoyHiZmZ99gkSJqdnoeEMOKDnyfbag+Pu1LWCCvIUcdC7r
         N7Ag==
X-Gm-Message-State: AOAM5301VbJgGzRGEfM/+QnFyB/LjF5WXUjuYVqe7EGqFBlXv1ODcOg7
        qxiUKb+HB+N4DnUizMsTMl4/4EI4DjVbWzni+XVdUBLrqmns/Yj5L+9sh8WHimPgfTUGlDhrZAZ
        KzufzgPJ9j/HqdXK4/r+PrHCmWzLCUomkIPEwWmCuYeaA0KIRej7wmhy8wP1ShnP4P7MUJY/z+A
        Im1HAz
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr29668099ejb.544.1617655323007;
        Mon, 05 Apr 2021 13:42:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm8nf1tqMzBZssk/U1kHFDLgecgilMGv1OH8SumtY+G1JuPzfClltzHuftsHABmo5YUFt1ow==
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr29668087ejb.544.1617655322836;
        Mon, 05 Apr 2021 13:42:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm12171726edy.72.2021.04.05.13.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:42:02 -0700 (PDT)
Subject: Re: [PATCH v2 resend 0/2] iio: documentation: Document
 proximity/accel sensor label use
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210405203933.17282-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <de5cc2d9-9914-7d6d-f96c-e7d00758eb12@redhat.com>
Date:   Mon, 5 Apr 2021 22:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210405203933.17282-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Ugh, I messed up the "To:" list for this resend, sorry, please ignore.

Regards,

Hans



On 4/5/21 10:39 PM, Hans de Goede wrote:
> Hi Jonathan,
> 
> AFAICT the v2 of this series is ready for merging, but I'm not seeing it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Hence this resend.
> 
> Regards,
> 
> Hans
> 
> 
> 
> Hans de Goede (2):
>   iio: documentation: Document proximity sensor label use
>   iio: documentation: Document accelerometer label use
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

