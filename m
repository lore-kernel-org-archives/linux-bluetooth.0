Return-Path: <jp-www@dcs.gla.ac.uk>
Date: Tue, 10 Aug 2004 14:53:29 +0100 (BST)
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   snd-bt-sco@corinis.net
Subject: Re: [snd-bt-sco] Re: [Bluez-devel] snd-bt-sco development teamup |
 ALSA connection
In-Reply-To: <1092145515.4564.143.camel@pegasus>
Message-ID: <Pine.LNX.4.59.9999.0408101448200.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus>
  <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus>
 <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de>  <1092140041.4564.96.camel@pegasus>
 <4118C5FC.1050502@dark-reality.de> <1092145515.4564.143.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 10 Aug 2004 3:45pm +0200, Marcel Holtmann wrote:

>> - -notice the BlueZ module if some program looks for a connection
>
> If you mean with that when someone opens the DSP device we should create
> the connection, then this will fail. The RFCOMM channel must be created
> first and this is part of the connection handling from userspace. The
> kernel can't do anything here.

A user space daemon can, however, keep a file descriptor open on the ALSA 
device's hwdep interface. The kernel driver could notify the daemon when 
an app opens the device, at which point the daemon can take a policy 
decision about attempting to connect to some default headset device (which 
eventually results in binding the SCO socket to the device).

> The general workflow should be something like this:
>
> 	- create RFCOMM channel and start AT handling
> 	- create SCO socket if needed
> 	- issue ioctl to make SCO socket an ALSA device

I think that the creation of ALSA devices and binding of SCO socket to an 
ALSA device should be separate operations. That way, an ALSA device can 
exist with no attached headset. Using the technique described above, that
device can be demand-connected to a particular SCO socket.
