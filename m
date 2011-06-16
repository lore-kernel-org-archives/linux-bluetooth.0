Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Ganir, Chen" <chen.ganir@ti.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Date: Thu, 16 Jun 2011 07:47:48 -0700
In-Reply-To: <BANLkTimKcE09f8qniUwbtDHtU2_BajDwwg@mail.gmail.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	 <1308175855.2196.7.camel@aeonflux>
	 <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	 <1308191356.2196.9.camel@aeonflux>
	 <7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
	 <BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
	 <BANLkTimKcE09f8qniUwbtDHtU2_BajDwwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308235671.2196.21.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> >>> if TX power is only read once than the kernel should just do it once
> >>> and
> >>> be done with it.
> >>>
> >>> And for RSSI, it would be better if the kernel read this periodically
> >>> based on current sniff mode etc. Userspace can not trigger this with
> >>> proper timing anyway. And it will potentially at some point start
> >>> blocking the controller. Only the kernel really knows when it is
> >>> acceptable to read the RSSI value.
> >>
> >> Reading the RSSI by the kernel, will force a certain limitation on the
> >> current and future Profiles. I believe setting the timing should be done
> >> by the profile itself, not the bluez user space code or the kernel. It
> >> is the responsibility of the profile to periodically poll the RSSI Level.
> >> For some cases, polling it every 5 seconds would be ok, and for some
> >> Others, it may be better to read it every second. I believe we must not
> >> impose any limitation here.
> >
> > You probably forgot that besides bluetoothd there should be no other
> > application holding the mgmt socket, so not you can't really do it in
> > poll in the application side and doing it over D-Bus is overkill. Also
> > I notice that from some parties, you include, there is some tendency
> > to have the profiles split from the bluetoothd, IMO this will only add
> > fragmentation with each and every platform using BlueZ having their
> > own implementation of each profile and not sharing much, making the
> > IOP a complete mess.
> >
> 
> Some additional comments...
> 
> Health plugin will need a similar approach to read the clock. It will
> be good to implement the same approach.
> In our suggested implementation the adapter controls when to send the
> command to read the RSSI, keeping the same logic for both: hciops and
> mgmtops. If the adapter is managing when to send the commands,
> repeated commands can be avoided, multiple callbacks can be registered
> by the profiles, but only one command to read the RSSI will be sent.
> The cover letter of the userspace patches contains more details how we
> implemented it.
> 
> Reading the RSSI directly by the kernel will break hciops. These are
> the arguments that I have to support our decision.

what I am hearing is that we want the kernel to poll for certain
information if userspace needs them. And either it is a one-shot poll or
it is on a regular interval.

The management interface will be primarily used by bluetoothd, but it is
open for other users as well. Mainly some low-level system tools or more
important qualification tools.

So triggering certain actions from userspace is always tricky and then
we need to have bluetoothd sync with itself, its plugins etc. So I
rather prefer that we tell the kernel which pollable information to read
at which interval and then just get a notification if they have changed.
Let the kernel do its job without having to wakeup half of userspace to
make a simple decision to poll a value.

And don't get me wrong, the stupid Bluetooth chip should be able to poll
this value with an interval natively. The best we can do is emulate that
in the kernel.

Regards

Marcel


