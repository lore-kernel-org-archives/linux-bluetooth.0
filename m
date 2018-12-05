Return-Path: <SRS0=1GGh=OO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF68C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Dec 2018 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D577220834
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Dec 2018 00:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWU/lsbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D577220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeLEA1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:27:13 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38006 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeLEA1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 19:27:12 -0500
Received: by mail-wm1-f46.google.com with SMTP id m22so11166339wml.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xnc6Q2CoR1bpiA0YRhHgEm9acKW9mLnzafi/qJY7ND8=;
        b=BWU/lsbmeeylCeVClLSwYaHnTTIjbDY2NE6Cv2jEDp7WhOMOdojWrJ9lMniQBnukRC
         DeSsW7MBGMzud7ms0xrY/d7GUPo3QUDTDCG3qj5KnRddQEryXahK34zeyn1Cly6RmfP5
         YEe6SIXMkdaGqn4XGyGB/RVafYFRoWHGpY37okhf3mVEbkII1+xgznntR8IDdOhxFjNl
         3xqzm9PNfoOagYCUIu4QsJiXzMenVw9NWJNfU7zzS17N0hGTannm5ddtYPwPxfsPK7Hq
         ACcWmg/y1hTy4rv29rq2seSJ1JRsIjYJhicbCFn1Dv0AVj44/orCTJHAeoEH35vPtVOm
         7vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xnc6Q2CoR1bpiA0YRhHgEm9acKW9mLnzafi/qJY7ND8=;
        b=N6jO1jbRsVmBWm38EPugT11cHPoZlB1yfIsAM0jQWM46vO7aJPL+ncJsEETBUzU5cJ
         eVWbND+pWa2FF0PWH4WFk94WbOQgmkNLHYSH7PM6z0+YYrsULu2IQaJgYT2f+z4wZ/AK
         ZrvCbwAuD0CVwtih9BsCzY75ZIlcPln2vYKqPiU7BpbaopVAkeYvYgClwOxIAFXIB1V4
         i9tB1wfd9rdm03gut4JlaPJRB5gGKH511UizJ04LpjdxtXbZQOnsWRg17MNvdQgnQ5aL
         lj617f/iJP4gOMaCsu9uCK2Lp+zTvPxWmkvmwp04K0YJrqw8QiP1IeuGFNbuTTXfxsjB
         k9rQ==
X-Gm-Message-State: AA+aEWYEwDWEJdYm4APwjg7wetj6X+b8YJVDrMfUHm/CkucHQye1GcIQ
        iAvJdoMvJpmdfkvEeJUJ948GarbS
X-Google-Smtp-Source: AFSGD/XwKn5BuA9mp4nCPLXgZkSzMdn27Yq8B/233PhAyM8UFxIsGXKwqKOsqPXBAzGEPSr7DFKaBg==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr3514449wmn.128.1543969629594;
        Tue, 04 Dec 2018 16:27:09 -0800 (PST)
Received: from [192.168.0.1] (cpc149624-rdng29-2-0-cust819.15-3.cable.virginm.net. [82.15.3.52])
        by smtp.googlemail.com with ESMTPSA id o17sm8403132wmg.35.2018.12.04.16.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 16:27:08 -0800 (PST)
Subject: Re: Error setting UUIDs discovery filter on big endian systems
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
 <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
From:   Matt <mwtaylor@gmail.com>
Message-ID: <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com>
Date:   Wed, 5 Dec 2018 00:27:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 04/12/2018 19:53, Luiz Augusto von Dentz wrote:
> Hi Matt,
> On Mon, Dec 3, 2018 at 3:59 PM Matt <mwtaylor@gmail.com> wrote:
>> Hi,
>>
>> When setting a UUIDs discovery filter I am receiving
>> "org.bluez.Error.InProgress" on starting a scan (which isn't in progress
>> and will not start unless the discovery filter is cleared).
>>
>> I am using bluez 5.50 (on openWRT). The problem seems to only appear on
>> big endian hardware (tested a couple of recent kernel and bluez
>> versions), the same software compiled for and tested on little endian
>> hardware works as expected. The issue can be reproduced in the following
>> way using bluetoothctl:
>>
>> # /etc/init.d/bluetoothd restart
>> # bluetoothctl
>> [bluetooth]# power on
>> Changing power on succeeded
>> [CHG] Controller 00:1A:7D:DA:71:13 Powered: yes
>> [bluetooth]# menu scan
>> [bluetooth]# uuids 0000180f-0000-1000-8000-00805f9b34fb
>> [bluetooth]# back
>> [bluetooth]# scan on
>> SetDiscoveryFilter success
>> Failed to start discovery: org.bluez.Error.InProgress
>>
>> Setting an rssi filter does work as expected on my big endian hardware,
>> it is only the uuids filter that appears to show this problem. The issue
>> appears whether set using bluetoothctl or directly using DBus.
> Do you have the bluetoothd logs when that happens? I wonder if it is
> something with our string to UUID conversion.
>
>
When performing the above sequence in bluetoothctl with 'bluetoothd -d' 
I get the following in my log:

daemon.debug bluetoothd[22991]: src/agent.c:agent_ref() 0xb03e60: ref=1
daemon.debug bluetoothd[22991]: src/agent.c:register_agent() agent :1.29
daemon.debug bluetoothd[22991]: src/adapter.c:property_set_mode() 
sending Set Powered command for index 0
daemon.debug bluetoothd[22991]: 
src/adapter.c:property_set_mode_complete() Success (0x00)
daemon.debug bluetoothd[22991]: src/adapter.c:new_settings_callback() 
Settings: 0x00000ad1
daemon.debug bluetoothd[22991]: src/adapter.c:settings_changed() Changed 
settings: 0x00000001
daemon.debug bluetoothd[22991]: src/adapter.c:adapter_start() adapter 
/org/bluez/hci0 has been enabled
daemon.debug bluetoothd[22991]: src/adapter.c:trigger_passive_scanning()
daemon.debug bluetoothd[22991]: src/adapter.c:set_discovery_filter() 
sender :1.29
daemon.debug bluetoothd[22991]: 
src/adapter.c:parse_discovery_filter_dict() filtered discovery params: 
transport: 7 rssi: 32767 pathloss: 32767  duplicate data: false
daemon.debug bluetoothd[22991]: src/adapter.c:set_discovery_filter() 
successfully pre-set filter
daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery() sender :1.29
daemon.debug bluetoothd[22991]: src/adapter.c:update_discovery_filter()
daemon.debug bluetoothd[22991]: src/adapter.c:discovery_filter_to_mgmt_cp()
daemon.debug bluetoothd[22991]: src/adapter.c:trigger_start_discovery()
daemon.debug bluetoothd[22991]: src/adapter.c:cancel_passive_scanning()
daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery_timeout()
daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery_timeout() 
adapter->current_discovery_filter == 1
daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery_timeout() 
sending MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 1
daemon.debug bluetoothd[22991]: src/adapter.c:start_discovery_complete() 
status 0x0d
kern.err kernel: [709588.482104] Bluetooth: service_discovery: expected 
4100 bytes, got 20 bytes
daemon.debug bluetoothd[22991]: src/agent.c:agent_disconnect() Agent 
:1.29 disconnected
daemon.debug bluetoothd[22991]: src/agent.c:agent_destroy() agent :1.29
daemon.debug bluetoothd[22991]: src/agent.c:agent_unref() 0xb03e60: ref=0
