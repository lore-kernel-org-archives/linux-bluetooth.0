Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Message-ID: <20040627203414.GB26191@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <1088359746.3774.20.camel@pegasus> <20040627191016.GA26191@gmx.net> <1088363397.3774.64.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088363397.3774.64.camel@pegasus>
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
Date: Sun, 27 Jun 2004 22:34:14 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
> > I wouldn't consider 2.6. as stable. And i think it is not recommend to
> > use anything related to USB with 2.6. in a commercial standalone device.
> 
> the Linux kernel 2.6 itself first will become mature if Andrew takes
> over the maintainer role and the 2.7 branch is created. However the
> kernel itself is stable and the BlueZ core is also stable. The USB
> problem you are talking about is a driver problem (hci_usb) only and
> don't effect the BlueZ core.

I wasn't referring to the bluez code, but about the whole 2.6 kernel.
And nowadays USB is going to be the standard for connecting even
internal devices, so the OP should be clear that using the 2.6 kernel is
no smart idea. Because these really heavy problems of the whole USB
subsystem affect the use of bluetooth usb dongles i mentioned it. I
think it isn't a good idea too use USB at all.  
 
> This is a another nice point why I don't really wanna start thinking in
> black/white or stable/testing categories. Choose what you need and then
> you can start talking about how stable this will be for a specific use
> case.

I agree with you, the seperation of stable/testing trees is not the
perfect solution. 
But you have to admit, that yours is a more error-prone approach then 
forking a stable branch and backporting bugfixes. Technically seen, it
is the same as fixing the core and do larger modifications and feature
adds to modules only. But i think this makes quality assurance more
complicated. 
The debian project shows that if you really want such high quality
standards for use in embedded devices e.g. it is possible to keep your
own stable branch. I think it is very easy with a good Changelog.

nicholas


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
