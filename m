Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB61DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905BC61057
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhCaUCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbhCaUBo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 16:01:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C53C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:01:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so20838673wrw.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UDT+7PgXWFzT5yi2yYOpRN4w/jBHtEDi6qBmAhGiEN4=;
        b=s/58wbouHW/KTj4ek5hvakoDt4vlIeYIdjd2Bwtst+cZZzjSfJxf2+BCdQRDsa4NYg
         m9ssCGf6L4bys/2U7pujSrw8qNkLUVs73eojVWNC47Lh8ajdyXvHH33OD2NDcF4CUW5J
         D3yiuUVwK8fBBTGk2LVqB1f0n5GCDEthDckYv/Lc/B1Alc6XoOvtjEfyWPw+LnkJW9EA
         cMsW6arp+we7kFTSwwkQEV1kOw6u9nzoMwnOQL6s8EwCZRvRMOaBL+5Jm3SuRn0hEGw2
         IgxzFlivMV8Aj0020MPQO8LMG+IjHJD8+P5FGEmrlrNJIjU7qHTNgYGvOaQRmqLGu9UO
         PZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UDT+7PgXWFzT5yi2yYOpRN4w/jBHtEDi6qBmAhGiEN4=;
        b=CPdfWXJoLmVdDtLo5NsQU3bg+fnEbNIsrQ3cE1hWVFFlGUQAi53nbAE27HutJhDfkq
         Z8c/4cKJJRljMkY3NVKG+FXq/OvrWkMdHD39Vj4kyRD5zyGKiFLDiRGYeUUM/WdLLt7n
         ZsyRkCRlnwxwKpqpu2av9WjeKZHWVBRbtzKvrq1VaZI5JwogGeSnKuN2YydTF5xADveA
         cwLUEm29dtO3ROFafbyZzFA79Vx1aT5sxCSl51udUu1k0cfaqqfHqQRw9f6RU7+wRAE4
         YJwd35o/BR0wZW2HgwfEbFf8Uee0K4ZCR+h9lnvpIOJjxnOWmdAX0l5cbdbKMR3br7Zf
         amHw==
X-Gm-Message-State: AOAM532hRdr91SXLWOw96al16NhSwUt975X86YFAnYhB/4/Lwe1qu4/W
        XED3+9keuEZlv49zqOJ/KfoIlQJVQ13W
X-Google-Smtp-Source: ABdhPJywt0iAto+n5Ewg+FohKB8s57HPj98g5XZ5k9Bw6YI5k07AXeHFSTHqsbz31nxxPFYtzM3ihg==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr5511871wre.183.1617220903050;
        Wed, 31 Mar 2021 13:01:43 -0700 (PDT)
Received: from [192.168.1.125] (ip-37-201-4-244.hsi13.unitymediagroup.de. [37.201.4.244])
        by smtp.gmail.com with ESMTPSA id a15sm6087339wrr.53.2021.03.31.13.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 13:01:42 -0700 (PDT)
Subject: Re: [PATCH BlueZ] audio/transport: Emit Volume changed if endpoint is
 source
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <80f40fbd-c903-6f10-1d9f-e75f0f214db5@gmail.com>
 <CABBYNZJ2Hw1+xSvhqwBQa90qkpcmYh+qO3U+Rs1JBaSOz+7AMA@mail.gmail.com>
From:   Feryllt Pryderi <feryllt@gmail.com>
Message-ID: <394e71c9-3abe-7a9d-e47d-0793ba9736f3@gmail.com>
Date:   Wed, 31 Mar 2021 22:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ2Hw1+xSvhqwBQa90qkpcmYh+qO3U+Rs1JBaSOz+7AMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

sure I can update the patch, but is the if at all needed? Can we have transports without any of source_watch and sink_watch?

On 3/31/21 8:33 PM, Luiz Augusto von Dentz wrote:
> Hi Feryllt,
>
> On Wed, Mar 31, 2021 at 4:40 AM Feryllt Pryderi <feryllt@gmail.com> wrote:
>> Change set_volume to send a Volume PropertyChanged signal also if
>> transport->sink_watch is set (and not only if source_watch is set).
>>
>> This fixes volume changes signals not being sent for devices like speakers and
>> headphone adapters with volume control (like Bose Soundlink Revolve or Fiio BTR5).
>> ---
>>  profiles/audio/transport.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index 8248014ae..26aa237a3 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -662,6 +662,7 @@ static void set_volume(const GDBusPropertyTable *property,
>>      a2dp->volume = volume;
>>
>>      notify = transport->source_watch ? true : false;
>> +    notify = notify || (transport->sink_watch ? true : false);
> Id replace the following like with:
>
>   if (transport->source_watch || transport->sink_watch)
>
>>      if (notify)
>>          g_dbus_emit_property_changed(btd_get_dbus_connection(),
>>                          transport->path,
>> --
>> 2.31.0
>>
>
