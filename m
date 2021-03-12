Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A219464F83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 19:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhCLTJo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhCLTJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 14:09:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA470C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 11:09:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 425001F46E67
Subject: Re: [PATCH Bluez v2] adapter: Fix discovery trigger for 0 second
 delay
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210312165017.31829-1-frederic.danis@collabora.com>
 <CABBYNZ+fjE8x6Ba4FJvzb+RUoNgN9i8O8Vn4g0fhLJ+8CbYigg@mail.gmail.com>
From:   =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis@collabora.com>
Message-ID: <49e20ff2-795c-12e9-db79-697b12725f12@collabora.com>
Date:   Fri, 12 Mar 2021 20:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+fjE8x6Ba4FJvzb+RUoNgN9i8O8Vn4g0fhLJ+8CbYigg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 12/03/2021 19:28, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Fri, Mar 12, 2021 at 8:53 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> When calling `StartDiscovery` the effective start can take around 10 ms or
>> up to 700 ms.
>> g_timeout_add_seconds() call doesn't ensure the time for the first call of
>> the timer if the delay is less or equal to 1 second.
> Interesting, I always thought that 0 would be handle just as idle and
> not round up to the next timeout.
>
>> ---
>> v2: Fix issue founs by CI
>>
>>   src/adapter.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index cc0849f99..3078ce1a8 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -1797,6 +1797,13 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
>>          if (!btd_adapter_get_powered(adapter))
>>                  return;
>>
>> +       if (!delay) {
>> +               adapter->discovery_idle_timeout = g_idle_add(
>> +                                               start_discovery_timeout,
>> +                                               adapter);
>> +               return;
>> +       }
>> +
>>          adapter->discovery_idle_timeout = g_timeout_add_seconds(delay,
>>                                          start_discovery_timeout, adapter);
> Maybe we should have a wrapper function for g_timeout_add_seconds
> since I suspect there might be other instances of
> g_timeout_add_seconds with 0 delay.

Ok
Is adding a timeout_add_seconds() function to src/shared/timeout.h the 
right place?

Fred
