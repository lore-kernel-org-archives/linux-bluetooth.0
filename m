Return-Path: <edd@usefulinc.com>
Subject: Re: Lockups (was Re: [Bluez-devel] Bluetooth kernel patch for
	2.6.0)
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073433290.2674.2.camel@saag>
References: <1073041104.25261.15.camel@pegasus>
	 <1073132228.8729.39.camel@saag>  <1073141037.8729.47.camel@saag>
	 <1073420681.27652.20.camel@saag>  <1073428132.2508.106.camel@pegasus>
	 <1073433290.2674.2.camel@saag>
Content-Type: text/plain
Message-Id: <1073438965.3116.3.camel@saag>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 01:29:26 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-01-06 at 23:54, Edd Dumbill wrote:
> >From hcidump, the lockup appears to happen before ever I see any traffic
> from the dump: so it's as the connection is established from the remote
> device (yes, my trusty P800!).  I've tried with and without PREEMPT set.

This wasn't quite accurate.
To clear this up, here's a screen capture (taken the only way I could :)

http://heddley.com/edd/2004/01/bluez-crash.jpg

The red outlined bit is what happens on the connection that locks up the
system.

-- Edd
