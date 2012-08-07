Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <501F5BB9.30406@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
	<5018CF41.6020906@ti.com>
	<CAKT1EBdUCSLZm=_FodNeT1UuquYVQVx8oZTOJw9ei2ca8WCrqA@mail.gmail.com>
	<501F5BB9.30406@ti.com>
Date: Tue, 7 Aug 2012 13:29:09 -0300
Message-ID: <CAAngNMbXUskPXd-0AS2i_zp4mK6uH84LUmDr7bmMK68pppfqzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add GATT Client Battery Service
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Chen,

On Mon, Aug 6, 2012 at 2:52 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Claudio,
>
>
> On 08/03/2012 03:57 PM, Claudio Takahasi wrote:
>>
>> Hi Chen Ganir:
>>
>> On Wed, Aug 1, 2012 at 3:40 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>>>
>>> On 07/25/2012 08:42 AM, Chen Ganir wrote:
>>>>
>>>>
>>>> Add suupport for LE GATT Client Battery Service.
>>>>
>>>> This plugin adds battery list to the btd_device, exposes DBUS API to
>>>> list
>>>> the
>>>> device batteries, and allows querying for battery information. In
>>>> addition
>>>> this
>>>> patch allows getting notifications for battery level changes.
>>>>
>>>> Look at doc/device-api.txt and doc/battery-api.txt for more information.
>>>>
>>>> This is version 2 of this patch set, rebased on top of the latest
>>>> sources
>>>> and
>>>> fixes some issues found during testing and in the ML comments.
>>>>
>>>> Chen Ganir (9):
>>>>     Battery: Add Battery Service GATT Client
>>>>     Battery: Add connection logic
>>>>     Battery: Discover Characteristic Descriptors
>>>>     Battery: Get Battery ID
>>>>     Battery: Add Battery list to btd_device
>>>>     Battery: Add Battery D-BUS API
>>>>     Battery: Read Battery level characteristic
>>>>     Battery: Add support for notifications
>>>>     Battery: Emit property changed on first read
>>>>
>>>>    Makefile.am                          |   10 +-
>>>>    doc/battery-api.txt                  |   38 +++
>>>>    doc/device-api.txt                   |    5 +
>>>>    profiles/batterystate/batterystate.c |  518
>>>> ++++++++++++++++++++++++++++++++++
>>>>    profiles/batterystate/batterystate.h |   24 ++
>>>>    profiles/batterystate/main.c         |   67 +++++
>>>>    profiles/batterystate/manager.c      |   93 ++++++
>>>>    profiles/batterystate/manager.h      |   24 ++
>>>>    src/device.c                         |   66 +++++
>>>>    src/device.h                         |    3 +
>>>>    10 files changed, 846 insertions(+), 2 deletions(-)
>>>>    create mode 100644 doc/battery-api.txt
>>>>    create mode 100644 profiles/batterystate/batterystate.c
>>>>    create mode 100644 profiles/batterystate/batterystate.h
>>>>    create mode 100644 profiles/batterystate/main.c
>>>>    create mode 100644 profiles/batterystate/manager.c
>>>>    create mode 100644 profiles/batterystate/manager.h
>>>>
>>>
>>> Ping anyone ? Did anyone get to review this ?
>>>
>>> Thanks,
>>> Chen Ganir
>>
>>
>>
>> not yet.
>> We have an INTERNAL release in two weeks, next week we will send
>> comments in the ML.
>>
> Thanks. I'll be waiting.
>
>

I've been reviewing and did some quick tests on your code. It's
working with some minor issues, and I'll comment them on each commit.
But first I have a few more general questions:

1. Any specific reason for calling the plugin directory and files
'batterystate'? I don't see any reference to this name on the
documentation.

2. The spec recommends reading the battery level value with very
little frequency. Quoting the section 3.1.1:

"For example, if the expected battery life is in the order of years,
reading the battery level value more frequently than once a week is
not recommended."

And on the same section:

"The value of the Client Characteristic Configuration descriptor is
persistent for bonded devices when not in a connection."

At the moment the plugin is reading it every time it is probed, which
is a lot more than recommended. What do you think about only enabling
notifications after paring, and not reading the value at all and just
wait for the notifications. If the device doesn't support
notifications (which I *think* should be uncommon) we can read the
value after pairing and refresh it every week or so. For this to work
well we'll need characteristics value storage support, but that will
improve other things as well. While we don't support that, I don't
have other ideas to improve this.


>> BR,
>> Claudio
>>
>
> Chen Ganir.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
