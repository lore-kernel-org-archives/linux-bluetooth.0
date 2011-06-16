Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 17:08:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Ganir, Chen" <chen.ganir@ti.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [RFC 7/7] Update Management API documentation
Message-ID: <20110616140802.GA9225@dell.ger.corp.intel.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
 <1308175855.2196.7.camel@aeonflux>
 <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
 <1308191356.2196.9.camel@aeonflux>
 <7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
 <BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
 <BANLkTim3fp1UG7r5zS+iXJZP2Aw00=4OjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTim3fp1UG7r5zS+iXJZP2Aw00=4OjQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jun 16, 2011, Anderson Lizardo wrote:
> On Thu, Jun 16, 2011 at 3:54 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > You probably forgot that besides bluetoothd there should be no other
> > application holding the mgmt socket, so not you can't really do it in
> > poll in the application side and doing it over D-Bus is overkill. Also
> > I notice that from some parties, you include, there is some tendency
> > to have the profiles split from the bluetoothd, IMO this will only add
> > fragmentation with each and every platform using BlueZ having their
> > own implementation of each profile and not sharing much, making the
> > IOP a complete mess.
> 
> I would like to bring attention to a thread I attempted to start some
> time ago, named "D-Bus GATT API for external/proprietary profiles". If
> anyone is really willing to implement external profiles over D-Bus,
> please voice your points that would support this. Note that this
> attempt never happened before, AFAIK all bluez supported profiles are
> implemented internally on bluez source code, usually as plugins.

Not all profiles. There's e.g. the OBEX profiles provided by obexd. The
main reason for that separation is that practically everything handled
by obexd is user data which doesn't belong in a system level daemon like
bluetoothd. The same system-user separation could be a reason for other
profiles to exist in separate processes. Then there's also partial
splits like that for HFP where audio is handled by an audio subsystem
like PulseAudio and signaling by a cellular subsystem like oFono.

Johan
