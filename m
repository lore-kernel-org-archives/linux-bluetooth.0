Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <Suraj.Sumangala@Atheros.com>
To: Eponymous - <the.epon@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 13 May 2011 13:43:16 +0530
Subject: RE: HCI data payload not getting through when using BlueZ
Message-ID: <44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<20110511164736.GA22065@joana>
	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>,<BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
In-Reply-To: <BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
________________________________________
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org] On Behalf Of Eponymous - [the.epon@gmail.com]
Sent: Friday, May 13, 2011 1:24 PM
To: Eponymous -; linux-bluetooth@vger.kernel.org
Subject: Re: HCI data payload not getting through when using BlueZ

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

You have to enable it in the cofigure file and change "test_enable" from "no" to "yes".
Edit the file "configure", search for "test_enable"
change "test_enable=no" to "test_enable=yes"

That is what I do to enable l2test. I guess there could be some other cleaner way to do it.

Regards
Suraj
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
