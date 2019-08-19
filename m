Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E6C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5231522CEB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ2I1Qcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfHSRKw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:10:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSRKv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 13:10:51 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so5930282ioa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6vsdPHMc2yAtS4wTo18vV6fkZPfCs+gH5x+BhCkFg68=;
        b=jQ2I1QcxId45JVLbg9s2h5Q7QvskvoLkNg1IAPIGwqH0gr1+jpuNKWFvFRFmx8FZlU
         PWZeL9Y1lokEh7Gu7FKCnDp+l64coL16QSMttgaFrMYuWMJHW8nbH05tfqtusBk2kzxa
         Gk8PUp5Z+ChSNGZxVBnMKDbXkqcGIbwYjrwtlBBcIAstsRPqJsqVLNNeU6DiK7QvGyEB
         nAXnVbq4sUXOjbKV2uuz0lZWJ0312vVXdHzqCuTUYbpc9+ZWABey4sQDba7WKODxYHdd
         vQkfm5Fug0uTe/ai3ilBC4/HtyG2f7YNv199tQF2u/kILPCzQ0BKmbfRUQzJqwlbhqmH
         afwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6vsdPHMc2yAtS4wTo18vV6fkZPfCs+gH5x+BhCkFg68=;
        b=HfU/fynmlCkuksPlaF2P+dPun8pvwL4AUZY9Pw++zO00Rm0IgAczifNYfHkmoO7GOZ
         EA57sy1KFxi1t04b3UFVczNsoRd6etx6P17vWWvGUC4RawPf97aQWfFR9C9rK3GR0brI
         i9pkMYtrtbps7SPTS7YUlrJqtHHNBaSVE3dS1pC5w5cdHtzRr3vYuD5WaThh9k+k7iCf
         wriVznoDYbchzdhf0uL68GJsCZuyzBLCHNV1nNTda3bqo+BwHCsg1E8wYq+7UDsBWKFI
         tdmVj3BH3J0yfzu7TnVIHu96Y7n+MhLCIZUKNU/z7R5Mjyq2kh6tbEigH6Q1jWI21Bf5
         OiHQ==
X-Gm-Message-State: APjAAAXE0NHMI61Juy8lAmlcXPEWtWB60wAqvUm8cpVy7lJq/07U05P7
        5ZQhaiEk2OnFLLuUAWaCauE=
X-Google-Smtp-Source: APXvYqwDfILR56ATAbrJI21kLPgHmcV7XNAe1wwmJzKqL7BtRkquEqEQv4J5IL55k3+1ODbIvJc7IQ==
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr478208iog.153.1566234650738;
        Mon, 19 Aug 2019 10:10:50 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id k3sm22063326ioq.18.2019.08.19.10.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:10:49 -0700 (PDT)
Reply-To: csonsino@gmail.com
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
 <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
 <20190815104419.161177fa@kemnade.info>
 <0cda8242-304e-a073-90d8-63e656e3600c@gmail.com>
 <20190819180813.04a8e771@kemnade.info>
From:   Carey Sonsino <csonsino@gmail.com>
Message-ID: <624153c1-d462-1d6d-ddb2-ac7c03575a2c@gmail.com>
Date:   Mon, 19 Aug 2019 11:10:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819180813.04a8e771@kemnade.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Andreas,

Considering that this patch has already made it's way into stable trees, 
and the only options are to back it out or to patch it again, I would 
obviously prefer to keep it in and patch it again.  I think that it 
would be fairly quick and painless to just set the default min/max to 
6/3200, or add an additional flag as you suggested, which should resolve 
any problems in the near term.

Longer term, I think that there are several ways to allow the system 
admin to configure the allowable min/max, but it only matters if the 
system will check requests against the configured min/max and respond 
appropriately, which is what the patch in question does.  The best 
current way that I'm aware of to control the system-wide connection 
interval is through the existing debugfs mechanism, and in my opinion it 
didn't work correctly without this patch.

Regarding power consumption, I have not done any power measurement 
testing to determine the effect of connection interval on power 
consumption, so perhaps that was not the best use case.  Here is the 
exact real world use case that caused me to write the patch in the first 
place:

I was writing a Linux-based test system for an embedded 
BLE-communication based product.  The product embedded code was written 
to attempt to renegotiate the connection interval to a fairly low number 
after the initial connection was established. My test system had a 
requirement to be able to perform the tests using various pre-defined 
connection intervals so that I could gather data throughput and product 
performance metrics.  Every time my test system attempted to perform a 
test a the desired connection interval, the device would immediately 
request to renegiate to a lower value.  Linux would accept that request 
and return a successful response, and I had no way to stop it.  Let's 
not go down the "Why didn't you just change the embedded code?" / "Why 
doesn't Linux reject values outside of the configured bounds?" rabbit 
hole...  :)

Carey

On 8/19/19 10:08 AM, Andreas Kemnade wrote:
> Hi Carey,
>
> On Mon, 19 Aug 2019 07:58:19 -0600
> Carey Sonsino <csonsino@gmail.com> wrote:
>
>> This seems like the exact "downside" situation that I described in the
>> patch writeup.
>>
>> I would still claim that as a Linux system administrator, I should have
>> control over my system.  If I am operating in a low power environment, I
>> do not want to allow a remote device to apply a setting which causes me
>> to use more power without any say in the matter.
>>
> In principle I agree here. High connection interval has its downsides,
> low connection interval also. Just curios: What are the numbers about
> power consumption here? A few mA? I have only compared these values on
> peripherals running on low-power SoCs like e.g. the nrf stuff from nordic.
> I see around 1 mA difference there with a power consumption besides of that
> usually measured in the µA range. Never tested these things on a linux machine.
>
> The point here is that with this patch there is insufficient control
> about this. Yes, there is the debugfs interface.
>
> But if you want to provide a driver to a gatt service living on top of
> bluetoothd dbus api? Ask people to not use distribution kernels?
> What options do you have?
> using the monitor interface to sniff the connection handle and then
> call hci_le_conn_update() to set things?
>
>> The connection min/max interval settings are configuration options that
>> control how my bluetooth device operates.  Why are these down in debugfs
>> anyway?  I think that a much more appropriate fix would be to migrate
>> some of the BLE configuration options to sysconfdir (some place like
>> /etc/bluetooth/ble.conf).  That would also help in the persistence of
>> these configuration settings, which is kind of a pain with the debugfs
>> mechanism that gets wiped out and recreated on bootup.
>>
> I think that these things should be part of the  dbus api provided
> by bluetoothd so that a driver could decide and having defaults outside
> of such a dark corner like the debug fs.
>
>> A quicker fix would be to simply set the default connection min interval
>> and connection max interval values to the full range (6, 3200).
> Or just maybe a flag allowing such behavior?
>
>> *think* that this could be done by simply updating the values in
>> hci_core.c, the hci_alloc_dev() function:
>>
>>       hdev->le_conn_min_interval = 0x0018;
>>       hdev->le_conn_max_interval = 0x0028;
>>
>> would become:
>>
>>       hdev->le_conn_min_interval = 0x0006;
>>       hdev->le_conn_max_interval = 0x0c80;
>>
>> This should allow all devices to negotiate whatever connection interval
>> they want by default.  If I'm running on a device with debugfs (which I
>> happen to be most of the time), then I can still override these defaults
>> to control my system.
>>
>> Please let me know if you would like me to do any further work towards
>> resolving this issue.  I'd be happy to test and submit a patch that
>> changes the default connection min/max interval values- I could probably
>> get that done in the next day or two.  If you would like me to
>> investigate migrating configuration settings to /etc then I'd be happy
>> to do that as well, but it might take a bit more effort and time.
>>
> Well, all these things are important, but are new features but there is a
> problem:
> The kernel patch has gone into the stable trees and from there into distributions,
> so how can these new features flow down the same path.
>
> Regards,
> Andreas
>

