Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95932C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 08:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D5611AB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 08:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhETIr3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 04:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhETIr3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 04:47:29 -0400
Received: from mail.eh5.me (mail.eh5.me [IPv6:2001:19f0:7001:2deb:5400:2ff:fef8:7fd6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E9C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 01:46:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2055934A3FBE;
        Thu, 20 May 2021 16:46:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1621500365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=FITNTfXQTD7i0f63iHEGM4cWtZ1wXWV0wHqQ6ZrNndQ=;
        b=RrC9G2r3maRprrPAWAc+9+9NIPAuUtHAQG01dvkZ/R6DURBWTyHTw+vxzGA51uhx5mz/L8
        yTNKXsiJ7v4stPHSg2IBUgYEdkPg4AByHoIeMh3A/jqSXb8YLc8mSPnSMdu2ARDiXaP3ZG
        GZEpVY23SzugYU9mqIPW/OzEL9aEPTo=
Subject: Re: [PATCH BlueZ v2] avrcp: Fix unregister AVRCP player
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210520041142.332534-1-eh5@sokka.cn>
 <CABBYNZK_Wtc5VfQqojkpb7SzD9ueO8h_k8y7WxvFp=y7poNn_Q@mail.gmail.com>
From:   Huang-Huang Bao <eh5@sokka.cn>
Message-ID: <c340304e-2fe7-e10c-135e-28a5c6f6a804@sokka.cn>
Date:   Thu, 20 May 2021 16:45:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZK_Wtc5VfQqojkpb7SzD9ueO8h_k8y7WxvFp=y7poNn_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 5/20/21 1:44 PM, Luiz Augusto von Dentz wrote:
> Hi Huang-Huang,
> 
> On Wed, May 19, 2021 at 9:14 PM Huang-Huang Bao <eh5@sokka.cn> wrote:
>>
>> v2: fix commit message & code styles
>>
>> 'notify_addressed_player_changed()' expected to be called with
>> 'player->changed_id' set to what 'g_idle_add()' returns.
>>
>>      player->changed_id = g_idle_add(notify_addressed_player_changed,
>>                                      player);
>>
>> And 'avrcp_player_event()' relies on 'player->changed_id' to perform
>> Addressed Player Changed notification. However,
>> 'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
>> without adding it to the main loop and set 'player->changed_id'. To
>> make 'notify_addressed_player_changed()' can be called without set
>> 'player->changed_id' flag. We add antoher flag
>> 'player->addressed_changing' to indicate addressed player changing.
>>
>> Fixes https://github.com/bluez/bluez/issues/142
>> ---
>>   profiles/audio/avrcp.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 58d30b24d..5058a6848 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -239,6 +239,7 @@ struct avrcp_player {
>>          uint8_t *features;
>>          char *path;
>>          guint changed_id;
>> +       bool addressed_changing;
>>
>>          struct pending_list_items *p;
>>          char *change_path;
>> @@ -792,7 +793,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>>
>>          DBG("id=%u", id);
>>
>> -       if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->changed_id) {
>> +       if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED &&
>> +                       player->addressed_changing) {
>>                  code = AVC_CTYPE_REJECTED;
>>                  size = 1;
>>                  pdu->params[0] = AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
>> @@ -1794,6 +1796,8 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>>                                  };
>>          uint8_t i;
>>
>> +       player->addressed_changing = true;
> 
> Well we could just set the change_id manually instead since it is
> anyway set to 0 in the code below which is equivalent to what you are
> doing here.

Yeah, make since. I will submit a v3 soon.

Regards,
Bao

> 
>> +
>>          avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
>>
>>          /*
>> @@ -1804,6 +1808,7 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>>          for (i = 0; i < sizeof(events); i++)
>>                  avrcp_player_event(player, events[i], NULL);
>>
>> +       player->addressed_changing = false;
>>          player->changed_id = 0;
>>
>>          return FALSE;
>> --
>> 2.31.1
> 
> 
> 
