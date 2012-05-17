Return-Path: <cyrus@holtmann.org>
From: Alex Elsayed <eternaleye@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add dbus service file that references the systemd unit
Date: Thu, 17 May 2012 09:31:57 -0700
Message-ID: <4094065.PHO1OqQSqp@arkadios>
In-Reply-To: <20120517150237.GA21315@x220.P-661HNU-F1>
References: <20120516080134.GA27987@x220> <3bc04a064cb81285510d978c3c867e5ea5203600.1337201604.git.eternaleye@gmail.com> <20120517150237.GA21315@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday, May 17, 2012 06:02:37 PM Johan Hedberg wrote:
> Hi Alex,
> 
> On Wed, May 16, 2012, Alex Elsayed wrote:
> > This allows bluez to be bus-activated.
> > 
> > v2: Fix whitespace error
> 
> This v2 line shouldn't be part of the commit message. You can put stuff
> like that between the --- line and the diff line (usually before the
> diffstat).

Alright, I'll fix that

> > +++ b/src/org.bluez.service.in
> > @@ -0,0 +1,5 @@
> > +[D-BUS Service]
> > +Name=org.bluez
> > +Exec=@prefix@/sbin/bluetoothd -n
> > +User=root
> > +SystemdService=bluetooth.service
> 
> My Fedora 16 installation seems to provide its own org.bluez.service:
> 
> $ cat /usr/share/dbus-1/system-services/org.bluez.service
> [D-BUS Service]
> Name=org.bluez
> Exec=/bin/false
> User=root
> SystemdService=dbus-org.bluez.service
> 
> Could you explain why it's a bit different from what you're providing
> (particularly the /bin/false part). I'm not really an expert with with
> systemd/D-Bus files so you'll need to convince me of why your variant is
> correct (or more appropriate than the Fedora one) before it goes upstream.

Sure. In a systemd environment the Exec= line is ignored and the 
SystemdService is activated instead iff a SystemdService line exists. In a non-
systemd environment, however, the Exec= line is used to start the service. 
Since Fedora is standardizing on systemd, they omitted that line, but that 
means that bus activation will fail on non-systemd distros, such as ubuntu and 
debian.

However, I probably should use the SystemdService line from Fedora rather than 
the one I used, since that allows disabling bus activation. See
https://fedoraproject.org/wiki/Packaging:Systemd#DBus_activation

That requires adding an Alias= to the systemd service, so I'll be sending a v3 
of this patch.
