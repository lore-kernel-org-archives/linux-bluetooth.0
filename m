Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Date: Wed, 15 Jun 2011 19:29:13 -0700
In-Reply-To: <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	 <1308175855.2196.7.camel@aeonflux>
	 <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308191356.2196.9.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > so why are these two separate commands. Just reading them in one kernel
> > call might be a lot better. Including everything else you need to know
> > about the connection. Also TX power can be local and remote TX power if
> > I remember this correctly.
> 
> The issue I see with your proposal is that for Proximity (currently
> the only user of this information) we read TX power from server
> (reporter) using GATT, while RSSI is read on client (monitor) side. By
> reading both, we would need to issue two separate HCI commands (and
> wait for both responses), but will always use only one value,
> depending on local BlueZ role.
> 
> Also note that on latest Proximity profile drafts, it is mentioned
> that the TX power on reporter will never change during a connection,
> and thus it should be read only once when the connection is
> established. RSSI (which is read "locally" on monitor side), on the
> other hand, should be read periodically for path loss calculation.

if TX power is only read once than the kernel should just do it once and
be done with it.

And for RSSI, it would be better if the kernel read this periodically
based on current sniff mode etc. Userspace can not trigger this with
proper timing anyway. And it will potentially at some point start
blocking the controller. Only the kernel really knows when it is
acceptable to read the RSSI value.

Regards

Marcel


