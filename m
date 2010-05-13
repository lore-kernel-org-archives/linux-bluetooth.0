Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100507195325.GB4857@vigoh>
References: <w2ra6ca4e821005071241w9d7d982ezb78ad0ba4480e73d@mail.gmail.com>
	 <s2oa6ca4e821005071249tdfd2e197i2595b57ae2ccb705@mail.gmail.com>
	 <20100507195325.GB4857@vigoh>
Date: Thu, 13 May 2010 17:39:29 -0400
Message-ID: <AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
Subject: Re: Software caused connection abort (103 )
From: john michelle <jhnmichelle@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Any update on the software caused connection abort issue, it's happenning more
And more making bluez unstable for our application

John

On Fri, May 7, 2010 at 3:53 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> * john michelle <jhnmichelle@gmail.com> [2010-05-07 15:49:05 -0400]:
>
>> Hi Bluetooth hackers,
>>
>> i am having this consistent problem with bluez , from time to time i
>> get the error Software caused connection abort (103 )
>> And the bluetooth stick seems to disconnect and reconnects. this
>> happens during an sco connection and it occurs even
>> More when i am having the voice stream comming through the internet
>> rather than the lan.i don't know what exact
>> Details you need to solve this problem please tell me and i will give
>> you an immediate reply . i have linux kernel 2.6.33 and bluez 4.62
>
> I get the same problem sometimes when testing ERTM with l2test. So the
> problem is on l2cap too. I didn't have time to debug this yet. Now that
> someone else have confirmed it too, I'll to take a look at the problem.
>
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Gustavo F. Padovan
> http://padovan.org
>
