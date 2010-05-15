Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
References: <w2ra6ca4e821005071241w9d7d982ezb78ad0ba4480e73d@mail.gmail.com>
	 <s2oa6ca4e821005071249tdfd2e197i2595b57ae2ccb705@mail.gmail.com>
	 <20100507195325.GB4857@vigoh>
	 <AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
Date: Sat, 15 May 2010 14:52:15 +0300
Message-ID: <AANLkTilnMJQbRRfzjuVkVEV_HfN4CQmfZOhfnQQB0dml@mail.gmail.com>
Subject: Re: Software caused connection abort (103 )
From: john michelle <jhnmichelle@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

It seems that i am not the only one who is reporting this problem
below is other reporters

http://www.mp3car.com/vbulletin/linux/125997-hfp-linux-bluetooth-hands-free-5.html

even an older post show this bug

http://osdir.com/ml/linux.bluez.user/2004-04/msg00016.html

I hope we got someone attention.


John

On Fri, May 14, 2010 at 12:39 AM, john michelle <jhnmichelle@gmail.com> wrote:
> Hi Gustavo,
>
> Any update on the software caused connection abort issue, it's happenning more
> And more making bluez unstable for our application
>
> John
>
> On Fri, May 7, 2010 at 3:53 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
>> * john michelle <jhnmichelle@gmail.com> [2010-05-07 15:49:05 -0400]:
>>
>>> Hi Bluetooth hackers,
>>>
>>> i am having this consistent problem with bluez , from time to time i
>>> get the error Software caused connection abort (103 )
>>> And the bluetooth stick seems to disconnect and reconnects. this
>>> happens during an sco connection and it occurs even
>>> More when i am having the voice stream comming through the internet
>>> rather than the lan.i don't know what exact
>>> Details you need to solve this problem please tell me and i will give
>>> you an immediate reply . i have linux kernel 2.6.33 and bluez 4.62
>>
>> I get the same problem sometimes when testing ERTM with l2test. So the
>> problem is on l2cap too. I didn't have time to debug this yet. Now that
>> someone else have confirmed it too, I'll to take a look at the problem.
>>
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> Gustavo F. Padovan
>> http://padovan.org
>>
>
