Return-Path: <cyrus@holtmann.org>
Message-ID: <48D9399F.4000804@suse.de>
Date: Tue, 23 Sep 2008 20:46:55 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Packaging question
References: <48C685F1.9040905@suse.de>	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de>	 <1221237288.6695.19.camel@californication>  <48D22F30.1060301@suse.de>	 <1221758180.6782.22.camel@californication>  <48D29276.5060708@suse.de> <1221770377.6782.32.camel@californication>
In-Reply-To: <1221770377.6782.32.camel@californication>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel (and everybody else still listening),

Marcel Holtmann wrote:
> if we go always polling the D-Bus and try to re-connect it is bad, too.
> The solution is to make sure that D-Bus is always running and will never
> die. Everything else is just wrong and will break.

Yes, this was obviously meant as a joke.

This is what I have packaged for now:

- DBus activation for bluetoothd (actually runs the init script)
- udev events run a helper script /lib/udev/bluetooth.sh which basically
  consists of:

  #!/bin/sh
  [ x"$ACTION" != xadd ] && exit 0
  touch /var/run/bluetooth-adapter-present
  /bin/dbus-send --system --type=method_call \
                 --print-reply --reply-timeout=1000 \
                 --dest=org.bluez / org.bluez.hello

- a "bluetooth-coldplug" init script that checks for the existence of the
  bluetooth-adapter-present file and runs the "normal" init script (This could
  all be put   into the normal init script, but I had reasons for splitting
  it up).

So the coldplug case will be handled by the second init script, but still the
bluetoothd will only be started if an adapter is present.

Maybe this is kind of a solution until we get DBus started early enough to
make the problem go away.

Another thought: what prevents us from making bluetoothd exit as soon as all
adapters are unplugged? Is it useful for anything without hardware present
(can you alter settings etc)?

Thanks (and have fun in Portland ;)

	Stefan

-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
