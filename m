Return-Path: <cyrus@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1312989466.3373.126.camel@aeonflux>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Date: Wed, 10 Aug 2011 16:51:47 -0300
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org> <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org> <1312984225.3373.118.camel@aeonflux> <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com> <1312989466.3373.126.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Lizardo,

On Aug 10, 2011, at 12:17 PM, Marcel Holtmann wrote:

> Hi Anderson,
>
>>>> This patch adds a new parameter to mgmt_device_found() to inform
>>>> the length of 'eir' pointer.
>>>>
>>>> EIR data from LE advertising report event doesn't have a fixed  
>>>> length
>>>> as EIR data from extended inquiry result event does. We needed to
>>>> change mgmt_device_found() so it copies 'eir_len' bytes instead of
>>>> HCI_MAX_EIR_LENGTH.
>>>
>>> what is the max EIR length for LE? Is it more than with BR/EDR. Or  
>>> is it
>>> just variable length?
>>
>> From page 1735:
>>
>> "The data consists of a significant part and a non-significant part.
>> [...] The non-significant part extends the Advertising and Scan
>> Response data to 31 octets and shall contain all-zero octets."
>>
>> So actually it is not variable length, it has 31 octets, with the
>> non-significant part zero padded. BR/EDR EIR, on the other hand is  
>> 240
>> bytes (with zero padding for non-significant part as well)
>
> do we have a deep impact (memory wise) if we always pad this up to  
> 240.
> If we do, then we might wanna be smarter here anyway.

The advertising report event has the 'Length' field to inform the
'Data' field length, so I believe it has a variable length.
According to its description, the 'Length' field may vary from 0x00
to 0x1F (31) bytes.

The only drawback I see so far is copying extra ~200 bytes each time
we get a advertising report data.

- Andre
