Return-Path: <edd@usefulinc.com>
Subject: Re: Lockups
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073451456.2508.124.camel@pegasus>
References: <1073041104.25261.15.camel@pegasus>
	 <1073132228.8729.39.camel@saag>  <1073141037.8729.47.camel@saag>
	 <1073420681.27652.20.camel@saag>  <1073428132.2508.106.camel@pegasus>
	 <1073433290.2674.2.camel@saag>  <1073438965.3116.3.camel@saag>
	 <1073451456.2508.124.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073485192.2669.3.camel@saag>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 14:19:53 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-01-07 at 04:57, Marcel Holtmann wrote:

> we must hunt this bug, because from your screenshot I see that it is in
> the HCI core layer and that is really bad. Do you know the platform of
> the other guy? Maybe it is an endian bug.

It happens on my Athlon and my PowerPC.  He has an IBM Thinkpad Intel(R)
Pentium(R) M processor 1500MHz.

> And to sum this up. It only happens with 2.6 and it freezes your machine
> without any oops?

Run fron console, I see the oops at
http://heddley.com/edd/2004/01/bluez-oops.jpg

>  Do the keyboard leds are blinking?

No blinking.

-- Edd
