Return-Path: <andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <47E39EED-4F96-4128-BAD1-09CDE4FC7A2E@holtmann.org>
References: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl> <47E39EED-4F96-4128-BAD1-09CDE4FC7A2E@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 1 Sep 2017 15:28:27 +0200
Message-ID: <CADAkoF6KNrBEZ83STfFZBcb3T3WhsKS49EyWA=1qLEb+p3BOWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/btsnoop: Add nop opcode
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 1, 2017 at 2:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> This adds 'no operation' opcode for the cases where we do not want to
>> include any particular payload, just the header is valid.
>>
>> For example, when some packets are dropped over TTY implementation can
>> pass this information only in some other packet and this won't happen
>> until there's actually something to send. With this addition it can
>> just send nop after some time to indicate there were packets dropped.
>> ---
>> doc/btsnoop.txt | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt
>> index 975a53f6d..865b81554 100644
>> --- a/doc/btsnoop.txt
>> +++ b/doc/btsnoop.txt
>> @@ -115,6 +115,13 @@ User Logging
>>
>>       User logging information.
>>
>> +NOP
>> +-----------
>> +
>> +     Code:        0xffff
>> +
>> +     No operation.
>> +
>
> Hmmm. I am not a huge fan of this. Then I see that we defined the ext_hdr that allows to deal with the dropped packets.
>
> I need to think about this a bit since there are some other opcode extensions we have to do for certain cases where we have unexpected packets. Right now I would propose to use vendor diagnostic or system note with empty payload.

Vendor diagnostic would produce a message in btmon which may be
misleading and system note with empty payload will print some garbage
(i.e. previous contents of buffer) since message is not
null-terminated.
But in this case I can just fix btmon to skip system notes with no
payload and it will be basically the same as nop - does it sound good
enough for now?

> Regards
>
> Marcel

Best regards,
Andrzej
