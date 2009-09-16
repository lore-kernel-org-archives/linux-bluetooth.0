Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB130C4.5030205@binarywings.net>
Date: Wed, 16 Sep 2009 20:39:00 +0200
From: Florian Philipp <lists@binarywings.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com> <20090915061104.GA20323@jh-x301> <4AAFBFA6.70007@binarywings.net> <20090915165854.GA6550@jh-x301> <4AB107DE.5070700@binarywings.net> <20090916164104.GA11739@jh-x301>
In-Reply-To: <20090916164104.GA11739@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg schrieb:
> Hi,
> 
> On Wed, Sep 16, 2009, Florian Philipp wrote:
>> Of course I can't force you to do the programming but removing
>> functionality which worked - more or less - out of the box with an older
>> release and not providing any working alternative except of a
>> do-it-yourself solution ... well ... just sounds wrong.
> 
> I think part of the explanation is lack of knowledge about exactly in
> which ways people use BlueZ and how popular these use cases are. To be
> honest, I'm not sure I still understand exactly what kind of behavior or
> feature you're after.
> 

Okay, it's easy to explain it. What I originally set up in late 2007
resembles what is commonly called a "wlan router" just with bluetooth
instead of IEEE-802.11. It's a bluetooth GN with a pre-shared key. The
GN connects to an ethernet bridge with DHCP and DNS servers, NAT and
firewall for internet access. All built on a Gentoo Linux laptop.

It sure isn't one of the most common usages for bluetooth but it was
well supported at that time with lots of howtos and an easy setup. You
basically just had to put up some config files, a one line long script
for expanding the ethernet bridge for every connection and start the
daemon with the right parameters.

>> Okay, so without some significant work, you could only support legacy
>> pairing for those old deamons and I suppose that's all those test apps
>> can, right?
> 
> Exactly which old daemons are you talking about? I don't see how any old
> software that isn't aware of the current pairing/agent interface could be
> made to work "without some significant work".
> 

Apologies when I mix up some things here. It's not like I'm working with
bluez right now. I've left my current solution alone for at least 5
months and cared about other things.

As far as I remember, at least bluez-3.x had support for a legacy
interface which more or less resembled the old 2.x daemons. For some
reason that stopped to work for me (or maybe it never worked and I just
didn't notice until I needed the network again some months after the
update). Although I can't fully remember I'm pretty sure I never found
out why. When I searched help on this list, someone told me that 3.x was
too old for him to look into that problem and that I should move forward
to 4.x

Well, 4.x never worked for me so I went back to 2.x and here I am now.

>> a) Create and maintain the missing parts myself.
> 
> If the functionality makes sense and the implementation follows the usual
> coding standards that we have I don't see why you would be stuck
> maintaining it yourself. Surely it should be possibe to merge the work
> with upstream.
> 

Well, I'm pretty sure some other guys came up with the exact same
question which was the start of this thread at various occasions last
year or so (i.e. wanting to have a simple daemon-like pin helper). From
your post I read that you acknowledge that this functionality which
those other guys and me miss in bluez is something you'd like to have
back in, right?

So, if any solution, maybe heavily based on those two test programs
would really make it back into upstream and would not be dropped because
it somehow does not fit in the current design or whatever (that's what
my original question was because the functionality _was already there_
in 2.x), then why is the answer to those requests always "Do it
yourself" and not at least "Do it yourself and maybe send it to us so we
can merge it into upstream"?

That's exactly what I wanted to know in the first place: Why you would
not want this functionality in bluez but rather put people requesting it
down with "Do it yourself (and leave us alone)". At least that was my
impression.
