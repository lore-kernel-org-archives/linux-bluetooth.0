Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple connections on rfcomM?
From: Marcel Holtmann <marcel@holtmann.org>
To: scott.meesseman@alpsautomotive.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <OFD5ECABF7.C9CE691C-ON85256DFA.0056D0DF-85256DFA.0058EFFA@alpsautomotive.com>
References: 
	 <OFD5ECABF7.C9CE691C-ON85256DFA.0056D0DF-85256DFA.0058EFFA@alpsautomotive.com>
Content-Type: text/plain
Message-Id: <1071253945.27252.123.camel@pegasus>
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
Date: Fri, 12 Dec 2003 19:32:25 +0100

Hi Scott,

> I have been using BlueZ in a demo system and pretty much love the
> programming interface.  The stack has done well to this point
> regarding performance and reliability and such, but we are now looking
> into building a production product.  We are licensing QNX and my
> question is, before I spend much time researching, is it possible to
> pull the bluez stack components from the kernel source and compile it
> somehow as it's own entity?  My thinking is that there is no way, but
> I am being prodded by my co-workers to at least inquire of how hard of
> a job this would be.  Or is there another way to run bluez on QNX?

actually my knowledge of QNX is very limited, but I don't think that it
is an easy task to port BlueZ to QNX. The BlueZ interfaces up to L2CAP
are bound to the Linux kernel and its network stack. The RFCOMM, BNEP
and CMTP code depends only on the L2CAP socket interface, but they also
use the SKB's, task and thread support of the kernel. So I would say
that it is easier to write a new Bluetooth stack than porting it to
another OS. But as I also said my knowledge of QNX is limited - please
show me that I am wrong.

The part that is running in userspace like SDP, HCRP, HID etc. should be
easy reusable if the Bluetooth stack for QNX provides a socket interface
to L2CAP.

> I this does happen to be possible, I would like to take on the task of
> adding the A2DP profile and AVT protocol to bluez.  So anyone who has
> worked on this or is currently working on this please let me know...

Even if a port to QNX is not possible I think it is a good idea to work
together in adding AVDTP support to BlueZ.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
