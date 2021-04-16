Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 11:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7459C60238
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 11:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhDPLGJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235120AbhDPLGH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 07:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618571142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLznv+ygR8CoshQgaQUccGlPVXnAFeHemTBof14wFUc=;
        b=NE22h2COleZwghf1oLAUfSbRTGS8quldWaE7m2VIQKBdXvYz8yjf+4Sh3k/vvov4QUysv3
        45aGbj5PiLfSabGovpLWuqdwkET9MnGEb2HE3VnuBrLdri6xHwIb/XGa1qb97HnXOflpot
        xA7sa+3zQQGgrQKpn6sZJ46gAPUlH/U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-nfAL1zBnPeC0LAb1NYpSoQ-1; Fri, 16 Apr 2021 07:05:41 -0400
X-MC-Unique: nfAL1zBnPeC0LAb1NYpSoQ-1
Received: by mail-ej1-f70.google.com with SMTP id re9-20020a170906d8c9b029037ca22d6744so1894762ejb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 04:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLznv+ygR8CoshQgaQUccGlPVXnAFeHemTBof14wFUc=;
        b=lFm/dTcK/x74m+b4a75jiQ3PtCub/GNQjy0/Rdn6JLbFhczD5ua1wqX1+f90b5d0/6
         M2dk/M9VRFegzLu8qdSKtfk+7KtgrrQcXiKloSPFEdaMKrbnJXOxWq/TLrIExRu1GTa4
         5F4CeWeNfYbQeiwS/rrJO9Wb/Dbma2jPehs5Yci4FbQ8etf4bigwftZbHyHXeFGAJCCR
         UzhTta5TQA8LddstVNqiRqxPzdhWVFSM44moWPHem3w0zLlpmb4Vl0XAbcgLcHdjpTpj
         swBPv/T80g/BmK19LkchgazFCm7FRpF+RRQMQH/zSzEHZHQPx8Rtt2RFRbH8DPNSs8kl
         pOPg==
X-Gm-Message-State: AOAM531VUjxjr4TObeVNXDQyhkf/sfVGsHiNwYl5g0g34VN0dzH5L6ip
        B5dt1nBOtMIhU6Bt/g2SUciJZGc7R10t9OrqWP1wQqDNx367YmcCK+mP2lb4nuN+URUn1rLXFju
        96AQDiL1KiY1WHpC873RUoCAd2m5v
X-Received: by 2002:a50:f19d:: with SMTP id x29mr9658430edl.102.1618571139830;
        Fri, 16 Apr 2021 04:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqteDmX/bqUXZ3T/eOIupnUPS9w0TU9BCgV4ykocgGoSalmzJaSle22hAfifHHnVzvdcigxQ==
X-Received: by 2002:a50:f19d:: with SMTP id x29mr9658411edl.102.1618571139687;
        Fri, 16 Apr 2021 04:05:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s20sm5013934edu.93.2021.04.16.04.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 04:05:39 -0700 (PDT)
Subject: Re: [PATCH v2 resend 2/2] iio: documentation: Document accelerometer
 label use
To:     Bastien Nocera <hadess@hadess.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
References: <20210405203933.17282-1-hdegoede@redhat.com>
 <20210405203933.17282-3-hdegoede@redhat.com>
 <dcd78309d7bbbdad511e10a63eb0e73f01934e8b.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <871895f8-b85e-e8b0-83f1-de91636ce572@redhat.com>
Date:   Fri, 16 Apr 2021 13:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dcd78309d7bbbdad511e10a63eb0e73f01934e8b.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 4/16/21 12:56 PM, Bastien Nocera wrote:
> On Mon, 2021-04-05 at 22:39 +0200, Hans de Goede wrote:
>> Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
>> have 2 accelerometers, 1 in their base and 1 in their display.
>>
>> In many cases the kernel can detect the location of each
>> accelerometer
>> based on e.g. information from the ACPI tables.
>>
>> It is important for userspace to know the location of the 2
>> accelerometers.
>> Rather then adding a new sysfs-attribute for this we can relay this
>> information to userspace by using standardized label strings for
>> this.
>> This mirrors how this is done for proximity sensors.
>>
>> This commit documents 2 new standardized label strings for this
>> purpose:
>> "accel-base"
>> "accel-display"
> 
> If we have a combined proximity and accelerometer sensor (which
> wouldn't be unheard off with sensor hubs being used), how are multiple
> labels, say "proximity-wifi" and "accel-base" documented?

Sensor hubs typically use one iio device per sensor, see e.g.
how HID-sensors work. And if a device which does not use separate
iio-devices per sensor shows up then the plan is to use per
channel-labels which are already supported by iio.

Regards,

Hans



>> Note the "base" and "display" suffixes were chosen to match the
>> values
>> used for the systemd/udev hwdb.d/60-sensor.hwdb file's ACCEL_LOCATION
>> property.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Mark Pearson <mpearson@lenovo.com>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index 7379e40d862d..b7529bca83f5 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -72,6 +72,13 @@ Description:
>>                 calculated by firmware from other sensor readings,
>> rather then
>>                 being a raw sensor reading.
>>  
>> +               For accelerometers used in 2-in-1s with 360° (yoga-
>> style) hinges,
>> +               which have an accelerometer in both their base and
>> their display,
>> +               the following standardized labels are used:
>> +
>> +               * "accel-base"
>> +               * "accel-display"
>> +
>>  What:          /sys/bus/iio/devices/iio:deviceX/current_timestamp_cl
>> ock
>>  KernelVersion: 4.5
>>  Contact:       linux-iio@vger.kernel.org
> 
> 

