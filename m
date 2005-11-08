Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and
	PeriodicInquiry D-BUS methods
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051108143016.GA7919@localhost.localdomain>
References: <20051108134311.GA7150@localhost.localdomain>
	 <1131458070.5824.181.camel@blade>
	 <20051108143016.GA7919@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131461948.5824.195.camel@blade>
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
Date: Tue, 08 Nov 2005 15:59:08 +0100

Hi Johan,

> Attached is a new patch with some of your proposed changes (the ones I
> agree with ;)

the patch is in the CVS now (slightly modified).

> > > The possible ways of calling the methods after applying this patch are:
> > > 
> > > Inquiry()
> > > Inquiry(byte: length, byte: num_rsp, uint32: lap)
> > > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period)
> > > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period,
> > > 		byte: num_rsp, uint32: lap)
> > 
> > please swap the lap and num_rsp (call it num_responses btw.) and make
> > the num_responses also optional. It is more usual that you will specify
> > a different lap instead of num_responses. The reason for this is,
> > because the num_responses value is not really useful anymore. All chips
> > in inquiry mode 1 or 2 tend to send results multiple times and this
> > makes the num_responses value useless. It is only good for devices where
> > the memory storage for inquiry results is limited. Maybe we shouldn't
> > use it at all.
> 
> I removed the num_responses parameter alltogether. If it's needed we can
> always allow changing it through the default settings interface in the
> future.

and I renamed it back to num_rsp, because it is only internally.

> > Is it not better to call it access_code instead of lap?
> 
> Maybe. I called it lap since that's what your structs in hci.h and the
> HCI spec calls it. Note that the terms we use in the code don't have to
> the same what we put in the (yet to be created) public documentation of
> the interface.

Inside the code this doesn't matter. However don't be so picky on the
structs defined in hci.h. Some of them are over 4 years old and back
then sometimes we had no idea what we were doing.

> > The length parameter should also be in seconds and not the slot timing
> > we get from the baseband.
> 
> Well, then it would always have to be rounded to the nearest 1.28 sec
> multiple, so I'm not so sure how useful it would be (and it might be
> even confusing for the user when the inquiry doesn't last the exact
> amount of seconds that was given). I've left it unchanged for now. I can
> send a new patch later specifically for it. If we do change it, should
> it be an integer or a floating point number?

I don't see it as a big problem, because we will round to next 1.28 sec
to make it at least "length" number of seconds. In most cases this will
be some microseconds longer, but that doesn't really matter. The API is
event driven and so yes, they can't start another inquiry after exactly
"length" number seconds, but they periodic inquiry should used for this
kind of tasks anyhow.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
