Return-Path: <charles@bueche.ch>
Date: Fri, 25 Jun 2004 09:28:20 +0200
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MX900 page updated
Message-Id: <20040625092820.0d4af303@bluez.bueche.ch>
In-Reply-To: <1088107922.4296.135.camel@pegasus>
References: <20040624205328.47bf51ee@bluez.bueche.ch>
	<1088107922.4296.135.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Thu, 24 Jun 2004 22:12:02 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:
> > now that gentoo has a 2.6.7 kernel, I have tried Marcel's mh patch
> > with success, and I have updated my page about my setup :
> 
> aren't there any Gentoo packages for bluez-libs and bluez-utils?

Right, they appeared a month ago, while I was waiting for a mh-patchable
kernel. They are still masked, which mean the install need special
steps. I have documented them as well.

> > I'm not sure wheter I still need the uinput module since I switched
> > to hidd. I remember Marcel saying uinput is not needed with hidd. So
> > who sends events to /dev/input/mice ? hidd directly ?
> 
> You don't need uinput anymore. The HIDP Module will do this all by
> itself. On my presentation at LinuxTag tomorrow I am going to show how
> this all works. I created some nice new graphics ;)

I hope we see this online soon. Thanks a lot for your help !

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
