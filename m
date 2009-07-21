Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jul 2009 13:02:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth SPP link to Nokia phone
Message-ID: <20090721100239.GA19048@jh-x301>
References: <1248169540.7048.52.camel@whg21-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248169540.7048.52.camel@whg21-laptop>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henry,

On Tue, Jul 21, 2009, Henry Gomersall wrote:
> import dbus
> 
> bus = dbus.SystemBus();
> manager = dbus.Interface(bus.get_object('org.bluez', '/'),
> 'org.bluez.Manager')
> obj = bus.get_object('org.bluez', manager.DefaultAdapter())
> adapter = dbus.Interface(obj, 'org.bluez.Adapter')
> 
> phone = dbus.Interface(bus.get_object('org.bluez',
> adapter.ListDevices()[0]), 'org.bluez.Device')
> 
> phone_serial = dbus.Interface(phone, 'org.bluez.Serial')
> phone_serial.Connect('spp')

That looks fine to me, though you might want to use FindDevice with the
address of your phone in case you at some point configure more than one
device.

> At this stage, I have the device /dev/rfcomm0, but I cannot write data
> to it without breaking the link.

Do you open the device node and try to write to it from the same python
script that you created the connection with? At the very least the process
that calls Serial.Connect() needs to stay alive for the duration of the
connection. This is because bluetoothd will track the D-Bus client and
automatically disconnect if the client disconnects (e.g. when your script
exits).

Another potential issue that comes to mind is that the protocol you're
supposed to speak to the phone could be binary in which case you'll need
to set the tty into raw mode before doing anything with it (in C you'd use
cfmakeraw and tcsetattr for that and python probably provides something
similar).

Johan
