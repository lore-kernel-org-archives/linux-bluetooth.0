Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
Date: Tue, 25 Oct 2011 21:06:20 -0300
Message-ID: <CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir,

On Tue, Oct 25, 2011 at 10:19 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Claudio
>
>> -----Original Message-----
>> From: Claudio Takahasi [mailto:claudio.takahasi@openbossa.org]
>> Sent: Tuesday, October 25, 2011 2:53 PM
>> To: Ganir, Chen
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: GATT Dbus API on BlueZ
>>
>> Hi Chen Ganir,
>>
>> On Tue, Oct 25, 2011 at 4:38 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> > Hi.
>> >
>> > Currently, the DBUS API for GATT Client will allow discovering
>> characteristics and services, connecting to the peer device if
>> required. However, when the operation is done, the link is dropped (no
>> more attio registered). The only way to register a global gatt_service-
>> >attio and keep the connection alive all the time is to register a
>> characteristic watcher. Is there another way to do it ? I'd like to
>> keep the link a live (for example, implementing a proximity link loss
>> profile on top of the DBUS GATT Client) without the need for a watcher.
>> >
>> > Thanks,
>> > Chen Ganir
>> >
>> >
>>
>> At the moment there isn't another way to keep the link up. GATT
>> Profiles have different connection requirements, you will need a
>> dynamic mechanism anyway. The callback registration is the mechanism
>> to inform the core that connection is required. If you keep the
>> connection always up it will be necessary a function to get access to
>> the GAttrib instance and a way to notify that the connection has been
>> established.
>>
>> I tried to remove the association between GAttrib and GIOChannel. The
>> idea was to create GAttrib even if the link is disconnected, but the
>> effort doesn't worth. We will have problems with MTU and GATT
>> abstractions for read long.
>>
>> Do have another suggestion to control connections and control the ATT
>> request/response queue?
>>
>> BR,
>> Claudio
>
> Thanks for the reply.
>
> However, I did not quite understand your response, nor the relevancy to read long.
>
> My basic requirement is to allow a profile to control the connection - meaning that if I implement a proximity or other profile over dbus, I would like to be able to tell it to connect, discover services, discover characteristics, poll from time to time the value of a certain GATT char, or simply idle and wait for disconnection (like proximity does) or notification/indication. When using dbus-send I end up with a disconnected link at the end of the process. Do you think the disconnection results from the termination of the dbus-send application, or is it something else ?
>
> Thanks,
> Chen Ganir.
>
>

You are disabling all the GATT plugins, so my suggestion is: open the
ATT L2CAP socket directly in your JNI bindings. Using this approach
you will have all the control that you need.

We track the users/clients based on the D-Bus connection, if the
client(dbus-send or any other) leaves the bus the core will disconnect
link if watcher list is empty.

BR,
Claudio.
