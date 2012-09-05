Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5046DC86.7030905@ti.com>
References: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
	<5046DC86.7030905@ti.com>
Date: Wed, 5 Sep 2012 14:15:15 -0300
Message-ID: <CAAngNMaxNBWWHcmC1z27j79e=jsrcNTE_-4P+FiA66+EwYn44Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 00/14] LE General Connection Establishment procedure
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 5, 2012 at 2:00 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> João,
>
>
> On 09/04/2012 10:04 PM, João Paulo Rechi Vita wrote:
>>
>> This series implement the LE General Connection Establishment procedure
>> for LE connections.
>>
>> If there are LE bonded devices marked for auto connection they are added
>> to a connect_list on the adapter. When there is any device on this list
>> scan is performed continuously. When a device is found the connect_list
>
> How do we stop this scan ? Do we need to remove all auto-connect settings?
>

The scan stops when there are no devices left on the connect_list. The
connect_list is the new interface to connect to LE devices, and it
will use the GCE procedure. The auto-connect flag here simply states
whether or not we should try to re-connect to a device after
disconnection (adding it back to the connect_list).

>
>> is checked. If that device is on the list scan is stopped and a
>> connection attempt is made to that device.
>
> Do we have a timeout for this ? What happens if we succeed ? Do we start
> scanning again if more devices are set to auto-connect ? What happens when
> we fail a connection ? Do we retry to the same or start scanning again ?
>

Yes, right now there is the L2CAP timeout of 40s for an LE connect. If
the connection fails the device is added back to the connect_list, on
the att_error_cb() on src/device.c. After a connect attempt finishes
(either with sucess or fail) we check if there are any devices on the
connect_list and if so, we restart scanning.

>
>>
>> If any client tries to perform discovery and the scan for the General
>> Connection Establishment procedure is active, the discovery request is
>> queued and performed right after the GCEP scan session finishes.
>>
> I'm am having difficulties understanding the logic here. You say that as
> long as we have bonded devices set for auto-connect, the GCE scan will run
> until a connection is made?. What happens if we do not find any device ? Do
> we scan forever?
>

Scan will be active until a all LE bonded devices are connected or
removed (unpaired).

> This is a bit of a problem - device discovery can not be queued. Discovering
> devices is a user initiated command, and it should run whenever a client
> requires it. When a user requests for a list of devices, he expects to get
> the list. He does not care about background logic. The proper logic here is
> to pause the background scanning, discover devices (if LE scan reveals
> bonded devices that have auto-connect setting they should connect and then
> resume the discovery). After Device discovery is terminated, background
> connect scan should be continued.
>

And that is exactly what is implemented right now :)

Thanks for the reviewing, Chen!

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
