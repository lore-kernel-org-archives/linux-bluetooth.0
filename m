Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8DC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7673C20663
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="UUWUY8UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfCFSKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:10:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfCFSKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 13:10:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so9034299pgp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jcpmHV+k29P1FmsoW1jk0ftdTcORr/OOjVEI1JNI6Kg=;
        b=UUWUY8UTIGQbsJUjB0DmjYfeJyQoo8LVx0jf5ZgRLEeylIkiAfNZjeKdeuuIcHp8nM
         LAcENSd9L0uVbhFxcwke7/gXVTl8kmWIRjfEYmTlLdx1hbJeZW4MJvfLpIQplPnRW8Zp
         08YB/CMbf0ONF0qWB69tDJOkzQ5P7yAMYdnzq/1zGvZC8NjVdY+hkm0zvs/wUL9ep1rW
         hwzTqaK8PNSEHJglgNQEAJWZv8NCxh3vir4YN3AuCqVB/OD0Yl5ttbOgZ9CT6GgwPbPe
         eVKXDPVz14eBY0BMJUU7MlC6aIuPwdhjemTIe7ELVFl1xbJpchzE4edayrwkvd0QZ6X1
         Q7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jcpmHV+k29P1FmsoW1jk0ftdTcORr/OOjVEI1JNI6Kg=;
        b=LgpQfPacSrIx8LNju7xCcqvwFFLFVDKKxT278LarDoDHHraJ4AZHovojTCWU6k9NUi
         k1brOvy3IF7gyNWjkbh2kWCGevQd9HpDfsPL/mbE5+4g29wNdEmZdGbJJbrr/sK2wfO+
         UD9Mi4YT1hUGsVRj/ZWIaxPt/0pUX0b2mXQDAWKL85YCsaAtUagDBaH8CFUrkO8T6oi0
         tvb6Cuy05q7z5arzyvePqgRFfL3TKdmzHaBUZ/IY7PJOsLFEFWhxjViR4ataWKvb7hjo
         RMw0MDMLinXO6zGaF6Vuq1NE9h9lY+oZUOL57QZjifgPlgan7aOlIDaR2BLT8q/oUuhZ
         gGeA==
X-Gm-Message-State: APjAAAWOEz0grZ4HODszMWH3Mz5YG7EcAGD7BwSr1breZvSpO6akvq90
        oMR4+oUyzFNyq/TFvhXqhmnANg==
X-Google-Smtp-Source: APXvYqzA8zF2LFIfNzfUiRjvrEC9nzSajUSRU7GRf4Wi4tsu7KstRVHnNx/bmfDjcHGBVzPHahPFRQ==
X-Received: by 2002:a17:902:7a2:: with SMTP id 31mr1282466plj.246.1551895852338;
        Wed, 06 Mar 2019 10:10:52 -0800 (PST)
Received: from [192.168.69.121] (107-198-5-8.lightspeed.irvnca.sbcglobal.net. [107.198.5.8])
        by smtp.gmail.com with ESMTPSA id r28sm3357487pgl.72.2019.03.06.10.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:10:51 -0800 (PST)
Subject: Re: [PATCH 0/3] bluetooth: 6lowpan: multiple peers and addresses
From:   Michael Scott <mike@foundries.io>
To:     Josua Mayer <josua.mayer@jm0.eu>, linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        jukka.rissanen@linux.intel.com
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
 <a0d7f533-964c-7d5b-69be-840c26d05fd8@jm0.eu>
 <12348b37-c8ef-cf4a-a86e-ab09fadbc792@foundries.io>
Message-ID: <eb35ff67-1ec8-d5b6-05b9-b065ade27335@foundries.io>
Date:   Wed, 6 Mar 2019 10:10:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <12348b37-c8ef-cf4a-a86e-ab09fadbc792@foundries.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Josua,

On 2/28/19 12:30 PM, Michael Scott wrote:
> Hi Josua,
>
> On 2/28/19 12:00 PM, Josua Mayer wrote:
>> Ping
>>
>> Did anyone get a chance to look at this yet?
>> @Jukka I have added you in CC since this is about both 6lowpan and ble.
>>
>> Am 08.02.19 um 16:25 schrieb Josua Mayer:
>>> Dear maintainers,
>>>
>>> This patch set deals with an issue I reported earlier this year, where
>>> 1) packets addressed to a non-link-local address
>>> 2) any packets when at least 2 peers are connected
>>> were not delivered if they matched a direct peer i.e. no routing.
>>>
>>> The full explanation of the issue including steps to reproduce are:
>>> https://www.spinics.net/lists/linux-bluetooth/msg78486.html
>
> Thank you for submitting these patches!  I've been debugging what 
> seems to be the very same issue.
>
> My setup:
> - a Linux-based gateway running a fairly recent kernel (4.18) 
> connected to my local network (and the internet) via wifi/ethernet.
> - several Zephyr(RTOS)-based devices (mostly Nordic) connected via BLE 
> 6lowpan to the gateway
> - the gateway provides DNS64 and NAT64 translation, so that the 
> IPv6-based nodes can communicate with IPv4 services
>
> Much as you describe, everything works flawlessly when only 1 BLE 
> 6lowpan node is connected.
>
> Once a 2nd node is connected, all non-link local communication fails.  
> Using tcpdump to watch bt0 interface traffic on the gateway: it 
> *looks* like the packets are being sent back to the various nodes.  
> However, on the node side those packets are never received.   The very 
> second you bring the 2nd node down so that only 1 node is connected, 
> communication on non-link local IPs is immediately restored.
>
> NOTE: I can reproduce the same behavior on a 4.20 kernel using my 
> laptop, so this issue is still valid.
>
> I should be able to apply these patches to my local setup today or 
> tomorrow, and I'll write back regarding the experience.

Apologies for the delay, work has been very busy.

I was able to test these patches and everything works well on my end.  
Feel free to add my Tested-By:

Tested-by: Michael Scott <mike@foundries.io>

>
> Thank you again,
>
> - Mike
>
>>>
>>> Please comment if I am on the right track here, especially on the
>>> second patch in this series where I am nto completely sure if I found
>>> the right api call to the neighbour cache.
>>>
>>> Josua Mayer (3):
>>>    bluetooth: 6lowpan: search for destination address in all peers
>>>    bluetooth: 6lowpan: check neighbour table for SLAAC
>>>    bluetooth: 6lowpan: always check destination address
>>>
>>>   net/bluetooth/6lowpan.c | 40 ++++++++++++++++++++++++----------------
>>>   1 file changed, 24 insertions(+), 16 deletions(-)
>>>
-- 
Michael Scott
Embedded Software Engineer at Foundries.io
"microPlatforms™ for Connected Products"
E: mike@foundries.io
W: https://www.foundries.io

