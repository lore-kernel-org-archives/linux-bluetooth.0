Return-Path: <SRS0=KRcZ=RD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B771C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 20:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C57218AE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 20:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="ZjS9OqEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfB1Uar (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:30:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42438 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfB1Uar (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Feb 2019 15:30:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so10260487pfi.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Feb 2019 12:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iPcsZ4GUnkGPXWTcotGjzCqf8hYf1tjKHff7ExAhiAs=;
        b=ZjS9OqEN867kMPNHHL0bJ0TZHhHdlg9lCVJK0gXr536lPqyt+uXQSRlyAAd/024Y5g
         O8vk7Gq3lI+HIamA3zeXFYGVVwxcxgDM+D69Zbq0CGpBTlVsEkKd4Lxe/X5iWeGJRXUi
         MZuXXPvoP9SL+lfSnsqqJqoEx3LBiaNAMNIuhvJOnW8ebxK9ly4NP7xZiyI2kmjNrliH
         qE5A+794BhTNeSwNSmnnwvFJwhROytzyVF4Zc3qCjppAEIONdrC7ruqZRvKXaQGHzVqJ
         NgzWG98YBmzctX2k//3A/AIfcVsikeLaePtCLXrgIfmGcHsxvMguLWOOC1EIcNNhpYFN
         dQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iPcsZ4GUnkGPXWTcotGjzCqf8hYf1tjKHff7ExAhiAs=;
        b=aufLu1t6rdCCCJwa77MSOVbOHbdL/e8sfx8EYQNJ8SA98KT5De7cw0oSDfwGSLJl9a
         OAT/lH6L5Jn2lpO8ANqsJwLnqHk1GdlmKUB6Wpra+0kVTehkBEh0z58TB2yMFwawadV+
         GsUim3txQaK8mXY69L07yYICochUnXVkGLEZUjmCBHO63LdJa+QBAL3x4080FxACVr7R
         2YKD+IDVrZQLN0DqnWVu2baeUbV6/Rz1O7dg+fO4wzzAqFsjAQS9GczQR9B0jlU8Zi7f
         Vv0EjyOFg8MDaBExBK+oUgnocLluPGiFUcNaoQYJVZYOlUJbOCjM0NHIZI3OFUzuhc2g
         gf3g==
X-Gm-Message-State: APjAAAVtVtk3psuuG6yn5ORqiTxg7tRXycNEDo6nF+WIaEuY74gGrj5O
        imrXisaTI7bojQUdS2wGAj+I2Q==
X-Google-Smtp-Source: APXvYqw7JW4kHI8seJoO1lcjxB21h2UCzudiBgSNsKq6l3pOxu1gitMAq304ecRcX6fbrbj/W5+faA==
X-Received: by 2002:a63:f718:: with SMTP id x24mr1003637pgh.107.1551385845937;
        Thu, 28 Feb 2019 12:30:45 -0800 (PST)
Received: from [192.168.69.121] (107-198-5-8.lightspeed.irvnca.sbcglobal.net. [107.198.5.8])
        by smtp.gmail.com with ESMTPSA id b6sm18044184pgl.49.2019.02.28.12.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:30:45 -0800 (PST)
Subject: Re: [PATCH 0/3] bluetooth: 6lowpan: multiple peers and addresses
To:     Josua Mayer <josua.mayer@jm0.eu>, linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        jukka.rissanen@linux.intel.com
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
 <a0d7f533-964c-7d5b-69be-840c26d05fd8@jm0.eu>
From:   Michael Scott <mike@foundries.io>
Message-ID: <12348b37-c8ef-cf4a-a86e-ab09fadbc792@foundries.io>
Date:   Thu, 28 Feb 2019 12:30:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a0d7f533-964c-7d5b-69be-840c26d05fd8@jm0.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Josua,

On 2/28/19 12:00 PM, Josua Mayer wrote:
> Ping
>
> Did anyone get a chance to look at this yet?
> @Jukka I have added you in CC since this is about both 6lowpan and ble.
>
> Am 08.02.19 um 16:25 schrieb Josua Mayer:
>> Dear maintainers,
>>
>> This patch set deals with an issue I reported earlier this year, where
>> 1) packets addressed to a non-link-local address
>> 2) any packets when at least 2 peers are connected
>> were not delivered if they matched a direct peer i.e. no routing.
>>
>> The full explanation of the issue including steps to reproduce are:
>> https://www.spinics.net/lists/linux-bluetooth/msg78486.html

Thank you for submitting these patches!  I've been debugging what seems 
to be the very same issue.

My setup:
- a Linux-based gateway running a fairly recent kernel (4.18) connected 
to my local network (and the internet) via wifi/ethernet.
- several Zephyr(RTOS)-based devices (mostly Nordic) connected via BLE 
6lowpan to the gateway
- the gateway provides DNS64 and NAT64 translation, so that the 
IPv6-based nodes can communicate with IPv4 services

Much as you describe, everything works flawlessly when only 1 BLE 
6lowpan node is connected.

Once a 2nd node is connected, all non-link local communication fails.  
Using tcpdump to watch bt0 interface traffic on the gateway: it *looks* 
like the packets are being sent back to the various nodes.  However, on 
the node side those packets are never received.   The very second you 
bring the 2nd node down so that only 1 node is connected, communication 
on non-link local IPs is immediately restored.

NOTE: I can reproduce the same behavior on a 4.20 kernel using my 
laptop, so this issue is still valid.

I should be able to apply these patches to my local setup today or 
tomorrow, and I'll write back regarding the experience.

Thank you again,

- Mike

>>
>> Please comment if I am on the right track here, especially on the
>> second patch in this series where I am nto completely sure if I found
>> the right api call to the neighbour cache.
>>
>> Josua Mayer (3):
>>    bluetooth: 6lowpan: search for destination address in all peers
>>    bluetooth: 6lowpan: check neighbour table for SLAAC
>>    bluetooth: 6lowpan: always check destination address
>>
>>   net/bluetooth/6lowpan.c | 40 ++++++++++++++++++++++++----------------
>>   1 file changed, 24 insertions(+), 16 deletions(-)
>>
-- 
Michael Scott
Embedded Software Engineer at Foundries.io
"microPlatforms™ for Connected Products"
E: mike@foundries.io
W: https://www.foundries.io

