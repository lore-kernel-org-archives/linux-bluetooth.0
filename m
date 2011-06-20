Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=+SNHKAty5MQY6oGwG=MGrmZRPRA@mail.gmail.com>
References: <BANLkTimHLO1dJYeapKQdTdOTpzfVjKrhdA@mail.gmail.com>
	<BANLkTi=8q0usxLXQ5uB82CwN8=zXgwn-Jw@mail.gmail.com>
	<BANLkTi=+SNHKAty5MQY6oGwG=MGrmZRPRA@mail.gmail.com>
Date: Mon, 20 Jun 2011 11:16:34 -0300
Message-ID: <BANLkTi=s+pbqLxYSEH1g2t6nY80wkuq3FA@mail.gmail.com>
Subject: Re: [RFC] Attribute IO Driver
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jun 20, 2011 at 10:06 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Mon, Jun 20, 2011 at 3:56 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi,
>>
>> On Mon, Jun 20, 2011 at 8:35 AM, Claudio Takahasi
>> <claudio.takahasi@openbossa.org> wrote:
>>> This is the current driver definition:
>>> struct btd_attio_driver {
>>>        const char *name;
>>>        const char **uuids; /* UUIDs of primary services */
>>>        int (*probe) (struct btd_device *device, GSList *uuids);   /*
>>> List of Primary Services: UUID and start/end handles */
>>>        void (*remove) (struct btd_device *device);
>>>        int (*connected) (struct btd_device *device, GAttrib *attrib);
>>>        void (*disconnected) (struct btd_device *device);
>>> };
>>>
>>> * Open issues:
>>> 1. How to request re-connections. The current code shares the GAtrrib,
>>> I am trying to avoid sharing the GAttrib reference creating a ATT
>>> command queue. The idea is to inform the queue when the device is
>>> probed, allowing offline operations and automatic connection request.
>>> If there is at least one item in the queue the device will be added in
>>> the "automatic" connection list. Using a command queue, it MAY be
>>> possible to remove the "connected" and "disconnected" callbacks.
>>> 2. Move attio.c source to device.c?
>>> 3. should Generic API be a "built-in" ATT IO driver? (I moved to
>>> plugins/attribute.c), it looks more clean to me. Same "level" of
>>> Service/SDP plugin.
>>> 4. Passive scanning: it will be necessary to re-connect
>>
>> Just to complement the list of open issues:
>>
>> 5. We plan to drop the connected/disconnected callbacks. Most profiles
>> (except proximity) will not need them, and as Claudio mentioned, we do
>> not want to tie the profiles to an active connection. For those who
>> need a handler for connected/disconnected events, we can implement a
>> "btd_adapter_register_connected_callback" (just like the existing
>> btd_adapter_register_powered_callback() in src/adapter.c).
>
> The most obvious question, which I didn't see any answer here, is why
> we need to separate the Device drivers from the ATT IO drivers? Why
> can't we just extend the Device drivers to attend the LE profiles?
>
> --
> Luiz Augusto von Dentz
>

All consequence of the requirements and open issues explained previously.

If we implement GATT Profiles using Device "drivers" we will need:
* function to say the connection should be automatically established
for a given profile
* callbacks to be notified when the connection is established/dropped
* callbacks to be notified about notifications and indications
* btd_function to get the primary services. side-effect: re-parse all
primary services decoded after search, before to probe the drivers to
list of primary services that match are already available.
* functions to set the LSTO and intervals: profiles define the
recommended values. They are fixed values, using btd_functions look
that they are dynamic to me. For multiple profiles scenario, the
values need to the re-calculated.
* some profiles will not be available through BR, how to inform to the
core this info? Using ATT IO driver I was considering add another
field in the driver declaration.

ATT IO driver may be dropped if we solve all problems pointed
previously. I am still open for suggestions.
Adding btd_device_get_gatt() as you proposed solves partially the
problem, but remember that we can't add GATT/ATT headers dependency
for NON GATT profiles.

Generic API is another problem. I added a hook allowing "UUID = NULL"
in the driver declaration to address all services. No mater if we use
ATTIO or device driver, how it looks?

Regards,
Claudio.
