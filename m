Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=QGnn5bhWSvBvaAE-k0NiRcKoybQM+pjGtn9ua@mail.gmail.com>
References: <AANLkTikmAHP8JiBw=cYqHCbiLot6rLjjboc7wnySmEmj@mail.gmail.com>
	<20101020144004.GA14607@jh-x301>
	<AANLkTi=QGnn5bhWSvBvaAE-k0NiRcKoybQM+pjGtn9ua@mail.gmail.com>
Date: Wed, 20 Oct 2010 12:56:27 -0400
Message-ID: <AANLkTikuM7hRCBgsv=EQvQoxaS64eAZM9NT4QC-JW5RC@mail.gmail.com>
Subject: Re: Activating a serial connection with qdbus
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Igor pesando <ipesando@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 20, 2010 at 11:17 AM, Igor pesando <ipesando@gmail.com> wrote:
> The issue I have is therefore associated with blueman:
> when you switch off the adapter with blueman and then kill blueman-applet
> hciconfig hci0 up does not work and returns an error (Can't init
> device hci1: Unknown error 132 (132) )
> and sometimes
> dbus-send and test-adapter do the same (
> dbus.exceptions.DBusException: org.bluez.Error.Failed: Unknown error
> 132)
> while blueman-applet can solve the problem if restarted.

Might not be related but... it  could be that RFKILL has disabled the
device. Run "rfkill list" and see if is either hard or soft blocked.
If it is, unblock it with "rfkill unblock <id>".

I've seen many times bluetoothd blocking devices on shutdown, maybe
because it thinks the device is blocked during start.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
