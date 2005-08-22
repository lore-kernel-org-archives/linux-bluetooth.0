Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
Message-ID: <20050822120911.GA5397@uni-duesseldorf.de>
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de> <430954A6.40107@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <430954A6.40107@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Aug 2005 14:09:11 +0200

Hi Brad,
> >>>3. I have written a small Python-Script and a .btscorc
> >>I will link to you or put these in a contrib dir (what do you think?)
> >I don't care. I don't think this will need updates, unless the skype
> >d-bus protocol gets changed in a fundamental way.
> Ok, I will put it in contrib and add a note that it's derived from the 
> api documentation example. If you like the mod from "Whoopie" I'll apply 
> that too.

Yeah. I like it. Much appreciated enhancement. I've uploaded his version
to my site as well.

I suggest you use this version. I made a minimal change to Whoopie's
version. I call the API-Name "SkypePickup" which is probably more
generic, as the script will do a pickup - it does not really have 
something to do with BT headsets, except that it is a nice sample 
application.

> >[I just noticed, that the copying around is done in kernelspace. Got to
> > check it there, then.]
> I'll bet we could watch for this. If byte order gets reversed, it might 
> present a pattern that we can identify. 

Very probably. If there is a little noise on the line, the pattern for a
signed16 signal will be, that there is an unusual amount of
lowbytes being 0x00 or 0xff.

My first idea would be to check, if _all_ lowbytes (i.e. the lowbytes
as they are transmitted) are 0x00 or 0xff in a transmitted block of not
too short length. If that is the case, I'd suggest to just "miss" a
single byte in transfer. If that cures the problem, it should be ok.

The only case where this doesn't work should be very noisy environments.

I don't think it will mistrigger on natural inputs.

> It seems like SCO is not a reliable transport so maybe bluez is 
> supposed to watch for this kind of stuff somehow. I should read 
> up on it...

I had assumed it is reliable enough to send only even-length messages.
But that might be not true. You might want to check that.


> >A nice addition for me would be a software mic-boost. The quality of the
> >sound is not bad, but (probably due to the ridiculously compact design
> >of my headset) the dynamic range is not used appropriately.
> The general solution is an adaptive boost which would be nice even for 
> mics that use the full range. It's a common problem so I'll bet you can 
> get this from one of the alsa layers in userspace.

The main problem is, that I got to work without floating point stuff,
as this goes into kernelspace and that I got to keep CPU usage low.

But I think I can manage that. I used to do some realtime signal
processing a while ago.


> >Another thing I noticed (which is probably not btsco related, but more
> >of a general bluez problem, maybe even a general kernel problem) is,
> >that I now had two occasions where my USB subsystem became unresponsive 
> >to a point where the machine froze.
> I suppose since it's only happened twice you can't reproduce it? 

No, not really. The shutdown-lockup seems to happen quite often,
though.

> I've seen times where the mouse starts acting whacked and focus gets 
> stuck on some widget even if the mouse is pointing elsewhere. I've been 
> meaning to restart hidd and/or reload evdev to see if it's linked to the 
> bluetooth mouse.

This sounds more like a windowmanager problem. I've seen this with wired
mice as well at times. Restarting the WM usually helps.


CU, ANdy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
