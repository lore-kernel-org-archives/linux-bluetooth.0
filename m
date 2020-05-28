Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ADE20888
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 00:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri34lTeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgE1AXk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE1AXk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 20:23:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EEC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 17:23:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so31158007lji.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gkDCYxkIaYpF+mMdysuvMKfvwvqYZtICLIzLu2hIjfM=;
        b=ri34lTeLkxvXLsnbPFPNULWhPsQyUDbmrqtaFmqKgpLFnYriwkSk/rlUaPeLtcn7Ll
         epnmG9Vw+dnon8K9D9q5aAABaeNm+6w+YJS1CpwzdS16YBQnuaxt3N1dFTWjQDADeT4O
         ds1LvDsxoARxCVIB5Wm8GCiWde3LHPBINkFoip98xHLqpchrvJphrcvQDmUp/R3BxWZ+
         y6dp4Wi2v1ljCajWUt9t5olnB8BE7BTRdUQi/V6kcpOIh8gKu7eBzebGR6HovFyoLr+h
         Df4YWH1nxaesuBgaIfWAeGOePKkdJYIhXHdtWdLhWQntSx9MeBursrj6EV6S+UzuxO2C
         iIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkDCYxkIaYpF+mMdysuvMKfvwvqYZtICLIzLu2hIjfM=;
        b=ivmSGHkJqGI+99nrOsk+NuPOaoIInxuRmLcr3fJ+x/F5TSC84u3iw/l5sbauyHZDJN
         eun/FVnKLP44oIg1xAJfGnvy5Omju2xp1Gl010zshjPVwTTz/hHgGGuTiIlC9POcBg5M
         Oan8FkSwkKRda62ADlTQ6BsSZHQsGWUJqUUUpopam0A/FjNlshWEp9u3Z9fthshK+KxN
         OniUszmPJ1zOwwE81lyG/SLCQqO1zttk3kEgPyNBDb0Iyu/9ga7IvlRSywt+lahfF2yF
         keFHF4+1h5HSyO0s4JxNrc1nKb8aaJQWfHVdfA0Ki9rm9N/ffma5Ao9SOzIGXHe7zaTT
         TeEg==
X-Gm-Message-State: AOAM530FBDmH1ZpT3EWtUMtHgTTYhj5G2BQNEOIf/Yz6aVGGgiu4HLge
        NkylhROlpEXOCDrNFwN3jtOvTOOiNnQ=
X-Google-Smtp-Source: ABdhPJzizfga/5KVu2WZHgF3eFMawJFpOygmij74nW5y81ZCkv5pSNeGeLAkT2cQTjpZEHnciEo0Xg==
X-Received: by 2002:a2e:9395:: with SMTP id g21mr127413ljh.417.1590625417954;
        Wed, 27 May 2020 17:23:37 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id o14sm1155281ljj.135.2020.05.27.17.23.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 17:23:36 -0700 (PDT)
Subject: Re: [PATCH BlueZ] avrcp: Fix always requesting player settings for
 category 1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200527224343.182610-1-luiz.dentz@gmail.com>
 <CABBYNZ+yYU=FOq8-xTVzv+jLufkOFgs_0UmJZnhW8XkvFCU3TA@mail.gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <7a7b8f77-4367-9b3d-823d-25716d06633a@gmail.com>
Date:   Thu, 28 May 2020 03:23:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+yYU=FOq8-xTVzv+jLufkOFgs_0UmJZnhW8XkvFCU3TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-05-28 01:46, Luiz Augusto von Dentz wrote:
> On Wed, May 27, 2020 at 3:43 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Player Application settings is not mandatory for category 1 so instead
>> of always listing the settings the code now checks if
>> AVRCP_FEATURE_PLAYER_SETTINGS is enabled.
>> ---
>>   profiles/audio/avrcp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 773ccdb60..75811bf98 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -3814,7 +3814,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>>          if (!session->controller || !session->controller->player)
>>                  return FALSE;
>>
>> -       if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>> +       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
>> +                       !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>>                  avrcp_list_player_attributes(session);
>>
>>          if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
>> --
>> 2.25.3
> 
> Please let me know if you are able to test the above patch, it should
> fix the problem with Senheisers headsets if the are not setting the
> Player Settings bits this would prevent the command to be send so it
> doesn't crash.
> 

I'll try it with Momentum True Wireless 2 tomorrow.
