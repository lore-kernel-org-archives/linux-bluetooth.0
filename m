Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040627203414.GB26191@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus> <20040627191016.GA26191@gmx.net>
	 <1088363397.3774.64.camel@pegasus>  <20040627203414.GB26191@gmx.net>
Content-Type: text/plain
Message-Id: <1088369388.3774.88.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 27 Jun 2004 22:49:48 +0200

Hi Nicholas,

> > the Linux kernel 2.6 itself first will become mature if Andrew takes
> > over the maintainer role and the 2.7 branch is created. However the
> > kernel itself is stable and the BlueZ core is also stable. The USB
> > problem you are talking about is a driver problem (hci_usb) only and
> > don't effect the BlueZ core.
> 
> I wasn't referring to the bluez code, but about the whole 2.6 kernel.
> And nowadays USB is going to be the standard for connecting even
> internal devices, so the OP should be clear that using the 2.6 kernel is
> no smart idea. Because these really heavy problems of the whole USB
> subsystem affect the use of bluetooth usb dongles i mentioned it. I
> think it isn't a good idea too use USB at all.  

the current USB subsystem (as of 2.6.7) is not as bad as you think.
Actually it is working very nice and even the hci_usb driver didn't
crash anymore. Anyhow the problem is not USB. We made all of them by
ourself :(
 
> > This is a another nice point why I don't really wanna start thinking in
> > black/white or stable/testing categories. Choose what you need and then
> > you can start talking about how stable this will be for a specific use
> > case.
> 
> I agree with you, the seperation of stable/testing trees is not the
> perfect solution. 
> But you have to admit, that yours is a more error-prone approach then 
> forking a stable branch and backporting bugfixes. Technically seen, it
> is the same as fixing the core and do larger modifications and feature
> adds to modules only. But i think this makes quality assurance more
> complicated. 
> The debian project shows that if you really want such high quality
> standards for use in embedded devices e.g. it is possible to keep your
> own stable branch. I think it is very easy with a good Changelog.

I really like the Debian way of forking a stable version and only doing
security or bugfixes. The problem is that this needs a lot of man power
and costs a lot of time. I know what I am talking about, because I did
all the 2.4 kernel backports of the Bluetooth subsystem.

If we got a number of companies that help sponsoring the BlueZ itself
and its official qualification I can think of such a fork. At that point
it makes sense to me and is worth the extra work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
