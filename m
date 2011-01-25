Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295971902.1520.52.camel@aeonflux>
References: <AANLkTinQdwaAQk6LU_uLJ60YFOthhuwu5rL2gzZUXZ-k@mail.gmail.com>
	<AANLkTimUJoUmYorKNdNJPke_GJbAr6AK-ercNGr1uRRA@mail.gmail.com>
	<AANLkTimxHnqd9hp_Uu9DCXokq2Zj0bBb-3aJqRXE_AdE@mail.gmail.com>
	<20110125160830.GA14610@jh-x301>
	<1295971902.1520.52.camel@aeonflux>
Date: Tue, 25 Jan 2011 21:47:41 +0530
Message-ID: <AANLkTikm4nn8Y-89U7Rzvyr+csLR-t2_6WOjQGe1J-2M@mail.gmail.com>
Subject: Re: why scan_disable during hciops_power_off
From: Pavan Savoy <pavan_savoy@sify.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 25, 2011 at 9:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> > >> 1. are there controllers there which even after doing hci0 down,
>> > >> allows other devices to be scanned?
>> > >> for those what do hci0 down mean ? radio not switched off ?
>> > >
>> > > Good point, perhaps this is driver dependent, so we do it just be safe guard.
>> >
>> > I hope all devices and drivers out there consider the hci0 down as the
>> > radio OFF,
>> > I don't think there is a reason for it to be otherwise....
>> > so why the safe-guard ?
>>
>> IIRC Marcel added this due to paranoia with the non-connectable GAP test
>> case with the BITE tester. The test kept failing even though the device
>> was in DOWN state.
>
> we also had the case where we considered non-connectable as off when the
> HCI devdown was not working properly. However this is a long time ago
> and has been fixed properly. So we might can remove this now.

Oo...
I want to send the patch, I want to send the patch ..
Can I please .....


> Regards
>
> Marcel
>
>
>
