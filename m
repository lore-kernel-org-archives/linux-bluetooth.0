Return-Path: <cyrus@holtmann.org>
Subject: Re: Packaging question
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <48D22F30.1060301@suse.de>
References: <48C685F1.9040905@suse.de>
	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de>
	 <1221237288.6695.19.camel@californication>  <48D22F30.1060301@suse.de>
Content-Type: text/plain
Date: Thu, 18 Sep 2008 19:16:20 +0200
Message-Id: <1221758180.6782.22.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Another question, also related to packaging:
> 
> How should the bluetoothd be started nowadays?
> 
> dbus-activation with a service-file like this one?
> root@stoetzler:~# cat /usr/share/dbus-1/system-services/org.bluez.service
> [D-BUS Service]
> Name=org.bluez
> Exec=/etc/init.d/bluetooth start
> User=root
> 
> But then, who will start it before XDM fires up? Has anybody already hacked up
> a nice way to just start it on adapter hotplug? Some HAL magic maybe?
> 
> I had that old udev rule hack that would call the init script at adapter
> plugin, but that's ugly and racy (because it typically starts before DBus is
> started).
> 
> Any innovative ideas?

we had the discussion for Fedora and we want to start it via udev,
however then we need D-Bus before udev runs and that is not an option
right now. So the current solution is to just do it via init.d, but in
the future we want udev. The D-Bus service activation is nice, but makes
problems when you wanna use the mouse and keyboard early.

Regards

Marcel


