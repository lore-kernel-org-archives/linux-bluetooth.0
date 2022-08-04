Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B64C19F29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiHDAHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiHDAF5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:05:57 -0400
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F45DF23
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:05:56 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.106.20.54])
        by endrift.com (Postfix) with ESMTPSA id 23C3DA05B;
        Wed,  3 Aug 2022 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1659571556; bh=gJXQX/WG4EtlFaxS/I3ZwzCz0bSFUFkwopQ2MftQAZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pZUzhaHDVLUiJHJeYntx/uEMrD3p93uFaNIUhTMWjy9md3KPg8FHUYKksAW4eyBvK
         zRLdWR+g6gEpFL/2ioMMRPtaknarliG9TN5UYMAAnAQID8/pwYPt90JDp5U2438/Ui
         +eJwE7KplZc68jjSpiDh+i3qAMGgjguNB/bIkkP5KZFmflD8ElhyZn6N41vLHkTirj
         33HBVQB/7K4XxqI3xoqzEpeLAv30tVds4wwy6M1qRrXG59f5fgGK6LcD9R9URfjmfx
         UrWLy29Egk363ccxBsPhLg0kxjawV6HeKxeOmakyOkjJCsz+f90P45ErQQROtZDst5
         BYlMhaHFyxOeg==
Message-ID: <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com>
Date:   Wed, 3 Aug 2022 17:05:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20220803225716.1287921-1-vi@endrift.com>
 <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> Hi Vicki,
> 
> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
>>
>> Though a 512 byte report map size seems plenty large, there exist some devices
>> (e.g. Brydge W-Touch) that send larger reports. There is no protocol-defined
>> maximum size so doubling the maximum size is safe, and should hopefully fix
>> most real-world failures.
>> ---
>>  profiles/input/hog-lib.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>> index 4a9c60185..9f3eb428c 100644
>> --- a/profiles/input/hog-lib.c
>> +++ b/profiles/input/hog-lib.c
>> @@ -64,7 +64,7 @@
>>  #define HOG_PROTO_MODE_BOOT    0
>>  #define HOG_PROTO_MODE_REPORT  1
>>
>> -#define HOG_REPORT_MAP_MAX_SIZE        512
>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
>>  #define HID_INFO_SIZE                  4
>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> 
> Afaik 512 is the maximum length an attribute can have even when using
> read long procedure:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> page 1416:
> 
> The maximum length of an attribute value shall be 512 octets.
> 
> And
> 
> BLUETOOTH SPECIFICATION
> HID Service Specification
> Page 16 of 26
> 
> 2.6.1 Report Map Characteristic Behavior
> The GATT Read Characteristic Value or Read Long Characteristic Values sub-
> procedures are used to read the Report Map characteristic value.
> The length of the Report Map characteristic value is limited to 512 octets.
> 
> So I believe the device is not compliant and very likely needs to have
> multiple instances of HID Service instead of combining everything in a
> single instance.
> 
>> --
>> 2.37.1
>>
> 
> 

Ah, that's strange. I looked through the spec but didn't see those. That said, while the device may be non-compliant, the device is on the market and I doubt I could get them to update the firmware as a random third party. It works on Windows, so clearly Windows doesn't have a problem with its noncompliance. So this raises the question, how should Linux handle non-compliant hardware, especially when it could easily be made to work just by bending the rules in this one instance? I can absolutely change the commit message since it's erroneous, but the question then comes down to how should it be handled at all.
