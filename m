Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51613C2BB41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 06:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiHPGrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHPGrR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 02:47:17 -0400
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C13F339
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 18:49:34 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.106.20.54])
        by endrift.com (Postfix) with ESMTPSA id CB01CA176;
        Mon, 15 Aug 2022 18:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1660614574; bh=D6l9v4SCkxOFCmHxvon49KLHY+sl1oGS0FN/viPlM+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LB/vEmjtdGDuU+fl9JnftKCgVG93460gSqj3PEYJOfK2882rssfnbuKIzV9Fe5cyF
         SFk5KU4c1yLm3jf+VpN+uYclLTlC9JCDBle0AO3HbksPs5IUVpZvVk5o+Svs9im6a3
         r08eOnr7YUdJqcwflEspZWV00sNU8eyGuO37fmz+qnsIk0NIcTZSJiRqPy0q4HAXpU
         bvePG/G8Ko7VAtLsnpqqG2QHP/DGUA+d4thRbgMIiBA5DY652dOlbP8HVMBWo4rXna
         imm3yOHntC2ThIpftda3t5oRKDn64AfcjyjqyqVuVOeAMZDGF9HPdXbpc+r8IFprvs
         L0W9grPtWsg2Q==
Message-ID: <be49af1f-f08a-7e26-42e5-98fe83077488@endrift.com>
Date:   Mon, 15 Aug 2022 18:49:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20220803225716.1287921-1-vi@endrift.com>
 <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com>
 <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
 <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com>
 <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
 <CABBYNZKbCcz7p+EaNpWZkuX77BJ-DsoT=BRUQGwJjAhTesLhXA@mail.gmail.com>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <CABBYNZKbCcz7p+EaNpWZkuX77BJ-DsoT=BRUQGwJjAhTesLhXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 8/15/22 11:09, Luiz Augusto von Dentz wrote:
> Hi Vicki,
> 
> On Wed, Aug 10, 2022 at 1:13 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Vicki,
>>
>> On Tue, Aug 9, 2022 at 7:02 PM Vicki Pfau <vi@endrift.com> wrote:
>>>
>>>
>>>
>>> On 8/3/22 17:16, Luiz Augusto von Dentz wrote:
>>>> Hi Vicki,
>>>>
>>>> On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
>>>>>> Hi Vicki,
>>>>>>
>>>>>> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
>>>>>>>
>>>>>>> Though a 512 byte report map size seems plenty large, there exist some devices
>>>>>>> (e.g. Brydge W-Touch) that send larger reports. There is no protocol-defined
>>>>>>> maximum size so doubling the maximum size is safe, and should hopefully fix
>>>>>>> most real-world failures.
>>>>>>> ---
>>>>>>>  profiles/input/hog-lib.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>>>>>>> index 4a9c60185..9f3eb428c 100644
>>>>>>> --- a/profiles/input/hog-lib.c
>>>>>>> +++ b/profiles/input/hog-lib.c
>>>>>>> @@ -64,7 +64,7 @@
>>>>>>>  #define HOG_PROTO_MODE_BOOT    0
>>>>>>>  #define HOG_PROTO_MODE_REPORT  1
>>>>>>>
>>>>>>> -#define HOG_REPORT_MAP_MAX_SIZE        512
>>>>>>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
>>>>>>>  #define HID_INFO_SIZE                  4
>>>>>>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
>>>>>>
>>>>>> Afaik 512 is the maximum length an attribute can have even when using
>>>>>> read long procedure:
>>>>>>
>>>>>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
>>>>>> page 1416:
>>>>>>
>>>>>> The maximum length of an attribute value shall be 512 octets.
>>>>>>
>>>>>> And
>>>>>>
>>>>>> BLUETOOTH SPECIFICATION
>>>>>> HID Service Specification
>>>>>> Page 16 of 26
>>>>>>
>>>>>> 2.6.1 Report Map Characteristic Behavior
>>>>>> The GATT Read Characteristic Value or Read Long Characteristic Values sub-
>>>>>> procedures are used to read the Report Map characteristic value.
>>>>>> The length of the Report Map characteristic value is limited to 512 octets.
>>>>>>
>>>>>> So I believe the device is not compliant and very likely needs to have
>>>>>> multiple instances of HID Service instead of combining everything in a
>>>>>> single instance.
>>>>>>
>>>>>>> --
>>>>>>> 2.37.1
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> Ah, that's strange. I looked through the spec but didn't see those. That said, while the device may be non-compliant, the device is on the market and I doubt I could get them to update the firmware as a random third party. It works on Windows, so clearly Windows doesn't have a problem with its noncompliance. So this raises the question, how should Linux handle non-compliant hardware, especially when it could easily be made to work just by bending the rules in this one instance? I can absolutely change the commit message since it's erroneous, but the question then comes down to how should it be handled at all.
>>>>
>>>> While I agree this could be worked around it is probably worth
>>>> checking with the manufacturer if it is aware of the problem because
>>>> even if we were to allow reading past 512 bytes offset in the future
>>>> there may be qualification tests enforcing not to do so, besides
>>>> versions up to BlueZ 5.65 would still not work anyway so I thing
>>>> letting the manufacturer know there is a problem with their
>>>> implementation is actually worth a shot here.
>>>>
>>> Brydge replied with the standard tech support "this is only supported on Windows, so there probably won't be a firmware update" reply, despite its noncompliance. And since I doubt Windows will add a change to limit it, well, that kind of limits our options here to either "enforce compliance and break non-compliant hardware" or "figure out a way to bend the rules". Given that BlueZ, upon expanding the maximum size, does successfully read the overly-long report map (it does use the read blob with offset message to get the last several bytes), it does work as intended if we ignore that specific rule. Though obviously that's up to the bluetooth maintainers to solve, so at this point I'm just tossing my two cents at it.
>>
>> Well we can do what Windows is doing but let's have it documented
>> then, we could as well scalate this with Bluetooth SIG since the
>> manufacturer seem to be intentionally creating interoperability
>> problems with a standard service, but that would likely take a lot
>> more time and most likely will need to be resolved by introducing a
>> test that enforces that HoG client don't attempt to read past 512
>> bytes offset.

Is the client the device or the computer? Because the computer does successfully read past 512 bytes, and I believe it's needed for this device.

>>
>> Btw, if there is no limitation on how big the report map can get in
>> HID, I'd leave it up to the kernel to figure out if that is acceptable
>> or not, so I'd remove the 1024.

That makes sense. I can look into how to arbitrarily size that buffer.

> 
> Are you still planning to update this change? Btw, how about Android,
> does it handle such devices?
> 

Ah sorry, your reply was somewhat open ended and I didn't realize you wanted me to specifically look into this. As for Android, I have no idea. I can try pairing the trackpad with an Android device and seeing what happens, but I don't have anything with modern Android as it's not my day-to-day phone OS.
