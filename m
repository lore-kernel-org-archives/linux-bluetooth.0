Return-Path: <bluez-devel@schaettgen.de>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sco link help needed
Date: Sun, 22 Feb 2004 22:54:53 +0100
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Marcel Holtmann <marcel@holtmann.org>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
References: <4034CA08.50500@soft.uni-linz.ac.at> <1077452836.2716.42.camel@pegasus> <403916CB.3060205@superbug.demon.co.uk>
In-Reply-To: <403916CB.3060205@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402222254.53781.bluez-devel@schaettgen.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sunday 22 February 2004 21:53, James Courtier-Dutton wrote:
> Marcel Holtmann wrote:
> > we don't need a kernel module that implements the headset profile as an
> > audio device. What we need is a generic SCO kernel module with a well
> > defined interface that is between the Bluetooth HCI SCO traffic and the
> > ALSA sound layer. This means that if a SCO connection is created the
> > driver must set up a new sound device, but the mixer stuff is profile
> > stuff and must be done by a userspace application.
...
> Summary: -
> 1) The alsa driver for bluetooth will be a kernel mode implementation of
> the bluetooth headset profile.

I don't understand why the whole headset profile has to be implemented as a 
part of an alsa driver. Everything can be done completely in user space 
already, completely independent from alsa. The only reason one might wish to 
have a special alsa driver is better responsiveness only, or what else did I 
miss? 
The rfcomm stuff isn't performance critical at all, so there is need for it to 
go into an alsa driver.

> 2) A userspace tool will be used to configure the bluetooth pairing and
> configure the alsa-bluez link.
>
> 3) We will need to be able to implement bluetooth profiles in kernel
> modules as well as user space applications.

I really don't like the idea that an alsa driver would decide if a sco 
connection is going to be accepted or not. This should all be up to the a 
regular userspace application. The alsa driver should not accept incoming 
connections itself. 
Instead their should be a way for the application to create or accept (or not 
accept) a SCO connection the usual way and - only if it wishes to - tell alsa 
to take care of that connection by creating a new alsa device for it.
The only job the driver should do is to connect an existing sco socket to an 
alsa device and make sure that there are no cracks in the audio stream, 
nothing more.

greetings
Fred
