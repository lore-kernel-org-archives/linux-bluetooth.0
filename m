Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] - BT HID message parsing framework and
	fixes for Keyboards in boot mode.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1103139137.12839.53.camel@localhost>
References: <1103056217.6424.23.camel@localhost>
	 <1103112320.2143.228.camel@pegasus>  <1103139137.12839.53.camel@localhost>
Content-Type: text/plain
Message-Id: <1103191308.28046.45.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 16 Dec 2004 11:01:48 +0100

Hi Matthew,

> > I only looked at the -rc3-bk6 patch, because as I said, this is what we
> > gonna do first. I don't wanna see any debug specific changes in there. I
> > will remove them anyway and this takes me only longer to merge this
> > patch into my tree.
> 
> You have to appreciate this given that I will bw writing 500-1000 lines
> more of code for net/bluetooth/hidp/core.c (maybe a seperate file) for
> the control channel state machine:

no need for an extra file. 500-1000 lines are not a lot of code.

> o Your debug code in the hidp directory DOES NOT COMPILE!!!
> I need working debug for the amount of work I am doing.  Please read
> my patch and fix it!

If my debug code doesn't compile then this is a bug. Why didn't you send
in a patch for this? Such a fix could already be merged mainline.

> o The code I am writing needs debug code so I can write it and get it
> working.

Fine with me, but before you submit it for inclusion remove this debug
code.

> o Extra debug code is needed in other places in the hidp directory to
> support any general user debugging of the control channel state machine
> code.

As I said before, I will only allow simple debug code in the Bluetooth
code that is off by default. I don't think that you can convince to add
deeper levels of debugging in the code. No extra debug code will make it
easy to merge your code back mainline. Otherwise we will be stuck here
and I have to remove everything by myself.

> >  The rest of this patch looks fine and there is only
> > one coding style issues that I might not mentioned last time. In a
> > "switch" construct we normally add an empty line between "break" and the
> > next "case".
> > 
> > And another thing. What is the difference between ...ctrl_message()
> > and ...ctrl_byte()? We don't need that. If data is NULL then both is the
> > same.
> 
> ...ctrl_message() is needed latter in the state machine work as some
> control messages will be over 1 byte in size.  It will be used in phase
> 2.

You don't get my point. You need only one of these functions to do the
job. What you did is code duplication:

	#define ...ctrl_byte() ...ctrl_message(a, b, NULL, 0)

> You may also notice the 2 separate functions for queueing the sending of
> control bytes  (..ctrl_byte() and ...ctrl_reply()), one from within the
> hidp_session() kernel process, and one for use from the ioctl(s).  Here
> is my reasoning for it. I take it that you do not want to put extra
> schedule() calls in the middle of the hidp_session() while loop, between
> the processing of individual received control packets, before even
> processing the interrupt (high priority, basically  incoming HID events)
> and the transmission queue.  Even if this inserted schedule() call is
> conditional, 2 extra context switches for the hidp_session() thread get
> introduced before received keystrokes/HID events are processed, and the
> transmit queue gets looked at.  The BT HID spec says that the interrupt
> channel should be processed at higher priority (and even before?) the
> control channel.  Both ..ctrl_byte() and ...ctrl_reply() are needed
> according to this.

I haven't said anything about these two. I will look at it when I
applied the patch to me tree and started testing.

> Now about us working together, from your replies and comments about my
> patches it has been obvious to me that you have not had much time to
> look them over and think about things.  You comments on coding style are
> appreciated, and I myself don't like being sloppy, and I know that the
> netfilter people are way too sloppy for my own liking to.  But you are
> holding on too tightly to the control of the BT HID code.  I need the
> flexibility and autonomy of being the delegated lead developer there so
> that my development can be speed along. 

The coding style is important, because it makes it a lot easier to merge
your changes back mainline. I simply won't spent any time fixing coding
style mistakes of other people.

And actually I looked in detail at your patches, but as I said only the
patch against the -rc3-bk6. We do this step by step and this is the one
that comes first. I will merge it back mainline after I tested it with
my devices. However this will be after 2.6.10 is out.

There is no tight control on the BT HID code, but every patch goes
through my hands. I acknowlege it or reject it with a reason and an
advice on how to fix it. The BT HID is a little bit special, because we
don't have the generic HID parser at the moment. I am working on a final
Bitkeeper tree for mainline inclusion. This must be done this way,
because we must keep the revision history. If this is done and 2.6.10 is
finally out everything will be very easy.

> Could you please freeze the BT HID code in the kernel for 3 months
> (apart from brown-paper bag stuff), and let me subsume the HID report
> code in your mh* patches, and strip the net/bluetooth/hidp code from
> your patches, and use my stuff instead so that I can efficiently get the
> work done on improving it rapidly.  If changes are needed to the in
> kernel stuff, please feed them my way and I will integrate them as
> quickly as I can.  This should not be too hard, as it looks like there
> has not been much activity in the BT HID area in the last few months
> apart from my work.

The generic HID parser is the way to go.

> I really want to work together with you on this, as cooperation will get
> far more done in the bluetooth area of the kernel given the small user
> base.  If the above arrangement is not suitable to you, please come up
> with one that we do not have major code clashes when merging each others
> code. 

Since you don't use Bitkeeper, there can't be any easy working together
until I got the generic HID parser in the right shape. I am not willing
to loose the revision history of the current USB HID code. It documents
many reasons why decissions are made and why it is done this way. It is
way too important.

> If you have doubts as to my ability, I am a professional router
> programmer who got fired because I insisted on making my work bug-free,
> robust, and high quality, with experience in OSPF, router device
> driveers and IPX code.  My early CV reads like that of Alan Cox, and I
> have been using Linux since 1993, with a bit work accepted into the
> 2.2.x kernel for ethernet bridging, 2.2.x security patches, and
> 2.2.x/2.4.x Sangoma driver fixes.  I will send you my resume if you want
> to look it over (it is a little out of date).

I have absolutly no doubts on your ability and actually I never read any
CVs, because I judge on the code people write.

> My patience on this is starting to wear out.  If we can't work something
> out soon, I am going to go ahead anyhow, and the merits of the work by
> itself will warrant its inclusion in a few months time.

I am sorry for that and I really appreciate your help. At the moment we
are in the final phase of 2.6.10 and so hoping that we get any stuff
into it is ridiculous (besides fixing my debug code bug maybe). So what
we can do is to get your patch against -rc3-bk6 ready for inclusion and
I will merge it mainline as soon as 2.6.10 is out.

I can start with the merge tree of the generic HID parser tomorrow, but
actually there is one patch from the input subsystem tree that hasn't
been merged back mainline so far. It changes a lot of things and I
haven't looked at it in detail at the moment.

If these two things happened I will remove my current report mode
support from the -mh patch and we will have a common base. Then you can
send in changes for the HID parser and/or for the HIDP code.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
