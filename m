Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040627191016.GA26191@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus>  <20040627191016.GA26191@gmx.net>
Content-Type: text/plain
Message-Id: <1088363397.3774.64.camel@pegasus>
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
Date: Sun, 27 Jun 2004 21:09:57 +0200

Hi Nicholas,

> > That is wrong. BlueZ itself is stable. Speaking about the kernel part
> > then every code in a stable kernel like 2.4 and 2.6 is stable. Bugs
> > exists and later kernel releases are more stable than previous, but
> > every BlueZ code in the kernel can be considered as stable.
> 
> I wouldn't consider 2.6. as stable. And i think it is not recommend to
> use anything related to USB with 2.6. in a commercial standalone device.

the Linux kernel 2.6 itself first will become mature if Andrew takes
over the maintainer role and the 2.7 branch is created. However the
kernel itself is stable and the BlueZ core is also stable. The USB
problem you are talking about is a driver problem (hci_usb) only and
don't effect the BlueZ core.

This is a another nice point why I don't really wanna start thinking in
black/white or stable/testing categories. Choose what you need and then
you can start talking about how stable this will be for a specific use
case.

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
