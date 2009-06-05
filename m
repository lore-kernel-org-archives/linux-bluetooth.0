Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244213775.23850.57.camel@localhost.localdomain>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
	 <1244209974.30768.2600.camel@cookie.hadess.net>
	 <1244211333.23850.46.camel@localhost.localdomain>
	 <1244213300.30768.2668.camel@cookie.hadess.net>
	 <1244213775.23850.57.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 16:06:17 +0100
Message-Id: <1244214377.30768.2690.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-05 at 16:56 +0200, Marcel Holtmann wrote:
> 
> > > On that point, you haven't merged the Socket fix upstream
> > 
> > It's not upstreamable, see the RH bugzilla. It depends on a kernel
> patch
> > that can't go upstream.
> 
> Which bug is it.

It's listed in the spec file, in the same directory you found that
patch:
https://bugzilla.redhat.com/show_bug.cgi?id=498756

>  What is missing and why haven't I seen that kernel
> patch at least send to the mailing list for review.

It's a patch to serial core, not Bluetooth, and there's a 3-year old
discussion on LKML, amongst other things.
