Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
        Marcel Holtmann
	<marcel@holtmann.org>
CC: "anderson.briglia@openbossa.org" <anderson.briglia@openbossa.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Bruna
 Moreira <bruna.moreira@openbossa.org>
Date: Thu, 16 Jun 2011 08:03:49 +0200
Subject: RE: [RFC 7/7] Update Management API documentation
Message-ID: <7769C83744F2C34A841232EF77AEA20C01D395DC90@dnce01.ent.ti.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
 <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
In-Reply-To: <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Anderson Lizardo
> Sent: Thursday, June 16, 2011 2:48 AM
> To: Marcel Holtmann
> Cc: anderson.briglia@openbossa.org; linux-bluetooth@vger.kernel.org;
> Bruna Moreira
> Subject: Re: [RFC 7/7] Update Management API documentation
>=20
> Hi Marcel,
>=20
> On Wed, Jun 15, 2011 at 6:10 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > so why are these two separate commands. Just reading them in one
> kernel
> > call might be a lot better. Including everything else you need to
> know
> > about the connection. Also TX power can be local and remote TX power
> if
> > I remember this correctly.
>=20
> The issue I see with your proposal is that for Proximity (currently
> the only user of this information) we read TX power from server
> (reporter) using GATT, while RSSI is read on client (monitor) side. By
> reading both, we would need to issue two separate HCI commands (and
> wait for both responses), but will always use only one value,
> depending on local BlueZ role.
>=20
> Also note that on latest Proximity profile drafts, it is mentioned
> that the TX power on reporter will never change during a connection,
> and thus it should be read only once when the connection is
> established. RSSI (which is read "locally" on monitor side), on the
> other hand, should be read periodically for path loss calculation.

Anderson,

Please note that this is currently true for LE connection, but may change=20
in the future. In addition, TX Power for BR/EDR may change during the=20
connection (by the controller, depending on LMP commands), so reading it=20
periodically and updating the GATT server must be implemented.

Chen Ganir.
