Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLKBwLZz69GYTT=w4Ldoz9sZidTtMixDqFcZHR9XGAP=g@mail.gmail.com>
References: <CAAu3APaxNENrLz0cp+3kk3FEgExw2bhrrRypUYYwPWXqFJkvqw@mail.gmail.com>
 <CABBYNZLKBwLZz69GYTT=w4Ldoz9sZidTtMixDqFcZHR9XGAP=g@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 11 Aug 2017 14:14:09 +0100
Message-ID: <CAAu3APbuGmfrH5iNQo2BdaqroBak=3fUvScRgL2wotQHRQGXVw@mail.gmail.com>
Subject: Re: Feedback on BlueZ DBus API
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for the prompt reply.

On 11 August 2017 at 11:57, Luiz Augusto von Dentz <luiz.dentz@gmail.com> w=
rote:
> Hi Barry,
>
> On Thu, Aug 10, 2017 at 8:07 PM, Barry Byford <31baz66@gmail.com> wrote:
>> Hello,
>>
>>
>> Over the last couple of years I=E2=80=99ve been doing some work with acc=
essing
>> BlueZ from the Python programming language. More recently I=E2=80=99ve b=
een
>> trying to create a library to lower the barrier to getting started
>> with Bluetooth on Linux. On that library we have recently done a
>> retrospective of where we are.
>>
>> (TL;DR https://github.com/ukBaz/python-bluezero/issues/126)
>>
>> The discussion spilled over to twitter where there was a suggestion
>> that some of our concerns should be shared back to the BlueZ project.
>> https://twitter.com/sandeepmistry/status/891836962952314880
>>
>>
>> I am not sure how relevant our feedback is to the broader user base of
>> the BlueZ project. However, it is true that we can=E2=80=99t complain th=
at our
>> needs aren=E2=80=99t being addressed by BlueZ if we don=E2=80=99t give f=
eedback.
>
> That is really a good start.
>
>>
>> I also accept that part of the issue here is with me as I don=E2=80=99t =
come
>> from a background where I know about the low level details of
>> Bluetooth and the C language. I am coming at this from the direction
>> of learning enough to rapidly prototype Python applications that
>> contain some Bluetooth functionality.
>
> That shouldn't prevent you to give us feedback on our APIs, which btw
> I have been updating recently.

I can see the updates coming and they all look like they are going int
the right direction. Maybe my feedback could be summarised as barriers
to accessing this great new stuff.

>>
>> Context:
>>
>> In my volunteering role as a STEM ambassador I have been a mentor on a
>> few school projects for engineering challenges where Bluetooth
>> functionality would have been helpful.
>>
>> These school projects typically use hardware like Raspberry Pi=E2=80=99s=
, BBC
>> micro:bits and tablets/phones where Bluetooth hardware is readily
>> available.
>>
>> My goal is to be able to create workshops that can be run at schools,
>> STEM fairs and community maker events that help people get started
>> exploring what is possible with Bluetooth and Python.
>>
>>
>> Building From Source:
>>
>> My first bit of feedback is that things with BlueZ are a lot better
>> now than they were a few short years ago. However this is the first
>> challenge as it takes a long time for updates to appear in operating
>> systems.
>>
>> The default Raspberry Pi OS is still shipping with BlueZ 5.23 which
>> isn=E2=80=99t much use for BLE. Even when Raspbian moves to being a Debi=
an
>> Stretch based release, it will be BlueZ 5.43. This means that much of
>> the DBus API will be behind the experimental flag and will be missing
>> some of the great recent updates such as AcquireWrite, AcquireNotify
>> and set name in scan response.
>>
>> While building from source is something I=E2=80=99ve become comfortable =
with,
>> getting organisers of workshop machines and users to do this is often
>> too large a barrier to entry.
>
> Can't you build a package using the latest changes? That would be
> beneficial to BlueZ as we get more exposure to different user.

Building a Debian package is something I've looked into as it is good
idea. However, I always have to patch my builds to get them working on
the Raspberry Pi 3 and along with a few other concerns I am not sure
that I have enough confidence to share it widely.
Is building the Debian package something that could be done as part of
BlueZ releases?

>
>>
>> Python DBus Library:
>>
>> As I=E2=80=99ve written about before on this list, there is not an obvio=
us
>> choice when it comes to a Python DBus library. I think the BlueZ
>> =E2=80=98test=E2=80=99 Python examples use the dbus-python library. Ther=
e seems to be
>> concerns about this Python library. Pydbus seems to be a recommended
>> library although there seems to be several holes in it for use with
>> BlueZ. The owner of the library appears to have moved on to another
>> project so updates (or merging of pull requests) seems to be sporadic.
>>
>
> Im not familiar with the differences between the D-Bus bindings, I
> guess we started doing the tests in whatever binding existed at that
> point and we never bothered changing it. Anyway you could in theory
> have your own binding if that really becomes the bottleneck.

Not having a good Python DBus library is a barrier to using BlueZ.
Creating my own is probably beyond me in a reasonable timeframe.
For your reference dbus-python is listed under Obsolete libraries on
https://www.freedesktop.org/wiki/Software/DBusBindings/

I am happy to help improve the bindings but too quickly it goes off
into the world of C and so again I am probably not best placed to make
updates.

>
>>
>> Beacons:
>>
>> Again another topic that has been discussed on this mailing list
>> before. There seems to have been a number of people that want to have
>> a Linux SBC continuously passively scan for beacons. This is something
>> that is not supported by the BlueZ DBus API. I believe the concern is
>> with flooding the bus. Could something similar to AcquireNotify be
>> done to solve this?
>
> I guess you are suggesting disabling the duplicated filtering, this is
> something I wish we discuss more in the list since we now also have
> mesh that uses the advertising as protocol transport. Depending on the
> system it might be alright, but in Linux distribution it might consume
> too much power.

Not sure I understand the 'too much power' comment in the context I
want to use this.

I also thought the issue was more than turning off the duplicates
filter. I thought the issues was if you were constantly scanning for
beacons then there was an issue with delays going through DBus. That
is why I thought that the notifications for new beacon updates could
go through a socket.

>
>>
>> Testing:
>>
>> It would be good to be able to test the Python apps without real
>> hardware. It would be good if BlueZ could provide some way of
>> mock/fake/stub so that unit testing could be easily done.
>>
>> The library python-dbusmock showed some promise however the bluez5.py
>> template needs some work.
>
> BlueZ/Linux support emulated controllers for a while, have a look at:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator
>
> We should probably add some documentation for it since it may not be
> very clear how to use btvirt, etc.

Yes, some documentation would be greatly appreciated as this sounds promisi=
ng.

>>
>> Our New Direction - Python Only Solution:
>>
>> Because of the issues raised above, investigation has started on using
>> only Python standard libraries to find a solution for our library.
>> This will allow our library to move faster than OS updates allow as it
>> will be easy to install directly from PyPI with fewer dependencies.
>>
>> The current investigation is looking to by-pass bluetoothd by using
>> HCI. What we have so far can be seen at:
>> https://github.com/TheBubbleworks/python-hcipy
>
> I guess that would also break any application and tools using BlueZ
> APIs in the system, but you probably already know that, not to mention
> having to have root access to use raw sockets, or making all python
> scripts to run with cap_net_raw:
>
> sudo setcap cap_net_raw+eip $(eval readlink -f `which python`)
> sudo setcap cap_net_raw+eip $(eval readlink -f `which python3`)
>
> I can give a lot more examples where this will lead to, but Im not
> sure the communities you are referring to will be able to listen. Far
> too many times Ive seen people disregard BlueZ to do its own thing,
> which end up in many different partial solutions like bleno,
> pygattlib... and there probably many many more to come, none is really
> a complete a BLE stack:
>
> https://github.com/sandeepmistry/bleno/issues/110
>
> At least with bleno Ive tried to make it use the D-Bus APIs but there
> was no interest, it seems it preferable to disable all other Bluetooth
> functionality, like pairing, authorization, etc, just to have GATT and
> Advertisement implemented natively, where only one simple process can
> access them, without ensuring this solution can pass a Bluetooth
> qualification.
>
> That said I know BlueZ is not perfect, we took way too long to make
> the GATT APIs stable and that possible cause this many solutions
> around BLE, but if instead of creating their own solution this effort
> was put into getting BlueZ GATT APIs tested we wouldn't be talking
> about it now and the Advertising API would probably have been adopted
> as well.

Again, I agree that the BlueZ DBus API is getting better all the time
and is definitely going in the right direction.
The central role with pydbus is working well. When the next release of
Raspbian based on Debian Stretch is available this should mike it
easily accessible to all.
However doing applications for beacon, scanner and peripheral continue
to be painful.

I want to help make the BlueZ DBus interface better I just don't know
how. For me the barrier to working on BlueZ or pydbus directly is too
high. I think this is why people go off and create their own solutions
as it appears 'easier' or 'quicker for them in the short term.

I am happy to take suggestions of how I can help.

Thanks,
Barry
