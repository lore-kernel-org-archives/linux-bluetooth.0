Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110616140802.GA9225@dell.ger.corp.intel.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
	<BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
	<BANLkTim3fp1UG7r5zS+iXJZP2Aw00=4OjQ@mail.gmail.com>
	<20110616140802.GA9225@dell.ger.corp.intel.com>
Date: Thu, 16 Jun 2011 10:17:41 -0400
Message-ID: <BANLkTim_ESc=PTjySsfEek-7aUrq9Rj2kw@mail.gmail.com>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Ganir, Chen" <chen.ganir@ti.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jun 16, 2011 at 10:08 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> I would like to bring attention to a thread I attempted to start some
>> time ago, named "D-Bus GATT API for external/proprietary profiles". If
>> anyone is really willing to implement external profiles over D-Bus,
>> please voice your points that would support this. Note that this
>> attempt never happened before, AFAIK all bluez supported profiles are
>> implemented internally on bluez source code, usually as plugins.
>
> Not all profiles. There's e.g. the OBEX profiles provided by obexd. The
> main reason for that separation is that practically everything handled
> by obexd is user data which doesn't belong in a system level daemon like
> bluetoothd. The same system-user separation could be a reason for other
> profiles to exist in separate processes. Then there's also partial
> splits like that for HFP where audio is handled by an audio subsystem
> like PulseAudio and signaling by a cellular subsystem like oFono.

Thanks for the clarification. I completely forgot about these cases
(also I don't actually know how obexd integrates with bluetoothd,
blame on me). But looks like the decision to whether to implement a
profile fully inside or outside (partially or not) bluez is per
profile, right? I think GATT profiles are so diverse that we would
have to make the decision on a profile basis. In this case, it helps
each profile having its own D-Bus API and plugin.

Proximity, for instance, is so attached to the connection state (and
depending on RSSI and TX power) that it would be an example of one
profile that is best implemented next to BlueZ.

Future GATT profiles which might need to read a lot of user
information might need a split from bluetoothd process.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
