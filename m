Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ8T3pp1DFCdT3g=XW8NBT7BhHrM+E3t54EZY3d7SwDcw@mail.gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337940693-3417-4-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZ+HiG58wPbXkgikR_7m9APwQLYn4E6VhzBdcbmSVPGc6Q@mail.gmail.com>
	<CANT-zCX32WtZbHpPRdWjU114wvJAwfj0JZyGU9sA_Dp-RkhBYA@mail.gmail.com>
	<CABBYNZJ8T3pp1DFCdT3g=XW8NBT7BhHrM+E3t54EZY3d7SwDcw@mail.gmail.com>
Date: Fri, 25 May 2012 13:02:06 +0200
Message-ID: <CANT-zCVoGHyk5ocgC0CdNiTduFOBHYO0eP6Sj1WQNty_iwrm7g@mail.gmail.com>
Subject: Re: [PATCH obexd v1 03/16] client: Add progress property to transfer
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 25, 2012 at 12:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Fri, May 25, 2012 at 1:45 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Fri, May 25, 2012 at 12:35 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Mikel,
>>>
>>> On Fri, May 25, 2012 at 1:11 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>>
>>>> +static void transfer_notify_progress(struct obc_transfer *transfer)
>>>> +{
>>>> +       gint64 now;
>>>> +       gint64 notify;
>>>> +
>>>> +       DBG("Transfer %p progress: %lu bytes", transfer, transfer->transferred);
>>>> +
>>>> +       if (transfer->path == NULL)
>>>> +               return;
>>>> +
>>>> +       if (transfer->transferred == transfer->transferred_dbus)
>>>> +               return;
>>>> +
>>>> +       now = g_get_monotonic_time();
>>>> +       notify = transfer->transferred_dbus_time +
>>>> +                                               TRANSFER_PROGRESS_PERIOD * 1000;
>>>> +
>>>> +       if ((transfer->transferred != transfer->size) && (now < notify))
>>>> +               return;
>>>> +
>>>> +       transfer->transferred_dbus = transfer->transferred;
>>>> +       transfer->transferred_dbus_time = now;
>>>> +
>>>> +       obex_dbus_signal_property_changed(transfer->conn,
>>>> +                                               transfer->path,
>>>> +                                               TRANSFER_INTERFACE, "Progress",
>>>> +                                               DBUS_TYPE_INT64,
>>>> +                                               &transfer->transferred_dbus);
>>>> +}
>>>
>>> I would suggest doing it in a different manner using
>>> g_timeout_add_seconds and storing the id, so you just need to know if
>>> the timer is running by checking the id, if there is no timer running
>>> you start it, if there is you just update the bytes transferred and
>>> wait the timeout to be fired where you emit the signal. If in the
>>> meantime the transfer is completed you just have to cleanup using
>>> g_source_remove, this should be simpler because you don't have to
>>> bother how much time has passed on every packet.
>>
>> That would certainly avoid a call to g_get_monotonic_time() every time
>> we receive a packet, but on the other hand we would be waking up the
>> process one additional time per second. I'm not sure if there is any
>> performance improvement there.
>>
>> From the implementation complexity point of view both approaches equally simple.
>
> Actually by using g_timeout_add_seconds we may wake up even less
> because it attempts to group wake-ups, see:
>
> https://live.gnome.org/GnomeGoals/UseTimeoutAddSeconds

That's why I said we would wake up one additional time per second, and
not per second and transfer. All existing transfers would be grouped
and signalled together.

So basically one wake-up per second should be irrelevant I guess, as
irrelevant as a bunch of calls to g_get_monotonic_time.

Anyway, I will implement your proposal in the next revision.

Cheers,
Mikel
