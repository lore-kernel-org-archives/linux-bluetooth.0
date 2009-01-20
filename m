Return-Path: <cyrus@holtmann.org>
Cc: Nick Pelly <npelly@google.com>,
	Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Message-Id: <DD78C3E4-03E2-417F-99B9-7D67B311C643@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: jaikumar Ganesh <jaikumarg@gmail.com>
In-Reply-To: <ac290f760901201054r804f79dm5b03abf73e2e89cf@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] Some kernel changes
Date: Tue, 20 Jan 2009 21:02:01 +0100
References: <496895AB.4050902@nokia.com> <1231768413.23749.1.camel@californication> <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com> <1231873966.12234.2.camel@californication> <ac290f760901151113jfd2d3b2t8bce890dd186ecbd@mail.gmail.com> <1232061946.15331.1.camel@californication> <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com> <1232099244.27758.4.camel@californication> <ac290f760901201054r804f79dm5b03abf73e2e89cf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>>>> why do you wanna set AUTH_PENDING again. That is not needed we only
>>>> wanna know once encryption comes back on. If no in time, then we  
>>>> just
>>>> disconnect the link. That simple.
>>>>
>>>>>   b) I also see that we are not clearing the timer and hence after
>>>>> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM  
>>>>> connection
>>>>> even though the encryption has been established.
>>>>
>>>> Good catch. Fixed it.
>>>
>>> Cool.  Can you upload it to bluetooth-testing git ? I saw a related
>>> problem while looking at the timer issue and wanted to see if the  
>>> fix
>>> takes care of it.
>>
>> I am in the process in doing so, but there are other important things
>> that need to be done first.
>
> Sorry to push you on this, is this patch been uploaded ?

since a few days now. Check the bluetooth-testing.git and it is even  
rebased against 2.6.29-rc2.

Regards

Marcel

