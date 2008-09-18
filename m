Return-Path: <cyrus@holtmann.org>
Message-ID: <48D22F30.1060301@suse.de>
Date: Thu, 18 Sep 2008 12:36:32 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Packaging question
References: <48C685F1.9040905@suse.de>	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de> <1221237288.6695.19.camel@californication>
In-Reply-To: <1221237288.6695.19.camel@californication>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann wrote:
>> So for now I'll go for the above list of packages, with libbluetooth3 instead
>> of bluez-libs.
> 
> the Fedora packaging guidelines are kinda clear about how to name
> library packages. Same as for Debian. I don't know about SuSE.

The openSUSE packaging guidelines are what made me change the name to
libbluetooth3 ;)

> This is basically about the build dependencies and changing the devel
> package name means that you would need to adjust all sources relying on
> it.

Yes, understood and considered. However, the build gurus solved that with some
RPM specfile magic for me ;)

Another question, also related to packaging:

How should the bluetoothd be started nowadays?

dbus-activation with a service-file like this one?
root@stoetzler:~# cat /usr/share/dbus-1/system-services/org.bluez.service
[D-BUS Service]
Name=org.bluez
Exec=/etc/init.d/bluetooth start
User=root

But then, who will start it before XDM fires up? Has anybody already hacked up
a nice way to just start it on adapter hotplug? Some HAL magic maybe?

I had that old udev rule hack that would call the init script at adapter
plugin, but that's ugly and racy (because it typically starts before DBus is
started).

Any innovative ideas?
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
