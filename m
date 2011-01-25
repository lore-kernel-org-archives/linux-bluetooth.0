Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jan 2011 18:08:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: why scan_disable during hciops_power_off
Message-ID: <20110125160830.GA14610@jh-x301>
References: <AANLkTinQdwaAQk6LU_uLJ60YFOthhuwu5rL2gzZUXZ-k@mail.gmail.com>
 <AANLkTimUJoUmYorKNdNJPke_GJbAr6AK-ercNGr1uRRA@mail.gmail.com>
 <AANLkTimxHnqd9hp_Uu9DCXokq2Zj0bBb-3aJqRXE_AdE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimxHnqd9hp_Uu9DCXokq2Zj0bBb-3aJqRXE_AdE@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 25, 2011, Pavan Savoy wrote:
> >> 1. are there controllers there which even after doing hci0 down,
> >> allows other devices to be scanned?
> >> for those what do hci0 down mean ? radio not switched off ?
> >
> > Good point, perhaps this is driver dependent, so we do it just be safe guard.
> 
> I hope all devices and drivers out there consider the hci0 down as the
> radio OFF,
> I don't think there is a reason for it to be otherwise....
> so why the safe-guard ?

IIRC Marcel added this due to paranoia with the non-connectable GAP test
case with the BITE tester. The test kept failing even though the device
was in DOWN state.

Johan
