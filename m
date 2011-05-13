Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<20110511164736.GA22065@joana>
	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>
Date: Fri, 13 May 2011 08:54:18 +0100
Message-ID: <BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: Eponymous - <the.epon@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can someone please advise me further on this please? There is no
binary called "l2test" in the 4.91 sources. It's crucial I get this
problem remedied as I can't send data between two HCI devices. This
could be a bug in BlueZ...


On Thu, May 12, 2011 at 11:19 AM, Eponymous - <the.epon@gmail.com> wrote:
> Hi,
>
> I've just downloaded the 4.91 sources and done a make and the only
> program I can see starting "l2" is "l2ping". There is no l2test.
>
>
> On Wed, May 11, 2011 at 5:47 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> * Eponymous - <the.epon@gmail.com> [2011-05-11 09:52:28 +0100]:
>>
>>> Hi,
>>>
>>> I've ran into an issue where data doesn't seem to be received by a slave device.
>>>
>>> I do the following:
>>>
>>> Using Gentoo Linux (2.6.34-gentoo-r1)
>>> Using BlueZ 4.81
>>>
>>> 1. Use BlueZ to connect to two Bluetooth devices using HCI only. This
>>> is over USB.
>>>
>>> 2. I set one device as a slave and then create a connection between
>>> the two. This completes sucessfully and can be seen on both sides.
>>>
>>> 3. I then try to send an acl packet with the word "hi" in it and it is
>>> not received on the other side.
>>
>> There a utility called l2test in the bluez sources. Check if it works for you.
>> Using -r in one side to listen and -s in the other side to send data. Or
>> l2test -h and see all options.
>>
>> --
>> Gustavo F. Padovan
>> http://profusion.mobi
>>
>
