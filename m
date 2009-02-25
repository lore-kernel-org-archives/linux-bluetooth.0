Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb compatibility issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49A2A2D4.2020904@xyzw.org>
References: <498EB082.7040708@xyzw.org>
	 <1234113019.5355.18.camel@californication>  <498F7C4E.4040305@xyzw.org>
	 <1234183143.4705.11.camel@californication>  <49A2A2D4.2020904@xyzw.org>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 11:00:24 +0100
Message-Id: <1235556025.24169.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> >>> Also please run a kernel built from bluetooth-testing.git so I can
> >>> properly debug this. There is one change in it that affects the bulk
> >>> URBs and maybe these dongles just don't like it if we only submit them
> >>> when needed.
> >> I found bluetooth-testing.git last night after posting here, and merged 
> >> it into my kernel. Today I just tested it, and the problem is solved 
> >> here. So there's probably no reason to provide the dump anymore. Will 
> >> this fix be backported to 2.6.27 and 2.6.28?
> >>     
> >
> > not likely since it is not clear what is causing it. There can be some
> > other changes in the tree that could have broken and fixed it. Sometimes
> > this is not Bluetooth related.
> >   
> 
> Maybe this isn't the same as knowing what's causing it, but I'm pretty 
> sure that 'Submit bulk URBs along with interrupt URBs' fixed it. I had 
> done some bisecting in search of the problem and never found a point 
> before it where btusb worked with the affected dongle. Rolling back to 
> just before that commit reproduces the problem, and then stepping 
> forward one fixes it again. I also tried starting with 2.6.27 and 
> cherry-picking the changes that touch drivers/bluetooth/btusb.c. That 
> also produced working Bluetooth as soon as that same commit was added.
> 
> Anyway, if it does not get backported to the official stable branches, I 
> think some distros will still want to add it to their kernels. I'll try 
> to get this into Ubuntu Jaunty's 2.6.28 kernel. So for the sake of me 
> saying "this is the fix applied upstream", do you have an ETA on when 
> this stuff will be merged into the kernel mainline?

I will be sending them for net-next inclusion during this week. Just
have to apply one additional patch and verify that it is fixing a crash
we saw lately.

Regards

Marcel


