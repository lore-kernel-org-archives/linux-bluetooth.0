Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01D395DC90@dnce01.ent.ti.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01D395DC90@dnce01.ent.ti.com>
Date: Thu, 16 Jun 2011 09:44:49 -0400
Message-ID: <BANLkTikn6b+8yezsPOAc77P5dfi2XA8TZA@mail.gmail.com>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Jun 16, 2011 at 2:03 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Please note that this is currently true for LE connection, but may change
> in the future.

If you read the latest Proximity draft (not from bluetooth.org, from
the mailing lists), you will see that the recommendation to read TX
power once on LE is to conserve power (specially on the single mode
device, I suppose, but it would waste power on the BlueZ side as
well). Unfortunately, if they change the recommendation again (in this
case they would be returning to a previous decision), we would
inevitably have to change implementation anyway.

> In addition, TX Power for BR/EDR may change during the
> connection (by the controller, depending on LMP commands), so reading it
> periodically and updating the GATT server must be implemented.

I don't really feel comfortable on discussing things which are not
adopted on BT-SIG yet but... Are you aware of any latest GATT profiles
which support BR/EDR? Be sure to check the latest drafts from BT-SIG
mailing lists.

I'm not saying it will *never* happen, but I think we should make
development decisions on what we know at the moment, not on what might
be possibly added to a future (not yet existing) profile. Otherwise we
risk doing unnecessary things for current profiles, like reading TX
Power periodically when a GATT profile would recommend reading once.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
