Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 May 2012 18:02:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add dbus service file that references the systemd unit
Message-ID: <20120517150237.GA21315@x220.P-661HNU-F1>
References: <20120516080134.GA27987@x220>
 <3bc04a064cb81285510d978c3c867e5ea5203600.1337201604.git.eternaleye@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3bc04a064cb81285510d978c3c867e5ea5203600.1337201604.git.eternaleye@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, May 16, 2012, Alex Elsayed wrote:
> This allows bluez to be bus-activated.
> 
> v2: Fix whitespace error

This v2 line shouldn't be part of the commit message. You can put stuff
like that between the --- line and the diff line (usually before the
diffstat).

> +++ b/src/org.bluez.service.in
> @@ -0,0 +1,5 @@
> +[D-BUS Service]
> +Name=org.bluez
> +Exec=@prefix@/sbin/bluetoothd -n
> +User=root
> +SystemdService=bluetooth.service

My Fedora 16 installation seems to provide its own org.bluez.service:

$ cat /usr/share/dbus-1/system-services/org.bluez.service 
[D-BUS Service]
Name=org.bluez
Exec=/bin/false
User=root
SystemdService=dbus-org.bluez.service

Could you explain why it's a bit different from what you're providing
(particularly the /bin/false part). I'm not really an expert with with
systemd/D-Bus files so you'll need to convince me of why your variant is
correct (or more appropriate than the Fedora one) before it goes upstream.

Johan
