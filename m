Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073485192.2669.3.camel@saag>
References: <1073041104.25261.15.camel@pegasus>
	 <1073132228.8729.39.camel@saag>  <1073141037.8729.47.camel@saag>
	 <1073420681.27652.20.camel@saag>  <1073428132.2508.106.camel@pegasus>
	 <1073433290.2674.2.camel@saag>  <1073438965.3116.3.camel@saag>
	 <1073451456.2508.124.camel@pegasus>  <1073485192.2669.3.camel@saag>
Content-Type: text/plain
Message-Id: <1073487147.2508.155.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Lockups
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Jan 2004 16:08:47 +0100

Hi Edd,

> > we must hunt this bug, because from your screenshot I see that it is in
> > the HCI core layer and that is really bad. Do you know the platform of
> > the other guy? Maybe it is an endian bug.
> 
> It happens on my Athlon and my PowerPC.  He has an IBM Thinkpad Intel(R)
> Pentium(R) M processor 1500MHz.
> 
> > And to sum this up. It only happens with 2.6 and it freezes your machine
> > without any oops?
> 
> Run fron console, I see the oops at
> http://heddley.com/edd/2004/01/bluez-oops.jpg
> 
> >  Do the keyboard leds are blinking?
> 
> No blinking.

do you have any supported PCMCIA card? I like to know if this also
happens without the USB subsystem involved.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
