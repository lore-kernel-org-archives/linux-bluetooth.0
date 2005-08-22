Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
Message-ID: <20050822183820.GA18410@uni-duesseldorf.de>
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de> <430954A6.40107@xmission.com> <20050822120911.GA5397@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050822120911.GA5397@uni-duesseldorf.de>
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
Date: Mon, 22 Aug 2005 20:38:20 +0200

Andreas Beck <becka-bzdvl@bedatec.de> wrote:
> > >[I just noticed, that the copying around is done in kernelspace. Got to
> > > check it there, then.]
> > I'll bet we could watch for this. If byte order gets reversed, it might 
> > present a pattern that we can identify. 
> Very probably. If there is a little noise on the line, the pattern for a
> signed16 signal will be, that there is an unusual amount of
> lowbytes being 0x00 or 0xff.

That was right. I have a patch that fixes this. It basically checks, if 
all lowbytes are 0x00 or 0xff in a transmission block (which happens when 
there is silence, and the bytes are swapped). I also request that the
block is at least 32 bytes long, but I suppose this always happens.
I have only seen 48 byte blocks for my hardware.

> > It seems like SCO is not a reliable transport so maybe bluez is 
> > supposed to watch for this kind of stuff somehow. I should read 
> > up on it...
> I had assumed it is reliable enough to send only even-length messages.
> But that might be not true. You might want to check that.

It seems it is not an issue of variable length messages. I have put in a
warning, if you get odd length packets, but it doesn't trigger for me,
though I have the noise-problem occasionally.

The above heuristic seems to fix it, though.

For me, it happend once on the first connection after loading the
module, usually.

For this reason, my fixup code will trigger on the first and second
connection now (fix the first, fall back to normal behaviour for the
second). All connections are ok now.


> > >A nice addition for me would be a software mic-boost. The quality of the
> > >sound is not bad, but (probably due to the ridiculously compact design
> > >of my headset) the dynamic range is not used appropriately.
> > The general solution is an adaptive boost which would be nice even for 
> > mics that use the full range. It's a common problem so I'll bet you can 
> > get this from one of the alsa layers in userspace.
> The main problem is, that I got to work without floating point stuff,
> as this goes into kernelspace and that I got to keep CPU usage low.
> But I think I can manage that. I used to do some realtime signal
> processing a while ago.

[x] Done. 

I added a new boolean mixer variable AGC that will turn on AGC.

You may want to check if I did that right, and if it was really
necessary to put in the put and get functions, or if alsa standard
functions would have done.


AGC is very simplistic, but works nicely for me:

AGC ist limited to 1/16 - 20 times gain. 

It goes up by 1/16 for every 1/20 second that the signal (after processing) 
stays below an absolute value of 1000. This puts an upper limit to 
amplifying MIC noise.

It goes down immediately ba 1/16 for every overshoot value detected.


Works ok for me.

> > I've seen times where the mouse starts acting whacked and focus gets 
> > stuck on some widget even if the mouse is pointing elsewhere. I've been 
> > meaning to restart hidd and/or reload evdev to see if it's linked to the 
> > bluetooth mouse.
> This sounds more like a windowmanager problem. I've seen this with wired
> mice as well at times. Restarting the WM usually helps.

Very interesting. I got that one as well this afternoon.
However keyboard was not working as well (maybe due to the stuck focus)
So restarting fvwm didn't work. Killing from the console did.


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
