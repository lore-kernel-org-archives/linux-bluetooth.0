Cc: David Miller <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Message-Id: <8C4643EC-E6D9-47D3-8A27-04A2B3CDC6CC@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael J. Wysocki <rjw@sisk.pl>
In-Reply-To: <200809222342.46735.rjw@sisk.pl>
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: btusb suspend/resume bug...
Date: Tue, 23 Sep 2008 01:32:05 +0200
References: <20080916.155123.181085856.davem@davemloft.net> <1221668269.6782.8.camel@californication> <1222064651.13064.6.camel@californication> <200809222342.46735.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafael,

>>>> Marcel, others, please bring some kind of closure to this
>>>> regression list entry:
>>>>
>>>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=11442
>>>> Subject		: btusb hibernation/suspend breakage in current -git
>>>> Submitter	: Rafael J. Wysocki <rjw@sisk.pl>
>>>> Date		: 2008-08-25 11:37 (19 days old)
>>>> References	: http://marc.info/?l=linux-bluetooth&m=121966402012074&w=4
>>>> Handled-By	: Oliver Neukum <oliver@neukum.org>
>>>> Patch		: http://marc.info/?l=linux-bluetooth&m=121967226027323&w=4
>>>>
>>>> There is a patch, it is tested, so the only course of action at
>>>> this point is to merge the fix or declare that this really isn't
>>>> a regression.
>>>>
>>>> My impression is the later, because the driver btusb is replacing
>>>> doesn't handle suspend/resume either.  Isn't that right?
>>>
>>> the original patch that I had was expecting changes in the USB  
>>> subsystem
>>> that I deemed to much at this point. However Oliver got a patch that
>>> would make it work without the USB changes. I am still testing it.
>>>
>>> Let me see if I get some free minutes during the PlumbersConf to get
>>> this fully tested.
>>
>> so I took the patch apart and actually found a few more issues. I  
>> am not
>> sure if they should be applied this late in -rc phase.
>>
>> Rafael, can you pull from my tree and test the changes:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/ 
>> bluetooth-2.6.git
>>
>> It would be interesting if these fixes are enough.
>
> They appear to be enough.  I haven't had any suspend/resume failures  
> with them
> applied.

so it works _without_ applying patch-btusb-suspend. That would be  
great news and mean that there is no bug inside the USB and/or  
Bluetooth subsystem. It means we just have a  bug when handling the  
multiple interfaces. And that makes actually sense.

Dave, I will prepare a minimal patch set for you today or tomorrow.

Regards

Marcel
