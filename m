Return-Path: <cyrus@holtmann.org>
Subject: Re: dun profile
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100910150722x3fb617fbgc01c0fb4476b3d6d@mail.gmail.com>
References: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
	 <1255599537.3797.63.camel@localhost.localdomain>
	 <2d5a2c100910150722x3fb617fbgc01c0fb4476b3d6d@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 15 Oct 2009 16:19:58 +0100
Message-Id: <1255619998.19029.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-10-15 at 11:22 -0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Oct 15, 2009 at 6:38 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > Same questions as Stefan I'm afraid.
> >
> > In any case, I think the front-ends should be creating the port
> > themselves, so they would know which one to handle.
> >
> > See the recent (and less recent) work done in NetworkManager for DUN
> > support.
> 
> 
> Basically I want to avoid the code done in NetworkManager, simply
> because it doesn't work for anything but the one that create the port.
> So what Im proposing is that udev take care of setting the
> capabilities to the port, not the applet manually doing it, but to
> make it possible there must be something indicating that it is a port
> to dun profile channel (or spp if that matters).

It's not the applet doing it, but the daemon. And it will run
ModemManager on the device.

>  The other suggestion
> is that this port should be somehow stored so it is recreated after
> boot, but as Stefan cleverly point out this would be a bit difficult
> since some device insist in changing the channel/hide the service each
> time the profile got in use, so perhaps it is not a good idea in the
> end.
> 
> What Im still missing is how I attach the information to the port so
> that udev properly recognized and nobody has to do workarounds, store
> the return of Serial.Connect("dun") and then wait it to be announced
> by udev, than I can do it directly on bluetoothd and has to duplicate
> this code on front-ends.

That's fine if you want to hack around the device. NM/MM will add the
necessary properties to the udev device when it creates the device.


