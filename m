Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jun 2009 18:42:00 +0200
From: Stefan Seyfried <seife@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Petr Lautrbach <plautrba@redhat.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
Message-ID: <20090605164200.GB13177@suse.de>
References: <4A27DFBE.407@redhat.com> <20090605153852.GA29262@jh-x301> <1244216906.23850.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1244216906.23850.70.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 05, 2009 at 05:48:26PM +0200, Marcel Holtmann wrote:

> first of all the question from Stefan needs to be handled on how we
> handle the case for udev event before D-Bus system daemon is started.
> 
> Personally I think having an extra init script style for this makes no
> sense and just adds complexity in the start/stop process of the daemon.
> 
> I might prefer if we add special bluetoothd --udev={start,stop} handling
> to it (including polling code for D-Bus system daemon availability).

I actually solved it like this (no, I'm not proud of it, but it works):

* instead of calling "/etc/init.d/bluetooth condstart" from udev, I call
  a bluetooth.sh which basically does:

  mkdir /dev/shm/bluetooth-adapter-present # this is just a marker
  /bin/dbus-send --system --type=method_call --print-reply \
	--reply-timeout=1000 --dest=org.bluez / org.bluez.hello

  If D-Bus is already up (adapter hotplug), then the dbus-send activates
  bluetoothd via dbus-activation.

* I have a second, trivial init script which is always enabled and runs
  at the end of the boot process (after D-Bus start, that is) and which
  just does

  [ -x /dev/shm/bluetooth-adapter-present ] && \
	/etc/init.d/bluetooth start

  This handles the "adapter was plugged in before D-Bus was ready" case.

It's not particularly pretty, and I do not want to suggest that this is
a correct solution, but it solved the problem nicely for me.

Regards,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
