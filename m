Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CAAC04FF3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2941D613E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEVAbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 20:31:12 -0400
Received: from mail.eh5.me ([45.76.212.85]:59792 "EHLO mail.eh5.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhEVAbL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 20:31:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5361134A3FBE;
        Sat, 22 May 2021 08:29:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1621643385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=fs246rSy9hCDSCETMDVWHAxWoKH8IFbU597kP5LRuqE=;
        b=ow2QEPnb7rY1CYSi2nxi2ytE18FqCKJ4DG1RnlpjLoEtpaxNnAQ8HUZ6g79EH97dCGD5Dk
        i8XwKT1H0hpBlKaJpv9TMsNK00PLz21YNJfQ478RZexuW3AkX3rZsdD2tAjDJz2KWHUN70
        5eF6JDTAYitFFMnMOVfmH38UbYLdMKU=
Subject: Re: [PATCH BlueZ v3] avrcp: Fix unregister AVRCP player
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210520092200.14937-1-eh5@sokka.cn>
 <CABBYNZK0tmCaAKjLS3s-yndRnmsQsaurOnx7-ffa_QyQ_7BgYQ@mail.gmail.com>
From:   Huang-Huang Bao <eh5@sokka.cn>
Message-ID: <b2de7e62-1360-c443-fdd3-929dc990696f@sokka.cn>
Date:   Sat, 22 May 2021 08:29:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZK0tmCaAKjLS3s-yndRnmsQsaurOnx7-ffa_QyQ_7BgYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz

Oh, what a timing, thanks!

On 5/22/21 8:25 AM, Luiz Augusto von Dentz wrote:
> Hi Huang-Huang,
>
> On Thu, May 20, 2021 at 7:44 AM Huang-Huang Bao <eh5@sokka.cn> wrote:
>> 'notify_addressed_player_changed()' expected to be called with
>> 'player->changed_id' set to a non-zero value.
>>
>>      player->changed_id = g_idle_add(notify_addressed_player_changed,
>>                                      player);
>>
>> And 'avrcp_player_event()' relies on 'player->changed_id' to perform
>> Addressed Player Changed notification. However,
>> 'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
>> without adding it to the main loop and set 'player->changed_id'. To
>> indicate addreddsed player changed for both scenarios, we set
>> 'player->changed_id' to 1 at the head of
>> 'notify_addressed_player_changed()'.
>>
>> Fixes https://github.com/bluez/bluez/issues/142
>> ---
>>   profiles/audio/avrcp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 58d30b24d..ef721e17b 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -1794,6 +1794,12 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>>                                  };
>>          uint8_t i;
>>
>> +       /*
>> +        * Set changed_id to an non-zero value to indicate addreddsed player
>> +        * changed.
>> +        */
>> +       player->changed_id = 1;
>> +
>>          avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
>>
>>          /*
>> --
>> 2.31.1
> Applied, thanks.
>
