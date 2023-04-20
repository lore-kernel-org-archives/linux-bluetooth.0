Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0DDC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjDTJHZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjDTJGj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 05:06:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5055A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 02:03:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so719585a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681981382; x=1684573382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tLFkVpKGF90Ylvh0PyqkHUieTIrwi9ZpEJAQK8p+Ho=;
        b=fwQZog7xrrls1AMU7h/ZRrgExMsgHu4wxCOuDbzrR8J7tW5op2c6NWClQW4oEMN2mv
         LY0lMB+/8g2/mAy8cZT/bsDJISwg0zol7/pby7kfy+hztQhUgzQczfnwOMutLEatp7Gn
         eDj1O5uRW/xf5yVQYZFrCmPqQevuFyIUy5+Ab8LVurjqto/PiA8R6r72Mx0JWE9WucII
         BSzuk0ILMyq24HaXmTqEpjbPIzjXVGwKLCN+bnfrxHflE/uuO2mnfzcOTfL7ntSYSsTs
         tqzz0Vfb2s4GWiGi7qK3Knp9rXZvTYTCRaxedarx2xnrOsq3oEJ9PuBBTMIAKg/xTpMD
         OpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681981382; x=1684573382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tLFkVpKGF90Ylvh0PyqkHUieTIrwi9ZpEJAQK8p+Ho=;
        b=aQc5f78/ui5fBg0vArvvKwy0gomppKcwCerWH8w9KAqQGS5XtQ1jxjyhvmTlhD6NYQ
         v6FvCXuKlSZ/ImasbbxA0ukWQRhynaf/02NpWjbIa8IJ8IjjHSQqj6BOtb3eWzB++UD+
         una5SbtacUebF7x2KMmPowEOwBrjLUd1cSCRXCqpV2pCXTLMNDwxp5cqoDcvxPkJIkyp
         Nba6zzYRP0E61X7fP28mgJ2dXEKMyy7R7v844jKDs8pmqNQUFuzOVCjw/fCFiLG1fIzm
         iMRobfW3t2X6L1krOiyeAij65TKRpFFix2l3Jk/ZyyS3DNfJynORGyLqXkJY/Rz8jH3J
         8bzg==
X-Gm-Message-State: AAQBX9dYmZ9uWulPyzt3xfyjOIbGRehHjpSWiG5m7obGDgo1ifJeEwD3
        44gjaSaF+1f8ctC+8blV7XU=
X-Google-Smtp-Source: AKy350Z7bBGlgUUWYbZ9lbV4YGWzQdI0D338jQC+rWlmwvGQ24U0EOOOxP4eAAUVMy3Flid2bMIhKw==
X-Received: by 2002:a05:6a20:3950:b0:d5:73ad:87c2 with SMTP id r16-20020a056a20395000b000d573ad87c2mr1442400pzg.56.1681981382407;
        Thu, 20 Apr 2023 02:03:02 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902e8c100b0019f9fd5c24asm742550plg.207.2023.04.20.02.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:03:02 -0700 (PDT)
Message-ID: <c32287f8-1604-1571-703e-10ed8ccbc192@gmail.com>
Date:   Thu, 20 Apr 2023 17:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH BlueZ v4] obexd: support to reply folder name to store
 file
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
References: <20230420022554.14159-1-aarongt.shen@gmail.com>
 <c78e25ba-9cfa-9032-0cd8-3dc6c265558c@molgen.mpg.de>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <c78e25ba-9cfa-9032-0cd8-3dc6c265558c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Paul,


On 2023/4/20 14:57, Paul Menzel wrote:
> Dear Guiting,
>
>
> Thank you for sending the fourth iteration. In the summary, I’d use 
> also *return* instead of *reply*. Maybe:
>
> obexd: AuthorizePush: Support to return folder name for file storage
Ok, I will change this in v5 patch.
>
>
>
> Am 20.04.23 um 04:25 schrieb Guiting Shen:
>> The obex agent usually returns the full path by getting the default
>> folder and filename from the Filename property of the transfer object
>> which is not convenient.
>
> Just a minor thing for the future, I’d add a blank line between 
> paragraphs.
Ok.I will change this in v5 patch.
>
>> The patch helps that the obex agent can return the folder name suffixed
>> with '/' or new full path or even null which will use the default name
>> if new_name is NULL and the default folder if the new_folder is NULL in
>> opp_chkput().
>> ---
>>   doc/obex-agent-api.txt |  9 +++++----
>>   obexd/src/manager.c    | 10 ++++++----
>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
>> index 3923da6df..5a9c6d417 100644
>> --- a/doc/obex-agent-api.txt
>> +++ b/doc/obex-agent-api.txt
>> @@ -46,10 +46,11 @@ Methods        void Release()
>>               This method gets called when the service daemon
>>               needs to accept/reject a Bluetooth object push request.
>>   -            Returns the full path (including the filename) where
>> -            the object shall be stored. The tranfer object will
>> -            contain a Filename property that contains the default
>> -            location and name that can be returned.
>> +            Returns the full path (including the filename) or
>> +            folder name suffixed with '/' where the object shall
>> +            be stored. The transfer object will contain a Filename
>> +            property that contains the default location and name
>> +            that can be returned.
>>                 Possible errors: org.bluez.obex.Error.Rejected
>>                                org.bluez.obex.Error.Canceled
>> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
>> index 849928603..73fd6b9af 100644
>> --- a/obexd/src/manager.c
>> +++ b/obexd/src/manager.c
>> @@ -632,8 +632,7 @@ static void agent_reply(DBusPendingCall *call, 
>> void *user_data)
>>             if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
>>               agent_cancel();
>> -
>> -        if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
>> +        else if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
>>               agent->auth_reject = TRUE;
>
> By the way, this looks like an unrelated change? I would do such 
> changes in separate commits.
Ok.I will split such changes in two commit. Thanks.
>
>
> Kind regards,
>
> Paul
>
>
>>             dbus_error_free(&derr);
>> @@ -651,7 +650,10 @@ static void agent_reply(DBusPendingCall *call, 
>> void *user_data)
>>               agent->new_name = g_strdup(name);
>>               agent->new_folder = NULL;
>>           } else {
>> -            agent->new_name = g_strdup(slash + 1);
>> +            if (strlen(slash) == 1)
>> +                agent->new_name = NULL;
>> +            else
>> +                agent->new_name = g_strdup(slash + 1);
>>               agent->new_folder = g_strndup(name, slash - name);
>>           }
>>       }
>> @@ -722,7 +724,7 @@ int manager_request_authorization(struct 
>> obex_transfer *transfer,
>>         dbus_pending_call_unref(call);
>>   -    if (!agent || !agent->new_name || agent->auth_reject)
>> +    if (!agent || agent->auth_reject)
>>           return -EPERM;
>>         *new_folder = agent->new_folder;


Best regards,

Guiting

