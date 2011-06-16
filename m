Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
Date: Thu, 16 Jun 2011 10:54:31 +0300
Message-ID: <BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 16, 2011 at 9:07 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>>
>> if TX power is only read once than the kernel should just do it once
>> and
>> be done with it.
>>
>> And for RSSI, it would be better if the kernel read this periodically
>> based on current sniff mode etc. Userspace can not trigger this with
>> proper timing anyway. And it will potentially at some point start
>> blocking the controller. Only the kernel really knows when it is
>> acceptable to read the RSSI value.
>>
>> Regards
>>
>> Marcel
>>
>>
>
> Marcel,
>
> Reading the RSSI by the kernel, will force a certain limitation on the
> current and future Profiles. I believe setting the timing should be done
> by the profile itself, not the bluez user space code or the kernel. It
> is the responsibility of the profile to periodically poll the RSSI Level.
> For some cases, polling it every 5 seconds would be ok, and for some
> Others, it may be better to read it every second. I believe we must not
> impose any limitation here.

You probably forgot that besides bluetoothd there should be no other
application holding the mgmt socket, so not you can't really do it in
poll in the application side and doing it over D-Bus is overkill. Also
I notice that from some parties, you include, there is some tendency
to have the profiles split from the bluetoothd, IMO this will only add
fragmentation with each and every platform using BlueZ having their
own implementation of each profile and not sharing much, making the
IOP a complete mess.


-- 
Luiz Augusto von Dentz
