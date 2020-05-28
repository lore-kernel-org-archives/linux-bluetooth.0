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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91730C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 00:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605FD207CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 00:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCB6lorU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE1AXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE1AXd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 20:23:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06290C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 17:23:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z206so11899694lfc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gkDCYxkIaYpF+mMdysuvMKfvwvqYZtICLIzLu2hIjfM=;
        b=XCB6lorUS+EXcz30TDNMnZKGsCZd6EMOPycWmbCyUcMiqjZiIuMJ707NfDZwnsLHNf
         pD/iwFUnx3C5TV490JMvbtpmXekKjZCnm7xK9gj3N5dp1J1b4JnBXhDAmQPTiG0LUAfX
         lWT3UN08Jf4TyOsRrzTrfAcS5o4/a8N/fhJdPX9J+SEMYDo2qvWr+y+KRp89KS/MfstN
         RuZ0/uuuXFXACHnd8mIQPwW3JvBOukK1C9UvqOArXFzwSzs14VKCZKH9GCzFgJh3aqvg
         m2bm85RRT1Tmuuno0AnKJw2a+uQezqPMUG7patRXghVYC44Oladqs6I3+gAVk2Uc9T7E
         lsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkDCYxkIaYpF+mMdysuvMKfvwvqYZtICLIzLu2hIjfM=;
        b=eyYsbOtz4/NdCv1XUrDS9UQCj2kFKckPIXiymXn9DEcf3GF4+Dkecki03Xc428z7O0
         n5CgBqXDk3otdGLnKIt0sG+C0f9b3zUZrFY93cVCHafdl3UVkip8er9n9bZ8YGk2dA7B
         KypUhkOZSLnPYQVZhgYuDcmOv23g1xDnp7JBl7GL8aONTAmlGM/cYys8MQsz6KBS4HaB
         NB0E4D4m+G0fB/rHqTmXBAzrddx58gANC0hqt85o51SGNQ6pu4c24ecKSA5tTL4fS4TU
         2/k2mqAHL6/j7rscdU0/NvoDzQBBlcVJsYWXc0Ksg45+sEoIP0h0ftWyUbio4m2y5CWx
         jmlA==
X-Gm-Message-State: AOAM530/qmvY6wGzn8d6QXb1Qi/WLCl7xx8SYKxhv36IVyLOz89kBotz
        UUw1Tp01lybFZXRjIwgGPlEAwECEGTU=
X-Google-Smtp-Source: ABdhPJwMNvAnBS+AphxalR6tFGP3JeHrdTN7U6R0iH5dFsdEnTcwRct0crkIl0rCepo3Choi+jbrmQ==
X-Received: by 2002:a19:c751:: with SMTP id x78mr279881lff.82.1590625410790;
        Wed, 27 May 2020 17:23:30 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id l15sm1032750ljc.73.2020.05.27.17.23.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 17:23:29 -0700 (PDT)
Subject: Re: [PATCH BlueZ] avrcp: Fix always requesting player settings for
 category 1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200527224343.182610-1-luiz.dentz@gmail.com>
 <CABBYNZ+yYU=FOq8-xTVzv+jLufkOFgs_0UmJZnhW8XkvFCU3TA@mail.gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <1d23ca79-1940-dca0-6048-8374594ce6c7@gmail.com>
Date:   Thu, 28 May 2020 03:23:28 +0300
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
