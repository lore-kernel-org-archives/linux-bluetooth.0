Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth SPP link to Nokia phone
From: Henry Gomersall <whg21@cam.ac.uk>
Reply-To: heng@cantab.net
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090721100239.GA19048@jh-x301>
References: <1248169540.7048.52.camel@whg21-laptop>
	 <20090721100239.GA19048@jh-x301>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 12:51:40 +0100
Message-Id: <1248177100.5156.14.camel@whg21-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-07-21 at 13:02 +0300, Johan Hedberg wrote:
> > phone = dbus.Interface(bus.get_object('org.bluez',
> > adapter.ListDevices()[0]), 'org.bluez.Device')
> > 
> > phone_serial = dbus.Interface(phone, 'org.bluez.Serial')
> > phone_serial.Connect('spp')
> 
> That looks fine to me, though you might want to use FindDevice with
> the
> address of your phone in case you at some point configure more than
> one
> device.
> 
yeah, it was a quick and dirty method to get it connected - I couldn't
work out the string format for the bluetooth address (its obvious
now!) ;)

> > At this stage, I have the device /dev/rfcomm0, but I cannot write
> data
> > to it without breaking the link.
> 
> Do you open the device node and try to write to it from the same
> python
> script that you created the connection with? At the very least the
> process
> that calls Serial.Connect() needs to stay alive for the duration of
> the
> connection.

Well, this is all being handled inside an ipython session (which I do
not exit)
> 
> Another potential issue that comes to mind is that the protocol you're
> supposed to speak to the phone could be binary in which case you'll
> need
> to set the tty into raw mode before doing anything with it (in C you'd
> use
> cfmakeraw and tcsetattr for that and python probably provides
> something
> similar).

I've tried doing the same thing using the rfcomm program. This allows me
to set up a stable connection using:
rfcomm connect /dev/rfcomm0 'XX:XX:XX:XX:XX:XX'

I can then write AT commands to it as expected.

I'll take a look at the rfcomm source and see what its doing differently
from me (unless someone knows the answer ;)

Thanks,

Henry

