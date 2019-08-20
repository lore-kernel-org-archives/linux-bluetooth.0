Return-Path: <SRS0=V5YL=WQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB222C3A589
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9710E214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZHzOOjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfHTNYA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:24:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35596 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNX7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Aug 2019 09:23:59 -0400
Received: by mail-io1-f67.google.com with SMTP id i22so12110132ioh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2019 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QQes9DUnXhC73eARxBQoQrmlVOBm48ISTAGez9p7qCY=;
        b=mZHzOOjAEKAq73dT64KmuMkQXqP8N1ka0Z/7JPZ2gAe4VQ9gMCk+9ZqkkdIpQQpQJ9
         i5kYssKS4Wsa72nkvvwIsqQzKWK7jWhSGB2JZU8N+Bwfy0x2QKtGkv4cEeA/isRxCN/9
         Sg3M8eipg1hl+Cs19sW/g4+s7n83A+JVoJyPNQQ63hT3QgiTHMHK/JXoqdmIfuoLMnCW
         eyQsgfLnDLAYPv8oLKD9Eak8GIOZUzem9pAL5br8TllWG9YHUaZeQrE2M/3y8ncocdNe
         xW7l3VrIVY9Sln2yq6CzetRH5sPVOHqHPYXUxluuNokmClhg0AhF95OPNcHtDZKarFBY
         8W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=QQes9DUnXhC73eARxBQoQrmlVOBm48ISTAGez9p7qCY=;
        b=MxEo5Mo8igeEgKJyRr3jE2eXixepCqrg5piiN43lmNWxypj5XIzee5HeZwt3YgXt8J
         H1N5WYQBMvfVvCx2jOdWVMYPo4I7UrNtHZ7J7znE98p7L6/jnwCdN6Br31BwhzUSnMQU
         mRPmyFDVb4ZzoirxFPddm2qswYCJBhfKJdi+OTCM/7CoVfuzIibT7U26y5OnpVpuHwts
         0ETD44Ee2pAHG41v4ovmBz8+3GtMEFFDpJ7JigYQGfYjv5Zbx2uWqe4mAsP9szlz4kav
         Z/fIxY0eQ96bWThdGf84FC6F7HavSTYcFUAG8My/NgOPv8sdzJ/jNsKEO8xxPANT1PKD
         6bxQ==
X-Gm-Message-State: APjAAAUn1Tgo4uIi4CSdBx6EW7wk3Jzm92Xb35h34Fg6YnGuCSX1ZsvN
        h3jV9Xn8UWyN8W/BnAXnoOs=
X-Google-Smtp-Source: APXvYqzqhFUIl05u0Dw1kIQlz8YCVHfFR510f4n4DqfWoj2R9MCcqqHiSLW6N1hS93O5hlYXTHoJ1Q==
X-Received: by 2002:a5d:9945:: with SMTP id v5mr17526182ios.143.1566307437709;
        Tue, 20 Aug 2019 06:23:57 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id p3sm15553089iom.7.2019.08.20.06.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:23:56 -0700 (PDT)
Reply-To: csonsino@gmail.com
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
 <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
 <20190815104419.161177fa@kemnade.info>
 <0cda8242-304e-a073-90d8-63e656e3600c@gmail.com>
 <20190819180813.04a8e771@kemnade.info>
 <624153c1-d462-1d6d-ddb2-ac7c03575a2c@gmail.com>
 <CY4PR1401MB186367631A1B8616845C8728E6AB0@CY4PR1401MB1863.namprd14.prod.outlook.com>
From:   Carey Sonsino <csonsino@gmail.com>
Message-ID: <b8afc6d6-9e4a-c930-0042-100f2e52a192@gmail.com>
Date:   Tue, 20 Aug 2019 07:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR1401MB186367631A1B8616845C8728E6AB0@CY4PR1401MB1863.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Jamie,

I completely agree that different devices should (and need to) be able 
to negotiate their own desired connection interval... as long as the 
connection interval that they want to use is within the bounds that I as 
a Linux system administrator have allowed my system to operate.

Admittedly, the current situation is not good because the default values 
are 24/40, so without additional modification (which it turns out may 
not be easy or possible if you don't have debugfs) a device can only 
negotiate a connection interval between 30ms and 50ms otherwise it will 
receive a negative/rejection response.  But if we were to change the 
default values to 6/3200, then any device would be able to negotiate 
it's own desired connection interval between 7.5ms and 4000ms and 
additional configuration would be required to restrict that range.

I think that if multiple BLE devices were connected to my Linux machine, 
the BLE radio would have to "wake up" on the schedule of the shortest 
connection interval, so I'm not convinced that you would actually get 
any benefit from a min/max per client.  But I do agree that I like 
having that level of control.  If we did want to support a min/max per 
client, information is already stored per-client in 
/var/lib/bluetooth/<DEVICE_MAC>/ (for secure keys and other things) and 
we could probably add min/max configuration down there somewhere.  Maybe 
it could even just override the global min/max in the debugfs area.

But also please note that the patch in question does not know or care 
how the current connection's interval was configured.  It could be from 
a global setting, or it could be device-specific configuration.  All it 
knows is that the current connection has min/max values, and if the 
remote device requests to change the connection interval, the requested 
value should be checked against the min/max bounds of that connection.

If the desired behavior were for Linux to blindly accept and return a 
successful response for any connection interval change request value, 
then it makes no sense to have a min/max at all. The min/max would 
essentially be any value allowed by the bluetooth spec, and having the 
notion of a min/max connection interval is confusing and misleading.  I 
believe that if you have bounds defined, then values should be checked 
against those bounds.

Regards,

Carey


On 8/20/19 12:45 AM, Jamie Mccrae wrote:
> Hi,
>  From my many years' experience of embedded Bluetooth LE development I
> would say that offering different connection intervals to different
> devices is a must. If you have 3 devices connected to a laptop, for
> example 1 device in DFU mode, 1 keyboard and 1 temperature sensor, you
> would want vastly different connection interval settings for all of
> these. To speed up a firmware update process on the DFU device you would
> want the lowest connection interval (and I can speak from experience
> having seen an embedded linux SoC try to update a device over DFU via
> Bluetooth LE on Bluez 4.x and DBUS that it took in excess of 30 minutes
> per device, compared to 1 minute on an android phone). They keyboard is
> likely to negotiate a slave latency so that it can stay idle if no keys
> are pressed for many connection intervals but if something is
> pressed then it can respond fast, and the temperature sensor is going to
> have a much larger connection interval, if the sensor itself gathers a
> new reading every minute, then a connection interval of 30 seconds would
> be fine. So to make things easy for both developers and users, how would
> you go about doing that? Simply having a single 'minimum' and 'maximum'
> connection interval in a file or hard-coded is not a workable solution
> and does nothing to help user experience.
> Thanks,
> Jamie
>
>> Andreas,
>>
>> Considering that this patch has already made it's way into stable trees,
>> and the only options are to back it out or to patch it again, I would
>> obviously prefer to keep it in and patch it again.  I think that it
>> would be fairly quick and painless to just set the default min/max to
>> 6/3200, or add an additional flag as you suggested, which should resolve
>> any problems in the near term.
>>
>> Longer term, I think that there are several ways to allow the system
>> admin to configure the allowable min/max, but it only matters if the
>> system will check requests against the configured min/max and respond
>> appropriately, which is what the patch in question does.  The best
>> current way that I'm aware of to control the system-wide connection
>> interval is through the existing debugfs mechanism, and in my opinion it
>> didn't work correctly without this patch.
>>
>> Regarding power consumption, I have not done any power measurement
>> testing to determine the effect of connection interval on power
>> consumption, so perhaps that was not the best use case.  Here is the
>> exact real world use case that caused me to write the patch in the first
>> place:
>>
>> I was writing a Linux-based test system for an embedded
>> BLE-communication based product.  The product embedded code was written
>> to attempt to renegotiate the connection interval to a fairly low number
>> after the initial connection was established. My test system had a
>> requirement to be able to perform the tests using various pre-defined
>> connection intervals so that I could gather data throughput and product
>> performance metrics.  Every time my test system attempted to perform a
>> test a the desired connection interval, the device would immediately
>> request to renegiate to a lower value.  Linux would accept that request
>> and return a successful response, and I had no way to stop it.  Let's
>> not go down the "Why didn't you just change the embedded code?" / "Why
>> doesn't Linux reject values outside of the configured bounds?" rabbit
>> hole...  :)
>>
>> Carey
>>
>> On 8/19/19 10:08 AM, Andreas Kemnade wrote:
>>> Hi Carey,
>>>
>>> On Mon, 19 Aug 2019 07:58:19 -0600
>>> Carey Sonsino <csonsino@gmail.com> wrote:
>>>
>>>> This seems like the exact "downside" situation that I described in the
>>>> patch writeup.
>>>>
>>>> I would still claim that as a Linux system administrator, I should have
>>>> control over my system.  If I am operating in a low power environment, I
>>>> do not want to allow a remote device to apply a setting which causes me
>>>> to use more power without any say in the matter.
>>>>
>>> In principle I agree here. High connection interval has its downsides,
>>> low connection interval also. Just curios: What are the numbers about
>>> power consumption here? A few mA? I have only compared these values on
>>> peripherals running on low-power SoCs like e.g. the nrf stuff from nordic.
>>> I see around 1 mA difference there with a power consumption besides of that
>>> usually measured in the µA range. Never tested these things on a linux machine.
>>>
>>> The point here is that with this patch there is insufficient control
>>> about this. Yes, there is the debugfs interface.
>>>
>>> But if you want to provide a driver to a gatt service living on top of
>>> bluetoothd dbus api? Ask people to not use distribution kernels?
>>> What options do you have?
>>> using the monitor interface to sniff the connection handle and then
>>> call hci_le_conn_update() to set things?
>>>
>>>> The connection min/max interval settings are configuration options that
>>>> control how my bluetooth device operates.  Why are these down in debugfs
>>>> anyway?  I think that a much more appropriate fix would be to migrate
>>>> some of the BLE configuration options to sysconfdir (some place like
>>>> /etc/bluetooth/ble.conf).  That would also help in the persistence of
>>>> these configuration settings, which is kind of a pain with the debugfs
>>>> mechanism that gets wiped out and recreated on bootup.
>>>>
>>> I think that these things should be part of the  dbus api provided
>>> by bluetoothd so that a driver could decide and having defaults outside
>>> of such a dark corner like the debug fs.
>>>
>>>> A quicker fix would be to simply set the default connection min interval
>>>> and connection max interval values to the full range (6, 3200).
>>> Or just maybe a flag allowing such behavior?
>>>
>>>> *think* that this could be done by simply updating the values in
>>>> hci_core.c, the hci_alloc_dev() function:
>>>>
>>>>        hdev->le_conn_min_interval = 0x0018;
>>>>        hdev->le_conn_max_interval = 0x0028;
>>>>
>>>> would become:
>>>>
>>>>        hdev->le_conn_min_interval = 0x0006;
>>>>        hdev->le_conn_max_interval = 0x0c80;
>>>>
>>>> This should allow all devices to negotiate whatever connection interval
>>>> they want by default.  If I'm running on a device with debugfs (which I
>>>> happen to be most of the time), then I can still override these defaults
>>>> to control my system.
>>>>
>>>> Please let me know if you would like me to do any further work towards
>>>> resolving this issue.  I'd be happy to test and submit a patch that
>>>> changes the default connection min/max interval values- I could probably
>>>> get that done in the next day or two.  If you would like me to
>>>> investigate migrating configuration settings to /etc then I'd be happy
>>>> to do that as well, but it might take a bit more effort and time.
>>>>
>>> Well, all these things are important, but are new features but there is a
>>> problem:
>>> The kernel patch has gone into the stable trees and from there into distributions,
>>> so how can these new features flow down the same path.
>>>
>>> Regards,
>>> Andreas
>>>

