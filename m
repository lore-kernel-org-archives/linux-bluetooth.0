Return-Path: <cyrus@holtmann.org>
Subject: Re: Users need to manually run "hid2hci --method dell -v 413c -p
 8158 --mode hci" even when udev rule is installed
From: Bastien Nocera <hadess@hadess.net>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1276959945.16187.0.camel@localhost.localdomain>
References: <1272134552.7585.9.camel@localhost.localdomain>
	 <1276959945.16187.0.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 19 Jun 2010 16:55:36 +0100
Message-ID: <1276962936.13559.143.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2010-06-19 at 17:05 +0200, Pacho Ramos wrote:
> El sáb, 24-04-2010 a las 20:42 +0200, Pacho Ramos escribió:
> > Hello
> > 
> > I would like to ask for help to try to find where could be the problem
> > causing this:
> > http://bugs.gentoo.org/show_bug.cgi?id=315749
> > 
> > Reporter seems to need to manually run:
> > hid2hci --method dell -v 413c -p 8158 --mode hci
> > 
> > to get bluetooth switched to hci mode.
> > 
> > I don't understand why he needs to run it since involved udev rule file
> > seems to be properly installed.
> > 
> > Could anybody help us on this please?
> > 
> > Thanks a lot
> 
> This is still affecting to some users, can anybody help us? At least,
> how could we check if udev is, at least, trying to execute hid2hci from
> 97-bluetooth-hid2hci.rules file?

2 things.

This is already fixed in udev upstream, and hid2hci doesn't live in
bluez, but in udev now.

This was also fixed recently in Fedora 14.

Cheers

