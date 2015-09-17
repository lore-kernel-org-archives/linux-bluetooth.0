Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] core: add startup option to provide different configuration file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55FA4AD0.50401@canonical.com>
Date: Thu, 17 Sep 2015 08:53:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D723D275-4AB3-42BE-B0EF-52F53CECF0D1@holtmann.org>
References: <1442382751-25315-1-git-send-email-simon.fels@canonical.com> <55FA4AD0.50401@canonical.com>
To: Simon Fels <simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

>> In some cases it's needed to select a different configuration file
>> at runtime than the one we load by default from a statically
>> configured path. This adds an optional argument to the daemon
>> startup which will enable us to load another a configuration file
>> from a different path.
>> ---
>>  src/main.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> 
> For a better understanding, our use case for this is the following:
> 
> On Ubuntu we create set of packages out of the BlueZ source which are used across all devices we support. We don't want to put any device specifics in these and use the same binaries (per architecture) on different device types (laptops, phones, ...). By default we ship the main.conf file coming with the BlueZ sources. For different device types we now need different settings as we need to specify different settings for class of device field for example. At the moment there is an additional package only used for phones which ships a modified configuration file which can't replace the one provided by the bluez package and is then passed to bluetoothd in an .override upstart job.

actually BlueZ is designed to run without the main.conf present and has proper defaults. That is also the reason why we are not installing any of these files in the first place.

That background here is simple that a distro can have a package that installs the correct platform specific configuration if it wants one. We have been doing this dating back to the MeeGo days. Meaning you normally have a meta package bluez-config (or something like that) and then you platform specific package with all the configurations provides this meta package. That way it is in full hands of the distro install the right packages.

So I think your solution should actually be to take main.conf out of the BlueZ package. And shove different main.conf in different platform packages.

And btw. this is how we have treated oFono, ConnMan, BlueZ and all the other projects. The times where configuration files were required are over. The daemon will start with appropriate defaults.

This becomes even more important with systemd where BlueZ will actually ship the unit file. There should be no need to do anything different and hack some different daemon option into the unit file. The bluetoothd is by its definition a singleton since it is the owner of the D-Bus bus name. That is highly woven into how systemd handles D-Bus autostart. That means that multiple units or instances for BlueZ are not a good idea. So there should be only a single main.conf location and it should be optional.

If your packages are not set up for doing this cleanly, then you could do this via bind mount of main.conf to map another file into that location. You could bind mount the whole /etc/bluetooth if you insist to. However I would strongly advise to look into the packaging strategy of the distro first. It sounds like that can be improved.

The one thing that we have not implemented yet is that we support package configuration in /usr/lib/bluetooth/config (owned by the package). These files can then be overwritten by /etc/bluetooth and maybe /run/bluetooth similar to what systemd and all its daemon currently support. The reason why we have not done that yet is mainly that we have sane defaults for values hardcoded in the daemon. However it would give packagers an option to ship other default than the hardcoded ones.

This will however not solve your problem either btw. The modern way of understanding /etc is that this is for sysadmin/users (meaning humans) to do configuration. And if you wipe it the system comes back in its factory defaults. So even if we had /usr/lib/bluetooth/config you should still apply the meta package concept from above.

Regards

Marcel

