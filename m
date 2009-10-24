Return-Path: <cyrus@holtmann.org>
Subject: Re: rfkill read / write access needs to be enabled for normal users
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrea Veri <andrea.veri89@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1256401467.7812.7.camel@localhost.localdomain>
References: <20091024171318.345c2bbf@bluepaper>
	 <1256401467.7812.7.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 24 Oct 2009 18:28:10 +0100
Message-Id: <1256405290.3198.5.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2009-10-25 at 01:24 +0900, Marcel Holtmann wrote:
> Hi Andrea,
> 
> > while working on gnome-bluetooth for Debian, I noticed that rfkill's
> > read / write access needs to be enabled for normal users.
> > 
> > There is a patch for this already:
> > 
> > KERNEL=="rfkill", ENV{ACL_MANAGE}="1"
> > 
> > This is done through an udev rule, but I don't think this is the best
> > way to have it fixed.
> > 
> > I guess that having a fix included into bluez itself would make the
> > trick IMHO.
> > 
> > Is there someone working on this already? if not, someone can suggest
> > me another way to have this fixed without having to use an udev rule?

This isn't a bug, it's mentioned in gnome-bluetooth's README, along with
the dependencies.

> I have said this before and let me repeat it again, gnome-bluetooth
> should not mess directly with the RFKILL subsystem. It is the wrong
> approach and that is the reason why normal users don't have uncontrolled
> access to /dev/rfkill.

Except that you have failed to come up with a better solution for _now_.
I don't think that we want to wait for you to write rfkilld, or to
change your mind again about how it should be implemented.

bluetoothd didn't even work properly with killswitches before I
mentioned it on the list and on IRC, so I'd appreciate a bit more
honesty in your blanket opinions...

Cheers
