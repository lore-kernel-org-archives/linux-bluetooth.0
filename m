Return-Path: <cyrus@holtmann.org>
Message-ID: <50365374.2030605@globaledgesoft.com>
Date: Thu, 23 Aug 2012 11:59:48 -0400
From: Ajay KV <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: BLE - multiple connections
References: <5008F67F.5030604@globaledgesoft.com> <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com> <502E56DF.3020103@globaledgesoft.com> <CAJdJm_P=4fbHXG7gFpYQht9NmD88nixzO95N-HsgYwUOMx+pig@mail.gmail.com> <502ED4E8.9040702@globaledgesoft.com> <CAJdJm_OBh4OzKJejongsaWm1mSx2GN5Yki3B4nYc6C2DbVS=nw@mail.gmail.com> <503503C1.6060805@globaledgesoft.com> <20120822151300.GA6746@samus>
In-Reply-To: <20120822151300.GA6746@samus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/22/2012 11:13 AM, Vinicius Costa Gomes wrote:
> Hi,
>
> On 12:07 Wed 22 Aug, Ajay KV wrote:
>> On 08/17/2012 12:27 PM, Anderson Lizardo wrote:
>>> Hi Ajay
>>>
>>> [your emails to BlueZ mailing list may be getting blocked because you
>>> are using HTML. Please fix that on your mail client. Also remember to
>>> not top-post]
>>>
>>> On Fri, Aug 17, 2012 at 7:34 PM, Ajay KV<ajay.kv@globaledgesoft.com>   wrote:
>>>> Thanks for your reply.  i have 2 dongles of different made  (iogear and
>>>> chirago)  . "Hciconfig hci0 lestates" gives  this following result
>>>>
>>>>     Supported link layer states:
>>>> [...]
>>>>
>>>>              Here my issue is to  know whether (connected mode + advertising
>>>> mode)  is possible at a time . Once A is connected to B (initiator),  i
>>>> could not able to enable advertise in  A  (getting command disallowed ) , so
>>>> that  device C is not getting the connectable advertising packets on
>>>> scanning.
>>> I could not see any reason to get "command disallowed" when enabling
>>> LE adv. Did you try changing dongle combinations to make sure it is
>>> not some hardware issue?
>>>
>>> Regards,
>>
>> Hi,
>>          i could not able to figure it out  yet , why its  showing
>> this error " command disallowed" . Here im using fedora 13 with
>> kernel 2.6.39 . i tried with both dongles , iogear and cirago . But
>> the result is same.  i dont think that  its something wrong with
>> kernel version, as we  uses hci commands (hciconfig hci0 leadv )
>> that directly talks with controller . please clear this issue..
>
> Most probably the controller is in the page scan or inquiry scan state.
> Try doing 'hciconfig hci0 noscan', before enabling advertising.
>

> Cheers,


Hi,
	Still not working  , getting the same old error. i just want to know , 
whether my dual-mode dongle allows this operation or not (Advertising 
mode+ connected mode)		

Regards,
