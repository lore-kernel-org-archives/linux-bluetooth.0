Return-Path: <edd@usefulinc.com>
Subject: Re: Lockups (was Re: [Bluez-devel] Bluetooth kernel patch for
	2.6.0)
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073428132.2508.106.camel@pegasus>
References: <1073041104.25261.15.camel@pegasus>
	 <1073132228.8729.39.camel@saag>  <1073141037.8729.47.camel@saag>
	 <1073420681.27652.20.camel@saag>  <1073428132.2508.106.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073433290.2674.2.camel@saag>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 23:54:51 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-01-06 at 22:28, Marcel Holtmann wrote:
> at the moment I am not able reproduce it. Try to track the problem and
> give me reports on it. It must be some kind of strange bug that can't be
> easily found.

I can reliably reproduce it here (just tried again with 2.6.1-rc2 (+your
patches).  Can you recommend any technique I might be able to use to
provide you with more information?

>>From hcidump, the lockup appears to happen before ever I see any traffic
from the dump: so it's as the connection is established from the remote
device (yes, my trusty P800!).  I've tried with and without PREEMPT set.

-- Edd
