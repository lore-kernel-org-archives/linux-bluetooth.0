Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-devel] Extremely slow printing?
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087438456.2624.64.camel@localhost.localdomain>
References: <1087431069.6361.26.camel@localhost.localdomain>
	 <1087432013.4309.43.camel@pegasus>
	 <1087438456.2624.64.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087440365.2624.75.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 04:46:05 +0200
List-ID: <bluez-devel.lists.sourceforge.net>

Oops... please disregard the last part of my previous message. It turns
out, of course, that the data being sent to the printer is *much* larger
than the original 250K of the postscript file. I haven't dealt much with
non-postscript printers before, so this is all a bit new to me. The size
of the raw data being sent to the printer is over 7 megabytes, which
means a speed of 30 seconds over bluetooth just won't be possible.

And I suppose the difference between the Windows and Linux results could
be explained by a difference in data size; maybe the Windows printer
driver generates a smaller raw data file. I'll have to investigate this
further.

So now my only question is: Is it expected/normal for the BlueZ CUPS
backend to only manage about 400kbps when transferring data to the
printer? Is there anything that can be done to speed this up?

Jon

On Thu, 2004-06-17 at 04:14, Jon Valvatne wrote:
> Thanks for the quick response,
> 
> After some more testing I've come up with the following results:
> 
> Windows USB: 30sec
> Windows Bluetooth: 1min 45sec
> Linux USB: 30sec
> Linux HCRP: 2min 25sec
> Linux SPP: 2min 50sec
> 
> These times are all taken while printing the exact same 250K postscript
> file (the Turboprint testpage-a4.ps, a single page with both text and
> color/photo elements), measured from the first time the print head puts
> ink on the paper until the page is completed. I've double- and
> triple-checked the times; they're entirely consistent and reproducible.
> 
> In other words, while there seems to be a significant speed penalty
> incurred just by printing over bluetooth instead of USB, there's also a
> significant speed penalty in moving from Windows to Linux.
> 
> My immediate conclusion would be that the latter is caused by BlueZ
> somehow, since there's no difference in speed between Windows and Linux
> when printing over USB. But of course I could be wrong in that
> conclusion: I know absolutely nothing of how printer drivers work, and I
> suppose there's a chance that something in CUPS or Turboprint (the
> proprietary driver I use for the i80) is causing the speed difference,
> and that this something for some reason only kicks in when the medium
> we're printing over is bluetooth and not USB.
> 
> But really, the difference between Windows and Linux here isn't very
> relevant for me right now, because the results above make bluetooth
> printing non-viable to me, on any platform. If it's going to take more
> than three times longer to print without a USB cable, I'd rather bring
> the cable and spend the extra five seconds it takes to hook it up.
> 
> Can anyone explain to me why there's any difference at all? My naive
> reaction here is surprise that the transfer medium has any impact on the
> actual print speed at all. Shouldn't it be possible to send all the data
> to the printer in one long burst, taking only a couple of seconds with
> the sort of file I've been testing with? That's very obviously not
> what's happening though: When printing over bluetooth the printer starts
> out nice and fast when printing the text part of the document, then
> slows to a crawl when it reaches the data-heavy part with the photos.
> 
> I guess this has veered off-topic, but for BlueZ there does seem to be a
> possibility to improve print speeds significantly, since Windows does
> it  faster. Of course it would be extremely cool if BlueZ could speed
> its printing up to the point where it's comparable to USB printing, but
> I guess that's getting my hopes up too much :)
> 
> Sorry for the long-winded rambling,
> 
> Jon
> 
> On Thu, 2004-06-17 at 02:26, Marcel Holtmann wrote:
> > Hi Jon,
> > 
> > > I got my bluetooth CF card today, stuck it in my laptop, and I have to
> > > say I'm very impressed with the status of BlueZ; all my bluetooth
> > > devices are working fine with minimal effort.
> > > 
> > > I'm noticing just one annoyance: I've got a Canon i80 printer with the
> > > bluetooth module, and printing over bluetooth turns out to be *much*
> > > slower than printing over USB: A 250K postscript file takes 40 seconds
> > > to print over USB, but 3 minutes to print over bluetooth.
> > > 
> > > I'm not very familiar with the internals of printers and printer
> > > drivers, so I'm not sure how surprising this is. The raw speed advantage
> > > that USB has shouldn't be an issue here, since bluetooth's bandwidth
> > > should still be enough to transfer the data in a couple of seconds. Is
> > > latency the issue? Or is it inefficiencies in the bluetooth backend for
> > > CUPS?
> > 
> > maybe the Bluetooth device or chip in the printer is too slow. Do it use
> > SPP or HCRP?
> > 
> > > I suppose I'll try using Canon's own drivers under Windows, which might
> > > tell me whether or not this is an inherent problem with printing over
> > > the bluetooth medium. But I thought I'd ask here as well.
> > 
> > Please check this first, because BlueZ tries to send with the maximum
> > speed. This must be a hardware issue.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> > Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> > Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> > REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
