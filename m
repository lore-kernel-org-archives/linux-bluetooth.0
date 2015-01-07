Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGpqJgrC1Bugj7tgeeZPkMSHx-JkHtYfgbH2MeTSSaUbNKApRg@mail.gmail.com>
References: <CAGpqJgqKGKn49N=Vc1OFcZs-szNOhh-9C1zVZhEPkf9zLiRBsg@mail.gmail.com>
	<CABBYNZKkS6wLDMitQD0iNzyNMY57ZZDt2z_2CCetUYFFgAooig@mail.gmail.com>
	<CAGpqJgrC1Bugj7tgeeZPkMSHx-JkHtYfgbH2MeTSSaUbNKApRg@mail.gmail.com>
Date: Wed, 7 Jan 2015 15:07:20 -0200
Message-ID: <CABBYNZJoX0qtK1c7thKeZBRCp9jP3VUmZsPvWOp2TwGR-cTd4Q@mail.gmail.com>
Subject: Re: Valgrind issue on sdp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arthur Lambert <lambertarthur22@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Arthur,

On Wed, Jan 7, 2015 at 2:53 PM, Arthur Lambert
<lambertarthur22@gmail.com> wrote:
> Hi Luiz,
>
> Thanks for your answer. I does not have dbus in my target environment.
> I could easily add dbus package in my target system but I have some
> constraint which force me to avoid the dependency which are not
> mandatory for my needs.
>
> I hope at least that the current api that I used is not  deprecated right ?


libbluetooth is intended for internal use, at least starting with BlueZ 5.0.

> Arthur.
>
>
>
> 2015-01-07 17:26 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> Hi Arthur,
>>
>> On Wed, Jan 7, 2015 at 12:39 PM, Arthur Lambert
>> <lambertarthur22@gmail.com> wrote:
>>> Hi,
>>>
>>> I am currently trying to implement a bluetooth server on linux to
>>> communicate with an android mobile device. I am using rfcomm socket.
>>>
>>> To be able to work with android I need to register a service using the
>>> sdp feature (Android cannot use rc channel dirrectly or only in a
>>> dirty way, need dynamic uuid though sdp).
>>>
>>> I am currently able to communicate correctly between my linux and my
>>> android. I was checking my code with valgrind and I get some memory
>>> leak in sdp library. I have done some search about this subject but I
>>> was not able to find a right answer.
>>>
>>> Current implementation of my sdp (which come from :
>>> http://people.csail.mit.edu/albert/bluez-intro/x604.html#bzi-sdp-register)
>>
>> There is a much easier way to do that using bluetoothd and
>> org.bluez.ProfileManager you can register a SPP record and receive the
>> socket file descriptor via org.bluez.Profile (see
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt),
>> there is also a test script in python if you want to look at some
>> example: https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/test-profile
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> - Arthur LAMBERT



-- 
Luiz Augusto von Dentz
