Return-Path: <SRS0=uRBT=WT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E0AC3A5A2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C720850
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 17:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAjryWWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbfHWRu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:50:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34161 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHWRu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Aug 2019 13:50:27 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so22061697ioa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2019 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JusjIKfneT/PNqU+0Q/IZqEmKuoVKkvstBuxtJXwDZc=;
        b=mAjryWWp9gEIxFroP4Uo8OF62F76ngVsgd2wwiwc1Y7eYOLkwv+TVYTLW2uewNZma1
         aH0wZ7XNjtnRMPpMjIvLYIXI/hyiXN81Cuikz6kGcxZIAMEceKMbp1T77BzXTmcUgxUK
         GsTwynB8l8KjBufnLv+/UMNU0IkqpAwJ8Hgy7w0pIisPYH4iku6JuUi/WS/5cXi9SzHx
         vSjng4zuo3nlzaAKh/7pTgMRJx/BADx36oWDsuJW+O8hXNr2ZeR7/e0Bmr7LTm/UpMUL
         Ln8OdIq2AAYmGskFkK2pveHOJRZcb6G7vu7wMvM4JYFK5sMjcv1vjKd7VXTOhys1Lbdx
         HrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=JusjIKfneT/PNqU+0Q/IZqEmKuoVKkvstBuxtJXwDZc=;
        b=rQpVUmeHwjjHIGsjDkHI8w3jYXY++pi0DVSQ7NyNXQZhwnWtsJcYU3V6/2Pex92tnc
         prR5UEEP6CZr/BWUYeUlSDWUzXM8oRLD1dYvT7LYQgO1OEzULHhdB/p3a+OPxsJGR9hr
         n4OdeB3UQoSUQUNEvr2zYTWbcpqWWjLIY8nJ5gmSsal4bx1k5ydp/MLy16YHU7krMXjG
         +nyz0AT5tuJpkW94b4MrLOJZ9iGWaUjBg4chK8jV5b7jfozJG9fAqcWILPKEQfCADpoe
         xqjojTHb8FYXWz+onX1mVorodDOv4+OOVJqSzBy0/3lk2M1/NO+eiCMlMlB9ouhFVD5A
         w1QA==
X-Gm-Message-State: APjAAAVwDBpHuqnKLp98eOQPRxTGIvB8KzgFWXssdFCBgBN84JRh0xJe
        h9E1URe4HwY1gk9fz4A/PZBShidV
X-Google-Smtp-Source: APXvYqxqK46sJ58jD9q29VG1m10o+VgiuPEU9O7ZUTAZcHuCrmyjEuMFqn+3BJG3cNgeXWqbHhb53g==
X-Received: by 2002:a5e:c311:: with SMTP id a17mr576684iok.140.1566582626631;
        Fri, 23 Aug 2019 10:50:26 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id y25sm5603438iol.59.2019.08.23.10.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 10:50:25 -0700 (PDT)
Reply-To: Carey Sonsino <csonsino@gmail.com>
Subject: Re: [PATCH 1/1] bluetooth: update default BLE connection interval
 bounds
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
 <20190823154559.1f203fac@aktux>
From:   Carey Sonsino <csonsino@gmail.com>
Message-ID: <f5976cc8-736f-74d7-a8ec-c5a860e89ae0@gmail.com>
Date:   Fri, 23 Aug 2019 11:50:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823154559.1f203fac@aktux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Well that is certainly a problem. According to the bluetooth core spec 
(5.1), section 4.5.2 Supervision timeout:

     The connSupervisionTimeout shall be a multiple of 10 ms in the 
range of 100 ms to 32.0 s and it shall be larger than (1 + 
connSlaveLatency ) * connInterval * 2.

So in theory that value should be able to go up to 3200 (ms * the 10ms 
multiple = 32000ms).  I see that le_supv_timeout is set to 0x2a (42 
*10ms = 420ms) so that explains the value in the error you're seeing, 
but I'm not sure what effect it would have to set the value to 0xc80 
(3200) -- kind of seems like a bad idea.  I haven't played around with 
the supervision timeout, and I'm not sure if 
le_supv_timeout/supervision_timeout specifies the exact value to use or 
if it's a maximum and the actual value is calculated based upon the 
negotiated connection interval and slave latency as shown above.

Will have to look into that and the other issues with the patch (commit 
message length & tabs).

Carey

On 8/23/19 7:45 AM, Andreas Kemnade wrote:
> Hi,
>
> On Tue, 20 Aug 2019 11:01:41 -0600
> Carey Sonsino <csonsino@gmail.com> wrote:
>
>> Update the default BLE connection interval min/max bounds to the full
>> range of permitted values (6-3200, corresponding to 7.25-4000ms).
>>
>> Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds
>> check on connection interval update requests, but the default min/max
>> values were left at 24-40 (30-50ms) which caused problems for devices
>> that want to negotiate connection intervals outside of those bounds.
>>
>> Setting the default min/max connection interval to the full allowable
>> range in the bluetooth specification restores the default Linux behavior
>> of allowing remote devices to negotiate their desired connection
>> interval, while still permitting the system administrator to later
>> narrow the range.
>>
>> Fixes c49a8682fc5d: (validate BLE connection interval updates)
>>
> Trying pair XX:XX:XX:XX:XX:XX in bluetoothctl
> leads to create connection commands containing
> le_conn_max_interval > le_supv_timeout (4000ms > 420ms) which the
> controller does not like and is imho not allowed.
>
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>      bdaddr XX:XX:XX:XX:XX:XX type 0
>      interval 96 window 96 initiator_filter 0
>      own_bdaddr_type 0 min_interval 6 max_interval 3200
>      latency 0 supervision_to 42 min_ce 0 max_ce 0
>> HCI Event: Command Status (0x0f) plen 4
>      LE Create Connection (0x08|0x000d) status 0x12 ncmd 1
>      Error: Invalid HCI Command Parameters
>
>
>> Signed-off-by: Carey Sonsino <csonsino@gmail.com>
>>
>> ---
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 04bc79359a17..f4f2f712c527 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3181,8 +3181,8 @@ struct hci_dev *hci_alloc_dev(void)
>>        hdev->le_adv_max_interval = 0x0800;
>>        hdev->le_scan_interval = 0x0060;
>>        hdev->le_scan_window = 0x0030;
>> -    hdev->le_conn_min_interval = 0x0018;
>> -    hdev->le_conn_max_interval = 0x0028;
>> +    hdev->le_conn_min_interval = 0x0006;
>> +    hdev->le_conn_max_interval = 0x0c80;
>>        hdev->le_conn_latency = 0x0000;
>>        hdev->le_supv_timeout = 0x002a;
>>        hdev->le_def_tx_len = 0x001b;
> hmm, what happened with the tabs here? I needed to manually apply it.
>
> Regards,
> Andreas
>

