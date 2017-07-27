Return-Path: <alvinlovi80@gmail.com>
MIME-Version: 1.0
In-Reply-To: <354B5E5A-BEFA-434F-AAF3-EBE782D718E3@holtmann.org>
References: <CANdxJyqO3mPKdsL4iy2JNq8111Ags+9Af-S0Vi+X+1AEdUextQ@mail.gmail.com>
 <354B5E5A-BEFA-434F-AAF3-EBE782D718E3@holtmann.org>
From: Alvin Lovi <alvinlovi80@gmail.com>
Date: Thu, 27 Jul 2017 14:23:51 +0200
Message-ID: <CANdxJypEyC7xgaVZ7GHOhqf8U=oN+J+RUWyUUo=EuCPuSPtSRg@mail.gmail.com>
Subject: Re: Bluez 5.43 - Problems with btmgmt
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
thanks for you reply.


On Wed, Jul 26, 2017 at 11:25 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alvin,
>
>> Hi, I'm trying to use the btmgmt command line tool integrated in the
>> above Bluez version and i've found the following problems/doubts:
>>
>> 1. btmgmt pair -c  [cap] -t [type] <rem addr.>
>> The tool automatically sends Passkey or PIN negative reply without
>> waiting any user input
>>
>> 2. btmgmt pair -c 0x04 -t 0x00 <rem addr.>
>> The sniffed pcap gives "IO Capability: Display Yes/NO (0x01)"
>>
>> 3. I've found the "disconnect" command but i haven't found the
>> "connect" one: is it present or not?
>
> can you run btmon at the same time. Recent kernels should also provide proper mgmt tracing capabilities.
>
> Regards
>
> Marcel
>

How can i use mgmt trace?
About the question 1. and 2. : any suggestion?
Thanks
Alvin
