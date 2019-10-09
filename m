Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C4C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A638206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=einfach.org header.i=@einfach.org header.b="WF6cItkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfJINJH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:09:07 -0400
Received: from postler.einfach.org ([5.9.2.179]:44649 "EHLO
        postler.einfach.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfJINJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 09:09:07 -0400
Received: from [192.168.5.9] (unknown [83.55.204.182])
        by postler.einfach.org (Postfix) with ESMTPSA id 3164C24DA;
        Wed,  9 Oct 2019 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=einfach.org; s=mail;
        t=1570626544; bh=rmSg8CA9vtrr50dL/pRP+U+Z8JSd6rtUkaF0NOB4+tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WF6cItkb7hOLnAQDYo625csp8uwtfi9XUrDmz4fccOp1lbFrHh/dH7uMy1vnJBnyG
         0qRu7xJr47W0JuHekWAgUuiA/ozNGjCXtGiCU0KahGNk0DANOiSr6mJjVoC3V8lgO1
         8rBIhm49j2ztqJrQUiIgR5ivDIe17LTtQ6vS3XsI=
Subject: Re: bluetoothd: Please don't filter UUIDs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
 <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com>
From:   Bruno Randolf <br1@einfach.org>
Openpgp: preference=signencrypt
Autocrypt: addr=br1@einfach.org; prefer-encrypt=mutual; keydata=
 xsBNBFJpIRIBCACxTu2oWUM4vbNxNSCcjw5ni3MeVFUUDNFukzepEUjbICSt/939ytVm7Z30
 skb9SHJe3W6LPNjcjRni97FTumyb0paDSLlj31oyJHISVjm+Ho82/WTxjz2j0hl3xy8Ou21H
 JEXv+05mAtxfWUIPYfJImJ7N8x9J0fM2IxttGKbK8MAbYaVO4114fBSSIOt78TlXNQvwqHdf
 4rLb3eXqnLF2XV1qyBBZPfieEbe3Rf2q/h65o7YFvrkYx1pEFrxSaYAymXzafcZj+zjz+Zb7
 XslOCDwwKbI2UdBZEn868mNbgpTOn68NfFDx2jyQKu2u+36+mWfaetyMdBovQuC2d1QJABEB
 AAHNH0JydW5vIFJhbmRvbGYgPGJyMUBlaW5mYWNoLm9yZz7CwJgEEwECAEICGyMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE3A0MZg9YDVxz+wTLTTqe7xBJ1YEFAlvPjYgFCQ8K
 BvYACgkQTTqe7xBJ1YEF1gf9GhTWp5y6SSm/XdBfdhdjYvmu4jHqd+WZk9oKHHbW/0I22VH4
 qyLqvMDGsRGD+nTchmM28CmxuWsHp56cG7eWZPnggTBssQfQNJdzLMkd7GQ8ZGuASVJF8tdP
 lHAZrTd+fb248Xw4nCyTXIw9t2/wXuXR0UGVwomMVM2PrCkPHVWbe8lak2YpR0NKm91IP2j8
 WJGsIElS+bL8F6/ZGAL86izbfk70tZpz23R6ssIyWtyRJWP0oSWXzWC52C8UvSri8XciWy0e
 gpXv7Wz4rJ8ANNWl2irc0PLLoq8dKSRRustJ16E35GOlqfapNV0kai75uU5OQxGIl47Orfei
 6PMQDM7ATQRSaSESAQgAxpMfiD/Sdi32y5/Tg0qhh5znQsYfYPoEtMvGNagpfeyeUk2UTlz4
 HSxCiKNyDimRPslMFW+GlPpvjnPq6ELMyAwlyJwPrqIkNntlrPJObznBlFSlQryyNLK7ZUtD
 aDcE2e8kZcIVQCzPOgR/HwbjNqU9UOnzE2ODrIsm1Y/ozLHIhNmnKVIEubWZebYHVjUUnf0w
 VuyOu/FSiHyvggGv/F2sZuysc4r4RShdk7tvBd44YWmZYlgB8BdGYpYZSuHbE6y776dGVEHk
 6Mzxwjnl0i/2BA0A35ivUEcEfhYj/dd98gFrFLg89n56rbBUn5157wjHMq+B+AiWfxg59r4T
 TQARAQABwsBlBBgBAgAPBQJSaSESAhsMBQkJZgGAAAoJEE06nu8QSdWBwBMH/i6S2jE3d+M8
 Fn4AOnj2XjIYDEVi9fHbh8r1fCusRODGXnIc7Jvwv/qIgZbBtLlGKOaWjTTtN8+l5DGhC0a3
 rsvrRgZMsLezwK7S7KNaEzmstkqEipSQfH9KpD1DJhPlpd85cXYqzkDgizMbJN1K1HavULQm
 U5WwTvLo+C05fIhHx4Aj8LmXrjXxCQR/y8wrQxMEkQKBMVNe8S60MxysqfJLP5a/524BSQF3
 c6fOB5Asfu8vCOMoOtJwy0OKQ35+lpsZG1zwMqA7wIjDALuZ4TOMRVmDODDRoxByY8Nz1jfv
 /NRp2tQ0amOFtZrperKA2GIS7iUruHVLEXUrySZlK2fCwHwEGAECACYCGwwWIQTcDQxmD1gN
 XHP7BMtNOp7vEEnVgQUCW8+NpQUJDwoHEwAKCRBNOp7vEEnVgfw1B/4vBBtZWHJuXIc55jtB
 VQJ/1/BLeb9aR97OkOETej77YrOYBMkAO3QkTBHoTj72inGbUBgC3daSkYtjC5qCRAUb02qs
 Srx/cMsH9CTwaxCrCnB9SfNIZwuFsCNjjWTsKXT0czbCYkKVlS8c9RjbpO+ehdicXRs4C9bF
 xAfkIcBUP6V2l6E89idXuD0LAJJG/v5CoNkykTDY0S81PcTAOwsZ+sSgcWb+tOUVQ/gnizj8
 eSQ2NKJ38LOvT+Fc1EOMNEdHZ4V4xwM5n2XUd75lKKdynwysLFbc52nDZbZLdwBmw92a4kAT
 kcSK3qeB7qKuAXopxt5uEFNOKZeKF/UQlKrr
Message-ID: <12b16466-3633-75ff-bf84-9cef44a2358c@einfach.org>
Date:   Wed, 9 Oct 2019 14:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11 (postler.einfach.org [0.0.0.0]); Wed, 09 Oct 2019 13:09:04 +0000 (UTC)
X-Virus-Scanned: clamav-milter 0.98.7 at bced1da0f74a
X-Virus-Status: Clean
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 03/10/2019 14:04, Luiz Augusto von Dentz wrote:
> Well I guess you are forgetting that other users of the GATT may
> interfere with plugin which is why we do the claim APIs in the first
> place.

Okay, I understand your arguments from your perspective, which seems to
focus on specific use cases with Desktop Linux.

But how do you suppose should application programmers or solution
providers access GATT characteristics under Linux in a predictable way
then? Not using BlueZ does not seem like a realistic option. Building
patched versions of bluetoothd isn't practical either.

At the very least there should be a build option to deactivate all
plugins, but I think something more flexible would be better. Could it
be a user choice? E.g. only claim services which the User has actively
connected to and activated that service?

In general I don't need to poll the battery status of every device I
happened to connect to, even though it might export a Battery service...
so I'd consider it more traffic if BAS is polled even though I didn't
ask for it. On the other hand on a Bluetooth device I have paired with,
something like a Headphone or Keyboard it obviously is the right choice.

I hope there is a way to support both use cases.

Regards,
bruno

>> It surely makes sense to provide this more generic API, but I'd argue
>> that all services and characteristics should be available via the normal
>> GATT-based API using org.bluez.GattCharacteristic1 as well.
> 
> Not if the service has security implication, for instance we don't
> want application to be able to access the keys presses coming from a
> HoG device, or other things like changing the settings bluetoothd has
> configured.
> 
>> One of my clients, for example, uses Linux/bluez as an interface for
>> Server-based reading and writing of GATT characteristics of several
>> managed devices. So I can read all those UUIDs, but why not the battery
>> level? What happens when Bluez learns other GATT services, will their
>> characteristics then also disappear? I think there is a strong argument
>> for maintaining a generic API for GATT reading/writing characteristics
>> independently.
> 
> But there is even a stronger argument if something breaks because the
> app access something it shouldn't, even if there are no conflicts
> between the plugin the very least it would cause is duplicating the
> traffic.
> 
>> I made the following change to the bluetoothd code to get access again
>> to all UUIDs, and I would like you to consider to include it upstream to
>> enable us to access all characteristics via the normal GATT API:
>>
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -2006,9 +2006,6 @@ static void export_service(struct
>> gatt_db_attribute *attr, void *user_data)
>>         struct btd_gatt_client *client = user_data;
>>         struct service *service;
>>
>> -       if (gatt_db_service_get_claimed(attr))
>> -               return;
>> -
>>         service = service_create(attr, client);
>>         if (!service)
>>                 return;
>>
>> Thank you,
>> bruno
>>
>>
>> [1] I published parts of that as an open source library:
>> https://github.com/infsoft-locaware/blzlib
>>
>> [2]
>> https://stackoverflow.com/questions/49078659/check-battery-level-of-connected-bluetooth-device-on-linux
>>
>>
> 
> 
