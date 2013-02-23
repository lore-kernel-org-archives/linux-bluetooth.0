Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361616485.1583.111.camel@aeonflux>
References: <87ehgkxcsi.fsf@intel.com>
	<1361616485.1583.111.camel@aeonflux>
Date: Sat, 23 Feb 2013 10:06:03 -0800
Message-ID: <CABhPDt9cnp=CiE0_U4kBL17WNrktsSrCrOq_Ly-x3+k0e4CKEw@mail.gmail.com>
Subject: Re: [PATCH] Correct the dbus service file's systemd unit name for bluez.
From: "Douglas, William" <william.douglas@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 23, 2013 at 2:48 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi William,
>
>> Even though dbus-org.bluez.service is set as an alias for the
>> bluetooth.service systemd unit file, systemd will not be able to load
>> the bluetooth daemon without the daemon being enabled (and the
>> dbus-org.bluez.service file linked to bluetooth.service). This patch
>> allows the daemon to be loaded by other services on demand.
>
> as you have noticed we have this in bluetooth.service:
>
> [Install]
> WantedBy=bluetooth.target
> Alias=dbus-org.bluez.service
>
> Isn't this exactly what we want anyway. The service must be enabled
> first before it will ever auto-started. Otherwise it just auto-starts
> and the user can never get rid of it.
>

Oh I didn't realize that was the intent. Is that because if it is auto
enabled there is no way for the service to be masked to avoid it from
auto starting? I was hoping to have the daemon start once it was
requested by default. Probably more of a distro choice though.
