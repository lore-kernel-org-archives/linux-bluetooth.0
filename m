Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=KK0zUyeBUxWJxUW+EyFvJ_SuALA@mail.gmail.com>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<20110511164736.GA22065@joana>
	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>
	<BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
	<44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
	<4DCCEB4E.7040600@nokia.com>
	<BANLkTikJMKed11aRghia+7as9XGHokOH7w@mail.gmail.com>
	<BANLkTi=H-iEn_oAMb1bwJk6KEAueHRMVtQ@mail.gmail.com>
	<BANLkTi=KK0zUyeBUxWJxUW+EyFvJ_SuALA@mail.gmail.com>
Date: Mon, 16 May 2011 11:36:51 +0100
Message-ID: <BANLkTi=nUb=CxPYMgJQk7HKUF0OCsc7jUw@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OK guys,

I had a theory that my l2test test was not working due to the fact
that the chip wasn't configured to work with upperlayers. After
enabling this however, the  devices disappear (in hciconfig) so I
can't really test any L2CAP stuff (which I assume is what l2test is
doing).

Are there any other things I can try to help debug this issue I've seen?

Thankyou.

On Fri, May 13, 2011 at 1:42 PM, Eponymous - <the.epon@gmail.com> wrote:
> The following were executed in a root shell.
>
> Receive Side (Device B):
>
> $ ./l2test -r 00:02:5B:00:31:21
> l2test[29219]: Waiting for connection on psm 4113 ...
>
> Transmit Side (Device A):
>
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29234]: Can't connect: Permission denied (13)
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29311]: Can't connect: Connection refused (111)
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29326]: Can't connect: Connection refused (111)
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29401]: Can't connect: Permission denied (13)
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29478]: Can't connect: Connection refused (111)
> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> l2test[29493]: Can't connect: Connection refused (111)
>
> Doesn't appear to work...
>
> On Fri, May 13, 2011 at 9:39 AM, Eponymous - <the.epon@gmail.com> wrote:
>> What format do you specify the bdaddr in ?
>>
>> Cheers.
>>
>> On Fri, May 13, 2011 at 9:26 AM, Mika Linnanoja
>> <mika.linnanoja@nokia.com> wrote:
>>> On 05/13/2011 11:13 AM, ext Suraj Sumangala wrote:
>>>>
>>>> You have to enable it in the cofigure file and change "test_enable" from
>>>> "no" to "yes".
>>>> Edit the file "configure", search for "test_enable"
>>>> change "test_enable=no" to "test_enable=yes"
>>>>
>>>> That is what I do to enable l2test. I guess there could be some other
>>>> cleaner way to do it.
>>>
>>> ./configure --help :)
>>>
>>> If you pull from the git repo ./bootstrap-configure already enables most of
>>> them.
>>>
>>> Although lately configure is often *not* complaining if something is missing
>>> from build dependencies, have to do a bit of trial & error to get it right.
>>>
>>> This is very easy to notice when trying to 'make' bluez on a clean system
>>> where it hasn't ever been built before.
>>>
>>> Cheers,
>>> Mika
>>>
>>
>
