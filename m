Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Ganir, Chen" <chen.ganir@ti.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Date: Mon, 20 Jun 2011 09:47:47 -0700
In-Reply-To: <BANLkTinuKBu-euzA1E44E-dEHV1fYfCHSg@mail.gmail.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	 <1308175855.2196.7.camel@aeonflux>
	 <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	 <1308191356.2196.9.camel@aeonflux>
	 <7769C83744F2C34A841232EF77AEA20C01D395DC98@dnce01.ent.ti.com>
	 <BANLkTin2H1wkOj0zOsG5_D1n6ztBP7rGdA@mail.gmail.com>
	 <BANLkTimKcE09f8qniUwbtDHtU2_BajDwwg@mail.gmail.com>
	 <1308235671.2196.21.camel@aeonflux>
	 <BANLkTi==Co9KP4ELU0Z-RBXXYXJ3dD7RKg@mail.gmail.com>
	 <20110616204500.GC2594@joana>
	 <BANLkTinuKBu-euzA1E44E-dEHV1fYfCHSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308588470.2196.37.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >> >> >>> if TX power is only read once than the kernel should just do it once
> >> >> >>> and
> >> >> >>> be done with it.
> >> >> >>>
> >> >> >>> And for RSSI, it would be better if the kernel read this periodically
> >> >> >>> based on current sniff mode etc. Userspace can not trigger this with
> >> >> >>> proper timing anyway. And it will potentially at some point start
> >> >> >>> blocking the controller. Only the kernel really knows when it is
> >> >> >>> acceptable to read the RSSI value.
> >> >> >>
> >> >> >> Reading the RSSI by the kernel, will force a certain limitation on the
> >> >> >> current and future Profiles. I believe setting the timing should be done
> >> >> >> by the profile itself, not the bluez user space code or the kernel. It
> >> >> >> is the responsibility of the profile to periodically poll the RSSI Level.
> >> >> >> For some cases, polling it every 5 seconds would be ok, and for some
> >> >> >> Others, it may be better to read it every second. I believe we must not
> >> >> >> impose any limitation here.
> >> >> >
> >> >> > You probably forgot that besides bluetoothd there should be no other
> >> >> > application holding the mgmt socket, so not you can't really do it in
> >> >> > poll in the application side and doing it over D-Bus is overkill. Also
> >> >> > I notice that from some parties, you include, there is some tendency
> >> >> > to have the profiles split from the bluetoothd, IMO this will only add
> >> >> > fragmentation with each and every platform using BlueZ having their
> >> >> > own implementation of each profile and not sharing much, making the
> >> >> > IOP a complete mess.
> >> >> >
> >> >>
> >> >> Some additional comments...
> >> >>
> >> >> Health plugin will need a similar approach to read the clock. It will
> >> >> be good to implement the same approach.
> >> >> In our suggested implementation the adapter controls when to send the
> >> >> command to read the RSSI, keeping the same logic for both: hciops and
> >> >> mgmtops. If the adapter is managing when to send the commands,
> >> >> repeated commands can be avoided, multiple callbacks can be registered
> >> >> by the profiles, but only one command to read the RSSI will be sent.
> >> >> The cover letter of the userspace patches contains more details how we
> >> >> implemented it.
> >> >>
> >> >> Reading the RSSI directly by the kernel will break hciops. These are
> >> >> the arguments that I have to support our decision.
> >> >
> >> > what I am hearing is that we want the kernel to poll for certain
> >> > information if userspace needs them. And either it is a one-shot poll or
> >> > it is on a regular interval.
> >>
> >> If everybody agree we can do it. Our objective is to have the patches upstream.
> >> To keep the Proximity Monitor functional on both adapter_ops plugins
> >> we can move part of the logic from the adapter.c to the hciops. The
> >> polling to read the RSSI can be moved to hciops, in the management the
> >> polling will be in the kernel. The remaining code to register the
> >> callbacks doesn't need to be changed.
> >
> > Do we have a really good reason to implement this both for hciops and mgmtops?
> > We wrote mgmt interface to solve our problems. So why do we still care about
> > put new stuff on hciops? And then we maintain two pieces of code instead
> > of one.
> >
> >        Gustavo
> >
> 
> Ok, we could implement it just for mgmtops. But, I need some opinions
> before start coding. We was thinking about the architecture needed
> into the kernel and we have some ideas:
> 
> - Add a new Management command called MGMT_ADD_LISTENER or something
> like that, which has two arguments at least: command op code and timer
> interval.
> - A callback called by the expired timer for each monitored command
> will be responsible to send the result (e.g.: Read RSSI or Read
> Clock), to the userspace.
> 
> As you could notice, we should have one timer for each command. What
> do you think about this approach?

what you want is an mgmt event that notifies you about changes and that
could be well one event per type. And then you need one mgmt command to
set the trigger here.

Also you might wanna look at the SIG closely. I think they are trying to
fix this on the HCI controller side. So we get at least RSSI updates
when they change and don't have to poll them.

In theory it is always better to define a threshold instead of fixed
poll interval. Even if the threshold is implement as a poll on older
chips, at least for future ones you get this right.

Regards

Marcel


