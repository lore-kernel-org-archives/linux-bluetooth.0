Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430954A6.40107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de>
In-Reply-To: <20050821192634.GA10231@uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 21 Aug 2005 22:29:26 -0600

Andreas

>>>3. I have written a small Python-Script and a .btscorc
>>
>>Perfect. I gave a talk about btsco at our usergroup meeting and this 
>>very question came up! (slides at http://flamebot.com/blog)
>>I will link to you or put these in a contrib dir (what do you think?)
> 
> 
> I don't care. I don't think this will need updates, unless the skype
> d-bus protocol gets changed in a fundamental way.

Ok, I will put it in contrib and add a note that it's derived from the 
api documentation example. If you like the mod from "Whoopie" I'll apply 
that too.

> [I just noticed, that the copying around is done in kernelspace. Got to
>  check it there, then.]

I'll bet we could watch for this. If byte order gets reversed, it might 
present a pattern that we can identify. It seems like SCO is not a 
reliable transport so maybe bluez is supposed to watch for this kind of 
stuff somehow. I should read up on it...

> A nice addition for me would be a software mic-boost. The quality of the
> sound is not bad, but (probably due to the ridiculously compact design
> of my headset) the dynamic range is not used appropriately.

The general solution is an adaptive boost which would be nice even for 
mics that use the full range. It's a common problem so I'll bet you can 
get this from one of the alsa layers in userspace.

> Another thing I noticed (which is probably not btsco related, but more
> of a general bluez problem, maybe even a general kernel problem) is,
> that I now had two occasions where my USB subsystem became unresponsive 
> to a point where the machine froze.

I suppose since it's only happened twice you can't reproduce it? I'm not 
much help looking over logs since I don't know what to look for.

I've seen times where the mouse starts acting whacked and focus gets 
stuck on some widget even if the mouse is pointing elsewhere. I've been 
meaning to restart hidd and/or reload evdev to see if it's linked to the 
bluetooth mouse.

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
