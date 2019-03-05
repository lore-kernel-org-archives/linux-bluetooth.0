Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3801C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FA92082C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty+WGT0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfCESCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:02:16 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40032 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCESCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 13:02:16 -0500
Received: by mail-wr1-f48.google.com with SMTP id q1so10509045wrp.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2019 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d09vV4yyVouVjjl9ygVAHFB88VNuivvXNErpa5PXL78=;
        b=Ty+WGT0o8mWCU9vbJR2l5XJ+utrABO99TWXH4hNNIuFCzuLJZb51Wm27TzeEeh3KG8
         ra4R5rE/1ZFh/Db/tCGuqlxS/H0fcAhLn12nD06Ry54o7mkko49xRlixhy5tioL+BJ0M
         b8p0uIKCnvTXZYyVkDNZau9mXT9EOsmxZCXFMr+mvzhxRYJqW1HWmbfbJYG0Qq2/OBjP
         DCCTOV6wdlf+88RiGx/x5/5E/OD50fuQc9eGUU9pwitENvkMjLpDMx44ICcblTC+E8So
         uM6vcJ4O5tWavyUA66MuazX4d41rtMVui8O5jPEKGQ4zYpi8quEJtgwNKUyjf5YYso9t
         VXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d09vV4yyVouVjjl9ygVAHFB88VNuivvXNErpa5PXL78=;
        b=MfPYXx335HsNlMcU19zk8HZySKt2T/csXlrPWTYG5o3Vs+5N0yJyivR5JKkNUpccz7
         aAN+BUSZYVsl4+oPJHMQotZ5ttuY4suxzxdaYHh6evSWGNTkcFmXPecaxoQKbgOVsOlL
         1FMt+ezlFJn5mgeWc1XBksS0eziKY4tcI+j7B7fDJxsvk5FNEO/9hVfkU4xTlmoiI2xf
         ZtYrfwNtgfdNfY0bvZQ3O2J2XafRJyaE5b+Z25Jv4tUQ7+QOPpAWtJ6k9jfBJ8Dvssw/
         sFHOSA1yULMuTL5qbC0cgtWPdPkMk4N8/JzkPQ4sgVfIAwhffgIArM6w51+NCvH9p/Wh
         4HAg==
X-Gm-Message-State: APjAAAXMlARDnNop9dtQvhHT7T7oreVEuDqv1Ien9WDggJifdBMQ0FI6
        Ee0bdY9OugQPKqpRHsKiNLPCL4Ca
X-Google-Smtp-Source: APXvYqxgfCBlk9Z1XpZbIN99/kNLQEf1UhheE878GVx++QJLiuL9mamZs+ZQOx9h49mJdBM/d7MBOg==
X-Received: by 2002:adf:c543:: with SMTP id s3mr97145wrf.192.1551808933009;
        Tue, 05 Mar 2019 10:02:13 -0800 (PST)
Received: from [192.168.0.1] (cpc149624-rdng29-2-0-cust819.15-3.cable.virginm.net. [82.15.3.52])
        by smtp.googlemail.com with ESMTPSA id g3sm101165wmk.32.2019.03.05.10.02.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:02:12 -0800 (PST)
Subject: Re: Error setting UUIDs discovery filter on big endian systems
From:   Matt <mwtaylor@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
 <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
 <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com>
Message-ID: <b6ae709c-e62a-9c03-7abb-a8b4800361e6@gmail.com>
Date:   Tue, 5 Mar 2019 18:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 05/12/2018 00:27, Matt wrote:
> Hi Luiz,
>
> On 04/12/2018 19:53, Luiz Augusto von Dentz wrote:
>> Hi Matt,
>> On Mon, Dec 3, 2018 at 3:59 PM Matt <mwtaylor@gmail.com> wrote:
>>> Hi,
>>>
>>> When setting a UUIDs discovery filter I am receiving
>>> "org.bluez.Error.InProgress" on starting a scan (which isn't in 
>>> progress
>>> and will not start unless the discovery filter is cleared).
>>>
>>> I am using bluez 5.50 (on openWRT). The problem seems to only appear on
>>> big endian hardware (tested a couple of recent kernel and bluez
>>> versions), the same software compiled for and tested on little endian
>>> hardware works as expected. The issue can be reproduced in the 
>>> following
>>> way using bluetoothctl:
>>>
>>> # /etc/init.d/bluetoothd restart
>>> # bluetoothctl
>>> [bluetooth]# power on
>>> Changing power on succeeded
>>> [CHG] Controller 00:1A:7D:DA:71:13 Powered: yes
>>> [bluetooth]# menu scan
>>> [bluetooth]# uuids 0000180f-0000-1000-8000-00805f9b34fb
>>> [bluetooth]# back
>>> [bluetooth]# scan on
>>> SetDiscoveryFilter success
>>> Failed to start discovery: org.bluez.Error.InProgress
>>>
>>> Setting an rssi filter does work as expected on my big endian hardware,
>>> it is only the uuids filter that appears to show this problem. The 
>>> issue
>>> appears whether set using bluetoothctl or directly using DBus.
>> Do you have the bluetoothd logs when that happens? I wonder if it is
>> something with our string to UUID conversion.
>>
>>
> When performing the above sequence in bluetoothctl with 'bluetoothd 
> -d' I get the following in my log:
>
> daemon.debug bluetoothd[22991]: src/agent.c:agent_ref() 0xb03e60: ref=1
> daemon.debug bluetoothd[22991]: src/agent.c:register_agent() agent :1.29
> daemon.debug bluetoothd[22991]: src/adapter.c:property_set_mode() 
> sending Set Powered command for index 0
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:property_set_mode_complete() Success (0x00)
> daemon.debug bluetoothd[22991]: src/adapter.c:new_settings_callback() 
> Settings: 0x00000ad1
> daemon.debug bluetoothd[22991]: src/adapter.c:settings_changed() 
> Changed settings: 0x00000001
> daemon.debug bluetoothd[22991]: src/adapter.c:adapter_start() adapter 
> /org/bluez/hci0 has been enabled
> daemon.debug bluetoothd[22991]: src/adapter.c:trigger_passive_scanning()
> daemon.debug bluetoothd[22991]: src/adapter.c:set_discovery_filter() 
> sender :1.29
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:parse_discovery_filter_dict() filtered discovery params: 
> transport: 7 rssi: 32767 pathloss: 32767  duplicate data: false
> daemon.debug bluetoothd[22991]: src/adapter.c:set_discovery_filter() 
> successfully pre-set filter
> daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery() sender 
> :1.29
> daemon.debug bluetoothd[22991]: src/adapter.c:update_discovery_filter()
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:discovery_filter_to_mgmt_cp()
> daemon.debug bluetoothd[22991]: src/adapter.c:trigger_start_discovery()
> daemon.debug bluetoothd[22991]: src/adapter.c:cancel_passive_scanning()
> daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery_timeout()
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:start_discovery_timeout() 
> adapter->current_discovery_filter == 1
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:start_discovery_timeout() sending 
> MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 1
> daemon.debug bluetoothd[22991]: 
> src/adapter.c:start_discovery_complete() status 0x0d
> kern.err kernel: [709588.482104] Bluetooth: service_discovery: 
> expected 4100 bytes, got 20 bytes
> daemon.debug bluetoothd[22991]: src/agent.c:agent_disconnect() Agent 
> :1.29 disconnected
> daemon.debug bluetoothd[22991]: src/agent.c:agent_destroy() agent :1.29
> daemon.debug bluetoothd[22991]: src/agent.c:agent_unref() 0xb03e60: ref=0

If I instead try a uuid filter of 3 uuids in length I get this in the log:

bluetoothd[550]: src/adapter.c:start_discovery_timeout() sending 
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 3
kernel: [1077807.129187] Bluetooth: service_discovery: expected 12292 
bytes, got 52 bytes
bluetoothd[550]: src/adapter.c:start_discovery_complete() status 0x0d

So something about the size calculation is going wrong on big endian, 
from adapter.c (line 1607) the command is:

|

mgmt_send(adapter->mgmt,  MGMT_OP_START_SERVICE_DISCOVERY,
		adapter->dev_id,  sizeof(*sd_cp)  +  sd_cp->uuid_count  *  16,
		sd_cp,  start_discovery_complete,  adapter,  NULL);|

With 1 uuid the bytes expected is being returned as 4100 (should be 4 + 
1*16 = 20), with 3 uuids it is 12292 (should be 4 + 3*16 = 52). These 
are the numbers that would be returned if the endian of the uuid_count 
(or the number 16) was switched, i.e. 1 becomes 256, 3 becomes 768. I'm 
not sure why this should be happening.

I have naively tried changing `cp->uuid_count = uuid_count;` to 
`cp->uuid_count = htobs(uuid_count);` (line 2079), just to see what 
would happen by switching the endian, this stops that kernel error 
appearing but just creates an error further along.

bluetoothd[4333]: src/adapter.c:start_discovery_timeout() sending 
MGMT_OP_START_SERVICE_DISCOVERY -45, 7, 256
bluetoothd[4333]: src/adapter.c:start_discovery_complete() status 0x03
bluetoothd[4333]: Wrong size of start discovery return parameters

Perhaps there is some place that is just missing some endian switching 
that would fix this? Sorry, I am not experienced with bluez or related 
code to know where this could be but I would be happy to test any 
suggestions or help in some other way with fixing this issue if someone 
could advise.

Thanks,

Matt
