Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Dec 2008 23:00:36 +0100
From: Clemens Cap <clemens.cap@uni-rostock.de>
Subject: Re: Question about power tables or other transmit power limit
In-Reply-To: <70600880-A890-450D-9A97-B06C6A7EF04E@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Florian Schwehn <f.schwehn@wizai.com>, linux-bluetooth@vger.kernel.org
Message-ID: <4942DF04.8090101@uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
References: <6E2954C9-3AF9-4111-A87F-11C168B77753@wizai.com>
 <70600880-A890-450D-9A97-B06C6A7EF04E@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Florian,

we are researching a similar issue.

Marcel Holtmann wrote:
>> we are looking into limiting transmit power for our bluetooth file 
>> server project. The idea is to limit sending radius so that people 
>> don't feel harassed if they do not want to receive files.
>>
>> First we tried to read the RSSI during device discovery and base our 
>> decision on that. But the readings varied too much because of power 
>> saving methods like power tables.

RSSI does not work - power regulation mechanisms compensate signal 
strength loss and you only get indications of signal break down near at 
the limit of the range. Better approaches may be LQ, BER, inquiry 
response rates, l2ping delay rates and others. There are plenty of 
recent research papers on this at ieee or acm digital libraries which do 
not go rather deep but are proofs of concepts. We have a student digging 
into fusion concepts of the various indicators using statistical 
filtering approaches.

>> power tables with the bccmd. Unfortunately, the dongle doesn't seem to 
>> accept the change. After setting the value and re-reading it, the 
>> change is gone:
>>
>> [root@horst Desktop]# bccmd psget 0x0017
>> Maximum transmit power: 0x0004 (4)

First, make sure that you write into the correct memory bank (find out 
the memory structure using bccmd).

Second make sure you warmstart the dongle after adaption and be aware 
that the bluecore only reacts to a PS key value at certain moments 
during the operation cycle. There is not an immediate reaction of the bc 
to the ps key value.

>> I also tried dump all PS keys and restoring the modified dump - same 
>> issue.

Which dongles are you using?

This does not work with most class 2 dongles. Took us a while to figure 
that out as well.

>> Does anybody have experience with this? Do we need special BT dongles? 
>> We are also inquiring with CSR at the moment, but using a windows 
>> software is not an option, as our project is using embedded Linux (of 
>> course :).
> 
> this is a hardware detail that you better discuss with CSR people since 
> while I know a lot about their hardware, I am not that deep into all the 
> details. And messing with PS keys can result in unexpected things.

Beware of this remark... We already "consumed" 3 dongles by typos and 
mistakes in setting up incorrect ps keys. We got them working again, but 
it took us a while to "unbrick" them.


Please let me know if you get some results regarding the power table. We 
currently are trying this approach but without much success lately.

Best regards
Clemens.
