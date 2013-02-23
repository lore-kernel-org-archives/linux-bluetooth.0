Return-Path: <cyrus@holtmann.org>
Message-ID: <1361655279.3902.2.camel@aeonflux>
Subject: Re: [PATCH] Correct the dbus service file's systemd unit name for
 bluez.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Douglas, William" <william.douglas@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 23 Feb 2013 22:34:39 +0100
In-Reply-To: <CABhPDt9cnp=CiE0_U4kBL17WNrktsSrCrOq_Ly-x3+k0e4CKEw@mail.gmail.com>
References: <87ehgkxcsi.fsf@intel.com> <1361616485.1583.111.camel@aeonflux>
	 <CABhPDt9cnp=CiE0_U4kBL17WNrktsSrCrOq_Ly-x3+k0e4CKEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi William,

> >> Even though dbus-org.bluez.service is set as an alias for the
> >> bluetooth.service systemd unit file, systemd will not be able to load
> >> the bluetooth daemon without the daemon being enabled (and the
> >> dbus-org.bluez.service file linked to bluetooth.service). This patch
> >> allows the daemon to be loaded by other services on demand.
> >
> > as you have noticed we have this in bluetooth.service:
> >
> > [Install]
> > WantedBy=bluetooth.target
> > Alias=dbus-org.bluez.service
> >
> > Isn't this exactly what we want anyway. The service must be enabled
> > first before it will ever auto-started. Otherwise it just auto-starts
> > and the user can never get rid of it.
> >
> 
> Oh I didn't realize that was the intent. Is that because if it is auto
> enabled there is no way for the service to be masked to avoid it from
> auto starting? I was hoping to have the daemon start once it was
> requested by default. Probably more of a distro choice though.

I am actually curious on what is the best way here. My current thinking
is that the daemon should be started when hardware is present. Starting
it only because of a UI applet seems silly if there is no hardware
present, but I am not sure what's the appropriate default is here.

Regards

Marcel


