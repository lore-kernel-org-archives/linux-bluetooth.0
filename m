Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
	<BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
Date: Thu, 16 Jun 2011 09:49:43 -0400
Message-ID: <BANLkTim3fp1UG7r5zS+iXJZP2Aw00=4OjQ@mail.gmail.com>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>, Marcel Holtmann <marcel@holtmann.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 16, 2011 at 3:54 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> You probably forgot that besides bluetoothd there should be no other
> application holding the mgmt socket, so not you can't really do it in
> poll in the application side and doing it over D-Bus is overkill. Also
> I notice that from some parties, you include, there is some tendency
> to have the profiles split from the bluetoothd, IMO this will only add
> fragmentation with each and every platform using BlueZ having their
> own implementation of each profile and not sharing much, making the
> IOP a complete mess.

I would like to bring attention to a thread I attempted to start some
time ago, named "D-Bus GATT API for external/proprietary profiles". If
anyone is really willing to implement external profiles over D-Bus,
please voice your points that would support this. Note that this
attempt never happened before, AFAIK all bluez supported profiles are
implemented internally on bluez source code, usually as plugins.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
