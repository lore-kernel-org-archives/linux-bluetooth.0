Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [PATCH] - for BT HID fixes + beginning of
	ctrl handling
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1102315086.6245.1.camel@localhost>
References: <1101930555.6182.15.camel@localhost>
	 <1101933187.15615.54.camel@pegasus>  <1101982200.6274.24.camel@localhost>
	 <1101987344.15615.109.camel@pegasus>  <1102315086.6245.1.camel@localhost>
Content-Type: text/plain
Message-Id: <1102315745.8510.64.camel@pegasus>
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
Date: Mon, 06 Dec 2004 07:49:05 +0100

Hi Matthew,

> > Actually a schedule should not harm in any way. If you think we really
> > need it then I would prefer the same as a looked() versus __unlocked()
> > functions.
> 
> Like you I want to keep things simple here, but I want to also avoid the
> effects of giving up the processor to readily.  Also I want to avoid the
> complications of more locks.  The reply messages are being sent inside
> the global? Bluetooth HID lock.  We have to be careful about the context
> that this is all happening within.  If you are that concerned about the
> third function schedule parameter, I will create 2 separate control
> message sending functions as they are only 3-4 lines long.

maybe we have to move the hidp_schedule() call around. Don't duplicate
code even if they are only 3-4 lines long.

> > > Thinking about how best to look after all the code and patching.
> > > Putting all the BT code into a version control system here is looking to
> > > be quite sensible to make the patching easier to handle.  If we were not
> > > patching core.c for the report mode support, this would be a lot easier
> > > and cleaner.
> > 
> > I don't see any need for it at the moment. Once we get your HIDP core
> > stuff ready, I will try to merge it back mainline as soon as possible.
> > Every change after that should be minimal.
> > 
> 
> This first patch is only phase 1 in a 3 stage process.  Next 2 steps
> will be just as big and invasive.  After this probably half of the BT
> HID may be changed around quite significantly.  Please accept Debug code
> code changes I make, as I need these to get debug code to compile for my
> own use.  The version control system is so that I can more easily keep
> track of what I am doing.

The debug code is for the development stage. After the merge back we
remove it and leave only a minimal amount of debug code in there. That
is also the reason why no config option for it exists even if the define
looks like one.

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
