Return-Path: <cyrus@holtmann.org>
Message-ID: <1361616485.1583.111.camel@aeonflux>
Subject: Re: [PATCH] Correct the dbus service file's systemd unit name for
 bluez.
From: Marcel Holtmann <marcel@holtmann.org>
To: William Douglas <william.douglas@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 23 Feb 2013 11:48:05 +0100
In-Reply-To: <87ehgkxcsi.fsf@intel.com>
References: <87ehgkxcsi.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi William,

> Even though dbus-org.bluez.service is set as an alias for the
> bluetooth.service systemd unit file, systemd will not be able to load
> the bluetooth daemon without the daemon being enabled (and the
> dbus-org.bluez.service file linked to bluetooth.service). This patch
> allows the daemon to be loaded by other services on demand.

as you have noticed we have this in bluetooth.service:

[Install]
WantedBy=bluetooth.target
Alias=dbus-org.bluez.service

Isn't this exactly what we want anyway. The service must be enabled
first before it will ever auto-started. Otherwise it just auto-starts
and the user can never get rid of it.

Regards

Marcel


