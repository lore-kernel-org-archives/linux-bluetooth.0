Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361655279.3902.2.camel@aeonflux>
References: <87ehgkxcsi.fsf@intel.com>
	<1361616485.1583.111.camel@aeonflux>
	<CABhPDt9cnp=CiE0_U4kBL17WNrktsSrCrOq_Ly-x3+k0e4CKEw@mail.gmail.com>
	<1361655279.3902.2.camel@aeonflux>
Date: Sun, 24 Feb 2013 12:22:37 -0800
Message-ID: <CABhPDt-baxtSbCgBN2jRh_zGVhYFPP_78E==oqCJaVhQX7dOnQ@mail.gmail.com>
Subject: Re: [PATCH] Correct the dbus service file's systemd unit name for bluez.
From: "Douglas, William" <william.douglas@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 23, 2013 at 1:34 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi William,
>
>> >> Even though dbus-org.bluez.service is set as an alias for the
>> >> bluetooth.service systemd unit file, systemd will not be able to load
>> >> the bluetooth daemon without the daemon being enabled (and the
>> >> dbus-org.bluez.service file linked to bluetooth.service). This patch
>> >> allows the daemon to be loaded by other services on demand.
>> >
>> > as you have noticed we have this in bluetooth.service:
>> >
>> > [Install]
>> > WantedBy=bluetooth.target
>> > Alias=dbus-org.bluez.service
>> >
>> > Isn't this exactly what we want anyway. The service must be enabled
>> > first before it will ever auto-started. Otherwise it just auto-starts
>> > and the user can never get rid of it.
>> >
>>
>> Oh I didn't realize that was the intent. Is that because if it is auto
>> enabled there is no way for the service to be masked to avoid it from
>> auto starting? I was hoping to have the daemon start once it was
>> requested by default. Probably more of a distro choice though.
>
> I am actually curious on what is the best way here. My current thinking
> is that the daemon should be started when hardware is present. Starting
> it only because of a UI applet seems silly if there is no hardware
> present, but I am not sure what's the appropriate default is here.

That is an interesting point. I was looking at it like I do for
connman, where it will start even if there isn't any network
interfaces currently available and that is expected behavior to me.
Bluez could be waiting on a usb bluetooth adapter to be added just
like connman is waiting on a usb ethernet adapter (and it isn't
obvious to my that this is taking up a much in the way of resources or
adding a lot of wakeups but I don't know). Either way I expect an easy
to turn on and off UI component making either default simple to
correct. Right now, the connman UI I am using just presents a
bluetooth option for enable/disable but it doesn't work as is without
the service being able to autostart without being enabled manually (or
by the distro default).
