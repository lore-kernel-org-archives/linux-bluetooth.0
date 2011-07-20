Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310586426.21109.100.camel@aeonflux>
References: <4e1da4a5.04bfec0a.4243.00d9@mx.google.com>
	<1310580766.21109.96.camel@aeonflux>
	<CALJ2SBL=Fdcmrbrs69pQybXxMq1yh4=Gzmx4Xa32_qnFwDe-YA@mail.gmail.com>
	<1310586426.21109.100.camel@aeonflux>
Date: Wed, 20 Jul 2011 11:48:27 -0300
Message-ID: <CAKT1EBeJEzq3kWbFQy7HD0fmapMsA1KHQSxPUwWGAk+0y2Mocw@mail.gmail.com>
Subject: Re: [RFC 1/3] Bluetooth: Implement Read RSSI command
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 13, 2011 at 4:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Anderson,
>
>> >> This patch implements helper functions to make Read RSSI command
>> >> interceptable by MGMT Interface. It adds a new wrapper in HCI layer and
>> >> add a hook to call mgmt_read_rssi_complete when MGMT Interface has been
>> >> loaded.
>> >>
>> >> Read RSSI command is defined on Part E, section 7.5.4 of Bluetooth 4.0
>> >> Spec.
>> >
>> > I think that I mentioned this before. This is not something I like to
>> > see at all. 1:1 copies of HCI commands is pointless.
>> >
>> > If you need RSSI results, then something like proper interval and
>> > thresholds should be supported. Also with future Bluetooth SIG work on
>> > having controller driven notifications in this area.
>>
>> Note that even the RSSI and TX Power are implemented, it is not
>> possible to userspace request a RSSI or TX Power actively. If
>> userspace wants to receive RSSI and TX Power from the kernel, it must
>> add to the "monitored commands" and wait for the responses. Read RSSI
>> and TX Power Level are not being parsed on mgmt_control().
>> Maybe I should change the commit message of this patch and the next one.
>>
>> New Management commands were implemented in the last RFC patch to
>> monitor selected commands.
>
> no matter what, this needs to be done future proof in conjunction with
> where the Bluetooth SIG is going for the controller driven notifications
> of RSSI changes.
>
> With older controllers we just have to emulate the behavior via a simple
> poll mechanism.

The command to enable RSSI changes notification is not public, I hope
the changes in the Management API proposed by Briglia yesterday is
aligned with this new command.

>
> However such monitored commands things seems like a hack as well. Please
> use proper interfaces for threshold and interval values. Otherwise this
> is all pointless. And you just wake up userspace for no real reason. The
> plan is to get away from pointless userspace wakeups.
>
> Regards
>
> Marcel
>

About Tx Power... I understand that you don't want 1:1 mapping for HCI
commands in the management interface. Tx Power doesn't need to be
monitored, for LE it doesn't change. We could add a new management
command for Link Information command, but which relevant information
could be exposed by this Link Information command? Some commands are
applied to BREDR only, others to LE or AMP only.

At the moment we need Tx Power only, putting together Remote and Link
Information can be one alternative. Do you have other suggestion?
For example, we could create a management command called "Remote
Information" which returns: Tx Power, Features, version, ... Does it
make sense?

Regards,
Claudio
